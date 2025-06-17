<?php
require_once "misc.php";

class Products extends Model
{
    public int $idOrders;
    public int $idAccounts;
    public int $idEmployees;
    public float $price;
    public string $description;
    public string | null $description2;
    public int $quantity;
    public string $hexColor;
    public int $idImgs;

    public static function all(int $userId): array {
        $db = Database::getInstance();
        $result = $db->query("select idProducts from products where ");
        $products = [];
        while ($row = $result->fetch_assoc()) {
            $products[] = new Products($row["idProducts"]);
        }
        return $products;
    }
}