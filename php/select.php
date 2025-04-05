<?php
$host  = 'db';
$user  = 'root';
$pass  = '1234';
$db = 'curso';

$db = new mysqli($host, $user, $pass, $db);


$id = 0;

$stmt = $db->prepare("SELECT * FROM blog WHERE id > ?");
$stmt->bind_param("i", $id);
$stmt->execute();
$result = $stmt->get_result();
$retorno = $result->fetch_all(MYSQLI_ASSOC);

print_r($retorno);

    foreach ($retorno as $r) {
        echo "ID: " .$r['id']. " Nome: " . $r['nome'] . "<br>";
    }


    $stmt->bind_param("ssi", $nome, $descricao, $id);
    