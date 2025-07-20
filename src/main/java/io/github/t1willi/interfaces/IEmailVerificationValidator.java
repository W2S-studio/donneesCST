package io.github.t1willi.interfaces;

import io.github.t1willi.form.Form;

public interface IEmailVerificationValidator {
    boolean validateEmailResendRequest(Form form);
}