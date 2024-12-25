<?php 
require 'db.php';
if(isset($_POST['enviar'])) {
    $cliente = $_POST['cliente'];
    $funcionario = $_POST['funcionario'];
    $servico = $_POST['servico'];
    $data = $_POST['data'];
    $filial = $_POST['filial'];
    $setor = $_POST['setor'];
    $hora  = $_POST['hora'];

    $sql = "INSERT INTO tb_agendamento (id_cliente, id_funcionario, id_servico_prestado, data_agendamento, id_filial, id_setor, hora_agendamento)
    VALUES ('$cliente', '$funcionario', '$servico', '$data', '$filial', '$setor', '$hora')";

   $result = mysqli_query($conn, $sql);

   mysqli_affected_rows($conn) > 0 ? header ('Location: agendamento.php') : die('Erro ao inserir usuario'.  mysqli_error($conn));

}