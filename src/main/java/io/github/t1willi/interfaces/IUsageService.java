package io.github.t1willi.interfaces;

import java.util.Map;

public interface IUsageService {
    Map<String, Object> monthlyUsage(int userId, int months);

    Map<String, Object> usageByKey(int userId);
}
