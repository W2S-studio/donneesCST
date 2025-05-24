<header class="text-white">
    <div class="container d-flex justify-content-between align-items-center">
        <h1 class="fs-3 fw-bold">DonnéesCST</h1>
        <nav>
            <#if username??>
                <span class="navbar-text text-white me-3">Bienvenue, ${username}</span>
                <#if currentPage == "dashboard">
                    <a href="/" class="btn btn-outline-light mx-2">Accueil</a>
                <#else>
                    <a href="/dashboard" class="btn btn-outline-light mx-2">Tableau de bord</a>
                </#if>
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