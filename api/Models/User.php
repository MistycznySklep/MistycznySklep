<?php
require_once "../misc.php";

class User extends Model
{
    public int $id;
    public string $username;
    public string $password;
}