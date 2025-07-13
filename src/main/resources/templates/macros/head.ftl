<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>DonnéesCST - ${pageTitle!'Tableau de bord'}</title>
<link nonce="${nonce()}" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link nonce="${nonce()}" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
<link nonce="${nonce()}" href="/style/style.css" rel="stylesheet">
<link rel="shortcut icon" href="https://cdn-icons-png.flaticon.com/512/3872/3872759.png" type="image/x-icon">
<#if additionalCSS??>
    <#list additionalCSS as css>
        <link nonce="${nonce()}" href="${css}" rel="stylesheet">
    </#list>
</#if>
