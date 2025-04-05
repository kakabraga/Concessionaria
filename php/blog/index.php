<?php
include_once('templates/header.php');
?>

<main>
    <div id="title-container">
        <h1>Blog Codar</h1>
        <p>O seu Blog de Programação</p>
    </div>
    <div id="posts-container">
        <?php foreach ($posts as $p) { ?>
            <div class="post-box">
                <img src="<?= $BASE_URL ?>/img/<?= $p['img'] ?>" alt="">
                <h2 class="post-title">
                    <a href="<?= $BASE_URL ?>post.php?id=<?= $p['id'] ?>"><?= $p['title'] ?></a>
                </h2>
                <p class="post-description">
                    <?= $p['description'] ?>
                </p>
                <div id="tags-container">
                <?php foreach ($p['tags'] as $tag) { ?>
                    <a href="<?= $BASE_URL ?>post.php?tags"><?= $tag?></a>
                    <?php }?>
                </div>
            </div>
        <?php } ?>
    </div>
</main>
<?php
include_once('templates/footer.php');
?>