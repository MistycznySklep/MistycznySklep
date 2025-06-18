<?php
require_once "misc.php";

class Products extends Model
{
    public int $idProducts;
    public string $name;
    public float $price;
    public string $description;
    public string|null $description2;
    public int $quantity;
    public string $hexColor;
    public int $idImgs;
    public int $idProduct_subcategories;

    public static function all(string $query = ""): array
    {
        $db = Database::getInstance();
        $products = [];

        if ($query !== "") {
            $like = "%$query%";
            $stmt = $db->prepare("
                SELECT idProducts 
                FROM products 
                WHERE MATCH(name, description, description2) 
                    AGAINST (? IN NATURAL LANGUAGE MODE)
                OR name LIKE ?
                OR description LIKE ?
                OR description2 LIKE ?
            ");
            $stmt->bind_param("ssss", $query, $like, $like, $like);
            $stmt->execute();
            $result = $stmt->get_result();
        } else {
            $result = $db->query("SELECT idProducts FROM products");
        }

        while ($row = $result->fetch_assoc()) {
            $products[] = new Products($row["idProducts"]);
        }
        return $products;
    }
}