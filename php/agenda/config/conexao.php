<?php

$host = 'db';
$user = 'root';
$pass = '1234';
$db   = 'curso';

try {
    $conn = new PDO(
        "mysql:host=$host;dbname=$db",
        $user,
        $pass

    );
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    $error = $e->getMessage();
    echo "Erro: $error";
}
