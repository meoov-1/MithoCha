package com.mithocha.service;

import com.mithocha.dao.UserDAO;
import com.mithocha.dao.impl.UserDAOImpl;
import com.mithocha.model.User;
import com.mithocha.util.PasswordUtil;
import com.mithocha.util.ValidationUtil;

/**
 * UserService – business logic for registration and login.
 * Sits between the servlet (controller) and the DAO (data layer).
 */
public class UserService {

    private final UserDAO userDAO = new UserDAOImpl();

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
        if (ValidationUtil.isNullOrEmpty(name))          return -4;
        if (!ValidationUtil.isValidEmail(email))         return -2;
        if (!ValidationUtil.isValidPassword(password))   return -3;
        if (userDAO.emailExists(email))                  return -1;

        String hashed = PasswordUtil.hashPassword(password);
        User user = new User(name.trim(), email.trim().toLowerCase(), hashed, "customer");
        int id = userDAO.insertUser(user);
        return id > 0 ? id : -99;
    }

    /**
     * Authenticate a user by email + plain-text password.
     *
     * @return the User object on success, or null on failure.
     */
    public User login(String email, String password) {
        if (ValidationUtil.isNullOrEmpty(email) || ValidationUtil.isNullOrEmpty(password)) {
            return null;
        }
        User user = userDAO.findByEmail(email.trim().toLowerCase());
        if (user == null) return null;
        if (!PasswordUtil.verifyPassword(password, user.getPassword())) return null;
        if (PasswordUtil.needsRehash(user.getPassword())) {
            String upgradedHash = PasswordUtil.hashPassword(password);
            userDAO.updatePassword(user.getUserId(), upgradedHash);
            user.setPassword(upgradedHash);
        }
        return user;
    }

    public User findById(int userId) {
        return userDAO.findById(userId);
    }
}
