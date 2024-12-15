<?php require 'db.php'; ?>

<div class="container">
  <form class="row g-3" action="save_cliente.php" method="POST">
    <div class="col-md-6">
      <label for="inputText" class="form-label">Nome</label>
      <input type="text" name="nome" class="form-control" id="inputText">
    </div>
    <div class="col-md-6">
      <label for="inputEmail4" class="form-label">Email</label>
      <input type="text" name="email" class="form-control" id="inputEmail4">
    </div>
    <div class="col-md-3">
      <label for="inputAddress" class="form-label">CPF</label>
      <input type="text" name="cpf" class="form-control" id="inputAddress" placeholder="Seu CPF">
    </div>
    <div class="col-md-3">
      <label for="inputPassword4" class="form-label">DDD</label>
      <input type="text" name="ddd" class="form-control" id="inputPassword4">
    </div>
    <div class="col-md-6">
      <label for="inputPassword4" class="form-label">Telefone</label>
      <input type="text" name="telefone" class="form-control" id="inputPassword4">
    </div>
    <div class="col-12">
      <label for="inputAddress2" class="form-label">Endereço</label>
      <input type="text" name="endereco" class="form-control" id="inputAddress2" placeholder="Apartment, studio, or floor">
    </div>
    <div class="col-md-6">
      <label for="inputCity" class="form-label">Cidade</label>
      <input type="text" name="cidade" class="form-control" id="inputCity">
    </div>
    <div class="col-md-4">
      <label for="inputState" class="form-label">Estado</label>
      <select  name="estado" class="form-select">
        <?php
        $sql = "SELECT id_estado, sigla FROM tb_estado";
        $resultado = mysqli_query($conn, $sql);
        if (mysqli_num_rows($resultado) > 0) {
          while ($row = mysqli_fetch_assoc($resultado)) {
        ?><option value=<?php echo $row['sigla'] ?>><?php echo $row['sigla'] ?></option>
        <?php
          }}
        ?>
      </select>
    </div>
    <div class="col-md-2">
      <label for="inputZip" class="form-label">Rua</label>
      <input type="text" name="rua" class="form-control" id="inputZip">
    </div>
    <div class="col-12">
      <label for="inputAddress2" class="form-label">Complemento</label>
      <input type="text" name="complemento" class="form-control" id="inputAddress2" placeholder="Apartamento, casa...">
    </div>
    <div class="col-12">
      <button type="submit" name='enviar' class="btn btn-primary">Registrar</button>
    </div>

  </form>
</div>