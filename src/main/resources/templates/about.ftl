<!DOCTYPE html>
<html lang="fr">
<head>
    <#assign pageTitle = "À Propos" />
    <#assign additionalCSS = ["style/views/home.css"] />
    <#include "macros/head.ftl"/>
</head>
<body>
    <#assign currentPage = "about" />
    <#include "components/flash.ftl">
    <#include "components/navbar.ftl">
    
    <!-- Hero Section -->
    <div class="hero-section text-white py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center">
                    <h1 class="display-4 fw-bold mb-4">À Propos de DonnéesCST</h1>
                    <p class="lead">L'histoire derrière ce projet étudiant</p>
                    <p class="fs-5 mb-4">Découvrez pourquoi j'ai créé ce site et ce qui m'a motivé à le développer.</p>
                    <div class="d-flex flex-column flex-md-row justify-content-center gap-3">
                        <a href="/docs" class="btn btn-light btn-lg">
                            Explorer l'API
                        </a>
                        <a href="/T1WiLLi/Jolt" target="_blank" class="btn btn-outline-light btn-lg">
                            Voir le code sur GitHub
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Features Section -->
    <div class="features-section">
        <div class="container">
            <div class="row">
                <div class="col-12 text-center mb-5">
                    <h2 class="fw-bold">Ce qui rend DonnéesCST spécial</h2>
                    <p class="text-muted">Un projet né d'une passion pour le code et la communauté</p>
                </div>
            </div>
            
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="card h-100 shadow-sm feature-card">
                        <div class="card-body text-center">
                            <h5 class="card-title">Un projet de portfolio</h5>
                            <p class="card-text">Créé pour enrichir mon portfolio avec un projet concret et original, montrant mes compétences en développement web.</p>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="card h-100 shadow-sm feature-card">
                        <div class="card-body text-center">
                            <h5 class="card-title">Test du framework Jolt</h5>
                            <p class="card-text">Une opportunité d'expérimenter et d'améliorer mon framework Java Jolt, disponible sur <a href="/T1WiLLi/Jolt" target="_blank" class="auth-link">GitHub</a>.</p>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="card h-100 shadow-sm feature-card">
                        <div class="card-body text-center">
                            <h5 class="card-title">Inspiration CEGEP</h5>
                            <p class="card-text">Pensé pour les étudiants comme moi autrefois, cherchant des ressources centralisées au lieu de fouiller partout.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Story Section -->
    <div class="api-showcase py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <h2 class="fw-bold mb-4">Mon parcours avec DonnéesCST</h2>
                    <p class="lead text-muted mb-4">Une idée née d'une frustration passée (et d’un peu d’ego !)</p>
                    <p class="mb-4">Bon, tout a débuté quand j’étais au CEGEP, et franchement, c’était un vrai cirque pour coder. Imagine-toi : des nuits entières à scroller sur Google, tomber sur des forums où les réponses dataient d’avant l’invention du Wi-Fi, et des API qui plantaient juste quand je pensais avoir fini mon projet. J’ai même eu une fois un prof qui m’a dit « trouve-toi une solution toi-même », et là, j’étais comme un perdu dans le bois ! J’aurais payé cher – genre, mon clavier ou un café double – pour avoir un outil comme DonnéesCST. Un spot où tout est regroupé, où je pouvais demander des endpoints sur mesure sans supplier un serveur qui me faisait la gueule.</p>
                    <p class="mb-4">Et ouais, soyons honnêtes, au départ, c’était un peu égoïste. J’ai lancé ce site surtout pour booster mon portfolio – un truc cool à montrer pour dire « hey, regarde ce que je sais faire ! » avec un petit rire en coin. Mais en chemin, j’ai réalisé que ça pouvait servir à d’autres. Genre, un cadeau un peu improvisé pour vous, les étudiants qui galèrent comme moi avant. Fini les paniques avant les devoirs, fini les heures à chercher dans le néant – avec DonnéesCST, c’est un clic et hop, t’as ce qu’il te faut. Et puis, avouons-le, c’est rigolo de voir que mes vieilles galères ont inspiré tout ça. Alors, profitez-en bien, et si vous avez des idées complètement barrées, venez m’en parler, on s’amusera à les coder ensemble !</p>
                </div>
                <div class="col-lg-6">
                    <div class="text-center text-lg-start">
                        <img src="/images/author.jpg" alt="Photo de l'auteur" class="img-fluid rounded">
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Getting Started Section -->
    <div class="getting-started-section py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto">
                    <h2 class="text-center fw-bold mb-4">Contribuez ou explorez</h2>
                    <p class="text-center text-muted mb-5">Voici comment vous pouvez vous impliquer</p>
                    <div class="row step-section">
                        <div class="col-md-6 mb-4">
                            <div class="d-flex">
                                <div class="step-number">
                                    <span>1</span>
                                </div>
                                <div class="flex-grow-1 ms-3">
                                    <h5>Visitez le dépôt GitHub</h5>
                                    <p class="text-muted">Explorez le code source de Jolt et DonnéesCST sur <a href="/T1WiLLi/Jolt" target="_blank" class="auth-link">GitHub</a>.</p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-6 mb-4">
                            <div class="d-flex">
                                <div class="step-number">
                                    <span>2</span>
                                </div>
                                <div class="flex-grow-1 ms-3">
                                    <h5>Suggérez des améliorations</h5>
                                    <p class="text-muted">Proposez des idées ou des endpoints via les issues sur GitHub.</p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-6 mb-4">
                            <div class="d-flex">
                                <div class="step-number">
                                    <span>3</span>
                                </div>
                                <div class="flex-grow-1 ms-3">
                                    <h5>Rejoignez la communauté</h5>
                                    <p class="text-muted">Partagez vos projets et collaborez avec d'autres étudiants.</p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-6 mb-4">
                            <div class="d-flex">
                                <div class="step-number">
                                    <span>4</span>
                                </div>
                                <div class="flex-grow-1 ms-3">
                                    <h5>Utilisez l'API</h5>
                                    <p class="text-muted">Intégrez DonnéesCST dans vos propres applications dès aujourd'hui.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="text-center mt-5">
                        <a href="/docs" class="btn btn-primary btn-lg me-3">
                            Découvrir l'API
                        </a>
                        <a href="/T1WiLLi/Jolt" target="_blank" class="btn btn-outline-primary btn-lg">
                            Voir sur GitHub
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <#include "components/footer.ftl">

    <script nonce="${nonce()}" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>