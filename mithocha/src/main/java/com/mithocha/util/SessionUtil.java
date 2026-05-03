package com.mithocha.util;

import com.mithocha.model.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

/**
 * SessionUtil – centralises all session attribute keys and helper methods.
 */
public class SessionUtil {

    public static final String USER_KEY      = "loggedInUser";
    public static final String USER_ID_KEY   = "userId";
    public static final String USER_ROLE_KEY = "userRole";

    /** Store the authenticated user in the session. */
    public static void setUser(HttpServletRequest request, User user) {
        HttpSession session = request.getSession(true);
        session.setAttribute(USER_KEY,      user);
        session.setAttribute(USER_ID_KEY,   user.getUserId());
        session.setAttribute(USER_ROLE_KEY, user.getRole());
    }

    /** Retrieve the logged-in User object (may be null). */
    public static User getUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return null;
        return (User) session.getAttribute(USER_KEY);
    }

    /** Returns true if a user is currently logged in. */
    public static boolean isLoggedIn(HttpServletRequest request) {
        return getUser(request) != null;
    }

    /** Returns true if the logged-in user has the 'admin' role. */
    public static boolean isAdmin(HttpServletRequest request) {
        User user = getUser(request);
        return user != null && "admin".equals(user.getRole());
    }

    /** Invalidate the session (logout). */
    public static void invalidate(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) session.invalidate();
    }
}
