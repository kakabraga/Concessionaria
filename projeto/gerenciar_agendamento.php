<!DOCTYPE html>
<html lang="pt-BR">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gerenciamento de Agendamentos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body>
    <div class="wrapper">
        <?php include 'navbar.php'; ?>
    </div>
    <div class="container-fluid">
        <main class="container mt-5 d-flex justify-content-center">
            <div class="card-body ">
                <div class="container-fluid mb-10">
                    <div class="container">
                        <table class="table table-striped table-hover table-bordered shadow p-3 mb-5 bg-body-tertiary rounded">
                            <thead class="thead-dark">
                                <tr>
                                    <th scope="col">Nome do Cliente</th>
                                    <th scope="col">Funcionario</th>
                                    <th scope="col">Serviço</th>
                                    <th scope="col">Setor</th>
                                    <th scope="col">Filial</th>
                                    <th scope="col">Data Agendada</th>
                                    <th scope="col">Hora Agendada</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php include './get_agendamento.php'; ?>
                            </tbody>
                        </table>
                    </div>

                </div>

            </div>
    </div>
    </div>
</body>

</html>