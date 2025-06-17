<?php
require_once "misc.php";
require_once "Models/Accounts.php";

header("Content-Type: application/json");

$token = trim(getallheaders()["Authorization"] ?? "");

if (empty($token)) {
    HttpUtils::Status(401, "Unauthorised");
}

ReloadEnvFile();
$db = new Database($_ENV["DB_HOST"], $_ENV["DB_USER"], $_ENV["DB_PASSWORD"], $_ENV["DB_NAME"]);

$token = Database::getInstance()->real_escape_string($token);

$account = GetAccountOrDie($token);
if ($account->type !== "admin") {
    HttpUtils::Status(401, "Unauthorised");
}

$httpMethod = $_SERVER["REQUEST_METHOD"];
if ($httpMethod === "DELETE" && isset($_GET["id"])) {
    $id = $_GET["id"] ?? null;

    if (!$id || !is_numeric($id))
        HttpUtils::Status(400, "Missing or invalid id");

    $deleteSql = "delete from accounts where idAccounts = ?;";
    $stmt = Database::getInstance()->prepare($deleteSql);
    $stmt->bind_param("i", $id);
    $stmt->execute();
    $stmt->close();
    http_response_code(204);
    die();
}

echo json_encode(Accounts::all());