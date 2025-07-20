package io.github.t1willi.services;

import java.util.List;

import io.github.t1willi.entities.ApiKey;
import io.github.t1willi.injector.annotation.Bean;
import io.github.t1willi.interfaces.IApiKeyService;

@Bean
public class ApiKeyService implements IApiKeyService {

    @Override
    public List<ApiKey> getApiKeyForUser(int userId) {
        throw new UnsupportedOperationException("Unimplemented method 'getApiKeyForUser'");
    }
}
