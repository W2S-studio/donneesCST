package io.github.t1willi.validators;

import io.github.t1willi.form.Form;
import io.github.t1willi.injector.annotation.Bean;
import io.github.t1willi.interfaces.IPasswordResetValidator;
import io.github.t1willi.security.cryptography.Cryptography;

@Bean
public class PasswordResetValidator implements IPasswordResetValidator {

    @Override
    public boolean validatePasswordReset(Form form, String currentPassword) {
        String password = form.field("password").get();

        form.field("password")
                .required("Le mot de passe est obligatoire.")
                .strongPassword(
                        "Le mot de passe doit contenir au moins 8 caractères dont, 1 chiffre, 1 lettre majuscule et 1 lettre minuscule et 1 caractère spécial.")
                .rule(pwd -> !Cryptography.verify(currentPassword, pwd),
                        "Le nouveau mot de passe doit être différent de l'ancien mot de passe.");

        form.field("confirm_password")
                .required("La confirmation du mot de passe est obligatoire.")
                .rule(confirmPwd -> password != null && password.equals(confirmPwd),
                        "Les mots de passe doivent être identiques.");

        return form.validate();
    }

    @Override
    public boolean validatePasswordResetRequest(Form form) {
        form.field("email")
                .required("L'adresse email est obligatoire.")
                .email("L'adresse email n'est pas valide.");

        return form.validate();
    }
}