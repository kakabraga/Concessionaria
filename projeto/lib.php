<?php 

date_default_timezone_set('America/Sao_Paulo');
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;
use Dotenv\Dotenv;
require 'vendor/autoload.php';
$dotenv = Dotenv::createImmutable(__DIR__);
$dotenv->safeload();
$mail = new PHPMailer(true);

echo __DIR__;