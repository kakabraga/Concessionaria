<?php 

define('HOST', 'db');
define('USER', 'root');
define('PASS', '1234');
define('DB', 'db_concessionaria');

$conn = mysqli_connect(HOST, USER, PASS, DB);

mysqli_set_charset($conn, "utf8mb4");