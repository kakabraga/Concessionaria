<div class="container">
  <form class="row g-3" action="save_veiculo.php" method="POST">
    <div class="col-md-6">
      <label for="inputText" class="form-label">Modelo</label>
      <input type="text" name="modelo" class="form-control" id="inputText">
    </div>
    <div class="col-md-3">
      <label for="inputAddress" class="form-label">Marca</label>
      <input type="text" name="marca" class="form-control" id="inputAddress" placeholder="Marca">
    </div>
    <div class="col-md-3">
      <label for="inputPassword4" class="form-label">Cor</label>
      <input type="text" name="cor" class="form-control" id="inputPassword4">
    </div>
    <div class="col-md-6">
      <label for="inputPassword4" class="form-label">Preço</label>
      <input type="number" name="preco" class="form-control" id="inputPassword4">
    </div>
    <div class="col-md-6" data-placeholder="MM/AAAA">
      <label for="inputAddress2" class="form-label">Ano</label>
      <input type="month" class="form-control" id="mesAno" name="mesAno">
    </div>
    <div class="col-md-6">
      <label for="inputState" class="form-label">Filial</label>
      <select class="form-select" name="filial" aria-label="Default select example">
        <option selected>Selecione a Filial</option>
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
      <label for="inputPassword4" class="form-label">Quantidade</label>
      <input type="number" name="quantidade" class="form-control" id="inputPassword4">
    </div>
    <div class="col-12">
      <button type="submit" name='enviar' class="btn btn-primary">Registrar</button>
    </div>

  </form>
</div>