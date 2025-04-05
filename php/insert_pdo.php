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

$stmt = $conn->prepare("INSERT INTO blog (nome) VALUES (:nome)");
$nome = "Ayalla";
$stmt->bindParam(":nome", $nome);
if($stmt->execute()) {
    echo "Deu bom";
} else {
    echo "Deu ruim";
}