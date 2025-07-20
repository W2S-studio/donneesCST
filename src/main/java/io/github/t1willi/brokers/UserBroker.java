package io.github.t1willi.brokers;

import java.util.Optional;

import io.github.t1willi.database.RestBroker;
import io.github.t1willi.entities.User;
import io.github.t1willi.injector.annotation.Bean;

@Bean
public class UserBroker extends RestBroker<Integer, User> {

    public UserBroker() {
        super(
                "users",
                User.class,
                int.class);
    }

    public Optional<User> findByHashEmail(String email) {
        return selectOne("SELECT * FROM users WHERE hash_email = ?", email);
    }

    public boolean isEmailValidated(int userId) {
        return selectOne("SELECT * FROM " + table + " WHERE id = ? AND email_validate = ?", userId, true).isPresent();
    }
}
