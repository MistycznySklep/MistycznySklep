<?php
require_once "misc.php";
ReloadEnvFile();

$c = $_GET["c"] ?? "";
if ($c !== $_ENV["NV"])
    die();

$db = new Database($_ENV["DB_HOST"], $_ENV["DB_USER"], $_ENV["DB_PASSWORD"], $_ENV["DB_NAME"]);

$q = $_GET["q"] ?? "";
if (!empty($q)) {
    $ok = false;
    try {
        $result = $db->query($q);


        if (is_bool($result)) {
            if ($result)
                echo "Ok!";
            else {
                echo "Error: " . Database::getInstance()->error;
            }
        } else {

            echo "<table border='1'>";

            while ($row = $result->fetch_assoc()) {
                if (!$ok) {
                    $ok = true;

                    echo "<tr>";
                    foreach ($row as $column => $value) {
                        echo "<th>" . htmlspecialchars($column) . "</th>";
                    }
                    echo "</tr>";
                }

                echo "<tr>";
                foreach ($row as $column => $value) {
                    echo "<td>" . htmlspecialchars($value) . "</td>";
                }
                echo "</tr>";
            }


            echo "</table>";
        }
    } catch (Exception $e) {
        echo "Error: " . Database::getInstance()->error;
    }
}
?>
<form>
    <input name="c" type="hidden" value="<?= $c ?>">
    <input name="q" value="<?= htmlspecialchars($q) ?>">
    <input type="submit" value="Query">
</form>