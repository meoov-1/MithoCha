package com.mithocha.util;

import java.math.BigDecimal;
import java.util.Set;

/**
 * ValidationUtil – lightweight input validation helpers.
 */
public class ValidationUtil {

    private static final Set<String> IMAGE_CONTENT_TYPES = Set.of(
            "image/jpeg",
            "image/png",
            "image/webp",
            "image/gif"
    );

    /** Returns true if the string is null or blank. */
    public static boolean isNullOrEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    public static String trimToNull(String value) {
        if (isNullOrEmpty(value)) {
            return null;
        }
        return value.trim();
    }

    /** Basic email format check. */
    public static boolean isValidEmail(String email) {
        if (isNullOrEmpty(email)) return false;
        return email.matches("^[\\w._%+\\-]+@[\\w.\\-]+\\.[a-zA-Z]{2,}$");
    }

    /** Password must be at least 6 characters. */
    public static boolean isValidPassword(String password) {
        return password != null && password.length() >= 6;
    }

    /** Phone: optional, but if provided must be 7-15 digits (with optional leading +). */
    public static boolean isValidPhone(String phone) {
        if (isNullOrEmpty(phone)) return true; // phone is optional
        return phone.matches("^\\+?[0-9]{7,15}$");
    }

    /** Rating must be 1–5. */
    public static boolean isValidRating(int rating) {
        return rating >= 1 && rating <= 5;
    }

    public static boolean isPositiveInt(int value) {
        return value > 0;
    }

    public static boolean isNonNegativeAmount(BigDecimal value) {
        return value != null && value.compareTo(BigDecimal.ZERO) >= 0;
    }

    public static boolean isValidRole(String role) {
        return "admin".equalsIgnoreCase(role) || "customer".equalsIgnoreCase(role);
    }

    public static boolean isValidOrderStatus(String status) {
        if (isNullOrEmpty(status)) {
            return false;
        }
        String normalised = status.trim().toLowerCase();
        return "pending".equals(normalised)
                || "paid".equals(normalised)
                || "cancelled".equals(normalised)
                || "completed".equals(normalised);
    }

    public static boolean isSupportedImageContentType(String contentType) {
        return contentType != null && IMAGE_CONTENT_TYPES.contains(contentType.toLowerCase());
    }

    public static boolean isLengthWithin(String value, int maxLength) {
        return value == null || value.length() <= maxLength;
    }

    /** Sanitise a string for safe display (basic XSS prevention). */
    public static String sanitise(String input) {
        if (input == null) return "";
        return input.replace("&", "&amp;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;")
                    .replace("'", "&#x27;");
    }
}
