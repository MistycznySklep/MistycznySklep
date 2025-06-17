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

function generateBase32Secret(int $length = 32): string {
    $alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567';
    $secret = '';
    for ($i = 0; $i < $length; $i++) {
        $secret .= $alphabet[random_int(0, 31)];
    }
    return $secret;
}
$secret = generateBase32Secret();

$issuer = urlencode("LumoFlor");
$label = urlencode($account->email);
$otpauth = "otpauth://totp/{$issuer}:{$label}?secret={$secret}&issuer={$issuer}";

$qrUrl = "https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=" . urlencode($otpauth);
$dbSecret = Database::getInstance()->real_escape_string($secret);
$accountId = $account->idAccounts;
$sql = "delete from awaiting_mfas where idAccounts = $accountId;";
$db->query($sql);
$sql = "insert into awaiting_mfas (token, idAccounts) values ('$dbSecret', $accountId);";
$db->query($sql);

header('Content-Type: application/json');
echo json_encode([
    "secret" => $secret,
    "otpauth_url" => $otpauth,
    "qr_url" => $qrUrl
]);