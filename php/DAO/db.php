<?php 

    $db = "daoteste";
    $host = "db";
    $user = "root";
    $pass = "1234";

    $conn = new PDO("mysql:dbname=$db; host=$host", $user, $pass);

    if ($conn) {
        echo "foi";
    } else {
        echo "nao foi";
    }