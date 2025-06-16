<?php
require_once "misc.php";

class Categories extends Model
{
    #[Id]
    public int $idCategories;
    public string $category;

    public static function all(): array {
        $db = Database::getInstance();
        $result = $db->query("select idCategories from categories");
        $products = [];
        while ($row = $result->fetch_assoc()) {
            $products[] = new Categories($row["idCategories"]);
        }
        return $products;
    }
}