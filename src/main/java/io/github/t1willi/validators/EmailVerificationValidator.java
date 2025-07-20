package io.github.t1willi.validators;

import io.github.t1willi.form.Form;
import io.github.t1willi.injector.annotation.Bean;
import io.github.t1willi.interfaces.IEmailVerificationValidator;

@Bean
public class EmailVerificationValidator implements IEmailVerificationValidator {

    @Override
    public boolean validateEmailResendRequest(Form form) {
        form.field("email")
                .required("L'adresse email est obligatoire.")
                .email("L'adresse email n'est pas valide.");

        return form.validate();
    }
}