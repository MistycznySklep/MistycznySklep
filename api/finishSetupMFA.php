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
    HttpUtils::Status(400,"Missing OTP code");
}

$accountId = $account->idAccounts;
$secretSql = "select token from awaiting_mfas where idAccounts = $accountId;";
$result = $db->query($secretSql);
if ($result->num_rows === 0) {
    HttpUtils::Status(404,"No MFA is currently awaiting");
}
$secret = $result->fetch_assoc()["token"];

if (verifyCode($secret, $postedCode)) {
    $account->MFA_token = $secret;
    $account->Save();
    $sql = "delete from awaiting_mfas where idAccounts = $accountId;";
    $db->query($sql);
    HttpUtils::Status(200,"Success!");
} else {
    HttpUtils::Status(401,"Invalid code");
}