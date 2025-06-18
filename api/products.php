<?php
require_once "misc.php";
require_once "Models/Accounts.php";
require_once "Models/Products.php";

header("Content-Type: application/json");

$token = trim(getallheaders()["Authorization"] ?? "");

if (empty($token)) {
    HttpUtils::Status(401, "Unauthorised");
}

ReloadEnvFile();
$db = new Database($_ENV["DB_HOST"], $_ENV["DB_USER"], $_ENV["DB_PASSWORD"], $_ENV["DB_NAME"]);

$token = Database::getInstance()->real_escape_string($token);

$account = GetAccountOrDie($token);

if (
    isset($_POST["name"]) &&
    isset($_POST["johncena"]) &&
    isset($_POST["kolor"]) &&
    isset($_POST["description"]) &&
    isset($_POST["quantity"]) &&
    isset($_POST["cat"]) &&
    isset($_POST["image"])
) {
    $data = $_POST["image"];

    if (preg_match('/^data:image\/(\w+);base64,/', $data, $matches)) {
        $ext = $matches[1];
        $data = substr($data, strpos($data, ',') + 1);
        $data = base64_decode($data);

        if ($data === false) {
            die('Base64 decoding failed');
        }
        $sql = "insert into imgs values (NULL, 'meow.png')";
        $res = Database::getInstance()->query($sql);
        $id = Database::getInstance()->insert_id;

        $fileName = "$id.png";
        $filePath = __DIR__ . "/../userImages/$fileName";

        file_put_contents($filePath, $data);
        $sql = "insert into products values (NULL, ?, 'Sprzęt', ?, ?, null, ?, ?, $id, ?);";
        $stmt = Database::getInstance()->prepare($sql);
        $stmt->bind_param("sisisi", $_POST["name"], $_POST["johncena"], $_POST["description"], $_POST["quantity"], $_POST["kolor"], $_POST["cat"]);
        $stmt->execute();
        $stmt->close();
    } else {
        die('Invalid image data format');
    }
}


echo json_encode(Products::all($_GET["q"] ?? ""));