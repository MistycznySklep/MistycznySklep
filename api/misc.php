<?php

if (isset(getallheaders()["Content-Type"]) && getallheaders()["Content-Type"] === "application/json") {
    $_POST = json_decode(file_get_contents("php://input"), true);
}

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

    public static function Assert(bool $condition, string|null $message = null)
    {
        if ($condition)
            return;
        $message ??= "Assertion failed";
        HttpUtils::Status(500, $message);
    }
}

class Database
{
    private static mysqli|null $instance = null;
    public function __construct(string $host, string $username, string $password, string $name)
    {
        if (self::$instance === null)
            self::$instance = new mysqli($host, $username, $password, $name);
    }
    public static function getInstance()
    {
        HttpUtils::Assert(self::$instance !== null);
        return self::$instance;
    }
    public function query(string $query)
    {
        HttpUtils::Assert(self::$instance !== null);
        return self::$instance->query($query);
    }

    public function __destruct()
    {
        self::$instance->close();
    }
}

function PascalToSnake(string $pascal)
{
    if (empty($pascal))
        return $pascal;

    $name = strtolower($pascal[0]);
    for ($i = 1; $i < strlen($pascal); $i++) {
        $char = $pascal[$i];
        if (ctype_upper($char)) {
            $name .= "_";
            $name .= strtolower($char);
        } else
            $name .= $char;
    }
    return $name;
}

#[Attribute]
class Id
{
    public function __construct()
    {
    }
}

class IP
{
    public string $value;
    public function __construct(string $value)
    {
        $this->value = $value;
    }
}

abstract class Model
{
    private string $cacheSql = "";
    private array $columns = [];
    private string $idColumn = "";
    private string $tableName;

    public function __construct(mixed $id, string|null $table = null)
    {
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
            if (!empty($this->idColumn))
                break;
            $capitalisedTable = $table;
            $capitalisedTable[0] = strtoupper($capitalisedTable[0]);
            if ($column === "id" || $column === "id$capitalisedTable")
                $this->idColumn = $column;
        }
        if (!empty($columns))
            $columnsString = substr($columnsString, 0, -2);
        if ($id === null)
            return;

        $this->cacheSql = "select $columnsString from $table where $this->idColumn = $id";
        $this->columns = $columns;
        $this->tableName = $table;
        $this->Refresh();
    }
    public function Refresh()
    {
        if (empty($this->cacheSql))
            return;

        $db = Database::getInstance();
        $result = $db->query($this->cacheSql);
        HttpUtils::Assert($result !== false, "Database not loaded");
        HttpUtils::Assert($result->num_rows > 0, "Invalid row");
        $row = $result->fetch_assoc();
        foreach ($this->columns as $column) {
            $this->$column = $row[$column];
        }
    }
    public function Save()
    {
        $db = Database::getInstance();
        $table = $this->tableName;
        $updateSql = "update $table set ";

        foreach ($this->columns as $column) {
            $value = $this->$column;

            if ($value instanceof \DateTimeInterface) {
                $value = $value->format('Y-m-d H:i:s');
            } else if ($value instanceof \IP) {
                $ip = $value->value;
                $updateSql .= "$column = INET6_ATON('$ip'), ";
                continue;
            }

            $escaped = $db->real_escape_string((string) $value);
            $updateSql .= "$column = \"$escaped\", ";
        }
        $updateSql = substr($updateSql, 0, -2);
        $idColumn = $this->idColumn;
        $idValue = $this->$idColumn;

        $updateSql .= " where $idColumn = $idValue";
        $result = $db->query($updateSql);
        HttpUtils::Assert($result !== false, "SQL Error: $updateSql");
    }

    protected function Insert(string|null $table = null)
    {
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
            if (!empty($this->idColumn))
                break;
            $capitalisedTable = $table;
            $capitalisedTable[0] = strtoupper($capitalisedTable[0]);
            if ($column === "id" || $column === "id$capitalisedTable")
                $this->idColumn = $column;
        }
        $this->tableName = $table;
        $this->columns = $columns;

        $db = Database::getInstance();
        $table = $this->tableName;
        $updateSql = "insert into $table (";
        foreach ($this->columns as $column) {
            if ($column == $this->idColumn)
                continue;
            $updateSql .= "$column, ";
        }
        $updateSql = substr($updateSql, 0, -2);
        $updateSql .= ") values (";
        foreach ($this->columns as $column) {
            if ($column == $this->idColumn)
                continue;

            $value = $this->$column;

            if ($value instanceof \DateTimeInterface) {
                $value = $value->format('Y-m-d H:i:s');
            } else if ($value instanceof \IP) {
                $ip = $value->value;
                $updateSql .= "INET6_ATON('$ip'), ";
                continue;
            }

            $escaped = $db->real_escape_string((string) $value);
            $updateSql .= "\"$escaped\", ";
        }
        $updateSql = substr($updateSql, 0, -2);
        $updateSql .= ");";
        $result = $db->query($updateSql);
        HttpUtils::Assert($result !== false, "SQL Error: $updateSql");
        $idColumn = $this->idColumn;

        $this->$idColumn = $db->insert_id;
    }
}

