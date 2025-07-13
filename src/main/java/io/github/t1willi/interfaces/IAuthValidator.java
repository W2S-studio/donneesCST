package io.github.t1willi.interfaces;

import io.github.t1willi.form.Form;

public interface IAuthValidator {

    public boolean validateAuthentication(Form form);

    public boolean validateRegistration(Form form);

    public boolean validateEmailUpdate(Form form);

    public boolean validatePasswordUpdate(Form form);
}
