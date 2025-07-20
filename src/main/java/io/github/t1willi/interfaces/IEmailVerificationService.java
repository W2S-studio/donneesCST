package io.github.t1willi.interfaces;

import io.github.t1willi.context.JoltContext;
import io.github.t1willi.entities.User;
import io.github.t1willi.exception.SharedException;
import io.github.t1willi.form.Form;

public interface IEmailVerificationService {
    boolean sendVerificationEmail(User user, JoltContext context);

    boolean resendVerificationEmail(Form form, JoltContext context) throws SharedException;

    void verifyEmail(String token) throws SharedException;
}
