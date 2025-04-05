<?php 
include_once("./db.php");
?>

<h1>Form</h1>
<form action="procee.php" method="POST">
    <div>
        <label for="">Marca</label>
        <input type="text" name="marca">
    </div>
    <div>
        <label for="">Km</label>
        <input type="text" name="km">
    </div>
    <div>
        <label for="">Cor</label>
        <input type="text" name="cor">
    </div>
    <div>
        <button type="submit" value="Salvar">Enviar</button>
    </div>
</form>