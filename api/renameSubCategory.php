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

$name = $_POST["name"] ?? "";

if (!isset($_GET["id"]) || empty($name)) {
    HttpUtils::Status(400, "Missing field: productId");
}
if ($account->type !== "admin") {
    HttpUtils::Status(401, "Unauthorised");
}

$cartId = Database::getInstance()->real_escape_string($_GET["id"]);

$idAccount = $account->idAccounts;
$sql = "update product_subcategories set subcategory = ? where idProduct_subcategories = ?;";
$stmt = Database::getInstance()->prepare($sql);
$stmt->bind_param("si", $name, $cartId);
$stmt->execute();
http_response_code(204);
?>