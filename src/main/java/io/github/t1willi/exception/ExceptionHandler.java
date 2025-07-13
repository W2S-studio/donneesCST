package io.github.t1willi.exception;

import java.util.Map;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

import io.github.t1willi.exceptions.handler.GlobalExceptionHandler;
import io.github.t1willi.http.HttpStatus;
import io.github.t1willi.injector.annotation.Configuration;
import io.github.t1willi.template.JoltModel;
import jakarta.servlet.http.HttpServletResponse;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Configuration
public class ExceptionHandler extends GlobalExceptionHandler {

        @Override
        public void handle(Throwable t, HttpServletResponse response) {
                int statusCode = response.getStatus();
                HttpStatus httpStatus = HttpStatus.fromCode(statusCode);

                String message = t.getMessage() != null && !t.getMessage().isBlank()
                                ? t.getMessage()
                                : httpStatus.reason();

                String errorId = UUID.randomUUID().toString().substring(0, 8).toUpperCase();
                String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss"));
                ErrorInfo errorInfo = categorizeError(statusCode, message);

                context().status(statusCode);
                Map<String, Object> model = new java.util.HashMap<>();
                model.put("status", statusCode);
                model.put("message", message);
                model.put("statusReason", httpStatus.reason());
                model.put("errorId", errorId);
                model.put("timestamp", timestamp);
                model.put("category", errorInfo.getCategory());
                model.put("userMessage", errorInfo.getUserMessage());
                model.put("suggestions", errorInfo.getSuggestions());
                model.put("pageTitle", generatePageTitle(statusCode, httpStatus.reason()));
                model.put("canRetry", errorInfo.isCanRetry());
                model.put("showTechnicalDetails", shouldShowTechnicalDetails(statusCode));
                model.put("stackTrace", getStackTrace(t));
                model.put("requestPath", getRequestPath());
                model.put("userAgent", getUserAgent());

                context().render("error", JoltModel.of(model));
                context().commit();
        }

        private String generatePageTitle(int statusCode, String reason) {
                return switch (statusCode) {
                        case 400 -> "Requête Invalide - Données Incorrectes";
                        case 401 -> "Non Autorisé - Connexion Requise";
                        case 403 -> "Accès Interdit - Permissions Insuffisantes";
                        case 404 -> "Page Introuvable";
                        case 408 -> "Délai d'Attente Dépassé";
                        case 429 -> "Trop de Requêtes";
                        case 500 -> "Erreur Serveur - Nous Travaillons Dessus";
                        case 502 -> "Passerelle Défaillante - Service Indisponible";
                        case 503 -> "Service Indisponible - Maintenance";
                        case 504 -> "Délai de Passerelle Dépassé";
                        default -> "Erreur " + statusCode + " - " + reason;
                };
        }

