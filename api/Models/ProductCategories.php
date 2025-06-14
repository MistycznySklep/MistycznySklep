<?php
require_once "misc.php";

class ProductCategories extends Model
{
    public int $idProduct_categories;
    public string $category;

    public static function all(): array {
        $db = Database::getInstance();
        $result = $db->query("select idProduct_categories from product_categories");
        $products = [];
        while ($row = $result->fetch_assoc()) {
            $products[] = new ProductCategories($row["idProduct_categories"]);
        }
        return $products;
    }
}