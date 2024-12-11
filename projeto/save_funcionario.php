<?php 
require 'db.php';
if(isset($_POST['enviar'])) {
    $nome = $_POST['nome'];
    $cpf = $_POST['cpf'];
    $cargo = $_POST['cargo'];
    $salario = $_POST['salario'];
    $data = $_POST['data'];
    $filial = $_POST['filial'];
    $setor = $_POST['setor'];

    $sql = "INSERT INTO tb_funcionario (nome, cpf, cargo, salario, data_admissao, id_filial, id_setor)
    VALUES ('$nome', '$cpf', '$cargo', '$salario', '$data', '$filial', $setor)";

   $result = mysqli_query($conn, $sql);

   mysqli_affected_rows($conn) > 0 ? header ('Location: registrar_funcionario.php') : die('Erro ao inserir usuario'.  mysqli_error($conn));

}