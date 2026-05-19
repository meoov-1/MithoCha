package com.mithocha.util;

import com.google.gson.JsonObject;
import com.mithocha.model.User;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.time.Instant;
import java.util.Base64;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * JwtUtil – compact HS256 JWT generation/verification without an extra runtime dependency.
 */
public final class JwtUtil {

    private static final String HMAC_ALGORITHM = "HmacSHA256";
    private static final Base64.Encoder URL_ENCODER = Base64.getUrlEncoder().withoutPadding();
    private static final Base64.Decoder URL_DECODER = Base64.getUrlDecoder();
    private static final long DEFAULT_TTL_SECONDS = 24 * 60 * 60;
    private static final byte[] SECRET = resolveSecret();

    private JwtUtil() {}

    public static String generateToken(User user) {
        long issuedAt = Instant.now().getEpochSecond();
        long expiresAt = issuedAt + DEFAULT_TTL_SECONDS;

        Map<String, Object> header = new LinkedHashMap<>();
        header.put("alg", "HS256");
        header.put("typ", "JWT");

        Map<String, Object> payload = new LinkedHashMap<>();
        payload.put("sub", user.getUserId());
        payload.put("email", user.getEmail());
        payload.put("name", user.getName());
        payload.put("role", user.getRole());
        payload.put("iat", issuedAt);
        payload.put("exp", expiresAt);

        String encodedHeader = encodeUrl(JsonUtil.toJson(header));
        String encodedPayload = encodeUrl(JsonUtil.toJson(payload));
        String signature = sign(encodedHeader + "." + encodedPayload);
        return encodedHeader + "." + encodedPayload + "." + signature;
    }

    public static JwtClaims verifyToken(String token) {
        if (ValidationUtil.isNullOrEmpty(token)) {
            throw new IllegalArgumentException("Missing token.");
        }

        String[] parts = token.split("\\.");
        if (parts.length != 3) {
            throw new IllegalArgumentException("Invalid token format.");
        }

        String unsignedToken = parts[0] + "." + parts[1];
        String expectedSignature = sign(unsignedToken);
        if (!MessageDigest.isEqual(expectedSignature.getBytes(StandardCharsets.UTF_8),
                parts[2].getBytes(StandardCharsets.UTF_8))) {
            throw new IllegalArgumentException("Invalid token signature.");
        }

        String payloadJson = new String(URL_DECODER.decode(parts[1]), StandardCharsets.UTF_8);
        JsonObject payload = JsonUtil.parseObject(payloadJson);

        long expiresAt = payload.get("exp").getAsLong();
        if (Instant.now().getEpochSecond() >= expiresAt) {
            throw new IllegalArgumentException("Token has expired.");
        }

        return new JwtClaims(
                payload.get("sub").getAsInt(),
                payload.has("email") && !payload.get("email").isJsonNull() ? payload.get("email").getAsString() : null,
                payload.has("name") && !payload.get("name").isJsonNull() ? payload.get("name").getAsString() : null,
                payload.has("role") && !payload.get("role").isJsonNull() ? payload.get("role").getAsString() : null,
                expiresAt
        );
    }

    private static byte[] resolveSecret() {
        String configured = System.getenv("MITHOCHA_JWT_SECRET");
        if (ValidationUtil.isNullOrEmpty(configured)) {
            configured = System.getProperty("mithocha.jwt.secret");
        }
        if (ValidationUtil.isNullOrEmpty(configured)) {
            configured = "mithocha-dev-secret-change-me";
        }
        return configured.getBytes(StandardCharsets.UTF_8);
    }

    private static String encodeUrl(String value) {
        return URL_ENCODER.encodeToString(value.getBytes(StandardCharsets.UTF_8));
    }

    private static String sign(String value) {
        try {
            Mac mac = Mac.getInstance(HMAC_ALGORITHM);
            mac.init(new SecretKeySpec(SECRET, HMAC_ALGORITHM));
            return URL_ENCODER.encodeToString(mac.doFinal(value.getBytes(StandardCharsets.UTF_8)));
        } catch (Exception ex) {
            throw new IllegalStateException("Unable to sign JWT.", ex);
        }
    }

    public static final class JwtClaims {
        private final int userId;
        private final String email;
        private final String name;
        private final String role;
        private final long expiresAt;

        public JwtClaims(int userId, String email, String name, String role, long expiresAt) {
            this.userId = userId;
            this.email = email;
            this.name = name;
            this.role = role;
            this.expiresAt = expiresAt;
        }

        public int getUserId() {
            return userId;
        }

        public String getEmail() {
            return email;
        }

        public String getName() {
            return name;
        }

        public String getRole() {
            return role;
        }

        public long getExpiresAt() {
            return expiresAt;
        }
    }
}
