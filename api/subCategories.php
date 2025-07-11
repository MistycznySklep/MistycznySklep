<?php
require_once "misc.php";
require_once "Models/Accounts.php";
require_once "Models/ProductSubcategories.php";

header("Content-Type: application/json");

$token = trim(getallheaders()["Authorization"] ?? "");

if (empty($token)) {
    HttpUtils::Status(401, "Unauthorised");
}

ReloadEnvFile();
$db = new Database($_ENV["DB_HOST"], $_ENV["DB_USER"], $_ENV["DB_PASSWORD"], $_ENV["DB_NAME"]);

$token = Database::getInstance()->real_escape_string($token);

$account = GetAccountOrDie($token);

if (
    isset($_POST["name"]) &&
    isset($_POST["category"]) &&
    $account->type == "admin"
) {
     $stmt = Database::getInstance()->prepare("insert into product_subcategories values (NULL, ?, ?)");
     $stmt->bind_param("is", $_POST["category"], $_POST["name"]);
     $stmt->execute();
     $stmt->close();
}


echo json_encode(ProductSubcategories::all());