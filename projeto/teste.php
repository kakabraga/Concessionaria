<?php
use Dotenv\Dotenv;
require 'vendor/autoload.php';
$dotenv = Dotenv::createImmutable(__DIR__);
$dotenv->safeLoad();

if (file_exists(__DIR__.'/.env')) {
    echo "O arquivo .env foi encontrado.\n";
} else {
    echo "O arquivo .env NÃO foi encontrado.\n";
}

var_dump(getenv('USERNAME_PHPMAILER'));
var_dump(getenv('SENHA_PHPMAILER'));


?>
