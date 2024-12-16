<div class="container">
    <form class="row g-3" action="save_fornecedor.php" method="POST">
        <div class="col-md-6">
            <label for="inputText" class="form-label">Nome da Filial</label>
            <input type="text" name="nome" class="form-control" id="inputText">
        </div>
        <div class="col-md-6">
            <label for="inputText" class="form-label">CNPJ</label>
            <input type="text" name="cnpj" class="form-control" id="inputText">
        </div>
        <div class="col-12">
            <label for="inputText" class="form-label">Email</label>
            <input type="email" name="email" class="form-control" id="inputText">
        </div>
        <div class="col-md-6">
            <label for="inputAddress2" class="form-label">Endereço</label>
            <input type="text" name="endereco" class="form-control" id="inputAddress2" placeholder="Apartment, studio, or floor">
        </div>
        <div class="col-md-6">
            <label for="inputPassword4" class="form-label">Telefone</label>
            <input type="text" name="telefone" class="form-control" id="inputPassword4">
        </div>
        <div class="col-md-6">
            <label for="inputCity" class="form-label">Cidade</label>
            <input type="text" name="cidade" class="form-control" id="inputCity">
        </div>
        <div class="col-md-6">
            <label for="inputAddress" class="form-label">CEP</label>
            <input type="text" name="cep" class="form-control" id="inputAddress" placeholder="Seu CEP">
        </div>
        <div class="col-md-3">
            <label for="inputState" class="form-label">Estado</label>
            <select name="estado" class="form-select">
                <?php
                $sql = "SELECT id_estado, sigla FROM tb_estado";
                $resultado = mysqli_query($conn, $sql);
                if (mysqli_num_rows($resultado) > 0) {
                    while ($row = mysqli_fetch_assoc($resultado)) {
                ?><option value=<?php echo $row['sigla'] ?>><?php echo $row['sigla'] ?></option>
                <?php
                    }
                }
                ?>
            </select>
        </div>
        <div class="col-md-5">
            <label for="inputState" class="form-label">Tipo de Fornecedor</label>
            <select name="tipo_end" class="form-select">
                <?php
                $sql = "SELECT tipo FROM tb_tipo_fornecedor";
                $resultado = mysqli_query($conn, $sql);
                if (mysqli_num_rows($resultado) > 0) {
                    while ($row = mysqli_fetch_assoc($resultado)) {
                ?><option value=<?php echo $row['id_tipo_fornecedor'] ?>><?php echo $row['tipo'] ?></option>
                <?php
                    }
                }
                ?>
            </select>
        </div>
        <div class="col-12">
            <button type="submit" name='enviar' class="btn btn-primary">Registrar</button>
        </div>
    </form>
</div>