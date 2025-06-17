<?php
require_once "misc.php";
require_once "Models/Accounts.php";
require_once "Models/LoginToken.php";

header("Content-Type: application/json");

$token = trim(getallheaders()["Authorization"] ?? "");

if (empty($token)) {
    HttpUtils::Status(401, "Unauthorised");
}

ReloadEnvFile();
$db = new Database($_ENV["DB_HOST"], $_ENV["DB_USER"], $_ENV["DB_PASSWORD"], $_ENV["DB_NAME"]);

$token = Database::getInstance()->real_escape_string($token);

$postedCode = $_POST["code"] ?? "";
if (!$postedCode) {
    HttpUtils::Status(400, "Missing OTP code");
}

$sql = "select idAccounts from awaiting_mfa_logins where token = ?;";
$stmt = Database::getInstance()->prepare($sql);
$stmt->bind_param("s", $token);
$stmt->execute();
$result = $stmt->get_result();
if ($result->num_rows === 0) {
    header("Content-Type: application/json");
    HttpUtils::Status(401, "Unauthorised");
}
$account = Accounts::fromId($result->fetch_assoc()["idAccounts"]);
$secret = $account->MFA_token;

if (verifyCode($secret, $postedCode)) {
    $account->MFA_token = $secret;
    $account->Save();
    $accountId = $account->idAccounts;
    $sql = "delete from awaiting_mfa_logins where idAccounts = $accountId;";
    $db->query($sql);
    $tokenValue = base64_encode(string: random_bytes(32));
    $expirationDate = (new DateTime())->add(DateInterval::createFromDateString("7 days"));
    $ip = Database::getInstance()->real_escape_string($_SERVER["HTTP_X_FORWARDED_FOR"] ?? $_SERVER["REMOTE_ADDR"] ?? "");

    $token = LoginToken::create($tokenValue, getallheaders()["User-Agent"] ?? "", $accountId, $expirationDate, $ip);

    $tokenId = $token->idLogin_token;
    $sql = "insert into admin_log_details (idAccount, idToken) values ($accountId, $tokenId);";
    Database::getInstance()->query($sql);
    $detailsId = Database::getInstance()->insert_id;
    $type = LogSuccessfulLogin;
    $sql = "insert into admin_logs (type, idDetails) values ($type, $detailsId);";
    Database::getInstance()->query($sql);

    echo json_encode([
        "username" => $account->username,
        "token" => $token->value
    ]);
} else {
    HttpUtils::Status(401, "Invalid code");
}