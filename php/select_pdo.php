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

$id = 0;

$stmt = $conn->prepare("SELECT * FROM blog WHERE id > :id");
$stmt->bindParam(":id", $id);
$stmt->execute();

$retorno = $stmt->fetchAll(PDO::FETCH_ASSOC);

foreach ($retorno as $linha) {
   echo "ID: " .$linha['id']. " " . $linha['nome'] . "<br>";
    }

// print_r($retorno);
