<?php require 'db.php' ?>
<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <title>Meu Projeto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body>
    <div class="wrapper">
        <?php include 'navbar.php'; ?>
        <div class="container">

        </div>
    </div>
    <div class="container-fluid">
        <main class="container mt-4 d-flex justify-content-center">
            <div class="card" style="width: 50%">
                <div class="card-body">
                    <div class="container-fluid mbt-3">
                        <?php include './form_fornecedor.php'; ?>
                    </div>
                </div>
            </div>
    </div>
    </div>
</body>

</html>

