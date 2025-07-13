package io.github.t1willi.brokers;

import io.github.t1willi.database.RestBroker;
import io.github.t1willi.entities.ApiKey;

public class ApiKeyBroker extends RestBroker<Integer, ApiKey> {

    public ApiKeyBroker() {
        super(
                "apikey",
                ApiKey.class,
                int.class);
    }
}
