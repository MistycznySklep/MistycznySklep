<?php
require_once "misc.php";

// CREATE TABLE `accounts` (
//   `idAccounts` int(11) AUTO_INCREMENT PRIMARY KEY NOT NULL,
//   `login` varchar(50) NOT NULL,
//   `username` varchar(30) NOT NULL,
//   `password` text NOT NULL,
//   `email` varchar(50),
//   `type` enum('user','admin','employee') NOT NULL,
//   `balance` double(10,2) NOT NULL
// );

class Accounts extends Model
{
    public function __construct(
        string $login,
        string $username,
        string $password,
        string $email,
        string $type,
        float $balance
    ) {
        $this->login = $login;
        $this->username = $username;
        $this->password = $password;
        $this->email = $email;
        $this->type = $type;
        $this->balance = $balance;
        $this->Insert();
    }

    public static function fromId(int $accountId): self
    {
        $reflect = new \ReflectionClass(static::class);
        $instance = $reflect->newInstanceWithoutConstructor();

        $modelCtor = (new \ReflectionClass(Model::class))->getConstructor();
        $modelCtor->invoke($instance, $accountId);

        return $instance;
    }

   public static function all(): array
    {
        $db = Database::getInstance();

        $stmt = mysqli_prepare($db, "SELECT idAccounts, login, username, email, type, balance FROM accounts");
        if (!$stmt) return [];

        mysqli_stmt_execute($stmt);
        mysqli_stmt_bind_result($stmt, $id, $login, $username, $email, $type, $balance);

        $accounts = [];

        while (mysqli_stmt_fetch($stmt)) {
            $reflect = new \ReflectionClass(static::class);
            $instance = $reflect->newInstanceWithoutConstructor();

            $instance->idAccounts = $id;
            $instance->login = $login;
            $instance->username = $username;
            $instance->email = $email;
            $instance->type = $type;
            $instance->balance = $balance;

            $accounts[] = $instance;
        }

        mysqli_stmt_close($stmt);

        return $accounts;
    }

    public int $idAccounts;
    public string $login;
    public string $username;
    public string $password;
    public string $email;
    public string $type;
    public float $balance;
}