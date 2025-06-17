<?php
require_once "misc.php";
require_once "Models/Accounts.php";
require_once "Models/Carts.php";

header("Content-Type: application/json");

$token = trim(getallheaders()["Authorization"] ?? "");

if (empty($token)) {
    HttpUtils::Status(401, "Unauthorised");
}

ReloadEnvFile();
$db = new Database($_ENV["DB_HOST"], $_ENV["DB_USER"], $_ENV["DB_PASSWORD"], $_ENV["DB_NAME"]);

$token = Database::getInstance()->real_escape_string($token);

$account = GetAccountOrDie($token);

if (!isset($_POST["productId"])) {
    HttpUtils::Status(400, "Missing field: productId");
}

$productId = Database::getInstance()->real_escape_string($_POST["productId"]);

$idAccount = $account->idAccounts;
$sql = "insert into carts (idAccounts, idProducts, quantity) values ($idAccount, ?, 1);";
$stmt = Database::getInstance()->prepare($sql);
$stmt->bind_param("i", $productId);
$stmt->execute();
http_response_code(201);
?>
{ "status": "Ok" }