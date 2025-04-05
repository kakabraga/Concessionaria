<?php 
$host  = 'db';
$user  = 'root';
$pass  = '1234';
$db = 'curso';

$db = new mysqli($host, $user, $pass, $db);

$nome = "Matheus";

$stmt = $db->prepare("INSERT INTO blog (nome) VALUES(?)");

$stmt->bind_param("i", $nome);
$stmt->execute();

if($stmt->errno) {
    echo "erro:" . $stmt->errno;
}
// if ($stmt->execute()) {
//     echo "Dados inseridos com sucesso";
// } else {
//     echo "Dados não foram inseridos";
// }

$db->close();


if (defined('PDO::ATTR_DRIVER_NAME')) {
    echo "PDO está habilitado.";
} else {
    echo "PDO não está habilitado.";
}

