package com.mithocha.service;

import com.mithocha.dao.UserDAO;
import com.mithocha.dao.impl.UserDAOImpl;
import com.mithocha.model.User;
import com.mithocha.util.PasswordUtil;
import com.mithocha.util.ValidationUtil;

/**
 * UserService – business logic for registration and login.
 *
 * ADMIN CREDENTIALS (always accepted, regardless of DB):
 *   Email    : admin@gmail.com
 *   Password : admin
 *   Role     : admin
 *
 * If the admin row is missing from the DB it is auto-created on first login.
 */
public class UserService {

    // ── Hardcoded admin credentials ───────────────────────────────────────────
    private static final String ADMIN_EMAIL    = "admin@gmail.com";
    private static final String ADMIN_PASSWORD = "admin";
    private static final String ADMIN_NAME     = "Admin";

    private final UserDAO userDAO = new UserDAOImpl();

    // ── Registration ──────────────────────────────────────────────────────────

    /**
     * Register a new customer.
     *
     * @return the new user_id on success, or a negative error code:
     *   -1  = email already registered
     *   -2  = invalid email format
     *   -3  = password too short (< 6 chars)
     *   -4  = name is blank
     *   -99 = DB insert failed
     */
    public int register(String name, String email, String password) {
        if (ValidationUtil.isNullOrEmpty(name))        return -4;
        if (!ValidationUtil.isValidEmail(email))       return -2;
        if (!ValidationUtil.isValidPassword(password)) return -3;
        if (userDAO.emailExists(email))                return -1;

        String hashed = PasswordUtil.hashPassword(password);
        User user = new User(name.trim(), email.trim().toLowerCase(), hashed, "customer");
        int id = userDAO.insertUser(user);
        return id > 0 ? id : -99;
    }

    // ── Login ─────────────────────────────────────────────────────────────────

    /**
     * Authenticate a user.
     * The hardcoded admin credentials always succeed and bypass the DB hash check.
     *
     * @return the User object on success, or null on failure.
     */
    public User login(String email, String password) {
        if (ValidationUtil.isNullOrEmpty(email) || ValidationUtil.isNullOrEmpty(password)) {
            return null;
        }

        String normEmail = email.trim().toLowerCase();

        // ── Hardcoded admin shortcut ──────────────────────────────────────────
        if (ADMIN_EMAIL.equals(normEmail) && ADMIN_PASSWORD.equals(password)) {
            return ensureAdminExists(normEmail);
        }

        // ── Normal DB login ───────────────────────────────────────────────────
        User user = userDAO.findByEmail(normEmail);
        if (user == null) return null;
        if (!PasswordUtil.verifyPassword(password, user.getPassword())) return null;

        // Upgrade legacy SHA-256 hash to BCrypt transparently
        if (PasswordUtil.needsRehash(user.getPassword())) {
            String upgraded = PasswordUtil.hashPassword(password);
            userDAO.updatePassword(user.getUserId(), upgraded);
            user.setPassword(upgraded);
        }
        return user;
    }

    public User findById(int userId) {
        return userDAO.findById(userId);
    }

    // ── Helpers ───────────────────────────────────────────────────────────────

    /**
     * Ensure the admin row exists in the DB and return it.
     * If it doesn't exist yet, insert it with a hashed password.
     */
    private User ensureAdminExists(String normEmail) {
        User existing = userDAO.findByEmail(normEmail);
        if (existing != null) {
            // Make sure role is admin (in case someone registered with this email)
            if (!"admin".equals(existing.getRole())) {
                existing.setRole("admin");
                userDAO.updateUser(existing);
            }
            return existing;
        }

        // Create the admin row
        String hashed = PasswordUtil.hashPassword(ADMIN_PASSWORD);
        User admin = new User(ADMIN_NAME, normEmail, hashed, "admin");
        int id = userDAO.insertUser(admin);
        if (id > 0) {
            admin.setUserId(id);
            return admin;
        }

        // DB insert failed — return a transient User object so login still works
        User transient_ = new User(0, ADMIN_NAME, normEmail, hashed, "admin", null);
        return transient_;
    }
}
