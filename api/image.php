<?php
require_once "misc.php";
require_once "Models/Accounts.php";
require_once "Models/LoginToken.php";

$imageId = trim($_GET["id"] ?? "");

if (empty($imageId) || !is_numeric($imageId)) {
    header("Content-Type: application/json");
    HttpUtils::Status(400, "Invalid or missing field: id");
}

ReloadEnvFile();
$db = new Database($_ENV["DB_HOST"], $_ENV["DB_USER"], $_ENV["DB_PASSWORD"], $_ENV["DB_NAME"]);

$imageId = Database::getInstance()->real_escape_string($imageId);

$stmt = Database::getInstance()->prepare("select name from imgs where idImgs = ?");
$stmt->bind_param("i", $imageId);
$stmt->execute();
$result = $stmt->get_result();
if ($result->num_rows === 0) {
    header("Content-Type: application/json");
    HttpUtils::Status(404, "Resource not found");
}
$name = $result->fetch_assoc()["name"];
$path = __DIR__ . "/../userImages/$imageId.png";
if (!file_exists($path)) {
    header("Content-Type: application/json");
    HttpUtils::Status(500, [
        "message" => "Resource not found (but it appears to exist)",
        "details" => "Please report this issue at https://github.com/MistycznySklep/MistycznySklep/issues"
    ]);
}

http_response_code(200);
header("Content-Type: image/png");
if (isset($_GET["download"]))
    header("Content-Disposition: attachment; filename=\"$name.png\"");
else
    header("Content-Disposition: inline; filename=\"$name.png\"");

readfile($path);