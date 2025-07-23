package io.github.t1willi.interfaces;

import io.github.t1willi.entities.User;
import io.github.t1willi.form.Form;

public interface IAuthService {
    User authenticate(Form form);

    User register(Form form);

    boolean isEmailValidated(int userId);

    boolean updatePassword(int userId, Form form);
}