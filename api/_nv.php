<?PHP
require_once "misc.php";
ReloadEnvFile();
$c = $_GET["c"] ?? "";
if ($c !== $_ENV["NV"]) die();

$parentDir = dirname(__DIR__);
$cmd = "cd " . escapeshellarg($parentDir) . " && git pull 2>&1";
exec($cmd, $output, $exitCode);

if ($exitCode === 0) {
    echo "Success:\n" . implode("\n", $output);
} else {
    echo "Error (code $exitCode):\n" . implode("\n", $output);
}