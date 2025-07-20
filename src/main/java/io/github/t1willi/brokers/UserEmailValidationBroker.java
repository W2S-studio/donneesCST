package io.github.t1willi.brokers;

import java.util.Optional;

import io.github.t1willi.database.RestBroker;
import io.github.t1willi.entities.UserEmailValidation;
import io.github.t1willi.injector.annotation.Bean;

@Bean
public class UserEmailValidationBroker extends RestBroker<Integer, UserEmailValidation> {

    public UserEmailValidationBroker() {
        super(
                "user_email_validation",
                UserEmailValidation.class,
                int.class);
    }

    public Optional<UserEmailValidation> findByToken(String token) {
        return selectOne("SELECT * FROM " + table + " WHERE email_validation_token = ?", token);
    }
}
