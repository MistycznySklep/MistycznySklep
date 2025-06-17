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

$account = GetAccountOrDie($token);

$postedCode = $_POST["code"] ?? "";
if (!$postedCode) {
    HttpUtils::Status(400,"Missing voucher code");
}

$sql = "select idCash_codes, value from cash_codes where code = ? and isUsed = false;";
$stmt = Database::getInstance()->prepare($sql);
$stmt->bind_param("s", $postedCode);
$stmt->execute();
$stmt->bind_result($idCash_codes, $value);
$stmt->fetch();
$stmt->close();

if ($idCash_codes) {
    $account->balance += $value;
    $account->Save();

    $update = Database::getInstance()->prepare("update cash_codes set isUsed = true where idCash_codes = ?");
    $update->bind_param("i", $idCash_codes);
    $update->execute();
    $update->close();
    http_response_code(200);
    die();
}
HttpUtils::Status(400,"Invalid code");