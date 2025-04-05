<?php
require 'db.php';
include 'Envio.php';

$sql = " SELECT c.nome as cliente_nome, c.email as cliente_email, f.nome as funcionario, s.descricao, st.nome as setor, fl.nome as filial, a.data_agendamento, a.hora_agendamento, a.id_agendamento 
FROM tb_cliente as c
INNER JOIN tb_agendamento as a ON a.id_cliente = c.id_cliente
INNER JOIN tb_funcionario as f ON a.id_funcionario = f.id_funcionario
INNER JOIN tb_servico_prestado as s ON a.id_servico_prestado = s.id_servico
INNER JOIN tb_setor as st ON a.id_setor = st.id_setor
INNER JOIN tb_filial as fl ON a.id_filial = fl.id_filial
ORDER BY a.data_agendamento
";

$horahoje = new Datetime;
$result = mysqli_query($conn, $sql);
if (mysqli_num_rows($result) > 0) {
   while ($r = mysqli_fetch_assoc($result)) {
      echo '<tr>';
      echo '<td>' . $r['cliente_nome'] . '</td>';
      echo '<td>' . $r['funcionario'] . '</td>';
      echo '<td>' . $r['descricao'] . '</td>';
      echo '<td>' . $r['setor'] . '</td>';
      echo '<td>' . $r['filial'] . '</td>';
      echo '<td>' . $r['data_agendamento'] . '</td>';
      echo '<td>' . $r['hora_agendamento'] . '</td>';
      
      if ($r['hora_agendamento'] <= $horahoje) {
         echo '<td><span style="color: red;">Atrasado</span></td>';
      } else {
         echo '<td><span style="color: green;">No Horário</span></td>';
      }

      $destinatario = $r['cliente_email'];
      $horas = $r['hora_agendamento'];
      $nome = $r['cliente_nome'];

      // ✅ Corrigindo os botões
      echo '<td>';
      echo '<a href="editar_agendamento.php?id=' . $r['id_agendamento'] . '" class="btn btn-primary">Editar</a> ';
      echo '<a href="#" onclick="excluirRegistro(' . $r['id_agendamento'] . ')" class="btn btn-danger">Excluir</a>';
      echo '</td>';

      echo '</tr>';

      // $mensagem = "Ola " . $nome . " Voce esta atrasado, seu horario era as: " . $horas;
      // date_default_timezone_set('America/Sao_Paulo');
      // if ($horas <= $horahoje) {
      //    $mensagem = new Email(
      //       $destinatario,
      //       $mensagem,
      //       $horas,
      //    );
      //    $mensagem->enviaEmail();
      // }
   }
   echo '</tbody>';
   echo '</table>';
}
