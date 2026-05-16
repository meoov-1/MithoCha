package com.mithocha.util;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

/**
 * SchemaInitializer – ensures the required application tables exist and performs
 * a small compatibility migration from the older `product` table when present.
 */
public final class SchemaInitializer {

    private static final Object LOCK = new Object();
    private static volatile boolean initialised;

    private SchemaInitializer() {}

    public static void ensureSchema(String url, String username, String password) {
        if (initialised) {
            return;
        }

        synchronized (LOCK) {
            if (initialised) {
                return;
            }

            try (Connection conn = DriverManager.getConnection(url, username, password)) {
                conn.setAutoCommit(false);
                ensureUsersTable(conn);
                ensureProfileTable(conn);
                ensureProductsTable(conn);
                ensureProductSizesTable(conn);
                ensureProductToppingsTable(conn);
                ensureCartItemsTable(conn);
                ensureOrdersTable(conn);
                ensureOrderItemsTable(conn);
                ensurePaymentsTable(conn);
                migrateLegacyProducts(conn);
                conn.commit();
                initialised = true;
            } catch (SQLException ex) {
                throw new IllegalStateException("Schema initialization failed.", ex);
            }
        }
    }

    private static void ensureUsersTable(Connection conn) throws SQLException {
        execute(conn,
                "CREATE TABLE IF NOT EXISTS users ("
                        + "user_id INT AUTO_INCREMENT PRIMARY KEY, "
                        + "name VARCHAR(100) NOT NULL, "
                        + "email VARCHAR(100) NOT NULL UNIQUE, "
                        + "password VARCHAR(255) NOT NULL, "
                        + "role VARCHAR(20) NOT NULL DEFAULT 'customer', "
                        + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP"
                        + ")");

        ensureColumn(conn, "users", "role",
                "ALTER TABLE users ADD COLUMN role VARCHAR(20) NOT NULL DEFAULT 'customer'");
        ensureColumn(conn, "users", "created_at",
                "ALTER TABLE users ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP");
    }

    private static void ensureProfileTable(Connection conn) throws SQLException {
        execute(conn,
                "CREATE TABLE IF NOT EXISTS profile ("
                        + "profile_id INT AUTO_INCREMENT PRIMARY KEY, "
                        + "user_id INT NOT NULL UNIQUE, "
                        + "phone VARCHAR(20), "
                        + "address TEXT, "
                        + "city VARCHAR(100), "
                        + "postal_code VARCHAR(20), "
                        + "profile_image_url VARCHAR(500), "
                        + "profile_image_data LONGBLOB, "
                        + "profile_image_content_type VARCHAR(100), "
                        + "cover_image_url VARCHAR(500), "
                        + "bio TEXT, "
                        + "date_of_birth DATE, "
                        + "CONSTRAINT fk_profile_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE"
                        + ")");

        ensureColumn(conn, "profile", "profile_image_data",
                "ALTER TABLE profile ADD COLUMN profile_image_data LONGBLOB");
        ensureColumn(conn, "profile", "profile_image_content_type",
                "ALTER TABLE profile ADD COLUMN profile_image_content_type VARCHAR(100)");
    }

    private static void ensureProductsTable(Connection conn) throws SQLException {
        execute(conn,
                "CREATE TABLE IF NOT EXISTS products ("
                        + "product_id INT AUTO_INCREMENT PRIMARY KEY, "
                        + "name VARCHAR(100) NOT NULL, "
                        + "description TEXT, "
                        + "image_url VARCHAR(500), "
                        + "image_data LONGBLOB, "
                        + "image_content_type VARCHAR(100), "
                        + "additional_images LONGTEXT, "
                        + "category VARCHAR(100), "
                        + "is_available BOOLEAN NOT NULL DEFAULT TRUE, "
                        + "sizes LONGTEXT, "
                        + "flavours LONGTEXT, "
                        + "toppings LONGTEXT, "
                        + "base_price DECIMAL(10,2) NOT NULL DEFAULT 0.00, "
                        + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, "
                        + "updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"
                        + ")");
    }

