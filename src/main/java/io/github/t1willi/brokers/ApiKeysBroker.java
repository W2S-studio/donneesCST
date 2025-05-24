package io.github.t1willi.brokers;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import io.github.t1willi.database.RestBroker;
import io.github.t1willi.entities.ApiKeys;

public class ApiKeysBroker extends RestBroker<Integer, ApiKeys> {

    public ApiKeysBroker() {
        super("api_keys", ApiKeys.class, int.class);
    }

    public List<ApiKeys> findByUserId(int userId) {
        Map<String, Object> criteria = new HashMap<>();
        criteria.put("user_id", userId);
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
        return findByKey(key)
                .map(this::isNotExpired)
                .orElse(false);
    }

    public void deleteExpiredKeys() {
        query("DELETE FROM api_keys WHERE expire IS NOT NULL AND expire < NOW()");
    }

    private boolean isNotExpired(ApiKeys apiKey) {
        LocalDateTime expire = apiKey.getExpire();
        return expire == null || !LocalDateTime.now().isAfter(expire);
    }
}