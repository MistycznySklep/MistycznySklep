<?php
require_once "misc.php";

class Products extends Model
{
    public int $idProducts;
    public string $name;
    public string $type;
    public float $price;
    public string $description;
    public string | null $description2;
    public int $quantity;
    public string $hexColor;
    public int $idImgs;

    public static function all(): array {
        $db = Database::getInstance();
        $result = $db->query("select idProducts from products");
        $products = [];
        while ($row = $result->fetch_assoc()) {
            $products[] = new Products($row["idProducts"]);
        }
        return $products;
    }
}