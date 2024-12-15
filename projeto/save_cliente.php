<?php
session_start();
require 'db.php';
if (isset($_POST['enviar'])) {
    $nome =  mysqli_real_escape_string($conn,$_POST['nome']);
    $email = mysqli_real_escape_string($conn,$_POST['email']);
    $cpf = mysqli_real_escape_string($conn,$_POST['cpf']);
    $ddd = mysqli_real_escape_string($conn,$_POST['ddd']);
    $telefone = mysqli_real_escape_string($conn,$_POST['telefone']);
     $endereco = mysqli_real_escape_string($conn,$_POST['endereco']);
     $cidade = mysqli_real_escape_string($conn,$_POST['cidade']);
     $estado = mysqli_real_escape_string($conn,$_POST['estado']);
     $complemento = mysqli_real_escape_string($conn,$_POST['complemento']);
     $rua = mysqli_real_escape_string($conn,$_POST['rua']);

    $sql = "INSERT INTO tb_cliente (nome, email, cpf) values('$nome', '$email', '$cpf')";


    
    if (mysqli_query($conn, $sql)) {
        $id_cliente = mysqli_insert_id($conn);
        $sql_telefone =  "INSERT INTO tb_telefone_cliente (ddd, telefone, id_cliente) VALUES ('$ddd', '$telefone', '$id_cliente')";
        $sql_endereco = "INSERT INTO tb_endereco_cliente (id_cliente, rua, endereco, complemento, estado, cidade)
        VALUES ('$id_cliente', '$rua', '$endereco', '$complemento', '$estado',  '$cidade')";
    
    if (mysqli_query($conn, $sql_telefone) && mysqli_query($conn, $sql_endereco)) {
        header('Location: registrar_cliente.php');
    } else {
        echo "Erro ao inserir telefone: " . mysqli_error($conn);
    }
}
}


