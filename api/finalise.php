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

$totalCost = 0;
$items = Carts::all($account->idAccounts);

foreach ($items as $item) {
    $totalCost += $item->product()->price * $item->quantity;
}

if ($account->balance < $totalCost) {
    HttpUtils::Status(401, "Insufficient balance");
}
$account->balance = $totalCost;
$account->Save();

