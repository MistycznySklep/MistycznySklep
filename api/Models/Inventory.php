<?php
require_once "misc.php";

class Inventory extends Model
{
    public int $idInventory;
    public int $idAccounts;
    public int $idProducts;
    public int $quantity;

    public function product(): Products
    {
        return new Products($this->idProducts);
    }

    public function asJson(): mixed
    {
        return [
            "id" => $this->idInventory,
            "product" => $this->product(),
            "quantity" => $this->quantity
        ];
    }

    public static function all(int $accountId): array {
        $db = Database::getInstance();
        $result = $db->query("select idInventory from inventory where idAccounts = $accountId;");
        $products = [];
        while ($row = $result->fetch_assoc()) {
            $products[] = new Inventory($row["idInventory"]);
        }
        return $products;
    }
    public static function allJson(int $accountId): array
    {
        $db = Database::getInstance();
        $result = $db->query("select idInventory from inventory where idAccounts = $accountId;");
        $carts = [];
        while ($row = $result->fetch_assoc()) {
            $carts[] = new Inventory($row["idInventory"])->asJson();
        }
        return $carts;
    }
}