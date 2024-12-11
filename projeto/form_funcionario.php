<div class="container">
  <form class="row g-3" action="save_funcionario.php" method="POST">
    <div class="col-md-6">
      <label for="inputText" class="form-label">Nome</label>
      <input type="text" name="nome" class="form-control" id="inputText">
    </div>
    <div class="col-md-3">
      <label for="inputAddress" class="form-label">CPF</label>
      <input type="text" name="cpf" class="form-control" id="inputAddress" placeholder="Seu CPF">
    </div>
    <div class="col-md-3">
      <label for="inputPassword4" class="form-label">Cargo</label>
      <input type="text" name="cargo" class="form-control" id="inputPassword4">
    </div>
    <div class="col-md-6">
      <label for="inputPassword4" class="form-label">salario</label>
      <input type="text" name="salario" class="form-control" id="inputPassword4">
    </div>
    <div class="col-12">
      <label for="inputAddress2" class="form-label">Data de Admissao</label>
      <input type="date" name="data" class="form-control" id="inputAddress2" placeholder="Apartment, studio, or floor">
    </div>
    <div class="col-md-6">
      <label for="inputState" class="form-label">Filial</label>
      <select class="form-select" name="filial" aria-label="Default select example">
        <option selected>Open this select menu</option>
        <?php
        require 'db.php';
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
    <div class="col-md-6">
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
    <div class="col-12">
      <button type="submit" name='enviar' class="btn btn-primary">Registrar</button>
    </div>

  </form>
</div>