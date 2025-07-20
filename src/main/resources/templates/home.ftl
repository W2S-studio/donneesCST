<!DOCTYPE html>
<html lang="fr">
<head>
    <#assign pageTitle = "Pour les étudiants" />
    <#assign additionalCSS = ["style/views/home.css"] />
    <#include "macros/head.ftl"/>
</head>
<body>
    <#assign currentPage = "home" />
    <#include "components/flash.ftl">
    <#include "components/navbar.ftl">
    
    <div class="hero-section text-white py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center">
                    <h1 class="display-4 fw-bold mb-4"></i>DonnéesCST</h1>
                    <p class="lead">L'API REST non-officielle du Cégep de Sorel-Tracy</p>
                    <p class="fs-5 mb-4">Conçue par des étudiants, pour des étudiants. Accédez facilement aux données dont vous avez besoin pour vos projets académiques et personnels.</p>
                    <div class="d-flex flex-column flex-md-row justify-content-center gap-3">
                        <#if !username??>
                            <a href="/auth/login" class="btn btn-light btn-lg">
                                <i class="bi bi-person-fill"></i> Commencer maintenant
                            </a>
                        <#else>
                            <a href="/dashboard" class="btn btn-light btn-lg">
                                <i class="bi bi-speedometer2"></i> Tableau de bord
                            </a>
                        </#if>
                        <a href="/docs" class="btn btn-outline-light btn-lg">
                            <i class="bi bi-book"></i> Explorer l'API
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
                    <h2 class="fw-bold">Pourquoi choisir DonnéesCST ?</h2>
                    <p class="text-muted">Une solution technique adaptée aux besoins des étudiants du Cégep</p>
                </div>
            </div>
            
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="card h-100 shadow-sm feature-card">
                        <div class="card-body text-center">
                            <i class="bi bi-lightning-charge text-primary fs-1 mb-3"></i>
                            <h5 class="card-title">Performance optimisée</h5>
                            <p class="card-text">API haute performance avec temps de réponse rapides. Parfait pour vos applications web et mobiles les plus exigeantes.</p>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="card h-100 shadow-sm feature-card">
                        <div class="card-body text-center">
                            <i class="bi bi-shield-check text-primary fs-1 mb-3"></i>
                            <h5 class="card-title">Sécurisé & Fiable</h5>
                            <p class="card-text">Authentification robuste, données protégées et infrastructure stable. Concentrez-vous sur votre code, pas sur la sécurité.</p>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="card h-100 shadow-sm feature-card">
                        <div class="card-body text-center">
                            <i class="bi bi-people text-primary fs-1 mb-3"></i>
                            <h5 class="card-title">Communauté étudiante</h5>
                            <p class="card-text">Rejoignez une communauté active d'étudiants développeurs. Partagez, apprenez et collaborez sur des projets innovants.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- API Showcase Section -->
    <div class="api-showcase py-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <h2 class="fw-bold mb-4">Simple. Puissant. Gratuit.</h2>
                    <p class="lead text-muted mb-4">Intégrez DonnéesCST dans vos projets en quelques lignes de code seulement.</p>
                    <div class="d-flex flex-column gap-3">
                        <div class="d-flex align-items-center">
                            <i class="bi bi-check-circle-fill text-success me-3 fs-5"></i>
                            <span>Endpoints RESTful intuitifs</span>
                        </div>
                        <div class="d-flex align-items-center">
                            <i class="bi bi-check-circle-fill text-success me-3 fs-5"></i>
                            <span>Documentation interactive complète</span>
                        </div>
                        <div class="d-flex align-items-center">
                            <i class="bi bi-check-circle-fill text-success me-3 fs-5"></i>
                            <span>Authentification par token sécurisée</span>
                        </div>
                    </div>
                </div>
                <#include "/components/code_preview.ftl" />
            </div>
        </div>
    </div>

    <div class="getting-started-section py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto">
                    <h2 class="text-center fw-bold mb-4">Commencez votre projet en 4 étapes</h2>
                    <p class="text-center text-muted mb-5">Suivez ce guide simple pour intégrer DonnéesCST dans vos applications</p>
                    <div class="row step-section">
                        <div class="col-md-6 mb-4">
                            <div class="d-flex">
                                <div class="step-number">
                                    <span>1</span>
                                </div>
                                <div class="flex-grow-1 ms-3">
                                    <h5>Créer votre compte</h5>
                                    <p class="text-muted">Inscription gratuite avec votre adresse email du Cégep. Validation instantanée pour les étudiants.</p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-6 mb-4">
                            <div class="d-flex">
                                <div class="step-number">
                                    <span>2</span>
                                </div>
                                <div class="flex-grow-1 ms-3">
                                    <h5>Obtenir votre token d'API</h5>
                                    <p class="text-muted">Générez votre clé d'authentification personnelle depuis votre tableau de bord étudiant.</p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-6 mb-4">
                            <div class="d-flex">
                                <div class="step-number">
                                    <span>3</span>
                                </div>
                                <div class="flex-grow-1 ms-3">
                                    <h5>Explorer les endpoints</h5>
                                    <p class="text-muted">Découvrez toutes les données disponibles dans notre documentation interactive et testez directement.</p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-6 mb-4">
                            <div class="d-flex">
                                <div class="step-number">
                                    <span>4</span>
                                </div>
                                <div class="flex-grow-1 ms-3">
                                    <h5>Développer & déployer</h5>
                                    <p class="text-muted">Intégrez l'API dans votre projet et déployez. Rejoignez la communauté sur GitHub pour contribuer.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="text-center mt-5">
                        <a href="/docs" class="btn btn-primary btn-lg me-3">
                            <i class="bi bi-play-circle"></i> Commencer maintenant
                        </a>
                        <a href="/about" class="btn btn-outline-primary btn-lg">
                            <i class="bi bi-info-circle"></i> En savoir plus
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