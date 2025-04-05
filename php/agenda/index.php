<?php
include_once('config/url.php');
include_once('templates/header.php');
?>
<div class="container">
    <?php if (isset($msg) && $msg != '') { ?>
        <p id="msg"><?= $msg ?></p>
    <?php } ?>
    <h1 id="main-title">Minha Agenda</h1>
    <?php if (count($contacts) > 0) { ?>
        <p><strong>Você tem <?= count($contacts) ?> Contatos</strong></p>
        <table class="table" id="contacts-table">
            <thead>
                <tr>
                    <th scope="col">Nome</th>
                    <th scope="col">Numero</th>
                    <th scope="col">Descrição</th>
                    <th scope="col">Opções</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($contacts as $c) {
                ?>
                    <tr>
                        <td scope="row" class="nome"><?= $c['nome'] ?></td>
                        <td scope="row"><?= $c['telefone'] ?></td>
                        <td scope="row"><?= $c['observacoes'] ?></td>
                        <td class="actions">
                            <a href="<?= $BASE_URL ?>show.php?id=<?= $c['id'] ?>"><i class="fas fa-eye check-icon"></i></a>
                            <a href="<?= $BASE_URL ?>edit.php?id=<?= $c['id'] ?>"><i class="far fa-edit edit-icon"></i></a>
                            <form class="delete-form" action="<?= $BASE_URL ?>config/process.php" method="POST">
                                <input type="hidden" name="type" value="delete">
                                <input type="hidden" name="id" value="<?= $c['id']?>">
                                <button type="submit" class="delete"><i class="fas fa-times delete-icon"></i></button>
                            </form>
                        </td>
                    </tr>
                <?php } ?>
            </tbody>
        </table>
    <?php  } else { ?>
        <p id="empty-list-text">Você não tem nenhum contato, <a href="<?= $BASE_URL ?>create.php" class="btn btn-primary">Adc contato</a></p>
    <?php } ?>
</div>
<?php

include_once('templates/footer.php');
?>