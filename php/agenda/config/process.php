<?php

session_start();

include_once("conexao.php");
include_once("url.php");
$data = $_POST;
if (!empty($data)) {
    if ($data["type"] === "create") {
        $nome = $data['nome'];
        $telefone = $data['telefone'];
        $descricao = $data['descricao'];

        $sql = "INSERT INTO contatos (nome, telefone, observacoes) VALUES (:nome, :telefone, :observacoes)";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(":nome", $nome);
        $stmt->bindParam(":telefone", $telefone);
        $stmt->bindParam(":observacoes", $descricao);
        $stmt->execute();
        $_SESSION["msg"] = "Criado Com sucesso";
        header("Location:" . $BASE_URL . "../index.php");
    } else if ($data["type"] === "edit") {
        $id  = $data['id'];
        $nome = $data['nome'];
        $telefone = $data['telefone'];
        $descricao = $data['descricao'];

        $sql = "UPDATE contatos SET nome = :nome, telefone = :telefone, observacoes = :observacoes WHERE id = :id";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(":id", $id);
        $stmt->bindParam(":nome", $nome);
        $stmt->bindParam(":telefone", $telefone);
        $stmt->bindParam(":observacoes", $descricao);
        $stmt->execute();
        $_SESSION["msg"] = "Criado Com sucesso";
        header("Location:" . $BASE_URL . "../index.php");
    } else if ($data['type'] === 'delete') {
        $id  = $data['id'];
        $sql = "delete from contatos where id= :id";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(":id", $id);
        $stmt->execute();
        $_SESSION["msg"] = "Deletado Com sucesso";
        header("Location:" . $BASE_URL . "../index.php");
    }
}

if (!empty($_GET)) {
    $id = $_GET['id'];
}
if (!empty($id)) {
    $sql = "SELECT id, nome, telefone, observacoes FROM contatos WHERE id = :id";
    $stmt = $conn->prepare($sql);
    $stmt->bindParam(":id", $id);
    $stmt->execute();
    $contacts = $stmt->fetch();
} else {
    $contacts = [];
    $sql = "SELECT * FROM contatos";
    $stmt = $conn->prepare($sql);

    $stmt->execute();
    $contacts = $stmt->fetchAll();
}



$conn = null;
