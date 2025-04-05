<?php
require('../vendor/autoload.php');
use GuzzleHttp\Client;

$mensagem = 'Hello';
$api = new Client();

$resposta = $api->request('POST', 'https://api.funtranslations.com/translate/pirate.json', [
    'headers' => [
        'Content-Type' => 'application/json'
    ],
    'json' => [
        'text' => $mensagem
    ]
]);

$body = $resposta->getBody();
$dados = json_decode($body, true);

if(isset($dados['contents']['translated'])) {
    echo "Mensagem original: " . htmlspecialchars($mensagem) . "<br>";
    echo "Mensagem traduzida: " . htmlspecialchars($dados['contents']['translated']);
} else {
    echo "Erro na tradução."; 
}

