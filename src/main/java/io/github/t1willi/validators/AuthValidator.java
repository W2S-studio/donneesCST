package io.github.t1willi.validators;

import io.github.t1willi.form.Form;
import io.github.t1willi.injector.annotation.Bean;
import io.github.t1willi.interfaces.IAuthValidator;

@Bean
public class AuthValidator implements IAuthValidator {

        @Override
        public boolean validateAuthentication(Form form) {
                form.field("email")
                                .required("Votre adresse e-mail est obligatoire");

                form.field("password")
                                .required("Votre mot de passe est obligatoire");

                return form.validate();
        }

        @Override
        public boolean validateRegistration(Form form) {
                form.field("username")
                                .required("Votre nom d'utilisateur est obligatoire.")
                                .min(3, "Votre nom d'utilisateur doit contenir au moins 3 caractères.")
                                .max(32, "Votre nom d'utilisateur doit contenir au plus 32 caractères.")
                                .regex("^[a-zA-Z0-9]+$",
                                                "Votre nom d'utilisateur ne peut contenir que des lettres et des chiffres.");

                form.field("email")
                                .required("Votre adresse e-mail est obligatoire.")
                                .email("Votre adresse e-mail n'est pas valide.");

                form.field("password")
                                .required("Votre mot de passe est obligatoire.")
                                .max(64, "Votre mot de passe doit contenir au plus 64 caractères.")
                                .strongPassword(
                                                "Votre mot de passe doit contenir au moins 8 caractères dont, 1 chiffre, 1 lettre majuscule et 1 lettre minuscule et 1 caractère spécial.");

                form.field("password_confirm")
                                .required("Le mot de passe de confirmation est obligatoire.")
                                .rule(confirmPassword -> {
                                        return confirmPassword.equals(form.field("password").get());
                                }, "Le mot de passe de confirmation ne correspond pas au mot de passe.");

                return form.validate();
        }

        @Override
        public boolean validatePasswordUpdate(Form form) {
                form.field("current_password")
                                .required("Le mot de passe actuel est requis.");

                form.field("new_password")
                                .required("Le nouveau mot de passe est requis.")
                                .strongPassword(
                                                "Le nouveau mot de passe doit contenir au moins 8 caractères dont, 1 chiffre, 1 lettre majuscule et 1 lettre minuscule et 1 caractère spécial.");

                form.field("new_password_confirm")
                                .required("Le mot de passe de confirmation est obligatoire.")
                                .rule(confirmPassword -> {
                                        return confirmPassword.equals(form.field("new_password").get());
                                }, "Le mot de passe de confirmation ne correspond pas au mot de passe.");

                return form.validate();
        }
}
