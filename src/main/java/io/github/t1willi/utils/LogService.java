package io.github.t1willi.utils;

import io.github.t1willi.brokers.LogBroker;
import io.github.t1willi.context.JoltContext;
import io.github.t1willi.core.JoltDispatcherServlet;
import io.github.t1willi.entities.Log;
import lombok.Getter;
import lombok.ToString;

public class LogService {

    @Getter
    @ToString
    public static enum Action {
        // Authentication actions
        CONNEXION("Connexion réussie"),
        CONNEXION_FAILED("Tentative de connexion échouée"),
        LOGOUT("Déconnexion réussie"),

        // Account actions
        ACCOUNT_CREATED("Compte créé avec succès"),
        ACCOUNT_VERIFIED("Compte vérifié avec succès"),
        ACCOUNT_DELETED("Compte supprimé avec succès"),

        // Password actions
        PASSWORD_CHANGED("Mot de passe changé avec succès"),
        PASSWORD_RESET_REQUESTED("Demande de réinitialisation de mot de passe"),
        PASSWORD_RESET("Mot de passe réinitialisé avec succès"),

        // Email actions
        EMAIL_VERIFICATION_SENT("Email de vérification envoyé"),
        EMAIL_VERIFICATION_FAILED("Échec de la vérification de l'email"),
        EMAIL_UPDATED("Email mis à jour avec succès"),

        // Security actions
        TWO_FACTOR_ENABLED_FOR_EMAIL("Authentification à deux facteurs activée pour l'email"),
        TWO_FACTOR_DISABLED_FOR_EMAIL("Authentification à deux facteurs désactivée pour l'email"),
        TWO_FACTOR_ENABLED_FOR_APP("Authentification à deux facteurs activée pour l'application"),
        TWO_FACTOR_DISABLED_FOR_APP("Authentification à deux facteurs désactivée pour l'application"),
        TWO_FACTOR_CODE_SENT("Code d'authentification à deux facteurs envoyé par email"),
        TWO_FACTOR_CODE_SENT_TO_APP("Code d'authentification à deux facteurs envoyé à l'application"),
        TWO_FACTOR_CODE_VERIFIED("Code d'authentification à deux facteurs vérifié avec succès"),
        TWO_FACTOR_CODE_VERIFICATION_FAILED("Échec de la vérification du code d'authentification à deux facteurs"),

        // Support
        SUPPORT_CONTACTED("Support contacté avec succès"),
        SUPPORT_EMAIL_SENT("Email de support envoyé avec succès");

        private final String action;

        Action(String action) {
            this.action = action;
        }
    }

    public static void log(Action action) {
        JoltContext context = JoltDispatcherServlet.getCurrentContext();
        Log log = Log.of(action.toString(), context.userAgent(), context.clientIp());
        new LogBroker().save(log);
    }

    public static void log(Action action, int userId) {
        JoltContext context = JoltDispatcherServlet.getCurrentContext();
        Log log = Log.of(userId, action.toString(), context.userAgent(), context.clientIp());
        new LogBroker().save(log);
    }

    // Authentication
    public static void logConnexion() {
        log(Action.CONNEXION);
    }

    public static void logConnexion(int userId) {
        log(Action.CONNEXION, userId);
    }

    public static void logConnexionFailed() {
        log(Action.CONNEXION_FAILED);
    }

    public static void logConnexionFailed(int userId) {
        log(Action.CONNEXION_FAILED, userId);
    }

    public static void logLogout() {
        log(Action.LOGOUT);
    }

    public static void logLogout(int userId) {
        log(Action.LOGOUT, userId);
    }

    // Account actions
    public static void logAccountCreated() {
        log(Action.ACCOUNT_CREATED);
    }

    public static void logAccountCreated(int userId) {
        log(Action.ACCOUNT_CREATED, userId);
    }

    public static void logAccountVerified() {
        log(Action.ACCOUNT_VERIFIED);
    }

    public static void logAccountVerified(int userId) {
        log(Action.ACCOUNT_VERIFIED, userId);
    }

    public static void logAccountDeleted() {
        log(Action.ACCOUNT_DELETED);
    }

    public static void logAccountDeleted(int userId) {
        log(Action.ACCOUNT_DELETED, userId);
    }

