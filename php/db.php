<?php 
$host  = 'db';
$user  = 'root';
$pass  = '1234';
$db = 'curso';

$db = new mysqli($host, $user, $pass, $db);

if ($db->connect_error) {
    echo 'deu ruim';
} else {
    echo 'deu bom';
}

$sql = 'CREATE TABLE blog(
    id int primary key auto_increment)';

$db->query($sql);