<?php 
$chave = '45PSOxmONN6OQYIT2CAUyxecyt0OOLPVkvUsmRv7';
use GuzzleHttp\Client;
require 'vendor/autoload.php';

$client = new Client();
$response = $client->request('POST', 'https://api.correios.com.br/token/v1/autentica/'.$chave);

$body = $response->getBody();
$data = json_decode($body, true);

print_r($data);