    // Password actions
    public static void logPasswordChanged() {
        log(Action.PASSWORD_CHANGED);
    }

    public static void logPasswordChanged(int userId) {
        log(Action.PASSWORD_CHANGED, userId);
    }

    public static void logPasswordResetRequested() {
        log(Action.PASSWORD_RESET_REQUESTED);
    }

    public static void logPasswordResetRequested(int userId) {
        log(Action.PASSWORD_RESET_REQUESTED, userId);
    }

    public static void logPasswordReset() {
        log(Action.PASSWORD_RESET);
    }

    public static void logPasswordReset(int userId) {
        log(Action.PASSWORD_RESET, userId);
    }

    // Email actions
    public static void logEmailVerificationSent() {
        log(Action.EMAIL_VERIFICATION_SENT);
    }

    public static void logEmailVerificationSent(int userId) {
        log(Action.EMAIL_VERIFICATION_SENT, userId);
    }

    public static void logEmailVerificationFailed() {
        log(Action.EMAIL_VERIFICATION_FAILED);
    }

    public static void logEmailVerificationFailed(int userId) {
        log(Action.EMAIL_VERIFICATION_FAILED, userId);
    }

    public static void logEmailUpdated() {
        log(Action.EMAIL_UPDATED);
    }

    public static void logEmailUpdated(int userId) {
        log(Action.EMAIL_UPDATED, userId);
    }

    // Security actions
    public static void logTwoFactorEnabledForEmail() {
        log(Action.TWO_FACTOR_ENABLED_FOR_EMAIL);
    }

    public static void logTwoFactorEnabledForEmail(int userId) {
        log(Action.TWO_FACTOR_ENABLED_FOR_EMAIL, userId);
    }

    public static void logTwoFactorDisabledForEmail() {
        log(Action.TWO_FACTOR_DISABLED_FOR_EMAIL);
    }

    public static void logTwoFactorDisabledForEmail(int userId) {
        log(Action.TWO_FACTOR_DISABLED_FOR_EMAIL, userId);
    }

    public static void logTwoFactorEnabledForApp() {
        log(Action.TWO_FACTOR_ENABLED_FOR_APP);
    }

    public static void logTwoFactorEnabledForApp(int userId) {
        log(Action.TWO_FACTOR_ENABLED_FOR_APP, userId);
    }

    public static void logTwoFactorDisabledForApp() {
        log(Action.TWO_FACTOR_DISABLED_FOR_APP);
    }

    public static void logTwoFactorDisabledForApp(int userId) {
        log(Action.TWO_FACTOR_DISABLED_FOR_APP, userId);
    }

    public static void logTwoFactorCodeSent() {
        log(Action.TWO_FACTOR_CODE_SENT);
    }

    public static void logTwoFactorCodeSent(int userId) {
        log(Action.TWO_FACTOR_CODE_SENT, userId);
    }

    public static void logTwoFactorCodeSentToApp() {
        log(Action.TWO_FACTOR_CODE_SENT_TO_APP);
    }

    public static void logTwoFactorCodeSentToApp(int userId) {
        log(Action.TWO_FACTOR_CODE_SENT_TO_APP, userId);
    }

    public static void logTwoFactorCodeVerified() {
        log(Action.TWO_FACTOR_CODE_VERIFIED);
    }

    public static void logTwoFactorCodeVerified(int userId) {
        log(Action.TWO_FACTOR_CODE_VERIFIED, userId);
    }

    public static void logTwoFactorCodeVerificationFailed() {
        log(Action.TWO_FACTOR_CODE_VERIFICATION_FAILED);
    }

    public static void logTwoFactorCodeVerificationFailed(int userId) {
        log(Action.TWO_FACTOR_CODE_VERIFICATION_FAILED, userId);
    }

    // Support actions
    public static void logSupportContacted() {
        log(Action.SUPPORT_CONTACTED);
    }

    public static void logSupportContacted(int userId) {
        log(Action.SUPPORT_CONTACTED, userId);
    }

    public static void logSupportEmailSent() {
        log(Action.SUPPORT_EMAIL_SENT);
    }

    public static void logSupportEmailSent(int userId) {
        log(Action.SUPPORT_EMAIL_SENT, userId);
    }
}