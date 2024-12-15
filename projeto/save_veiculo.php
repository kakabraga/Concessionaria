<?php
require 'db.php';

if (isset($_POST['enviar'])) {
    $modelo = mysqli_real_escape_string($conn, $_POST['modelo']);
    $marca = mysqli_real_escape_string($conn,$_POST['marca']);
    $cor = mysqli_real_escape_string($conn,$_POST['cor']);
    $preco = mysqli_real_escape_string($conn,$_POST['preco']);
    $ano = mysqli_real_escape_string($conn,$_POST['ano']);
    $filial = mysqli_real_escape_string($conn,$_POST['filial']);
    $quantidade = mysqli_real_escape_string($conn,$_POST['quantidade']);

    $sql = "INSERT INTO tb_estoque_veiculo (modelo, marca, cor, preco, ano, id_filial, quantidade) 
    VALUES ('$modelo', '$marca', '$cor', '$preco', '$ano', '$filial', '$quantidade')";

    $resultado = mysqli_query($conn, $sql);

    mysqli_affected_rows($conn) > 0 ? header('Location: registrar_veiculo.php') :  die('Erro ao inserir usuario'.  mysqli_error($conn));

    
}
