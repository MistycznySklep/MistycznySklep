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

$json = [];
$idAcocunts = $account->idAccounts;
$sql = "select idOrdersHistory, final_cost, ordered_at from orders_history where idAccounts = $idAcocunts";
$result = $db->query($sql);
while ($row = $result->fetch_assoc()) {
     $sql = "select products.name as Name from orders_history_accounts join products on orders_history_accounts.idAccounts = products.idProducts;";
     $nestedResult = $db->query($sql);
     $object = [
          "price" => $row["final_cost"],
          "ordered_at" => $row["ordered_at"],
          "products" => $nestedResult->fetch_all()
     ];
     $json[] = $object;
}

echo json_encode($json);