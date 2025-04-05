<?php
echo __DIR__;
?>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gerenciamento de Agendamentos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.5/css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="styles.css">
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#agendamento').DataTable();
        });
        async function excluirRegistro(id) {
  if (confirm(`Tem certeza que deseja excluir o agendamento ID ${id}?`)) {
    try {
      console.log(`Enviando requisição para excluir o agendamento com ID: ${id}`);

      const response = await fetch('http://localhost/projeto/excluir_agendamento.php', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json', // Informando que o corpo está em JSON
        },
        body: JSON.stringify({ id: parseInt(id) }), // Enviando o ID no corpo da requisição
      });

      // Obter o texto da resposta, não tentamos fazer JSON.parse ainda
      const responseText = await response.text();
      
      console.log('Resposta da API (raw):', responseText); // Exibir o conteúdo bruto

      // Agora tentamos converter para JSON
      try {
        const data = JSON.parse(responseText);
        if (data.Sucesso === true) {
          document.querySelector(`tr[data-id='${id}']`).remove(); // Remove a linha da tabela
          alert("Agendamento excluído com sucesso!");
        } else {
          alert(data.message || "Erro ao excluir agendamento.");
        }
      } catch (error) {
        console.error("Erro ao analisar JSON:", error);
        alert("Falha ao processar a resposta da API.");
      }

    } catch (error) {
      console.error("Erro na requisição:", error);
      alert("Falha ao conectar à API.");
    }
  }
}


</script>
</head>

<body>
    <?php include('navbar.php') ?>
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header" style="border-radius: 10px;">
                        <h4 style="text-align: center;">Clientes cadastrados
                        </h4>
                    </div>
                    <div class="card-body">
                        <table id="agendamento" class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                    <th scope="col" style="text-align:center;">CLIENTE</th>
                                    <th scope="col" style="text-align:center;">FUNCIONARIO</th>
                                    <th scope="col" style="text-align:center;">SERVIÇO</th>
                                    <th scope="col" style="text-align:center;">SETOR</th>
                                    <th scope="col" style="text-align:center;">FILIAL</th>
                                    <th scope="col" style="text-align:center;">DATA</th>
                                    <th scope="col" style="text-align:center;">HORA </th>
                                    <th scope="col" style="text-align:center;">Status</th>
                                    <th scope="col" style="text-align:center;">OPÇÕES</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php include 'get_agendamento.php'; ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>

</html>