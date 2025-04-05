<?php
require 'vendor/autoload.php';

use Dotenv\Dotenv;

// Carrega as variáveis de ambiente
$dotenv = Dotenv::createImmutable(__DIR__);
$dotenv->load();

echo "Diretório atual: " . __DIR__ . "\n";
var_dump(getenv('SENHA_BLABLA'));
var_dump(getenv('SENHA_PHPMAILER'));
