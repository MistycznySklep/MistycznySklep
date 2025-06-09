<?php
require_once "misc.php";
require_once "Models/Accounts.php";
require_once "Models/LoginToken.php";

if (
    !isset($_POST["password"]) || !isset($_POST["username"])
    || empty($_POST["password"]) || empty($_POST["username"])
) {
    HttpUtils::Status(400, "Missing login/password");
}

ReloadEnvFile();
$db = new Database($_ENV["DB_HOST"], $_ENV["DB_USER"], $_ENV["DB_PASSWORD"], $_ENV["DB_NAME"]);

$login = Database::getInstance()->real_escape_string(trim($_POST["username"]));
$password = Database::getInstance()->real_escape_string(trim($_POST["password"]));

$sql = "select idAccounts from accounts where login = '$login' and password = sha1('$password');";
$result = $db->query($sql);
if ($result->num_rows === 0) {
    HttpUtils::Status(401, "Invalid username or password");
}
$row = $result->fetch_assoc();
$id = $row["idAccounts"];
$account = Accounts::fromId($id);

$tokenValue = base64_encode(random_bytes(12));
$expirationDate = (new DateTime())->add(DateInterval::createFromDateString("7 days"));
$ip = Database::getInstance()->real_escape_string($_SERVER["HTTP_X_FORWARDED_FOR"] ?? $_SERVER["REMOTE_ADDR"] ?? "");

$token = LoginToken::create($tokenValue, getallheaders()["User-Agent"] ?? "", $id, $expirationDate, $ip);
echo json_encode([
    "name" => $account->username,
    "token" => $token->value
]);