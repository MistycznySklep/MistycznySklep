<?php
require_once "misc.php";
require_once "Models/Accounts.php";

// CREATE TABLE `login_token` (
//   `idLogin_token` int(11) NOT NULL AUTO_INCREMENT,
//   `value` varchar(255) NOT NULL,
//   `user_agent` varchar(255) NOT NULL,
//   `idAccounts` int(11) NOT NULL,
//   `expires_at` date NOT NULL,
//   PRIMARY KEY (`idLogin_token`),
//   KEY `fk_accounts_login_token` (`idAccounts`),
//   CONSTRAINT `fk_accounts_login_token` FOREIGN KEY (`idAccounts`) REFERENCES `accounts` (`idAccounts`)
// )

class LoginToken extends Model
{
    #[Id]
    public int $idLogin_token;
    public string $value;
    public string $user_agent;
    public int $idAccounts;
    public DateTime $expires_at;
    public IP $last_ip;
    

    public function getAccount(): Accounts
    {
        return Accounts::fromId($this->idAccounts);
    }

    public static function create(string $value, string $user_agent, int $idAccounts, DateTime $expiresAt, string $lastIp): self
    {
        $reflect = new \ReflectionClass(self::class);
        $instance = $reflect->newInstanceWithoutConstructor();

        $modelCtor = (new \ReflectionClass(Model::class))->getConstructor();
        $modelCtor->invoke($instance, null);

        $instance->value = $value;
        $instance->user_agent = $user_agent;
        $instance->idAccounts = $idAccounts;
        $instance->expires_at = $expiresAt;
        $instance->last_ip = new IP($lastIp);

        $instance->Insert();

        return $instance;
    }
}