    private static void ensureProductSizesTable(Connection conn) throws SQLException {
        execute(conn,
                "CREATE TABLE IF NOT EXISTS product_sizes ("
                        + "size_id INT AUTO_INCREMENT PRIMARY KEY, "
                        + "product_id INT NOT NULL, "
                        + "name VARCHAR(50) NOT NULL, "
                        + "price_modifier DECIMAL(10,2) NOT NULL DEFAULT 0.00, "
                        + "display_order INT NOT NULL DEFAULT 0, "
                        + "CONSTRAINT fk_product_sizes_product FOREIGN KEY (product_id) "
                        + "REFERENCES products(product_id) ON DELETE CASCADE"
                        + ")");
    }

    private static void ensureProductToppingsTable(Connection conn) throws SQLException {
        execute(conn,
                "CREATE TABLE IF NOT EXISTS product_toppings ("
                        + "topping_id INT AUTO_INCREMENT PRIMARY KEY, "
                        + "product_id INT NOT NULL, "
                        + "name VARCHAR(50) NOT NULL, "
                        + "price_modifier DECIMAL(10,2) NOT NULL DEFAULT 0.00, "
                        + "is_available BOOLEAN NOT NULL DEFAULT TRUE, "
                        + "CONSTRAINT fk_product_toppings_product FOREIGN KEY (product_id) "
                        + "REFERENCES products(product_id) ON DELETE CASCADE"
                        + ")");
    }

    private static void ensureCartItemsTable(Connection conn) throws SQLException {
        execute(conn,
                "CREATE TABLE IF NOT EXISTS cart_items ("
                        + "cart_item_id INT AUTO_INCREMENT PRIMARY KEY, "
                        + "user_id INT NOT NULL, "
                        + "product_id INT NOT NULL, "
                        + "product_size_id INT NULL, "
                        + "selected_topping_ids_json TEXT, "
                        + "selected_toppings_json LONGTEXT, "
                        + "quantity INT NOT NULL, "
                        + "unit_price DECIMAL(10,2) NOT NULL, "
                        + "item_total DECIMAL(10,2) NOT NULL, "
                        + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, "
                        + "updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, "
                        + "CONSTRAINT fk_cart_items_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE, "
                        + "CONSTRAINT fk_cart_items_product FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE, "
                        + "CONSTRAINT fk_cart_items_size FOREIGN KEY (product_size_id) REFERENCES product_sizes(size_id) ON DELETE SET NULL"
                        + ")");
    }

    private static void ensureOrdersTable(Connection conn) throws SQLException {
        execute(conn,
                "CREATE TABLE IF NOT EXISTS orders ("
                        + "order_id INT AUTO_INCREMENT PRIMARY KEY, "
                        + "user_id INT, "
                        + "total_amount DECIMAL(10,2) NOT NULL DEFAULT 0.00, "
                        + "order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, "
                        + "updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, "
                        + "status VARCHAR(20) NOT NULL DEFAULT 'pending', "
                        + "items LONGTEXT, "
                        + "payment LONGTEXT, "
                        + "shipping_address LONGTEXT, "
                        + "CONSTRAINT fk_orders_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL"
                        + ")");

        ensureColumn(conn, "orders", "updated_at",
                "ALTER TABLE orders ADD COLUMN updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP");
        ensureColumn(conn, "orders", "items",
                "ALTER TABLE orders ADD COLUMN items LONGTEXT");
        ensureColumn(conn, "orders", "payment",
                "ALTER TABLE orders ADD COLUMN payment LONGTEXT");
        ensureColumn(conn, "orders", "shipping_address",
                "ALTER TABLE orders ADD COLUMN shipping_address LONGTEXT");
        execute(conn, "ALTER TABLE orders MODIFY COLUMN status VARCHAR(20) NOT NULL DEFAULT 'pending'");
    }

