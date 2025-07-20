package io.github.t1willi.services;

import java.util.Map;

import io.github.t1willi.injector.annotation.Bean;
import io.github.t1willi.interfaces.IUsageService;

@Bean
public class UsageService implements IUsageService {

    @Override
    public Map<String, Object> monthlyUsage(int userId, int months) {
        return null;
    }

    @Override
    public Map<String, Object> usageByKey(int userId) {
        return null;
    }
}
