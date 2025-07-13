package io.github.t1willi.brokers;

import java.util.Optional;

import io.github.t1willi.database.RestBroker;
import io.github.t1willi.entities.User;

public class UserBroker extends RestBroker<Integer, User> {

    public UserBroker() {
        super(
                "users",
                User.class,
                int.class);
    }

    public Optional<User> findByEmail(String email) {
        return selectOne("SELECT * FROM users WHERE email = ?", email);
    }
}
