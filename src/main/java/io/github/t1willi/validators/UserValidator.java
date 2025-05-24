package io.github.t1willi.validators;

import io.github.t1willi.form.Form;
import java.time.LocalDate;

public class UserValidator {

    public static void validateRegistration(Form form) throws IllegalArgumentException {
        form.field("username")
                .required("Le nom d'utilisateur est requis.")
                .min(3, "Le nom d'utilisateur doit contenir au moins 3 caractères.")
                .max(20, "Le nom d'utilisateur ne doit pas dépasser 20 caractères.");

        form.field("password")
                .required("Le mot de passe est requis")
                .strongPassword("Min 8 car., 1 maj., 1 min., 1 chiffre, 1 spécial");

        form.field("passwordConfirm")
                .required("La confirmation du mot de passe est requise")
                .rule(val -> val.equals(form.field("password").get()), "Les mots de passe ne correspondent pas");

        validateFormOrThrow(form);
    }

    public static void validateLogin(Form form) throws IllegalArgumentException {
        form.field("username")
                .required("Nom d'utilisateur requis");

        form.field("password")
                .required("Mot de passe requis");

        validateFormOrThrow(form);
    }

    public static void validatePasswordUpdate(Form form) throws IllegalArgumentException {
        form.field("oldPassword")
                .required("L'ancien mot de passe est requis");

        form.field("newPassword")
                .required("Le nouveau mot de passe est requis")
                .strongPassword("Min 8 car., 1 maj., 1 min., 1 chiffre, 1 spécial");

        form.field("newPasswordConfirm")
                .required("La confirmation du nouveau mot de passe est requise")
                .rule(val -> val.equals(form.field("newPassword").get()),
                        "Les nouveaux mots de passe ne correspondent pas");

        validateFormOrThrow(form);
    }

    public static void validateApiKeyCreation(Form form) throws IllegalArgumentException {
        String expiration = form.field("key_expiration").get();

        if (expiration != null && !expiration.isEmpty()) {
            form.field("key_expiration")
                    .rule(val -> isValidFutureDate(val),
                            "La date d'expiration doit être dans le futur et au format valide");
        }

        validateFormOrThrow(form);
    }

    public static void validatePasswordConfirmation(Form form) throws IllegalArgumentException {
        form.field("confirmPassword")
                .required("La confirmation du mot de passe est requise");

        validateFormOrThrow(form);
    }

    // Private helper methods
    private static void validateFormOrThrow(Form form) throws IllegalArgumentException {
        if (!form.validate()) {
            throw new IllegalArgumentException(String.join("; ", form.errors().values()));
        }
    }

    private static boolean isValidFutureDate(String dateStr) {
        try {
            LocalDate date = LocalDate.parse(dateStr);
            return !date.isBefore(LocalDate.now());
        } catch (Exception e) {
            return false;
        }
    }
}