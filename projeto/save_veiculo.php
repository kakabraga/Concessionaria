<?php
require 'db.php';
header('Content-type: application/json');

// Verifica se o conteúdo da requisição é JSON
if ($_SERVER['CONTENT_TYPE'] == 'application/json') {
    // Captura os dados do corpo da requisição
    $resposta_json = file_get_contents('php://input');
    $dados = json_decode($resposta_json, true); // Decodifica o JSON em um array

    // Verifica se os campos necessários estão presentes
    if (isset($dados['modelo'], $dados['marca'], $dados['cor'], $dados['preco'], $dados['ano'], $dados['filial'], $dados['quantidade'])) {
        
        // Protege os dados contra SQL Injection
        $modelo = mysqli_real_escape_string($conn, $dados['modelo']);
        $marca = mysqli_real_escape_string($conn, $dados['marca']);
        $cor = mysqli_real_escape_string($conn, $dados['cor']);
        $preco = mysqli_real_escape_string($conn, $dados['preco']);
        $ano = mysqli_real_escape_string($conn, $dados['ano']);
        $filial = mysqli_real_escape_string($conn, $dados['filial']);
        $quantidade = mysqli_real_escape_string($conn, $dados['quantidade']);

        // Prepara o SQL para inserção
        $sql = "INSERT INTO tb_estoque_veiculo (modelo, marca, cor, preco, ano, id_filial, quantidade) 
                VALUES ('$modelo', '$marca', '$cor', '$preco', '$ano', '$filial', '$quantidade')";

        // Executa a consulta
        if (mysqli_query($conn, $sql)) {
            // Se a inserção for bem-sucedida, responde com um JSON de sucesso
            echo json_encode(["status" => "success", "message" => "Produto registrado com sucesso."]);
        } else {
            // Se ocorrer um erro na inserção, responde com um erro
            echo json_encode(["status" => "error", "message" => "Erro ao inserir o produto: " . mysqli_error($conn)]);
        }

    } else {
        // Se algum campo necessário estiver ausente
        echo json_encode(["status" => "error", "message" => "Dados incompletos."]);
    }

} else {
    // Se o tipo de conteúdo não for JSON, retorna erro
    echo json_encode(["status" => "error", "message" => "Tipo de conteúdo não suportado."]);
}

