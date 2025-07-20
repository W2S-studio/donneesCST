package io.github.t1willi.validators;

import io.github.t1willi.form.Form;
import io.github.t1willi.injector.annotation.Bean;
import io.github.t1willi.interfaces.ISupportValidator;

@Bean
public class SupportValidator implements ISupportValidator {
    @Override
    public boolean validateSupport(Form form) {
        form.field("username")
                .required("Le nom d'utilisateur est obligatoire.");

        form.field("email")
                .required("L'adresse email est obligatoire.")
                .email("L'adresse email n'est pas valide.");

        form.field("subject")
                .required("Le sujet est obligatoire.");

        form.field("message")
                .required("Le message est obligatoire.");

        return form.validate();
    }
}