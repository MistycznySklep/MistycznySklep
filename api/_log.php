<?PHP
require_once "misc.php";
ReloadEnvFile();
$c = $_GET["c"] ?? "";
if ($c !== $_ENV["NV"]) die();

readfile("/var/log/nginx/error.log");