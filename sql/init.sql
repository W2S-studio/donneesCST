CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
);

CREATE TABLE apikey (
    id SERIAL PRIMARY KEY,
    user_id REFERENCES users (id) NOT NULL,
    value VARCHAR(255) NOT NULL UNIQUE,
    max_usage INT NOT NULL DEFAULT 100,
    nbr_usage INT NOT NULL DEFAULT 0,
    last_usage TIMESTAMP,
    last_reset TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
);

CREATE TABLE logs (
    id SERIAL PRIMARY KEY,
    user_id REFERENCES users (id),
    action VARCHAR(255) NOT NULL,
    user_agent VARCHAR(255) NOT NULL,
    ip_address VARCHAR(255) NOT NULL,
    timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- INDEXES
CREATE INDEX idx_users_email ON users (email);

CREATE INDEX idx_users_username ON users (username);

CREATE INDEX idx_apikey_user_id ON apikey (user_id);

CREATE INDEX idx_apikey_value ON apikey (value);

CREATE INDEX idx_log_user_id ON log(user_id);

CREATE INDEX idx_log_timestamp ON log(timestamp);

CREATE INDEX idx_log_action ON log(action);

CREATE INDEX idx_apikey_last_usage ON apikey (last_usage);

CREATE INDEX idx_apikey_last_reset ON apikey (last_reset);

CREATE INDEX idx_apikey_max_usage ON apikey (max_usage);