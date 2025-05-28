<?php

class HttpUtils
{
    public static function Status(int $code, mixed $details)
    {
        http_response_code($code);
        if (is_string($details))
            $details = [
                "error" => $details
            ];
        echo json_encode($details, true);
        die();
    }

    public static function Assert(bool $condition, string | null $message = null)
    {
        if ($condition) return;
        $message ??= "Assertion failed";
        HttpUtils::Status(500, $message);
    }
}

class Database {
    private static mysqli | null $instance = null;
    public function __construct(string $host, string $username, string $password, string $name) {
        if (self::$instance === null)
            self::$instance = new mysqli($host, $username, $password, $name);
    }
    public static function getInstance() {
        HttpUtils::Assert(self::$instance !== null);
        return self::$instance;
    }
    public function query(string $query) {
        HttpUtils::Assert(self::$instance !== null);
        return self::$instance->query($query);
    }

    public function __destruct() {
        self::$instance->close();
    }
}

function PascalToSnake(string $pascal) {
    if (empty($pascal)) return $pascal;

    $name = strtolower($pascal[0]);
    for ($i = 1; $i < strlen($pascal); $i++) {
        $char = $pascal[$i];
        if (ctype_upper($char)) {
            $name .= "_";
            $name .= strtolower($char);
        } else $name .= $char;
    }
    return $name;
}

#[Attribute]
class Id {
    public function __construct() {}
}

abstract class Model {
    private string $cacheSql = "";
    private array $columns = [];
    private string $idColumn = "";

    public function __construct(mixed $id, string | null $table = null) {
        $reflection = new ReflectionClass($this);
        if ($table === null) {
            $pascalName = $reflection->getShortName();
            $table = PascalToSnake($pascalName);
        }
        
        $fields = $reflection->getProperties();
        $columns = [];
        $columnsString = "";
        foreach ($fields as $field) {
            $idAttribute = $field->getAttributes(Id::class);
            if (!empty($idAttribute)) {
                $this->idColumn = $field->getName();
            }
            $columns[] = $field->getName();
            $columnsString .= $field->getName() . ", ";
        }
        foreach ($columns as $column) {
            if (!empty($this->idColumn)) break;
            $capitalisedTable = $table;
            $capitalisedTable[0] = strtoupper($capitalisedTable[0]);
            if ($column === "id" || $column === "id$capitalisedTable") $this->idColumn = $column;
        }
        if (!empty($columns)) $columnsString = substr($columnsString,0,-2);
        $this->cacheSql = "select $columnsString from $table where $this->idColumn = $id";
        $this->columns = $columns;
        $this->Refresh();
    }
    public function Refresh() {
        $db = Database::getInstance();
        $result = $db->query($this->cacheSql);
        HttpUtils::Assert($result !== false, "Database not loaded");
        HttpUtils::Assert($result->num_rows > 0, "Invalid row");
        $row = $result->fetch_assoc();
        foreach ($this->columns as $column) {
            $this->$column = $row[$column];
        }
    } 
    public function Save() {
        
    }
}

#[Attribute]
class PostParam
{
    public function __construct(string $name, string | null $default = null)
    {
    }
}
#[Attribute]
class GetParam
{
    public function __construct(string $name, string | null $default = null)
    {
    }
}

function ReloadEnvFile() {
    $file = "../.env";
    if (!file_exists($file)) return;
    $lines = file($file, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
    foreach ($lines as $line) {
        $line = trim($line);

        if ($line === "" || $line[0] === "#") continue;

        // key=value
        if (preg_match('/^\s*([A-Z0-9_]+)\s*=\s*(.*)\s*$/i', $line, $matches)) {
            $key = $matches[1];
            $value = $matches[2];

            if ((str_starts_with($value, '"') && str_ends_with($value, '"')) ||
                (str_starts_with($value, "'") && str_ends_with($value, "'"))) {
                $value = substr($value, 1, -1);
            }

            putenv("$key=$value");
            $_ENV[$key] = $value;
        }
    }
}

class Route
{
    private Database $db;
    public function __construct()
    {
        ReloadEnvFile();

        $this->db = new Database($_ENV["DB_HOST"], $_ENV["DB_USER"], $_ENV["DB_PASSWORD"], $_ENV["DB_NAME"]);
        $httpMethod = $_SERVER["REQUEST_METHOD"];

        header("Content-Type: application/json");
        if ($httpMethod === "POST")
            $this->EnumeratePost();
        else if ($httpMethod === "GET")
            $this->EnumerateGet();
        else HttpUtils::Status(404, "Unsupported method: $httpMethod");
    }

    protected function GetDB(): Database {
        return $this->db;
    }
    protected function Redirect(string $url) 
    {
        header("Location: $url");
        die();
    }

    private function EnumeratePost()
    {
        $reflect = new ReflectionClass($this);
        $methods = $reflect->getMethods(ReflectionMethod::IS_PUBLIC);
        $foundCandidates = false;

        foreach ($methods as $method) {
            $attributes = $method->getAttributes(PostParam::class);
            if (empty($attributes))
                continue;
            $foundCandidates = true;

            $params = [];
            foreach ($attributes as $attr) {
                $args = $attr->getArguments();
                if (sizeof($args) == 1)
                    $params[] = ["name" => $args[0]];
                else if (sizeof($args) == 2)
                    $params[] = ["name" => $args[0], "default" => $args[1]];
                else
                    HttpUtils::Status(500, "Invalid route");
            }

            // check requirements
            $meetsCritera = true;
            $methodArguments = [];

            foreach ($params as $param) {
                if (!isset($_POST[$param["name"]])) {
                    if (isset($param["default"]))
                        $methodArguments[] = $param["default"];
                    else {
                        $meetsCritera = false;
                        break;
                    }
                } else
                    $methodArguments[] = $_POST[$param["name"]];
            }
            if (!$meetsCritera)
                continue;
            $this->$method(...$methodArguments);
            return;
        }

        HttpUtils::Status(400, $foundCandidates ? "Invalid parameters" : "Invalid method");
    }
    private function EnumerateGet()
    {
        $reflect = new ReflectionClass($this);
        $methods = $reflect->getMethods(ReflectionMethod::IS_PUBLIC);
        $foundCandidates = false;

        foreach ($methods as $method) {
            $attributes = $method->getAttributes(GetParam::class);
            $foundCandidates = true;

            $params = [];
            foreach ($attributes as $attr) {
                $args = $attr->getArguments();
                if (sizeof($args) == 1)
                    $params[] = ["name" => $args[0]];
                else if (sizeof($args) == 2)
                    $params[] = ["name" => $args[0], "default" => $args[1]];
                else
                    HttpUtils::Status(500, "Invalid route");
            }

            // check requirements
            $meetsCritera = true;
            $methodArguments = [];

            foreach ($params as $param) {
                if (!isset($_GET[$param["name"]])) {
                    if (isset($param["default"]))
                        $methodArguments[] = $param["default"];
                    else {
                        $meetsCritera = false;
                        break;
                    }
                } else
                    $methodArguments[] = $_GET[$param["name"]];
            }
            if (!$meetsCritera)
                continue;
            $methodName = $method->getName();
            $this->$methodName(...$methodArguments);
            return;
        }

        HttpUtils::Status(400, $foundCandidates ? "Invalid parameters" : "Invalid method");
    }
}