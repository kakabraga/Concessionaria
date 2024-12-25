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
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#agendamento').DataTable();
        });

        function editarRegistro(id) {
            // Implementar a função de edição
            const url = 'editar_agendamento.php';
            const data = {
                id: id
            };

            fetch(url, {
                    method: 'POST',
                    body: JSON.stringify(data),
                    headers: {
                        'Content-Type': 'application/json'
                    }
                })
                .then(response => response.json())
                .then(result => {
                    console.log('Success:', result);
                    // Atualizar a interface ou redirecionar
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        }

        function excluirRegistro(id_agendamento) {
            if (confirm('Você realmente deseja excluir este registro?')) {
                const url = 'excluir.php';
                const data = {
                    id: id_agendamento
                };

                fetch(url, {
                        method: 'POST',
                        body: JSON.stringify(data),
                        headers: {
                            'Content-Type': 'application/json'
                        }
                    })
                    .then(response => response.json())
                    .then(result => {
                        console.log('Success:', result);
                        // Atualizar a interface para remover a linha
                        location.reload();
                    })
                    .catch(error => {
                        console.error('Error:', error);
                    });
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