#[Attribute]
class PostParam
{
    public function __construct(string $name, string|null $default = null)
    {
    }
}
#[Attribute]
class GetParam
{
    public function __construct(string $name, string|null $default = null)
    {
    }
}

function ReloadEnvFile()
{
    $file = "../.env";
    if (!file_exists($file))
        return;
    $lines = file($file, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
    foreach ($lines as $line) {
        $line = trim($line);

        if ($line === "" || $line[0] === "#")
            continue;

        // key=value
        if (preg_match('/^\s*([A-Z0-9_]+)\s*=\s*(.*)\s*$/i', $line, $matches)) {
            $key = $matches[1];
            $value = $matches[2];

            if (
                (str_starts_with($value, '"') && str_ends_with($value, '"')) ||
                (str_starts_with($value, "'") && str_ends_with($value, "'"))
            ) {
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
        else
            HttpUtils::Status(404, "Unsupported method: $httpMethod");
    }

    protected function GetDB(): Database
    {
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
            $returnType = $method->getReturnType();

            ob_start();

            if ($returnType === null || $returnType === "void")
                $this->$methodName(...$methodArguments);
            else if ($returnType->getName() === "int") {
                $code = $this->$methodName(...$methodArguments);
                $length = ob_get_length();
                http_response_code($code);
                if ($length === 0)
                    echo json_encode([
                        "code" => 200,
                    ]);
            } else
                echo json_encode($this->$methodName(...$methodArguments));

            ob_end_flush();
            return;
        }

        HttpUtils::Status(400, $foundCandidates ? "Invalid parameters" : "Invalid method");
    }
}

function PurgeStaleTokens(): void
{
    $db = Database::getInstance();
    $sql = "delete from login_token where expires_at < now();";
    $db->query($sql);
}

function GetAccountOrDie(string $token): Accounts
{
    PurgeStaleTokens();
    $db = Database::getInstance();

    $sql = "select idAccounts, INET6_NTOA(last_ip) as last_ip, expires_at from login_token where login_token.value = '$token';";
    // TODO: Additional authentication via user-agent; remove the token on mismatch

    $result = $db->query($sql);
    if ($result->num_rows === 0) {
        HttpUtils::Status(401, "Unauthorised");
    }
    $row = $result->fetch_assoc();

    $today = date("Y-m-d", (new DateTime())->add(DateInterval::createFromDateString("7 days"))->getTimestamp());
    $ip = Database::getInstance()->real_escape_string($_SERVER["HTTP_X_FORWARDED_FOR"] ?? $_SERVER["REMOTE_ADDR"] ?? "");

    if ($ip !== $row["last_ip"] || $row["expires_at"] !== $today) {
        $updateSQL = "
        update login_token
        set
            last_ip = IF(INET6_NTOA(last_ip) != '$ip', INET6_ATON('$ip'), last_ip),
            expires_at = IF(expires_at != '$today', '$today', expires_at)
        where value = '$token'";
        $db->query($updateSQL);
    }

    return Accounts::fromId($row["idAccounts"]);
}