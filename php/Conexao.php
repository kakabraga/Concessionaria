<?php

class Conexao
{
    public $host  = 'db';
    public $user  = 'root';
    public $pass  = '1234';
    public $db = 'curso';

    public function __construct($host, $user, $pass, $db) {
        $this->host = $host;
        $this->user = $user;
        $this->pass = $pass;
        $this->db = $db;
        $db = new mysqli($host, $user, $pass, $db);
    }
}
