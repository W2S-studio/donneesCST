<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DonnéesCST - Connexion</title>
    <link nonce="${nonce()}" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link nonce="${nonce()}" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link nonce="${nonce()}" href="/style/home.css" rel="stylesheet">
</head>
<body class="d-flex flex-column min-vh-100">
    <main class="container flex-grow-1 d-flex align-items-center">
        <div class="w-100 card-wrapper">
            <div class="card shadow-sm">
                <div class="card-body p-4">
                    <h2 class="h4 fw-bold text-center mb-4">Connexion</h2>
                    <#if errors?? && errors?size gt 0>
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <#list errors as error>
                                <div>${error}</div>
                            </#list>
                            <button 
                                type="button" 
                                class="btn-close" 
                                data-bs-dismiss="alert" 
                                aria-label="Close">
                            </button>
                        </div>
                    </#if>
                    <form action="/connexion" method="post">
                        <div class="mb-3">
                            <label for="username" class="form-label">Nom d'utilisateur</label>
                            <input type="text" class="form-control" id="username" name="username" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Mot de passe</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Se connecter</button>
                    </form>
                    <p class="text-center mt-3 mb-0">
                        Pas de compte? <a href="/inscription" class="text-primary">Créez-en un</a>
                    </p>
                </div>
            </div>
        </div>
    </main>
    <script nonce="${nonce()}" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>