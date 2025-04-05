<?php
include_once("templates/header.php");

if (isset($_GET['id'])) {

    $id = $_GET['id'];
    $Currentpost;

    foreach ($posts as $p) {
        if ($p['id'] == $id) {
            $Currentpost = $p;
        }
    }
}
?>

<main id="post-container">
    <div class="content-container">
        <h1 id="main-title">
            <?= $Currentpost['title'] ?>
        </h1>
        <p id="post-description">
            <?= $Currentpost['description'] ?>
        </p>

        <div class="img-container">
            <img src="<?= $BASE_URL ?>/img/<?= $Currentpost['img'] ?>" alt="<?= $Currentpost['title'] ?>">
        </div>
        <p class="post-content">
            Lorem ipsum dolor sit amet consectetur adipisicing elit. Qui similique perferendis porro dignissimos aut temporibus, placeat magnam corporis, saepe fugit ipsum aliquam magni neque architecto, quibusdam cupiditate iste eveniet. Veritatis.
            Earum, dolore! Quidem sunt, atque, aliquid ipsa quae, aliquam culpa in enim consequuntur blanditiis accusantium dignissimos repudiandae! Excepturi, delectus sunt rem porro commodi expedita, impedit dolor facere perspiciatis unde obcaecati.
            Dicta dignissimos temporibus architecto maiores hic alias quis eius, non, cum commodi officia nostrum, quibusdam eveniet dolorum at dolores assumenda quam eaque ut veritatis accusantium sapiente blanditiis expedita? Unde, earum.
            Doloribus reprehenderit, ipsa nobis doloremque, sequi assumenda maiores eum rerum, ex explicabo at ea! Eveniet non quidem tempora ex! Soluta architecto blanditiis praesentium laboriosam repellendus consequatur numquam a vero in.
            Impedit quaerat vitae odio corporis illum, voluptatibus nemo praesentium debitis veniam ullam explicabo accusantium, aliquid dolorem hic in asperiores animi maxime consectetur cupiditate quia. Veritatis possimus tempora hic perferendis at?</p>
        <p class="post-content">Lorem ipsum dolor sit amet consectetur adipisicing elit. Qui similique perferendis porro dignissimos aut temporibus, placeat magnam corporis, saepe fugit ipsum aliquam magni neque architecto, quibusdam cupiditate iste eveniet. Veritatis.
            Earum, dolore! Quidem sunt, atque, aliquid ipsa quae, aliquam culpa in enim consequuntur blanditiis accusantium dignissimos repudiandae! Excepturi, delectus sunt rem porro commodi expedita, impedit dolor facere perspiciatis unde obcaecati.
            Dicta dignissimos temporibus architecto maiores hic alias quis eius, non, cum commodi officia nostrum, quibusdam eveniet dolorum at dolores assumenda quam eaque ut veritatis accusantium sapiente blanditiis expedita? Unde, earum.
            Doloribus reprehenderit, ipsa nobis doloremque, sequi assumenda maiores eum rerum, ex explicabo at ea! Eveniet non quidem tempora ex! Soluta architecto blanditiis praesentium laboriosam repellendus consequatur numquam a vero in.
            Impedit quaerat vitae odio corporis illum, voluptatibus nemo praesentium debitis veniam ullam explicabo accusantium, aliquid dolorem hic in asperiores animi maxime consectetur cupiditate quia. Veritatis possimus tempora hic perferendis at?</p>
    </div>
    <aside id="nav-container">
        <h3 id="tags-title">Tags </h3>
        <ul id="tag-list">
            <?php foreach ($Currentpost['tags'] as $tag) { ?>
                <li><a href="#"><?= $tag ?></a></li>
            <?php } ?>
        </ul>
        <h3 id="categories-title">Categorias</h3>
        <ul id="categories-list">
            <?php foreach ($categories as $category) { ?>
                <li><a href="#"><?= $category ?></a></li>
            <?php } ?>
        </ul>
    </aside>
</main>
</div>
<?php
include_once("templates/footer.php");
?>