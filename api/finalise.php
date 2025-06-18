<?php
require_once "misc.php";
require_once "Models/Accounts.php";
require_once "Models/LoginToken.php";
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

$totalCost = 0;
$items = Carts::all($account->idAccounts);

foreach ($items as $item) {
    $totalCost += $item->product()->price * $item->quantity;
}

if ($account->balance < $totalCost) {
    HttpUtils::Status(401, "Insufficient balance");
}
$account->balance -= $totalCost;
$account->Save();



$sql = "insert into orders_history values (NULL, ?, ?, current_timestamp())";
$stmt = Database::getInstance()->prepare($sql);
$stmt->bind_param("ii", $account->idAccounts, $totalCost);
$stmt->execute();
$id = $stmt->insert_id;
$stmt->close();


foreach ($items as $item) {
    $sql = "INSERT INTO inventory (idProducts, idAccounts, quantity)
            VALUES (?, ?, ?)
            ON DUPLICATE KEY UPDATE quantity = quantity + VALUES(quantity)";

    $stmt = Database::getInstance()->prepare($sql);
    $stmt->bind_param("iii", $item->idProducts, $account->idAccounts, $item->quantity);
    $stmt->execute();

    
    $stmt->close();
    
    $stmt = Database::getInstance()->prepare("insert into orders_history_products values (NULL, ?, ?);");
    $stmt->bind_param("ii", $id, $item->idProducts);
    $stmt->execute();
    $stmt->close();

    $item->Delete();
}
