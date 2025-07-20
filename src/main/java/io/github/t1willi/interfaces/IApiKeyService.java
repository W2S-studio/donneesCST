package io.github.t1willi.interfaces;

import java.util.List;

import io.github.t1willi.entities.ApiKey;

public interface IApiKeyService {
    List<ApiKey> getApiKeyForUser(int userId);
}
