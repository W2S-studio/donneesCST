package io.github.t1willi.configuration;

import io.github.t1willi.server.config.ConfigurationManager;
import lombok.Getter;

public class EmailConfiguration {

    @Getter
    private final String host;

    @Getter
    private final String apiKey;

    @Getter
    private final String fromEmail;

    @Getter
    private final String fromName;

    public EmailConfiguration(Builder builder) {
        this.host = builder.host;
        this.apiKey = builder.apiKey;
        this.fromEmail = builder.fromEmail;
        this.fromName = builder.fromName;
    }

    public static class Builder {
        private String host;
        private String apiKey;
        private String fromEmail;
        private String fromName;

        public EmailConfiguration fromProperties() {
            this.host = ConfigurationManager.getInstance().getProperty("server.email.mailgun.domain");
            this.apiKey = ConfigurationManager.getInstance().getProperty("server.email.mailgun.api_key");
            this.fromEmail = ConfigurationManager.getInstance().getProperty("server.email.from.email");
            this.fromName = ConfigurationManager.getInstance().getProperty("server.email.from.name");
            return new EmailConfiguration(this);
        }
    }
}
