<?php
require_once "misc.php";
require_once "Models/description.php";

class Login extends Route
{
    public function Index() {
        $meow = new Returns();
        $meow->Save();
    }
}

new Login();