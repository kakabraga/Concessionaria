<?php
$host = 'db';
$db = 'curso';
$user = 'root';
$pass = '1234';

$conn = new PDO(

    "mysql:host=$host;dbname=$db",
    $user,
    $pass

);
