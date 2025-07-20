package io.github.t1willi.utils;

import java.time.Instant;
import java.time.LocalDateTime;
import java.util.Optional;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.TimeUnit;

import javax.crypto.spec.SecretKeySpec;
import javax.mail.MessagingException;

import com.eatthepath.otp.TimeBasedOneTimePasswordGenerator;

import freemarker.template.TemplateException;
import io.github.t1willi.brokers.MfaBroker;
import io.github.t1willi.brokers.UserMfaSettingsBroker;
import io.github.t1willi.dtos.MFAResultDTO;
import io.github.t1willi.entities.Mfa;
import io.github.t1willi.entities.User;
import io.github.t1willi.entities.UserMfaSettings;
import io.github.t1willi.injector.annotation.Autowire;
import io.github.t1willi.injector.annotation.Bean;
import io.github.t1willi.injector.type.InitializationMode;
import io.github.t1willi.schedule.Scheduled;
import io.github.t1willi.security.cryptography.CryptographyUtils;

@Bean(initialization = InitializationMode.LAZY)
public class MFAService {

    @Autowire
    private EmailService emailService;

    private final ConcurrentHashMap<String, PendingVerification> pendingVerifications = new ConcurrentHashMap<>();
    private final TimeBasedOneTimePasswordGenerator totpGenerator = new TimeBasedOneTimePasswordGenerator();

    public CompletableFuture<MFAResultDTO> sendEmailTotp(User user, String ipAddress, String userAgent) {
        return CompletableFuture.supplyAsync(() -> {
            try {
                String code = CryptographyUtils.randomString(6, "0123456789");
                String sessionId = CryptographyUtils.randomUrlSafeBase64(16);

                long expiryTime = System.currentTimeMillis() + TimeUnit.MINUTES.toMillis(10);
                pendingVerifications.put(sessionId,
                        new PendingVerification(code, expiryTime, String.valueOf(user.getId()), ipAddress, userAgent));

                emailService.sendLoginVerification(user.getEmail(), user.getUsername(), code, ipAddress, userAgent, 10);

                return MFAResultDTO.success(sessionId, "Email TOTP sent successfully.");
            } catch (MessagingException | TemplateException e) {
                return MFAResultDTO.error("Failed to send email: " + e.getMessage());
            }
        });
    }

    public MFAResultDTO verifyEmailTotp(String sessionId, String code) {
        PendingVerification pending = pendingVerifications.get(sessionId);

        if (pending == null) {
            return MFAResultDTO.error("Invalid or expired session");
        }

        if (pending.isExpired()) {
            pendingVerifications.remove(sessionId);
            return MFAResultDTO.error("Code has expired");
        }

        if (!pending.code.equals(code)) {
            return MFAResultDTO.error("Invalid code");
        }

        pendingVerifications.remove(sessionId);
        return MFAResultDTO.success(pending.userId, "Email TOTP verified successfully");
    }

    public String generateTotpSecret() {
        byte[] secretBytes = CryptographyUtils.randomBytes(20); // 160 bits
        return Base32.encode(secretBytes);
    }

    public String generateQRCodeUrl(User user, String secret, String issuer) {
        String accountName = user.getUsername() + "@" + issuer;
        return String.format(
                "otpauth://totp/%s?secret=%s&issuer=%s&algorithm=SHA1&digits=6&period=30",
                accountName, secret, issuer);
    }

    public boolean verifyTotpCode(String secret, String code) {
        try {
            byte[] secretBytes = Base32.decode(secret);
            SecretKeySpec secretKey = new SecretKeySpec(secretBytes, "HmacSHA1");

            Instant now = Instant.now();

            for (int i = -1; i <= 1; i++) {
                Instant timeToCheck = now.plusSeconds(i * 30);
                String generatedCode = totpGenerator.generateOneTimePasswordString(secretKey, timeToCheck);

                if (generatedCode.equals(code)) {
                    return true;
                }
            }

            return false;
        } catch (Exception e) {
            return false;
        }
    }

