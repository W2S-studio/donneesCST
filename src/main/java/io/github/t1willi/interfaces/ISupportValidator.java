package io.github.t1willi.interfaces;

import io.github.t1willi.form.Form;

public interface ISupportValidator {
    /**
     * Validate the support/contact form.
     * 
     * @param form the incoming Form
     * @return true if valid (no errors), false otherwise
     */
    boolean validateSupport(Form form);
}
