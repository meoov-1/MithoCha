package com.mithocha.util;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * CookieUtil – centralises all cookie read/write/delete helpers.
 *
 * Usage examples:
 *   // Write
 *   CookieUtil.set(response, "mithocha_cart", jsonValue, 7 * 24 * 3600);
 *
 *   // Read
 *   String value = CookieUtil.get(request, "mithocha_cart");
 *
 *   // Delete
 *   CookieUtil.delete(response, "mithocha_cart");
 */
public class CookieUtil {

    /** Default max-age: 7 days in seconds. */
    public static final int DEFAULT_MAX_AGE = 7 * 24 * 60 * 60;

    /** Cart cookie name — must match the key used in storefront.js. */
    public static final String CART_COOKIE = "mithocha_cart";

    // ── Write ─────────────────────────────────────────────────────────────────

    /**
     * Creates or overwrites a cookie with the given name, value and max-age.
     *
     * @param response   the HTTP response to attach the cookie to
     * @param name       cookie name
     * @param value      cookie value (plain string — not URL-encoded here)
     * @param maxAgeSeconds  positive = expires after N seconds;
     *                       0 = delete immediately;
     *                      -1 = session cookie (deleted when browser closes)
     */
    public static void set(HttpServletResponse response,
                           String name, String value, int maxAgeSeconds) {
        Cookie cookie = new Cookie(name, value);
        cookie.setMaxAge(maxAgeSeconds);
        cookie.setPath("/");
        cookie.setHttpOnly(false);   // must be readable by JS (storefront.js)
        cookie.setAttribute("SameSite", "Lax");
        response.addCookie(cookie);
    }

    /**
     * Creates or overwrites a cookie using the default 7-day max-age.
     */
    public static void set(HttpServletResponse response, String name, String value) {
        set(response, name, value, DEFAULT_MAX_AGE);
    }

    // ── Read ──────────────────────────────────────────────────────────────────

    /**
     * Returns the value of the first cookie with the given name,
     * or {@code null} if no such cookie exists.
     */
    public static String get(HttpServletRequest request, String name) {
        Cookie[] cookies = request.getCookies();
        if (cookies == null) return null;
        for (Cookie cookie : cookies) {
            if (name.equals(cookie.getName())) {
                return cookie.getValue();
            }
        }
        return null;
    }

    /**
     * Returns the value of the first cookie with the given name,
     * or {@code defaultValue} if no such cookie exists.
     */
    public static String getOrDefault(HttpServletRequest request,
                                      String name, String defaultValue) {
        String value = get(request, name);
        return value != null ? value : defaultValue;
    }

    /**
     * Returns true if a cookie with the given name exists in the request.
     */
    public static boolean exists(HttpServletRequest request, String name) {
        return get(request, name) != null;
    }

    // ── Delete ────────────────────────────────────────────────────────────────

    /**
     * Deletes a cookie by setting its max-age to 0.
     * The path must match the path used when the cookie was created.
     */
    public static void delete(HttpServletResponse response, String name) {
        set(response, name, "", 0);
    }

    /**
     * Deletes the cart cookie specifically.
     * Called by CartServlet after a successful order.
     */
    public static void clearCart(HttpServletResponse response) {
        delete(response, CART_COOKIE);
    }
}
