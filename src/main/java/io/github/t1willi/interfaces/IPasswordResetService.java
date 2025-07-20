package io.github.t1willi.interfaces;

import io.github.t1willi.context.JoltContext;
import io.github.t1willi.exception.SharedException;
import io.github.t1willi.form.Form;

public interface IPasswordResetService {
    boolean sendPasswordResetEmail(Form form, JoltContext context) throws SharedException;

    boolean resetPassword(Form form) throws SharedException;

    void validateResetToken(String token) throws SharedException;
}
