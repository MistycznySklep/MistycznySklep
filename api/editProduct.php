<?php
require_once "misc.php";
require_once "Models/Accounts.php";
require_once "Models/LoginToken.php";

$token = trim(getallheaders()["Authorization"] ?? "");

if (empty($token)) {
    HttpUtils::Status(401, "Unauthorised");
}

ReloadEnvFile();
$db = new Database($_ENV["DB_HOST"], $_ENV["DB_USER"], $_ENV["DB_PASSWORD"], $_ENV["DB_NAME"]);

$token = Database::getInstance()->real_escape_string($token);

$account = GetAccountOrDie($token);

$id = $_GET["id"] ?? "";
$name = $_POST["name"] ?? "";
$cena = $_POST["cena"] ?? "";
$quantity = $_POST["quantity"] ?? "";

if (empty($id) || !is_numeric($id)) {
    HttpUtils::Status(400, "missing id");
}
if ($account->type !== "admin") {
    HttpUtils::Status(401, "Unauthorised");
}

$sql = "update products set name = coalesce(?, name), price = coalesce(?, price), quantity = coalesce(?, quantity) where idProducts = ?;";
$stmt = Database::getInstance()->prepare($sql);
$stmt->bind_param("siii", $name, $cena, $quantity, $id);
$stmt->execute();
$stmt->close();

http_response_code(204);
