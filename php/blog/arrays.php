<?php 

// $arr = [1, 2, 4, 5];

//  if (in_array('100', $arr)) {
//     echo "tem";
//  } else {
//     echo "nao tem ";
//  };
// $resultado = array_reduce($arr, "");

$arr = [

    "Corinthians" => 1,
    "Flamengo" => 2,
    "Botafogo" => 3,

];

 arsort($arr);

print_r($arr);

?>

<h1>Ranking:</h1>
<ol>
    <?php foreach($arr as $a => $posição): ?>
        <li><?= $a?> -> <?= $posição?> pontos </li>
        <?php endforeach; ?>
</ol>