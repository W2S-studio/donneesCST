<link nonce="${nonce()}" rel="stylesheet" href="/style/shared/navbar.css">

<nav class="navbar navbar-expand-xxl navbar-cegep custom-breakpoint">
    <div class="container">
        <a class="navbar-brand">DonnéesCST (Beta)</a>
        
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Basculer la navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link ${(currentPage == 'home')?then('active', '')}" href="/">
                        <i class="bi bi-house-door"></i> Accueil
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${(currentPage == 'docs')?then('active', '')}" href="/docs">
                        <i class="bi bi-file-earmark-code"></i> Documentation
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${(currentPage == 'about')?then('active', '')}" href="/about">
                        <i class="bi bi-info-circle"></i> À propos
                    </a>
                </li>
            </ul>
            
            <ul class="navbar-nav">
                <#if username??>
                     <li class="nav-item d-flex align-items-center user-display">
                        <i class="bi bi-person-circle me-2"></i>
                        <span class="username-text">${username}</span>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link ${(currentPage == 'dashboard')?then('active', '')}" href="/dashboard">
                            <i class="bi bi-speedometer2"></i> Tableau de bord
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/logout">
                            <i class="bi bi-box-arrow-right"></i> Se déconnecter
                        </a>
                    </li>
                <#else>
                    <li class="nav-item">
                        <a class="nav-link" href="/login">
                            <i class="bi bi-box-arrow-in-right"></i> Connexion
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/register">
                            <i class="bi bi-person-plus"></i> S'inscrire
                        </a>
                    </li>
                </#if>
            </ul>
        </div>
    </div>
</nav>