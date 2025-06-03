<?php
const DB_HOST = "localhost";
const DB_USER = "root";
const DB_PASSWORD = "";
const DB_NAME = "magiczny_sklep_ogrodniczy";

$db = new mysqli ( DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);

if(!$db || $db->connect_error){
    echo "wystąpił problem z połączeniem z bazą danych, spróbuj ponownie"  . mysqli_connect_error();
}else{
    
}



?>