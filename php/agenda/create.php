<?php
include_once('templates/header.php');
?>

<div class="container">
    <?php include_once('templates/blackbtn.php'); ?>
    <h1 id="main-title">Criando Contato</h1>
    <form id="create-form"action="<?= $BASE_URL ?>config/process.php" method="POST">
        <input type="hidden" name="type" value="create">
        <div class="form-group">
            <label for="name">Nome do Contato</label>
            <input type="text" class="form-control" id="nome" name="nome" placeholder="Seu nome" required>
        </div>
        <div class="form-group">
            <label for="name">Telefone</label>
            <input type="text" class="form-control" id="telefone" name="telefone" placeholder="Seu telefone" required>
        </div>
        <div class="form-group">
            <label for="Descrição">Descrição</label>
            <textarea rows="3" class="form-control" id="descricao" name="descricao" placeholder="Descrição" required></textarea>
        </div>
        <button type="submit" class="btn btn-primary" name="enviar" style="margin-top: 10px;">Cadastrar</button>
    </form>
</div>

<?php
include_once('templates/footer.php');
 