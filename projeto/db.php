<?php 
if (!defined('HOST')) {
    define('HOST', 'db');
}
if (!defined('USER')) {
    define('USER', 'root');
}
if (!defined('PASS')) {
    define('PASS', '1234');
}
if (!defined('DB')) {
    define('DB', 'db_concessionaria');
}
$conn = mysqli_connect(HOST, USER, PASS, DB);

mysqli_set_charset($conn, "utf8mb4");


