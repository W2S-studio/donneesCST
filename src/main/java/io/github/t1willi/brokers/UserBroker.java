package io.github.t1willi.brokers;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import io.github.t1willi.database.RestBroker;
import io.github.t1willi.entities.ApiKeys;
import io.github.t1willi.entities.User;
import io.github.t1willi.security.cryptography.Cryptography;

public class UserBroker extends RestBroker<Integer, User> {

    public UserBroker() {
        super("users", User.class, int.class);
    }

    public Optional<User> findByUsername(String username) {
        return selectOne("SELECT * FROM users WHERE username = ?", username);
    }

    public boolean usernameExists(String username) {
        return findByUsername(username).isPresent();
    }

    public User createUser(String username, String hashedPassword) throws IllegalArgumentException {
        if (usernameExists(username)) {
            throw new IllegalArgumentException("Username already exists: " + username);
        }

        User user = new User();
        user.setUsername(username);
        user.setPassword(hashedPassword);
        return save(user);
    }

    public User updatePassword(int userId, String newHashedPassword)
            throws IllegalArgumentException {
        Optional<User> userOpt = findById(userId);
        if (userOpt.isEmpty()) {
            throw new IllegalArgumentException("User not found with ID: " + userId);
        }

        User user = userOpt.get();
        user.setPassword(Cryptography.hash(newHashedPassword));
        return save(user);
    }

    public Optional<User> authenticate(String username, String password) {
        Optional<User> userOpt = findByUsername(username);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            if (Cryptography.verify(user.getPassword(), password)) {
                loadApiKeys(user);
                return Optional.of(user);
            }
        }
        return Optional.empty();
    }

    public void loadApiKeys(User user) {
        List<ApiKeys> apiKeys = new ApiKeysBroker().findByUserId(user.getId());
        user.setApiKeys(apiKeys);
    }

    @Override
    public Optional<User> findById(Integer id) {
        Optional<User> userOpt = super.findById(id);
        userOpt.ifPresent(this::loadApiKeys);
        return userOpt;
    }

    @Override
    public List<User> findAll() {
        List<User> users = super.findAll();
        users.forEach(this::loadApiKeys);
        return users;
    }

    @Override
    public List<User> findByCriteria(Map<String, Object> criteria) {
        List<User> users = super.findByCriteria(criteria);
        users.forEach(this::loadApiKeys);
        return users;
    }
}