    private static void ensureOrderItemsTable(Connection conn) throws SQLException {
        execute(conn,
                "CREATE TABLE IF NOT EXISTS order_items ("
                        + "order_item_id INT AUTO_INCREMENT PRIMARY KEY, "
                        + "order_id INT NOT NULL, "
                        + "product_id INT, "
                        + "product_name VARCHAR(100) NOT NULL, "
                        + "product_size_id INT NULL, "
                        + "size_name VARCHAR(50), "
                        + "selected_topping_ids_json TEXT, "
                        + "selected_toppings_json LONGTEXT, "
                        + "quantity INT NOT NULL, "
                        + "unit_price DECIMAL(10,2) NOT NULL, "
                        + "item_total DECIMAL(10,2) NOT NULL, "
                        + "CONSTRAINT fk_order_items_order FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE, "
                        + "CONSTRAINT fk_order_items_product FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE SET NULL, "
                        + "CONSTRAINT fk_order_items_size FOREIGN KEY (product_size_id) REFERENCES product_sizes(size_id) ON DELETE SET NULL"
                        + ")");
    }

    private static void ensurePaymentsTable(Connection conn) throws SQLException {
        execute(conn,
                "CREATE TABLE IF NOT EXISTS payments ("
                        + "payment_id INT AUTO_INCREMENT PRIMARY KEY, "
                        + "order_id INT NOT NULL, "
                        + "transaction_id VARCHAR(120) NOT NULL UNIQUE, "
                        + "status VARCHAR(20) NOT NULL, "
                        + "amount DECIMAL(10,2) NOT NULL, "
                        + "method VARCHAR(50) NOT NULL, "
                        + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, "
                        + "CONSTRAINT fk_payments_order FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE"
                        + ")");
    }

