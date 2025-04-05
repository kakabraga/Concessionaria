<?php
require 'db.php ';
class Excluir
{

    public function excluir($id)
    {
        $id_agendamento = $_POST['excluir'];

        $sql = "DELETE FROM tb_agendamento WHERE id_agendamento = $id_agendamento";

        mysqli_affected_rows($conn) > 0 ? header('Location: registrar_funcionario.php') : die('Erro ao inserir usuario' .  mysqli_error($conn));
    }
}
