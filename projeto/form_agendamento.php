<?php
require 'db.php';
?>

<div class="container">
  <form class="row g-3" action="save_agendamento.php" method="POST">
    <div class="col-md-6">
      <label for="inputText" class="form-label">Cliente</label>
      <select class="form-select" name="cliente" aria-label="Default select example">
        <option selected>Selecione o Cliente</option>
        <?php
        $sql = 'SELECT id_cliente, nome FROM tb_cliente';
        $result = mysqli_query($conn, $sql);

        if (mysqli_num_rows($result) > 0) {
          while ($row = mysqli_fetch_assoc($result)) {
        ?>
            <option value="<?php echo $row['id_cliente'] ?>"><?php echo $row['nome']; ?></option>
        <?php }
        } ?>
      </select>
    </div>
    <div class="col-md-6">
      <label for="inputAddress" class="form-label">funcionario</label>
      <select class="form-select" name="funcionario" aria-label="Default select example">
        <option selected>Selecione o Cliente</option>
        <?php
        $sql = 'SELECT id_funcionario, nome FROM tb_funcionario';
        $result = mysqli_query($conn, $sql);

        if (mysqli_num_rows($result) > 0) {
          while ($row = mysqli_fetch_assoc($result)) {
        ?>
            <option value="<?php echo $row['id_funcionario'] ?>"><?php echo $row['nome']; ?></option>
        <?php }
        } ?>
      </select>
    </div>
    <div class="col-md-6">
      <label for="inputPassword4" class="form-label">Serviço</label>
      <select class="form-select" name="servico" aria-label="Default select example">
        <option selected>Selecione o Servico</option>
        <?php
        $sql = 'SELECT id_servico, descricao FROM tb_servico_prestado';
        $result = mysqli_query($conn, $sql);

        if (mysqli_num_rows($result) > 0) {
          while ($row = mysqli_fetch_assoc($result)) {
        ?>
            <option value="<?php echo $row['id_servico'] ?>"><?php echo $row['descricao']; ?></option>
        <?php }
        } ?>
      </select>
    </div>
    <div class="col-md-6">
      <label for="inputState" class="form-label">Filial</label>
      <select class="form-select" name="filial" aria-label="Default select example">
        <option selected>Selecione a Filia</option>
        <?php
        $sql = 'SELECT nome, id_filial FROM tb_filial';
        $result = mysqli_query($conn, $sql);
        
        if (mysqli_num_rows($result) > 0) {
          while ($row = mysqli_fetch_assoc($result)) {
            ?>
            <option value="<?php echo $row['id_filial'] ?>"><?php echo $row['nome']; ?></option>
            <?php }
        } ?>
      </select>
    </div>
    <div class="col-md-4">
      <label for="inputState" class="form-label">Setor</label>
      <select id="inputState" name="setor" class="form-select">
        <?php
        $sql = 'SELECT nome, id_setor FROM tb_setor';
        $result = mysqli_query($conn, $sql);
        
        if (mysqli_num_rows($result) > 0) {
          while ($row = mysqli_fetch_assoc($result)) {
            ?>
            <option value="<?php echo $row['id_setor'] ?>"><?php echo $row['nome'] ?></option>
            <?php
          }
        } ?>
      </select>
    </div>
    <div class="col-md-4">
      <label for="inputAddress2" class="form-label">Data de Agendamento</label>
      <input type="date" name="data" class="form-control" id="inputAddress2">
    </div>
    <div class="col-md-4">
    <label for="inputAddress2" class="form-label">Data de Agendamento</label>
      <input type="time" name="hora" class="form-control" id="inputAddress2">
    </div>
    <div class="col-12">
      <button type="submit" name='enviar' class="btn btn-primary">Registrar</button>
    </div>

  </form>
</div>