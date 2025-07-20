package io.github.t1willi.brokers;

import java.util.Optional;

import io.github.t1willi.database.RestBroker;
import io.github.t1willi.entities.Mfa;

public class MfaBroker extends RestBroker<Integer, Mfa> {

    public MfaBroker() {
        super(
                "mfa",
                Mfa.class,
                int.class);
    }

    public Optional<Mfa> findGraceTokenByUserAndFingerprint(int userId, String deviceFingerprint) {
        return selectOne(
                "SELECT * FROM mfa WHERE userId = ? AND deviceFingerprint = ? AND type = 'GRACE_TOKEN' AND (expireAt IS NULL OR expireAt > NOW())",
                userId, deviceFingerprint);
    }

    public Optional<Mfa> findBySecret(String secret) {
        return selectOne("SELECT * FROM mfa WHERE secret = ?", secret);
    }

    public void deleteExpiredGraceTokens() {
        query("DELETE FROM mfa WHERE type = 'GRACE_TOKEN' AND expireAt IS NOT NULL AND expireAt < NOW()");
    }

    public void updateLastUsed(int id) {
        query("UPDATE mfa SET lastUsed = NOW() WHERE id = ?", id);
    }
}