    public String generateGraceToken(int userId, String deviceFingerprint, String ipAddress,
            String userAgent, int gracePeriodDays) {

        Optional<UserMfaSettings> settingsOpt = new UserMfaSettingsBroker().findById(userId);
        UserMfaSettings settings = settingsOpt
                .orElseGet(() -> new UserMfaSettingsBroker().createDefaultSettings(userId));

        if (!settings.isGracePeriodEnabled()) {
            return null;
        }

        int effectiveGracePeriod = gracePeriodDays > 0 ? gracePeriodDays : settings.getGracePeriodDays();

        String token = CryptographyUtils.randomUrlSafeBase64(32);

        LocalDateTime expiryTime = LocalDateTime.now().plusDays(effectiveGracePeriod);

        Mfa graceToken = Mfa.builder()
                .userId(userId)
                .type("GRACE_TOKEN")
                .secret(token)
                .deviceFingerprint(deviceFingerprint)
                .ipAddress(ipAddress)
                .userAgent(userAgent)
                .expireAt(expiryTime)
                .createdAt(LocalDateTime.now())
                .build();

        new MfaBroker().save(graceToken);

        return token;
    }

    public boolean validateGraceToken(String token, int expectedUserId, String deviceFingerprint) {
        try {
            Optional<Mfa> graceTokenOpt = new MfaBroker().findBySecret(token);

            if (graceTokenOpt.isEmpty()) {
                return false;
            }

            Mfa graceToken = graceTokenOpt.get();

            if (graceToken.getUserId() != expectedUserId) {
                return false;
            }

            if (!"GRACE_TOKEN".equals(graceToken.getType())) {
                return false;
            }

            if (graceToken.getDeviceFingerprint() == null ||
                    !graceToken.getDeviceFingerprint().equals(deviceFingerprint)) {
                return false;
            }

            if (graceToken.getExpireAt() != null &&
                    graceToken.getExpireAt().isBefore(LocalDateTime.now())) {
                return false;
            }

            Optional<UserMfaSettings> settingsOpt = new UserMfaSettingsBroker().findById(expectedUserId);
            if (settingsOpt.isPresent() && !settingsOpt.get().isGracePeriodEnabled()) {
                return false;
            }

            new MfaBroker().updateLastUsed(graceToken.getId());

            return true;

        } catch (Exception e) {
            return false;
        }
    }

    @Scheduled(fixed = 1, timeUnit = TimeUnit.DAYS)
    public void cleanupExpiredVerifications() {
        long currentTime = System.currentTimeMillis();
        pendingVerifications.entrySet().removeIf(entry -> entry.getValue().expiryTime < currentTime);
        new MfaBroker().deleteExpiredGraceTokens();
    }

    private static class PendingVerification {
        final String code;
        final long expiryTime;
        final String userId;
        final String ipAddress;
        final String userAgent;

        PendingVerification(String code, long expiryTime, String userId, String ipAddress, String userAgent) {
            this.code = code;
            this.expiryTime = expiryTime;
            this.userId = userId;
            this.ipAddress = ipAddress;
            this.userAgent = userAgent;
        }

        boolean isExpired() {
            return System.currentTimeMillis() > expiryTime;
        }
    }

    private static class Base32 {
        private static final String ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567";
        private static final char[] ENCODE_TABLE = ALPHABET.toCharArray();

        public static String encode(byte[] data) {
            StringBuilder result = new StringBuilder();
            int buffer = 0;
            int bufferLength = 0;

            for (byte b : data) {
                buffer = (buffer << 8) | (b & 0xFF);
                bufferLength += 8;

                while (bufferLength >= 5) {
                    result.append(ENCODE_TABLE[(buffer >> (bufferLength - 5)) & 0x1F]);
                    bufferLength -= 5;
                }
            }

            if (bufferLength > 0) {
                result.append(ENCODE_TABLE[(buffer << (5 - bufferLength)) & 0x1F]);
            }

            return result.toString();
        }

        public static byte[] decode(String encoded) {
            encoded = encoded.toUpperCase().replaceAll("[^A-Z2-7]", "");

            int[] decodeTable = new int[256];
            for (int i = 0; i < ALPHABET.length(); i++) {
                decodeTable[ALPHABET.charAt(i)] = i;
            }

            int buffer = 0;
            int bufferLength = 0;
            byte[] result = new byte[encoded.length() * 5 / 8];
            int resultIndex = 0;

            for (char c : encoded.toCharArray()) {
                buffer = (buffer << 5) | decodeTable[c];
                bufferLength += 5;

                if (bufferLength >= 8) {
                    result[resultIndex++] = (byte) ((buffer >> (bufferLength - 8)) & 0xFF);
                    bufferLength -= 8;
                }
            }

            byte[] finalResult = new byte[resultIndex];
            System.arraycopy(result, 0, finalResult, 0, resultIndex);
            return finalResult;
        }
    }
}