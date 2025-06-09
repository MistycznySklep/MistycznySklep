<?php
require_once "misc.php";
require_once "Models/Accounts.php";
require_once "Models/LoginToken.php";

if (
    !isset($_POST["password"]) || !isset($_POST["login"]) || !isset($_POST["email"]) || !isset($_POST["username"])
    || empty($_POST["password"]) || empty($_POST["login"] || empty($_POST["email"]) || empty($_POST["username"]))
) {
    HttpUtils::Status(400, "Missing login, password, email or username");
}

ReloadEnvFile();
$db = new Database($_ENV["DB_HOST"], $_ENV["DB_USER"], $_ENV["DB_PASSWORD"], $_ENV["DB_NAME"]);

$login = Database::getInstance()->real_escape_string(trim($_POST["login"]));
$username = Database::getInstance()->real_escape_string(trim($_POST["username"]));
$email = Database::getInstance()->real_escape_string(trim($_POST["email"]));
$password = password_hash(Database::getInstance()->real_escape_string(trim($_POST["password"])), PASSWORD_BCRYPT, ['cost' => 12]);

$sql = "select idAccounts from accounts where login = '$login'";
$result = $db->query($sql);
if ($result->num_rows !== 0) {
    HttpUtils::Status(409, "Account already exists");
}

$account = new Accounts($login, $username, $password, $email, "user", 0);

$tokenValue = base64_encode(random_bytes(12));
$expirationDate = (new DateTime())->add(DateInterval::createFromDateString("7 days"));
$ip = Database::getInstance()->real_escape_string($_SERVER["HTTP_X_FORWARDED_FOR"] ?? $_SERVER["REMOTE_ADDR"] ?? "");

$token = LoginToken::create($tokenValue, getallheaders()["User-Agent"] ?? "", $account->idAccounts, $expirationDate, $ip);
echo json_encode([
    "name" => $account->username,
    "token" => $token->value
]);