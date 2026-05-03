package com.mithocha.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * DBUtil – loads JDBC connection settings from db.properties on the classpath.
 * Place db.properties directly under src/main/resources/ (not inside a sub-folder).
 *
 * db.properties content:
 *   db.driver   = com.mysql.cj.jdbc.Driver
 *   db.url      = jdbc:mysql://localhost:3306/MithoCha?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
 *   db.username = root
 *   db.password =
 */
public class DBUtil {

    private static final String DEFAULT_DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String DEFAULT_URL =
            "jdbc:mysql://localhost:3306/mithocha?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";

    private static String driver;
    private static String url;
    private static String username;
    private static String password;

    static {
        try {
            Properties props = new Properties();
            try (InputStream in = openPropertiesStream()) {
                if (in != null) {
                    props.load(in);
                }
            }

            driver   = props.getProperty("db.driver", DEFAULT_DRIVER);
            url      = props.getProperty("db.url", DEFAULT_URL);
            username = props.getProperty("db.username", "root");
            password = props.getProperty("db.password", "");

            Class.forName(driver);
            SchemaInitializer.ensureSchema(url, username, password);

        } catch (Exception e) {
            throw new ExceptionInInitializerError("DBUtil init failed: " + e.getMessage());
        }
    }

    private static InputStream openPropertiesStream() throws IOException {
        ClassLoader classLoader = DBUtil.class.getClassLoader();
        InputStream direct = classLoader.getResourceAsStream("db.properties");
        if (direct != null) {
            return direct;
        }

        // Backward-compatible fallback for the older nested resource path.
        return classLoader.getResourceAsStream("db.properties/db.properties");
    }

    /** Returns a new JDBC connection. Caller is responsible for closing it. */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, username, password);
    }

    /** Quietly closes a connection (null-safe). */
    public static void close(Connection conn) {
        if (conn != null) {
            try { conn.close(); } catch (SQLException ignored) {}
        }
    }
}
