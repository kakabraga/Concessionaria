<?php 
$host = 'db';
$db = 'curso';
$user = 'root';
$pass = '1234';

$conn = new PDO(

    "mysql:host=$host;dbname=$db",
    $user,
    $pass

);

// Caminho do arquivo CSV
$caminho_csv = __DIR__ . "/csv.csv";
// Abrir o arquivo CSV
if (($handle = fopen($caminho_csv, 'r')) !== false) {
    // Ignorar a primeira linha (cabeçalho)
    fgetcsv($handle, 1000, ';');
    fgetcsv($handle, 1000, ';');

    // Preparar a query de inserção
    $stmt = $conn->prepare("INSERT INTO csv (idSolicitante , TipoDemandante, DataNascimento, Genero, Escolaridade, TipoPessoaJuridica, Pais, UF, Municipio) VALUES (:id, :tipo, :datanasc,
    :genero, :escolaridade, :tipoPessoa, :pais, :uf, :municipio
    )");

    // Ler o arquivo linha por linha
    while (($data = fgetcsv($handle, 1000, ';')) !== false) {
        // Atribuir os valores do CSV às variáveis
        $id = (int)$data[0];
        $tipo = $data[1];
        $datanasc = $data[2];
        $genero = $data[3];
        $escolaridade = $data[4];
        $tipoPessoa = $data[5];
        $pais = $data[6];
        $uf = $data[7];
        $municipio = $data[8];

        // Executar a query de inserção
        $stmt->execute([
            ':id' => (string)$id,
            ':tipo' => $tipo,
            ':datanasc' => $datanasc,
            ':genero' => $genero,
            ':escolaridade' => $escolaridade,
            ':tipoPessoa' => $tipoPessoa,
            ':pais' => $pais,
            ':uf' => $uf,
            ':municipio' => $municipio,

        ]);
    }

    // Fechar o arquivo
    fclose($handle);

    echo "Dados importados com sucesso!";
} else {
    echo "Erro ao abrir o arquivo CSV.";
}
?>
