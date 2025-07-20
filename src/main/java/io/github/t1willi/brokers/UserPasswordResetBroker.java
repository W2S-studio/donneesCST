package io.github.t1willi.brokers;

import java.util.Optional;

import io.github.t1willi.database.RestBroker;
import io.github.t1willi.entities.UserPasswordReset;
import io.github.t1willi.injector.annotation.Bean;

@Bean
public class UserPasswordResetBroker extends RestBroker<Integer, UserPasswordReset> {

    public UserPasswordResetBroker() {
        super("user_password_reset", UserPasswordReset.class, int.class);
    }

    public Optional<UserPasswordReset> findByToken(String token) {
        return selectOne("SELECT * FROM " + table + " WHERE password_reset_token = ?", token);
    }
}