    private static void migrateLegacyProducts(Connection conn) throws SQLException {
        if (!tableExists(conn, "product") || countRows(conn, "products") > 0) {
            return;
        }

        String selectSql = "SELECT * FROM product ORDER BY product_id";
        String insertSql = "INSERT INTO products "
                + "(product_id, name, description, image_url, additional_images, category, "
                + "is_available, sizes, flavours, toppings, base_price) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement select = conn.prepareStatement(selectSql);
             PreparedStatement insert = conn.prepareStatement(insertSql)) {

            ResultSet rs = select.executeQuery();
            while (rs.next()) {
                int productId = rs.getInt("product_id");
                insert.setInt(1, productId);
                insert.setString(2, rs.getString("name"));
                insert.setString(3, rs.getString("description"));
                insert.setString(4, rs.getString("image_url"));
                insert.setString(5, rs.getString("additional_images"));
                insert.setString(6, rs.getString("category"));
                insert.setBoolean(7, rs.getBoolean("is_available"));
                insert.setString(8, rs.getString("sizes"));
                insert.setString(9, rs.getString("flavours"));
                insert.setString(10, rs.getString("toppings"));
                insert.setBigDecimal(11, rs.getBigDecimal("base_price"));
                insert.executeUpdate();

                insertProductSizes(conn, productId, rs.getString("sizes"));
                insertProductToppings(conn, productId, rs.getString("toppings"));
            }
        }
    }

    private static void insertProductSizes(Connection conn, int productId, String raw) throws SQLException {
        List<OptionSnapshot> options = parseOptions(raw);
        if (options.isEmpty()) {
            return;
        }

        String sql = "INSERT INTO product_sizes (product_id, name, price_modifier, display_order) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            int displayOrder = 0;
            for (OptionSnapshot option : options) {
                ps.setInt(1, productId);
                ps.setString(2, option.label);
                ps.setBigDecimal(3, option.extra);
                ps.setInt(4, displayOrder++);
                ps.executeUpdate();
            }
        }
    }

    private static void insertProductToppings(Connection conn, int productId, String raw) throws SQLException {
        List<OptionSnapshot> options = parseOptions(raw);
        if (options.isEmpty()) {
            return;
        }

        String sql = "INSERT INTO product_toppings (product_id, name, price_modifier, is_available) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            for (OptionSnapshot option : options) {
                ps.setInt(1, productId);
                ps.setString(2, option.label);
                ps.setBigDecimal(3, option.extra);
                ps.setBoolean(4, true);
                ps.executeUpdate();
            }
        }
    }

    private static List<OptionSnapshot> parseOptions(String raw) {
        List<OptionSnapshot> options = new ArrayList<>();
        if (ValidationUtil.isNullOrEmpty(raw)) {
            return options;
        }

        try {
            JsonElement root = JsonParser.parseString(raw);
            if (root.isJsonArray()) {
                JsonArray array = root.getAsJsonArray();
                for (JsonElement element : array) {
                    OptionSnapshot option = parseOption(element);
                    if (option != null) {
                        options.add(option);
                    }
                }
                return options;
            }
            OptionSnapshot option = parseOption(root);
            if (option != null) {
                options.add(option);
            }
            return options;
        } catch (Exception ignored) {
            String[] chunks = raw.split(",");
            for (String chunk : chunks) {
                String value = ValidationUtil.trimToNull(chunk);
                if (value != null) {
                    options.add(new OptionSnapshot(value, BigDecimal.ZERO));
                }
            }
            return options;
        }
    }

    private static OptionSnapshot parseOption(JsonElement element) {
        if (element == null || element.isJsonNull()) {
            return null;
        }

        if (element.isJsonPrimitive()) {
            String label = ValidationUtil.trimToNull(element.getAsString());
            return label == null ? null : new OptionSnapshot(label, BigDecimal.ZERO);
        }

        if (!element.isJsonObject()) {
            return null;
        }

        String label = firstNonBlank(
                getString(element, "label"),
                getString(element, "name"),
                getString(element, "value"),
                getString(element, "size"),
                getString(element, "topping"),
                getString(element, "flavour")
        );
        if (label == null) {
            return null;
        }

        BigDecimal extra = firstBigDecimal(
                getBigDecimal(element, "extra"),
                getBigDecimal(element, "price"),
                getBigDecimal(element, "addOn")
        );

        return new OptionSnapshot(label, extra == null ? BigDecimal.ZERO : extra);
    }

    private static String getString(JsonElement element, String field) {
        return element.getAsJsonObject().has(field) && !element.getAsJsonObject().get(field).isJsonNull()
                ? element.getAsJsonObject().get(field).getAsString()
                : null;
    }

    private static BigDecimal getBigDecimal(JsonElement element, String field) {
        try {
            return element.getAsJsonObject().has(field) && !element.getAsJsonObject().get(field).isJsonNull()
                    ? element.getAsJsonObject().get(field).getAsBigDecimal()
                    : null;
        } catch (Exception ex) {
            return null;
        }
    }

    private static String firstNonBlank(String... values) {
        for (String value : values) {
            String trimmed = ValidationUtil.trimToNull(value);
            if (trimmed != null) {
                return trimmed;
            }
        }
        return null;
    }

    private static BigDecimal firstBigDecimal(BigDecimal... values) {
        for (BigDecimal value : values) {
            if (value != null) {
                return value;
            }
        }
        return null;
    }

    private static void ensureColumn(Connection conn, String table, String column, String alterSql) throws SQLException {
        if (!columnExists(conn, table, column)) {
            execute(conn, alterSql);
        }
    }

    private static boolean tableExists(Connection conn, String tableName) throws SQLException {
        DatabaseMetaData meta = conn.getMetaData();
        try (ResultSet rs = meta.getTables(conn.getCatalog(), null, tableName, null)) {
            return rs.next();
        }
    }

    private static boolean columnExists(Connection conn, String tableName, String columnName) throws SQLException {
        DatabaseMetaData meta = conn.getMetaData();
        try (ResultSet rs = meta.getColumns(conn.getCatalog(), null, tableName, columnName)) {
            return rs.next();
        }
    }

    private static int countRows(Connection conn, String tableName) throws SQLException {
        try (Statement statement = conn.createStatement();
             ResultSet rs = statement.executeQuery("SELECT COUNT(*) FROM " + tableName)) {
            rs.next();
            return rs.getInt(1);
        }
    }

    private static void execute(Connection conn, String sql) throws SQLException {
        try (Statement statement = conn.createStatement()) {
            statement.execute(sql);
        }
    }

    private static final class OptionSnapshot {
        private final String label;
        private final BigDecimal extra;

        private OptionSnapshot(String label, BigDecimal extra) {
            this.label = label;
            this.extra = extra;
        }
    }
}
