<?php
require_once "misc.php";
require_once "Models/Accounts.php";
require_once "Models/LoginToken.php";

header("Content-Type: application/json");

$login = trim($_POST["login"] ?? "");
$password = trim($_POST["password"] ?? "");

if (empty($login) || empty($password)) {
    HttpUtils::Status(400, "Missing credentials");
}

ReloadEnvFile();
$db = new Database($_ENV["DB_HOST"], $_ENV["DB_USER"], $_ENV["DB_PASSWORD"], $_ENV["DB_NAME"]);

$login = Database::getInstance()->real_escape_string($login);

$stmt = Database::getInstance()->prepare("select idAccounts, password from accounts where login = ?");
$stmt->bind_param("s", $login);
$stmt->execute();
$result = $stmt->get_result();

$fakeHash = $_ENV["FakeBCRYPT"] ?? "$2y$12\$usesomesillystringfore7hnbRJHxXVLeakoG8K30oukPsA.ztMG";

if ($result->num_rows === 0) {
    password_verify($password, $fakeHash);
    HttpUtils::Status(401, "Invalid login or password");
}

$row = $result->fetch_assoc();

if (!password_verify($password, $row["password"])) {
    $idAccounts = $row["idAccounts"];
    $sql = "insert into admin_log_details (idAccount) values ($idAccounts);";
    Database::getInstance()->query($sql);
    $detailsId = Database::getInstance()->insert_id;
    $type = LogFailedLogin;
    $sql = "insert into admin_logs (type, idDetails) values ($type, $detailsId);";
    Database::getInstance()->query($sql);

    HttpUtils::Status(401, "Invalid login or password");
}

$id = $row["idAccounts"];
$account = Accounts::fromId($id);

if ($account->MFA_token !== null && !empty($account->MFA_token)) {
    $mfaToken = base64_encode(string: random_bytes(24));
    $mfaTokenSql = Database::getInstance()->real_escape_string($mfaToken);
    $sql = "insert into awaiting_mfa_logins (token, expires_at, idAccounts) values ('$mfaTokenSql', curdate(), $id);";
    Database::getInstance()->query($sql);
    HttpUtils::Status(401,[
        "mfa" => $mfaToken,
    ]);
}

$tokenValue = base64_encode(string: random_bytes(32));
$expirationDate = (new DateTime())->add(DateInterval::createFromDateString("7 days"));
$ip = Database::getInstance()->real_escape_string($_SERVER["HTTP_X_FORWARDED_FOR"] ?? $_SERVER["REMOTE_ADDR"] ?? "");

$token = LoginToken::create($tokenValue, getallheaders()["User-Agent"] ?? "", $id, $expirationDate, $ip);

$tokenId = $token->idLogin_token;
$sql = "insert into admin_log_details (idAccount, idToken) values ($id, $tokenId);";
Database::getInstance()->query($sql);
$detailsId = Database::getInstance()->insert_id;
$type = LogSuccessfulLogin;
$sql = "insert into admin_logs (type, idDetails) values ($type, $detailsId);";
Database::getInstance()->query($sql);

echo json_encode([
    "username" => $account->username,
    "token" => $token->value
]);
