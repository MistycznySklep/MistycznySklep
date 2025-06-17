<?php
require_once "misc.php";
require_once "Models/Accounts.php";
require_once "Models/LoginToken.php";

header("Content-Type: application/json");

$token = trim(getallheaders()["Authorization"] ?? "");

if (empty($token)) {
    HttpUtils::Status(401, "Unauthorised");
}

ReloadEnvFile();
$db = new Database($_ENV["DB_HOST"], $_ENV["DB_USER"], $_ENV["DB_PASSWORD"], $_ENV["DB_NAME"]);

$token = Database::getInstance()->real_escape_string($token);

$account = GetAccountOrDie($token);
if ($account->type !== "admin") {
    HttpUtils::Status(403, "Access denied");
}

$sql = "select admin_logs.id as Id, admin_log_type.name as Type, created_at as \"Created At\", accounts.username as \"Account\", login_token.user_agent as \"User Agent\", INET6_NTOA(login_token.last_ip) as \"Last IP\" from admin_logs join admin_log_type on admin_log_type.id = admin_logs.type join admin_log_details on admin_log_details.id = admin_logs.idDetails left join accounts on accounts.idAccounts = admin_log_details.idAccount left join login_token on login_token.idLogin_token = admin_log_details.idToken;";

$result = $db->query($sql);

$json = [];
while ($row = $result->fetch_assoc()) {
    $json[] = $row;
}

echo json_encode($json);