package com.mithocha.model;

import java.sql.Timestamp;

/**
 * POJO for the `users` table.
 *
 * CREATE TABLE users (
 *   user_id    INT AUTO_INCREMENT PRIMARY KEY,
 *   name       VARCHAR(100) NOT NULL,
 *   email      VARCHAR(100) UNIQUE NOT NULL,
 *   password   VARCHAR(255) NOT NULL,
 *   role       ENUM('admin','customer') DEFAULT 'customer',
 *   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
 * );
 */
public class User {

    private int       userId;
    private String    name;
    private String    email;
    private String    password;   // stored as hashed value
    private String    role;       // "admin" | "customer"
    private Timestamp createdAt;

    // ── Constructors ──────────────────────────────────────────────────────────

    public User() {}

    /** Used when registering a new user (no id / timestamp yet). */
    public User(String name, String email, String password, String role) {
        this.name     = name;
        this.email    = email;
        this.password = password;
        this.role     = role;
    }

    /** Full constructor (used when reading from DB). */
    public User(int userId, String name, String email, String password,
                String role, Timestamp createdAt) {
        this.userId    = userId;
        this.name      = name;
        this.email     = email;
        this.password  = password;
        this.role      = role;
        this.createdAt = createdAt;
    }

    // ── Getters & Setters ─────────────────────────────────────────────────────

    public int getUserId()               { return userId; }
    public void setUserId(int userId)    { this.userId = userId; }

    public String getName()              { return name; }
    public void setName(String name)     { this.name = name; }

    public String getEmail()             { return email; }
    public void setEmail(String email)   { this.email = email; }

    public String getPassword()                  { return password; }
    public void setPassword(String password)     { this.password = password; }

    public String getRole()              { return role; }
    public void setRole(String role)     { this.role = role; }

    public Timestamp getCreatedAt()                  { return createdAt; }
    public void setCreatedAt(Timestamp createdAt)    { this.createdAt = createdAt; }

    @Override
    public String toString() {
        return "User{userId=" + userId + ", name='" + name + "', email='" + email
                + "', role='" + role + "'}";
    }
}