        private ErrorInfo categorizeError(int statusCode, String message) {
                return switch (statusCode) {
                        case 400 -> new ErrorInfo(
                                        "Erreur Client",
                                        "La requête contient des informations invalides. Veuillez vérifier vos données et réessayer.",
                                        new String[] { "Vérifiez que tous les champs requis sont remplis",
                                                        "Contrôlez le format des données",
                                                        "Contactez le support si le problème persiste" },
                                        true);
                        case 401 -> new ErrorInfo(
                                        "Authentification Requise",
                                        "Vous devez vous connecter pour accéder à cette ressource.",
                                        new String[] { "Connectez-vous avec vos identifiants",
                                                        "Vérifiez si votre session a expiré",
                                                        "Réinitialisez votre mot de passe si nécessaire" },
                                        false);
                        case 403 -> new ErrorInfo(
                                        "Accès Refusé",
                                        "Vous n'avez pas les permissions nécessaires pour accéder à cette ressource.",
                                        new String[] { "Contactez l'administrateur pour obtenir l'accès",
                                                        "Vérifiez les permissions de votre compte",
                                                        "Connectez-vous avec un autre compte" },
                                        false);
                        case 404 -> new ErrorInfo(
                                        "Introuvable",
                                        "La page ou la ressource que vous cherchez n'existe pas.",
                                        new String[] { "Vérifiez l'URL pour les fautes de frappe",
                                                        "Utilisez le menu de navigation",
                                                        "Recherchez ce dont vous avez besoin" },
                                        false);
                        case 408 -> new ErrorInfo(
                                        "Délai Dépassé",
                                        "La requête a pris trop de temps à traiter.",
                                        new String[] { "Réessayez avec une requête plus simple",
                                                        "Vérifiez votre connexion internet",
                                                        "Contactez le support si le problème persiste" },
                                        true);
                        case 429 -> new ErrorInfo(
                                        "Limite de Débit",
                                        "Trop de requêtes envoyées en peu de temps. Veuillez ralentir.",
                                        new String[] { "Attendez quelques minutes avant de réessayer",
                                                        "Réduisez la fréquence des requêtes",
                                                        "Contactez le support pour augmenter la limite" },
                                        true);
                        case 500 -> new ErrorInfo(
                                        "Erreur Serveur",
                                        "Quelque chose s'est mal passé de notre côté. Nous travaillons à le corriger.",
                                        new String[] { "Essayez de rafraîchir la page",
                                                        "Attendez quelques minutes et réessayez",
                                                        "Contactez le support avec l'ID d'erreur" },
                                        true);
                        case 502 -> new ErrorInfo(
                                        "Service Indisponible",
                                        "Le service est temporairement indisponible.",
                                        new String[] { "Réessayez dans quelques minutes",
                                                        "Consultez la page de statut du service",
                                                        "Contactez le support si le problème persiste" },
                                        true);
                        case 503 -> new ErrorInfo(
                                        "Mode Maintenance",
                                        "Le service est en cours de maintenance. Nous serons bientôt de retour.",
                                        new String[] { "Attendez la fin de la maintenance",
                                                        "Consultez nos réseaux sociaux pour les mises à jour",
                                                        "Réessayez plus tard" },
                                        true);
                        case 504 -> new ErrorInfo(
                                        "Délai de Passerelle",
                                        "Le serveur n'a pas reçu de réponse à temps.",
                                        new String[] { "Réessayez dans un moment", "Vérifiez votre connexion",
                                                        "Contactez le support si cela continue" },
                                        true);
                        default -> new ErrorInfo(
                                        "Erreur",
                                        "Une erreur inattendue s'est produite.",
                                        new String[] { "Rafraîchissez la page", "Réessayez plus tard",
                                                        "Contactez le support avec l'ID d'erreur" },
                                        true);
                };
        }

        private boolean shouldShowTechnicalDetails(int statusCode) {
                return statusCode >= 500;
        }

        private String getStackTrace(Throwable t) {
                if (t == null)
                        return "";

                StringBuilder sb = new StringBuilder();
                sb.append(t.getClass().getSimpleName()).append(": ").append(t.getMessage()).append("\n");

                for (StackTraceElement element : t.getStackTrace()) {
                        sb.append("    at ").append(element.toString()).append("\n");
                        if (sb.length() > 2000) {
                                sb.append("    ... (truncated)\n");
                                break;
                        }
                }

                if (t.getCause() != null) {
                        sb.append("Caused by: ").append(getStackTrace(t.getCause()));
                }

                return sb.toString();
        }

        private String getRequestPath() {
                return context().rawPath() != null ? context().rawPath() : "Inconnu";
        }

        private String getUserAgent() {
                return context().userAgent() != null ? context().userAgent() : "Inconnu";
        }

        @Getter
        @AllArgsConstructor
        public static class ErrorInfo {
                private final String category;
                private final String userMessage;
                private final String[] suggestions;
                private final boolean canRetry;
        }

        @Getter
        @AllArgsConstructor
        public static class ExceptionResponse {
                private final String message;
                private final int status;
                private final String statusMessage;
        }
}