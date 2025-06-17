<?php
require_once "misc.php";
require_once "Models/Accounts.php";
require_once "Models/Products.php";

class Carts extends Model
{
    public int $idCarts;
    public int $idAccounts;
    public int $idProducts;
    public int $quantity;

    public function account(): Accounts
    {
        return Accounts::fromId($this->idAccounts);
    }
    public function product(): Products
    {
        return new Products($this->idProducts);
    }

    public function asJson(): mixed
    {
        return [
            "id" => $this->idCarts,
            "product" => $this->product(),
            "quantity" => $this->quantity
        ];
    }

    public static function all(int $userId): array
    {
        $db = Database::getInstance();
        $result = $db->query("select idCarts from carts where idAccounts = $userId");
        $carts = [];
        while ($row = $result->fetch_assoc()) {
            $carts[] = new Carts($row["idCarts"]);
        }
        return $carts;
    }
    public static function allJson(int $userId): array
    {
        $db = Database::getInstance();
        $result = $db->query("select idCarts from carts where idAccounts = $userId");
        $carts = [];
        while ($row = $result->fetch_assoc()) {
            $carts[] = new Carts($row["idCarts"])->asJson();
        }
        return $carts;
    }
}