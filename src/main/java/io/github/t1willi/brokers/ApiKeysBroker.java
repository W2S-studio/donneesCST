package io.github.t1willi.brokers;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import io.github.t1willi.database.RestBroker;
import io.github.t1willi.entities.ApiKeys;

public class ApiKeysBroker extends RestBroker<Integer, ApiKeys> {

    protected ApiKeysBroker() {
        super("api_keys", ApiKeys.class, int.class);
    }

    public List<ApiKeys> findByUserId(int id) {
        Map<String, Object> criteria = new HashMap<>();
        criteria.put("user_id", id);
        return findByCriteria(criteria);
    }

    public Optional<ApiKeys> findByKey(String key) {
        return selectOne("SELECT * FROM api_keys WHERE key = ?", key);
    }

    public ApiKeys createApiKey(int userId, String key, LocalDateTime expireDate) {
        ApiKeys apiKey = new ApiKeys();
        apiKey.setUserId(userId);
        apiKey.setKey(key);
        apiKey.setCreated(LocalDateTime.now());
        apiKey.setExpire(expireDate);
        return save(apiKey);
    }

    public boolean isKeyValid(String key) {
        Optional<ApiKeys> apiKey = findByKey(key);
        if (apiKey.isEmpty()) {
            return false;
        }

        LocalDateTime expire = apiKey.get().getExpire();
        if (expire == null) {
            return true;
        }

        return !LocalDateTime.now().isAfter(expire);
    }

    public void deleteExpiredKeys() {
        query("DELETE FROM api_keys WHERE expire IS NOT NULL AND expire < NOW()");
    }
}