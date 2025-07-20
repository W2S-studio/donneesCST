<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Message reçu - Support Jolt Framework</title>
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
        .message-content {
            background-color: #ffffff;
            border: 1px solid #dee2e6;
            padding: 15px;
            border-radius: 5px;
            margin: 10px 0;
            font-style: italic;
        }
        .response-time {
            background-color: #fff3cd;
            border-left: 4px solid #ffc107;
            padding: 10px 15px;
            margin: 20px 0;
            border-radius: 0 5px 5px 0;
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
            <h1>✉️ Message reçu</h1>
        </div>
        <div class="content">
            <h1>Bonjour ${userName},</h1>
            <p>Nous avons bien reçu votre message envoyé à notre équipe de support.</p>
            
            <div class="message-info">
                <strong>✅ Votre demande a été enregistrée avec succès !</strong>
            </div>
            
            <div class="message-details">
                <h3>Détails de votre demande :</h3>
                <p><strong>Sujet :</strong> ${subject}</p>
                <p><strong>Date et heure :</strong> ${submissionTime}</p>
                <p><strong>Adresse email :</strong> ${userEmail}</p>
                
                <div class="message-content">
                    <strong>Votre message :</strong><br>
                    ${messageContent}
                </div>
            </div>
            
            <div class="response-time">
                <strong>⏱️ Délai de réponse :</strong> Notre équipe de support vous répondra dans les plus brefs délais, généralement sous 24 à 48 heures.
            </div>
            
            <p>En attendant notre réponse, n'hésitez pas à consulter notre documentation ou notre FAQ qui pourraient répondre à vos questions.</p>
            
            <p>Si votre demande est urgente ou si vous avez des informations supplémentaires à nous communiquer, vous pouvez répondre directement à cet email.</p>
            
            <p>Merci de votre confiance et de votre patience.</p>
            
            <p>Cordialement,<br>
            L'équipe de support Jolt Framework</p>
        </div>
        <div class="footer">
            <p>&copy; 2025 Jolt Framework. All rights reserved.</p>
            <p>Cet email a été envoyé automatiquement, merci de ne pas y répondre directement. Sauf si votre demande est urgente.</p>
        </div>
    </div>
</body>
</html>