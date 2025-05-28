<?php
require_once "misc.php";
require_once "Models/description.php";

class Login extends Route
{
    public function Index(): int {
        $meow = new Returns(1);
        echo "$meow->idReturns\n";
        echo "$meow->idOrders\n";
        echo "$meow->idProducts\n";
        $meow->Save();
        return 404;
    }
}

new Login();