<?php
require 'db.php';

if (isset($_POST['enviar'])) {
    $id_filial = mysqli_insert_id($conn);
    $nome = mysqli_real_escape_string($conn, $_POST['nome']);
    $cnpj = mysqli_real_escape_string($conn, $_POST['cnpj']);
    $email = mysqli_real_escape_string($conn, $_POST['email']);
    $telefone = mysqli_real_escape_string($conn, $_POST['telefone']);
    $endereco = mysqli_real_escape_string($conn, $_POST['endereco']);
    $cidade = mysqli_real_escape_string($conn, $_POST['cidade']);
    $estado = mysqli_real_escape_string($conn, $_POST['estado']);
    $cep = mysqli_real_escape_string($conn, $_POST['cep']);
    $tipo_end = mysqli_real_escape_string($conn, $_POST['tipo_end']);


    $sql = "INSERT INTO tb_fornecedor (nome, cnpj, email) VALUES ('$nome', '$cnpj', '$email')";

    if (mysqli_query($conn, $sql)) {
        $id_fornecedor = mysqli_insert_id($conn);
        $sql_telefone = "INSERT INTO tb_telefone_fornecedor (id_fornecedor, telefone) VALUES ('$id_fornecedor', '$telefone')";
        $sql_endereco = "INSERT INTO tb_endereco_fornecedor (id_fornecedor, endereco, cidade, estado, cep, tipo) VALUES ('$id_fornecedor', '$endereco', '$cidade', '$estado', '$cep', '$tipo_end')";
        if (mysqli_query($conn, $sql_telefone) && mysqli_query($conn, $sql_endereco)) {
            header('Location: registrar_fornecedor.php');
        } else {
            echo "Erro ao inserir telefone: " . mysqli_error($conn);
        }
    }
}
