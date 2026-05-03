package com.mithocha.util;

import org.mindrot.jbcrypt.BCrypt;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

/**
 * PasswordUtil – BCrypt hashing for new passwords, with backward-compatible
 * support for the legacy salted SHA-256 format already present in the project.
 */
public class PasswordUtil {

    private static final int SALT_BYTES = 16;
    private static final int BCRYPT_COST = 12;

    /** Hash a plain-text password and return the storable string. */
    public static String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(BCRYPT_COST));
    }

    /** Verify a plain-text password against a stored hash string. */
    public static boolean verifyPassword(String plainPassword, String storedHash) {
        if (plainPassword == null || storedHash == null) {
            return false;
        }

        if (isBcryptHash(storedHash)) {
            try {
                return BCrypt.checkpw(plainPassword, storedHash);
            } catch (IllegalArgumentException ex) {
                return false;
            }
        }

        return verifyLegacySha256Password(plainPassword, storedHash);
    }

    /** Returns true when the stored hash should be upgraded to BCrypt. */
    public static boolean needsRehash(String storedHash) {
        return storedHash != null && !isBcryptHash(storedHash);
    }

    public static boolean isBcryptHash(String storedHash) {
        return storedHash != null
                && (storedHash.startsWith("$2a$")
                || storedHash.startsWith("$2b$")
                || storedHash.startsWith("$2y$"));
    }

    private static boolean verifyLegacySha256Password(String plainPassword, String storedHash) {
        try {
            if (storedHash == null || !storedHash.contains("$")) return false;

            String[] parts = storedHash.split("\\$", 2);
            byte[] salt    = Base64.getDecoder().decode(parts[0]);
            byte[] expected = Base64.getDecoder().decode(parts[1]);
            byte[] actual   = sha256(salt, plainPassword);

            // Constant-time comparison
            if (actual.length != expected.length) return false;
            int diff = 0;
            for (int i = 0; i < actual.length; i++) {
                diff |= actual[i] ^ expected[i];
            }
            return diff == 0;

        } catch (Exception e) {
            return false;
        }
    }

    private static byte[] sha256(byte[] salt, String password) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        md.update(salt);
        return md.digest(password.getBytes(java.nio.charset.StandardCharsets.UTF_8));
    }
}
