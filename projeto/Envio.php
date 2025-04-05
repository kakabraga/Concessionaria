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
    Class Email {
        
        public $id;
        public $remente = 'cauebraga96@outlook.com';
        public $destinatario;
        public $mensagem;
        public $hora;

        // public function __construct($destinatario, $mensagem, $hora) {
        //     $this->destinatario = $destinatario;
        //     $this->mensagem = $mensagem;
        //     $this->hora = $hora;
        // }


        public function __construct($destinatario, $mensagem, $hora) {
            $this->destinatario = $destinatario;
            $this->mensagem = $mensagem;
            $this->hora = $hora;
            
        }
        public function enviaEmail(
           
        ) {

            $dotenv = Dotenv::createImmutable(__DIR__);
            $dotenv->safeload();
            $mail = new PHPMailer(true);
            try {
                //Server settings
                $mail->SMTPDebug = SMTP::DEBUG_OFF;                      //Enable verbose debug output
                $mail->isSMTP();                                            //Send using SMTP
                $mail->Host       = 'sandbox.smtp.mailtrap.io';                     //Set the SMTP server to send through
                $mail->SMTPAuth   = true;                                   //Enable SMTP authentication
                $mail->Username   = getenv('USERNAME_PHPMAILER');                     //SMTP username
                $mail->Password   = getenv('SENHA_PHPMAILER');                               //SMTP password
                $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;            //Enable implicit TLS encryption
                $mail->Port       = 2525; 

                $mail->setFrom('cauebraga96@outlook.com', 'ConfiaCar');
                $mail->addAddress($this->destinatario , 'ConfiaCar');     //Add a recipient
                $mail->addAddress('ellen@example.com');               //Name is optional
                $mail->addReplyTo('cauebraga96@outlook.com', 'Information');
                $mail->addCC('cc@example.com');
                $mail->addBCC('bcc@example.com');

                $mail->isHTML(true);                                  //Set email format to HTML
                $mail->Subject = 'ConfiaCar sempre com voce!!!';
                $mail->Body    = $this->mensagem ;
                $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';

                $mail->send();
                //echo 'Message has been sent';
                } catch (Exception $e) {
                  //echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
                }

        }
    }
