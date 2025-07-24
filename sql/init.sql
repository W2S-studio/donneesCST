CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    hash_email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email_validate BOOLEAN NOT NULL DEFAULT FALSE,
    has_accepted_tos BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_limit (
    id INT PRIMARY KEY REFERENCES users (id),
    request_limit_per_month INT NOT NULL DEFAULT 2500,
    request_limit_per_day INT NOT NULL DEFAULT 250
);

CREATE TABLE user_password_reset (
    id INT PRIMARY KEY REFERENCES users (id),
    password_reset_token VARCHAR(255) NOT NULL,
    password_reset_token_expiration TIMESTAMP NOT NULL
);

CREATE TABLE user_email_validation (
    id INT PRIMARY KEY REFERENCES users (id),
    email_validation_token VARCHAR(255) NOT NULL,
    email_validation_token_expiration TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP + INTERVAL '1 day',
    validated_at TIMESTAMP,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE mfa (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users (id) NOT NULL,
    type VARCHAR(50) NOT NULL,
    secret VARCHAR(255) NOT NULL,
    expires_at TIMESTAMP NULL,
    device_fingerprint VARCHAR(255),
    ip_address VARCHAR(255),
    user_agent VARCHAR(255),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_used TIMESTAMP
);

CREATE TABLE user_mfa_settings (
    id INT PRIMARY KEY REFERENCES users (id),
    grace_period_days INT NOT NULL DEFAULT 30,
    grace_period_enabled BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE apikey (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users (id) NOT NULL,
    description TEXT NOT NULL,
    value VARCHAR(255) NOT NULL UNIQUE,
    nbr_usage INT NOT NULL DEFAULT 0,
    last_usage TIMESTAMP,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE logs (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users (id),
    action TEXT NOT NULL,
    user_agent VARCHAR(255) NOT NULL,
    ip_address VARCHAR(255) NOT NULL,
    timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_support_ticket (
    id SERIAL PRIMARY KEY,
    ip_address VARCHAR(255) NOT NULL,
    user_agent VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- INDEXES

CREATE UNIQUE INDEX idx_mfa_user_totp ON mfa (user_id) WHERE type = 'totp_secret';

CREATE INDEX idx_users_email ON users (email);

CREATE INDEX idx_users_username ON users (username);

CREATE INDEX idx_apikey_user_id ON apikey (user_id);

CREATE INDEX idx_apikey_value ON apikey (value);

CREATE INDEX idx_log_user_id ON logs (user_id);

CREATE INDEX idx_log_timestamp ON logs (timestamp);

CREATE INDEX idx_log_action ON logs (action);

CREATE INDEX idx_apikey_last_usage ON apikey (last_usage);

CREATE INDEX idx_apikey_last_reset ON apikey (last_reset);

CREATE INDEX idx_mfa_user_id ON mfa (user_id);

CREATE INDEX idx_mfa_expires_at ON mfa (expires_at)
WHERE
    expires_at IS NOT NULL;

CREATE INDEX idx_mfa_type ON mfa (type);

-- FUNCTIONS
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- TRIGGERS
CREATE TRIGGER trigger_user_mfa_settings_updated_at
    BEFORE UPDATE ON user_mfa_settings
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();