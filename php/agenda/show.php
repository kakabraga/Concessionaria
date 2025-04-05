<?php
include_once("templates/header.php");
?>
<div class="container" id="view-contact-container">
    <?php include_once('templates/blackbtn.php') ?>
    <h1 id="main-title">
    <?= $contacts['nome'] ?></h1>
    <p class="bold">Telefone:</p>
    <p><?= $contacts['telefone'] ?></p>
    <p class="bold">Observações:</p>
    <p><?= $contacts['observacoes'] ?></p>
</div>
<?php
include_once("templates/footer.php");
?>