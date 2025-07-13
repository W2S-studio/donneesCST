package io.github.t1willi.interfaces;

import io.github.t1willi.entities.User;
import io.github.t1willi.form.Form;

public interface IAuthService {

    public User authenticate(Form form);

    public User register(Form form);

    public boolean updateEmail(int userId, Form form);

    public boolean updatePassword(int userId, Form form);
}
