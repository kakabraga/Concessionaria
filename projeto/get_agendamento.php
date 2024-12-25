<?php
require 'db.php';

$sql = " SELECT c.nome as cliente_nome, f.nome as funcionario, s.descricao, st.nome as setor, fl.nome as filial, a.data_agendamento, a.hora_agendamento 
FROM tb_cliente as c
INNER JOIN tb_agendamento as a ON a.id_cliente = c.id_cliente
INNER JOIN tb_funcionario as f ON a.id_funcionario = f.id_funcionario
INNER JOIN tb_servico_prestado as s ON a.id_servico_prestado = s.id_servico
INNER JOIN tb_setor as st ON a.id_setor = st.id_setor
INNER JOIN tb_filial as fl ON a.id_filial = fl.id_filial
";

$result = mysqli_query($conn, $sql);
 if (mysqli_num_rows($result) > 0 ) {
    while ($r = mysqli_fetch_assoc($result)) {
    echo '<tr>'; 
    echo '<td>' . $r['cliente_nome'] . '</td>'; 
    echo '<td>' . $r['funcionario'] . '</td>'; 
    echo '<td>' . $r['descricao'] . '</td>'; 
    echo '<td>' . $r['setor'] . '</td>'; 
    echo '<td>' . $r['filial'] . '</td>'; 
    echo '<td>' . $r['data_agendamento'] . '</td>'; 
    echo '<td>' . $r['hora_agendamento'] . '</td>'; 
    echo '</tr>'; } 
    echo '</tbody>'; 
    echo '</table>'; 
    }