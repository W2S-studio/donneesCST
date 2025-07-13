<!DOCTYPE html>
<html lang="fr">
<head>
    <#assign pageTitle = "Pour les étudiants" />
    <#assign additionalCss = ["style/custom.css", "style/normalize.css"] />
    <#include "macros/head.ftl"/>
</head>
<body class="d-flex flex-column min-vh-100">
    <#include "components/flash.ftl">
    <script nonce="${nonce()}" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>