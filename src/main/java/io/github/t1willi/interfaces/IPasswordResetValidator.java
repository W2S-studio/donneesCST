package io.github.t1willi.interfaces;

import io.github.t1willi.form.Form;

public interface IPasswordResetValidator {
    boolean validatePasswordReset(Form form, String userCurrentPassword);

    boolean validatePasswordResetRequest(Form form);
}