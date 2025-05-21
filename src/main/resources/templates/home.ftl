<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DonnéesCST - Pour les étudiants</title>
    <link nonce="${nonce()}" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link nonce="${nonce()}" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link nonce="${nonce()}" href="/style/home.css" rel="stylesheet">
</head>
<body class="d-flex flex-column min-vh-100">
    <header class="text-white">
        <div class="container d-flex justify-content-between align-items-center">
            <h1 class="fs-3 fw-bold">DonnéesCST</h1>
            <nav>
                <#if username??>
                    <span class="navbar-text text-white me-3">Bienvenue, ${username}</span>
                    <a href="/dashboard" class="btn btn-outline-light mx-2">Tableau de bord</a>
                    <form action="/dashboard" method="post" class="d-inline">
                        <input type="hidden" name="action" value="logout">
                        <button type="submit" class="btn btn-outline-light mx-2">Déconnexion</button>
                    </form>
                <#else>
                    <a href="/connexion" class="btn btn-outline-light mx-2">Connexion</a>
                    <a href="/inscription" class="btn btn-outline-light mx-2">Inscription</a>
                </#if>
            </nav>
        </div>
    </header>
    <main class="container flex-grow-1 py-5">
        <!-- Hero Section -->
        <section class="hero-section text-center">
            <h2 class="fw-bold mb-4">DonnéesCST : pour les étudiants du Cégep de Sorel-Tracy</h2>
            <p class="lead mb-5">Un outil simple et gratuit pour des données fictives en français, créé pour vos projets scolaires. Fait par un passionné, sur mon temps libre, juste pour vous!</p>
            <div class="d-flex justify-content-center gap-3 flex-wrap">
                <a href="/inscription" class="btn btn-primary btn-lg">Commencer maintenant</a>
                <a href="#fonctionnalites" class="btn btn-outline-light btn-lg">En savoir plus</a>
            </div>
        </section>

        <!-- Why Us Section -->
        <section class="bg-white rounded shadow-sm">
            <h3 class="h3 text-center mb-5">Pourquoi utiliser DonnéesCST?</h3>
            <div class="row g-4">
                <div class="col-12 col-md-4">
                    <div class="text-center">
                        <i class="bi bi-mortarboard-fill text-primary mb-3 icon"></i>
                        <h4 class="fs-5 fw-semibold mb-2">Fait pour les étudiants</h4>
                        <p class="text-muted">Conçu pour les projets du Cégep de Sorel-Tracy, avec des données simples pour apprendre à coder.</p>
                    </div>
                </div>
                <div class="col-12 col-md-4">
                    <div class="text-center">
                        <i class="bi bi-translate text-primary mb-3 icon"></i>
                        <h4 class="fs-5 fw-semibold mb-2">Tout en français</h4>
                        <p class="text-muted">Données et documentation 100 % en français, pour faciliter votre apprentissage.</p>
                    </div>
                </div>
                <div class="col-12 col-md-4">
                    <div class="text-center">
                        <i class="bi bi-geo-alt-fill text-primary mb-3 icon"></i>
                        <h4 class="fs-5 fw-semibold mb-2">Projet local</h4>
                        <p class="text-muted">Hébergé au Québec, conforme à nos lois sur la protection des données, créé pour vous.</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Features Section -->
        <section id="fonctionnalites">
            <h3 class="h3 text-center mb-5">Ce que vous pouvez faire</h3>
            <div class="row row-cols-1 row-cols-md-3 g-4">
                <div class="col">
                    <div class="card h-100 shadow-sm">
                        <div class="card-body text-center">
                            <i class="bi bi-database-fill text-primary mb-3 icon"></i>
                            <h4 class="card-title fs-5 fw-semibold">Données variées</h4>
                            <p class="card-text text-muted">Obtenez des données comme des profils, produits ou commandes, parfaites pour vos projets.</p>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100 shadow-sm">
                        <div class="card-body text-center">
                            <i class="bi bi-plug-fill text-primary mb-3 icon"></i>
                            <h4 class="card-title fs-5 fw-semibold">API facile</h4>
                            <p class="card-text text-muted">Utilisez notre API avec une documentation claire, même si vous débutez.</p>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100 shadow-sm">
                        <div class="card-body text-center">
                            <i class="bi bi-shield-lock-fill text-primary mb-3 icon"></i>
                            <h4 class="card-title fs-5 fw-semibold">Sécurisé</h4>
                            <p class="card-text text-muted">Clés API simples et sécurisées pour protéger vos projets.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="contact-section text-center">
            <h3 class="h3 fw-bold mb-4">Besoin de nouvelles données?</h3>
            <p class="text-muted mb-5">Je travaille seul sur ce projet, sur mon temps libre, mais je suis là pour vous! Contactez-moi pour suggérer des endpoints ou poser des questions.</p>
            <a href="mailto:contact@donneescst.quebec" class="btn btn-primary btn-lg">Me contacter</a>
        </section>
        
    </main>
    <footer class="bg-dark text-white">
        <div class="container">
            <div class="row gy-4">
                <div class="col-12 col-md-4 text-center text-md-start">
                    <h5 class="fw-bold mb-3">DonnéesCST</h5>
                    <p class="text-muted">Un projet gratuit pour les étudiants du Cégep de Sorel-Tracy, créé avec passion.</p>
                </div>
                <div class="col-12 col-md-4 text-center">
                    <h5 class="fw-bold mb-3">Liens rapides</h5>
                    <ul class="list-unstyled">
                        <li><a href="/connexion" class="text-white text-decoration-none">Connexion</a></li>
                        <li><a href="/inscription" class="text-white text-decoration-none">Inscription</a></li>
                        <li><a href="/documentation" class="text-white text-decoration-none">Documentation</a></li>
                    </ul>
                </div>
                <div class="col-12 col-md-4 text-center text-md-end">
                    <h5 class="fw-bold mb-3">Restez connecté</h5>
                    <div class="social-icons mb-3">
                        <a href="#" class="text-white"><i class="bi bi-github"></i></a>
                        <a href="#" class="text-white"><i class="bi bi-linkedin"></i></a>
                        <a href="mailto:contact@donneescst.quebec" class="text-white"><i class="bi bi-envelope-fill"></i></a>
                    </div>
                    <form class="d-flex justify-content-center justify-content-md-end">
                        <input type="email" class="form-control w-auto me-2" placeholder="Votre courriel" disabled>
                        <button type="submit" class="btn btn-primary" disabled>S'abonner</button>
                    </form>
                    <small class="text-muted d-block mt-2">(Bientôt disponible!)</small>
                </div>
            </div>
            <hr class="bg-white my-4">
            <p class="text-center mb-0">© 2025 DonnéesCST. Tous droits réservés.</p>
        </div>
    </footer>
    <script nonce="${nonce()}" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>