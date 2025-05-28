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

    public static function Assert(bool $condition, string $message = null)
    {
        if ($condition) return;
        $message ??= "Assertion failed";
        HttpUtils::Status(500, $message);
    }
}

class Database {
    private static mysqli | null $instance = null;
    public function __construct(string $host, string $username, string $password) {
        if (self::$instance === null)
            self::$instance = new mysqli($host, $username, $password);
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

abstract class Model {
    public function __construct(string $table = null) {
        $reflection = new ReflectionClass($this);
        if ($table === null) {
            $pascalName = $reflection->getShortName();
            $table = PascalToSnake($pascalName);
        }
        
    }
    public function Save() {
        
    }
}

#[Attribute]
class PostParam
{
    public function __construct(string $name, string $default = null)
    {
    }
}
#[Attribute]
class GetParam
{
    public function __construct(string $name, string $default = null)
    {
    }
}

class Route
{
    private Database $db;
    public function __construct()
    {
        $this->db = new Database("localhost", "root", "");
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