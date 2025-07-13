
package io.github.t1willi.brokers;

import io.github.t1willi.database.RestBroker;
import io.github.t1willi.entities.Log;

public class LogBroker extends RestBroker<Integer, Log> {

    public LogBroker() {
        super(
                "logs",
                Log.class,
                int.class);
    }
}