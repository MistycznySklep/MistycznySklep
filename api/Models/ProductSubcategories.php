<?php
require_once "misc.php";

class ProductSubcategories extends Model
{
    #[Id]
    public int $idProduct_subcategories;
    public int $idCategories;
    public string $subcategory;

    public static function all(): array {
        $db = Database::getInstance();
        $result = $db->query("select idProduct_subcategories from product_subcategories");
        $products = [];
        while ($row = $result->fetch_assoc()) {
            $products[] = new ProductSubcategories($row["idProduct_subcategories"]);
        }
        return $products;
    }
}