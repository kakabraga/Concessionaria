<?php

// $names = ['caue', 'laura', 'augusto', 'oi'];
// $retorno = '';

// if (count($names) == 1) {
//     foreach ($names as $name) {
//         $retorno = $name .  " likes this";
//     }
// } else if (count($names) == 2) {
//     for ($i = 0; $i <= count($names); $i++) {
//         $retorno = $names[0] . " and " . $names[1] . " Like this";
//     }
// } else if (count($names) == 3) {
//     for ($i = 0; $i <= count($names); $i++) {
//         $retorno = $names[0] . ", " . $names[1] . " and " . $names[2] . " Like this";
//     }
// } else if (count($names) >= 4) {
//     for ($i = 0; $i <= count($names); $i++) {
//         $outros = count($names) - 2;
//         $retorno = $names[0] . ", " . $names[1] . " and others " . $outros . " Like this";
//     }
// } else {
//         $retorno = "no one likes this";
// }


// echo $retorno;

$arr = [':)', ':D'];
$smiles_valid = [':)', ':D'];
$counts = array_count_values($arr);  // Conta as ocorrências de cada valor no array $arr

if (isset($counts[$smiles_valid])) {  // Verifica se o valor $smiles_valid está presente em $counts
    return $counts[$smiles_valid];  // Retorna o número de ocorrências do valor $smiles_valid
}
