<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Nouvelle demande de support - Jolt Framework</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            background-color: #ffffff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .header {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            text-align: center;
            padding: 20px;
        }
        .content {
            padding: 30px;
            color: #333;
        }
        .content h1 {
            font-size: 24px;
            margin-top: 0;
        }
        .content p {
            line-height: 1.6;
            font-size: 16px;
        }
        .message-info {
            background-color: #e9f7ef;
            border-left: 4px solid #28a745;
            padding: 15px 20px;
            margin: 20px 0;
            border-radius: 0 5px 5px 0;
        }
        .message-details {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            margin: 20px 0;
        }
        .message-details h3 {
            margin-top: 0;
            color: #495057;
        }
        .message-details p {
            margin: 5px 0;
            font-size: 14px;
            color: #6c757d;
        }
        .message-details ul {
            margin: 10px 0 0 20px;
            padding: 0;
        }
        .message-details ul li {
            font-size: 14px;
            color: #6c757d;
        }
        .message-content {
            background-color: #ffffff;
            border: 1px solid #dee2e6;
            padding: 15px;
            border-radius: 5px;
            margin: 10px 0;
            font-style: italic;
        }
        .footer {
            text-align: center;
            padding: 20px;
            font-size: 12px;
            color: #777;
            background-color: #f8f8f8;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>✉️ Nouvelle demande de support</h1>
        </div>
        <div class="content">
            <h1>Bonjour équipe de support,</h1>
            <p>Vous avez reçu une nouvelle demande :</p>

            <div class="message-info">
                <strong>⚠️ Veuillez prendre en charge cette demande :</strong>
            </div>

            <div class="message-details">
                <h3>Détails de la demande :</h3>
                <p><strong>Nom d'utilisateur :</strong> ${userName}</p>
                <p><strong>Adresse email :</strong> ${userEmail}</p>
                <p><strong>Sujet :</strong> ${subject}</p>
                <p><strong>Date et heure :</strong> ${submissionTime}</p>

                <#if attachments?? && attachments?size gt 0>
                    <p><strong>Fichiers joints :</strong></p>
                    <ul>
                      <#list attachments as file>
                        <li>${file.originalFilename}</li>
                      </#list>
                    </ul>
                </#if>

                <div class="message-content">
                    <strong>Message :</strong><br>
                    ${messageContent?html}
                </div>
            </div>

            <p>Merci de traiter ce ticket dès que possible.</p>
            <p>Cordialement,<br>
               Le système de support Jolt Framework</p>
        </div>
        <div class="footer">
            <p>&copy; 2025 Jolt Framework. Tous droits réservés.</p>
            <p>Ce message a été généré automatiquement.</p>
        </div>
    </div>
</body>
</html>
