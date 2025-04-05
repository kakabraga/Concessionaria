<?php
require 'db.php';
header('Content-type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    $data = json_decode(file_get_contents("php://input"), true);
    
    if (isset($data['id'])) {
        $id = intval($data['id']);
    } else {
        echo json_encode(['Sucesso' => false, "message" => "ID não informado"]);
        exit; // Impede qualquer outro processamento após enviar a resposta
    }
    
    $sql = "DELETE FROM tb_agendamento WHERE id_agendamento=" . $id;
    $resultado = mysqli_query($conn, $sql);
     
    if ($resultado) {
        if (mysqli_affected_rows($conn) > 0) {
            echo json_encode(["Sucesso" => true, "message" => "Agendamento excluído com sucesso"]);
        } else {
            echo json_encode(["Sucesso" => false, "message" => "Nenhum agendamento encontrado com esse ID"]);
        }
    } else {
        echo json_encode(["Sucesso" => false, "message" => "Erro ao excluir: " . mysqli_error($conn)]);
    }
    
    exit; // Garante que o código pare de executar aqui

} else {
    // Se a requisição não for POST, retorne um erro
    echo json_encode(['Sucesso' => false, "message" => "Método de requisição inválido. Use POST."]);
    exit;
}
