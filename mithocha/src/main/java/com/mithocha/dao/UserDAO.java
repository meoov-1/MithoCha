package com.mithocha.dao;

import com.mithocha.model.User;
import java.util.List;

/**
 * UserDAO – contract for all user-related database operations.
 */
public interface UserDAO {

    /** Insert a new user. Returns the generated user_id, or -1 on failure. */
    int insertUser(User user);

    /** Find a user by their email address (used for login). */
    User findByEmail(String email);

    /** Find a user by their primary key. */
    User findById(int userId);

    /** Return all users (admin use). */
    List<User> findAll();

    /** Update name, email, and role for an existing user. */
    boolean updateUser(User user);

    /** Delete a user by id. */
    boolean deleteUser(int userId);

    /** Check whether an email is already registered. */
    boolean emailExists(String email);
}
