package com.mithocha.dao.impl;

import com.mithocha.dao.ProductDAO;
import com.mithocha.model.Product;
import com.mithocha.model.ProductSize;
import com.mithocha.model.ProductTopping;
import com.mithocha.util.DBUtil;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.StringJoiner;

/**
 * ProductDAOImpl – JDBC implementation backed by the normalized `products`,
 * `product_sizes`, and `product_toppings` tables.
 */
public class ProductDAOImpl implements ProductDAO {

    private static final String PRODUCT_COLUMNS =
            "product_id, name, description, image_url, image_data, image_content_type, "
                    + "additional_images, category, is_available, sizes, flavours, toppings, base_price";

    @Override
    public int insertProduct(Product product) {
        String sql = "INSERT INTO products "
                + "(name, description, image_url, image_data, image_content_type, additional_images, "
                + "category, is_available, sizes, flavours, toppings, base_price) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            conn.setAutoCommit(false);
            bindProduct(ps, product);
            int affected = ps.executeUpdate();
            if (affected <= 0) {
                conn.rollback();
                return -1;
            }

            int productId;
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (!keys.next()) {
                    conn.rollback();
                    return -1;
                }
                productId = keys.getInt(1);
            }

            replaceProductSizes(conn, productId, product.getSizeOptions());
            replaceProductToppings(conn, productId, product.getToppingOptions());
            conn.commit();
            return productId;
        } catch (SQLException e) {
            System.err.println("[ProductDAOImpl] insertProduct error: " + e.getMessage());
            return -1;
        }
    }

    @Override
    public Product findById(int productId) {
        String sql = "SELECT " + PRODUCT_COLUMNS + " FROM products WHERE product_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    return null;
                }
                Product product = mapProduct(rs);
                attachOptions(conn, product);
                return product;
            }
        } catch (SQLException e) {
            System.err.println("[ProductDAOImpl] findById error: " + e.getMessage());
            return null;
        }
    }

    @Override
    public List<Product> findAll() {
        return queryProducts("SELECT " + PRODUCT_COLUMNS + " FROM products ORDER BY product_id DESC", null);
    }

    @Override
    public List<Product> findAllAvailable() {
        return queryProducts("SELECT " + PRODUCT_COLUMNS + " FROM products WHERE is_available = TRUE ORDER BY product_id DESC", null);
    }

    @Override
    public List<Product> findByCategory(String category) {
        return queryProducts(
                "SELECT " + PRODUCT_COLUMNS + " FROM products WHERE category = ? AND is_available = TRUE ORDER BY product_id DESC",
                category
        );
    }

    @Override
    public List<String> findAllCategories() {
        String sql = "SELECT DISTINCT category FROM products WHERE category IS NOT NULL ORDER BY category";
        List<String> categories = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                categories.add(rs.getString("category"));
            }
        } catch (SQLException e) {
            System.err.println("[ProductDAOImpl] findAllCategories error: " + e.getMessage());
        }
        return categories;
    }

    @Override
    public List<ProductSize> findSizesByProductId(int productId) {
        String sql = "SELECT size_id, product_id, name, price_modifier, display_order "
                + "FROM product_sizes WHERE product_id = ? ORDER BY display_order, size_id";
        List<ProductSize> sizes = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    sizes.add(mapSize(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("[ProductDAOImpl] findSizesByProductId error: " + e.getMessage());
        }
        return sizes;
    }

    @Override
    public ProductSize findSizeById(int sizeId) {
        String sql = "SELECT size_id, product_id, name, price_modifier, display_order FROM product_sizes WHERE size_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, sizeId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? mapSize(rs) : null;
            }
        } catch (SQLException e) {
            System.err.println("[ProductDAOImpl] findSizeById error: " + e.getMessage());
            return null;
        }
    }

    @Override
    public List<ProductTopping> findToppingsByProductId(int productId) {
        String sql = "SELECT topping_id, product_id, name, price_modifier, is_available "
                + "FROM product_toppings WHERE product_id = ? AND is_available = TRUE ORDER BY topping_id";
        List<ProductTopping> toppings = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    toppings.add(mapTopping(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("[ProductDAOImpl] findToppingsByProductId error: " + e.getMessage());
        }
        return toppings;
    }

    @Override
    public List<ProductTopping> findToppingsByIds(List<Integer> toppingIds) {
        if (toppingIds == null || toppingIds.isEmpty()) {
            return Collections.emptyList();
        }

        StringJoiner placeholders = new StringJoiner(", ");
        for (int i = 0; i < toppingIds.size(); i++) {
            placeholders.add("?");
        }

        String sql = "SELECT topping_id, product_id, name, price_modifier, is_available "
                + "FROM product_toppings WHERE topping_id IN (" + placeholders + ") AND is_available = TRUE";
        List<ProductTopping> toppings = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            for (int i = 0; i < toppingIds.size(); i++) {
                ps.setInt(i + 1, toppingIds.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    toppings.add(mapTopping(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("[ProductDAOImpl] findToppingsByIds error: " + e.getMessage());
        }
        return toppings;
    }

    @Override
    public boolean updateProduct(Product product) {
        String sql = "UPDATE products SET name = ?, description = ?, image_url = ?, image_data = ?, "
                + "image_content_type = ?, additional_images = ?, category = ?, is_available = ?, "
                + "sizes = ?, flavours = ?, toppings = ?, base_price = ? WHERE product_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            conn.setAutoCommit(false);
            bindProduct(ps, product);
            ps.setInt(13, product.getProductId());

            boolean updated = ps.executeUpdate() > 0;
            if (!updated) {
                conn.rollback();
                return false;
            }

            replaceProductSizes(conn, product.getProductId(), product.getSizeOptions());
            replaceProductToppings(conn, product.getProductId(), product.getToppingOptions());
            conn.commit();
            return true;
        } catch (SQLException e) {
            System.err.println("[ProductDAOImpl] updateProduct error: " + e.getMessage());
            return false;
        }
    }

    @Override
    public boolean setAvailability(int productId, boolean available) {
        String sql = "UPDATE products SET is_available = ? WHERE product_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setBoolean(1, available);
            ps.setInt(2, productId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[ProductDAOImpl] setAvailability error: " + e.getMessage());
            return false;
        }
    }

    @Override
    public boolean deleteProduct(int productId) {
        String sql = "DELETE FROM products WHERE product_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[ProductDAOImpl] deleteProduct error: " + e.getMessage());
            return false;
        }
    }

    private List<Product> queryProducts(String sql, String categoryParam) {
        List<Product> products = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            if (categoryParam != null) {
                ps.setString(1, categoryParam);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product product = mapProduct(rs);
                    attachOptions(conn, product);
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            System.err.println("[ProductDAOImpl] queryProducts error: " + e.getMessage());
        }
        return products;
    }

    private void bindProduct(PreparedStatement ps, Product product) throws SQLException {
        ps.setString(1, product.getName());
        ps.setString(2, product.getDescription());
        ps.setString(3, product.getStoredImageUrl());
        ps.setBytes(4, product.getImageData());
        ps.setString(5, product.getImageContentType());
        ps.setString(6, product.getAdditionalImages());
        ps.setString(7, product.getCategory());
        ps.setBoolean(8, product.isAvailable());
        ps.setString(9, product.getSizes());
        ps.setString(10, product.getFlavours());
        ps.setString(11, product.getToppings());
        ps.setBigDecimal(12, defaultAmount(product.getBasePrice()));
    }

    private void attachOptions(Connection conn, Product product) throws SQLException {
        product.setSizeOptions(findSizes(conn, product.getProductId()));
        product.setToppingOptions(findToppings(conn, product.getProductId()));
    }

    private List<ProductSize> findSizes(Connection conn, int productId) throws SQLException {
        String sql = "SELECT size_id, product_id, name, price_modifier, display_order "
                + "FROM product_sizes WHERE product_id = ? ORDER BY display_order, size_id";
        List<ProductSize> sizes = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    sizes.add(mapSize(rs));
                }
            }
        }
        return sizes;
    }

    private List<ProductTopping> findToppings(Connection conn, int productId) throws SQLException {
        String sql = "SELECT topping_id, product_id, name, price_modifier, is_available "
                + "FROM product_toppings WHERE product_id = ? ORDER BY topping_id";
        List<ProductTopping> toppings = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    toppings.add(mapTopping(rs));
                }
            }
        }
        return toppings;
    }

    private void replaceProductSizes(Connection conn, int productId, List<ProductSize> sizes) throws SQLException {
        try (PreparedStatement delete = conn.prepareStatement("DELETE FROM product_sizes WHERE product_id = ?")) {
            delete.setInt(1, productId);
            delete.executeUpdate();
        }

        if (sizes == null || sizes.isEmpty()) {
            return;
        }

        try (PreparedStatement insert = conn.prepareStatement(
                "INSERT INTO product_sizes (product_id, name, price_modifier, display_order) VALUES (?, ?, ?, ?)")) {
            int order = 0;
            for (ProductSize size : sizes) {
                insert.setInt(1, productId);
                insert.setString(2, size.getName());
                insert.setBigDecimal(3, defaultAmount(size.getPriceModifier()));
                insert.setInt(4, size.getDisplayOrder() > 0 ? size.getDisplayOrder() : order++);
                insert.executeUpdate();
            }
        }
    }

    private void replaceProductToppings(Connection conn, int productId, List<ProductTopping> toppings) throws SQLException {
        try (PreparedStatement delete = conn.prepareStatement("DELETE FROM product_toppings WHERE product_id = ?")) {
            delete.setInt(1, productId);
            delete.executeUpdate();
        }

        if (toppings == null || toppings.isEmpty()) {
            return;
        }

        try (PreparedStatement insert = conn.prepareStatement(
                "INSERT INTO product_toppings (product_id, name, price_modifier, is_available) VALUES (?, ?, ?, ?)")) {
            for (ProductTopping topping : toppings) {
                insert.setInt(1, productId);
                insert.setString(2, topping.getName());
                insert.setBigDecimal(3, defaultAmount(topping.getPriceModifier()));
                insert.setBoolean(4, topping.isAvailable());
                insert.executeUpdate();
            }
        }
    }

    private Product mapProduct(ResultSet rs) throws SQLException {
        Product product = new Product(
                rs.getInt("product_id"),
                rs.getString("name"),
                rs.getString("description"),
                rs.getString("image_url"),
                rs.getString("additional_images"),
                rs.getString("category"),
                rs.getBoolean("is_available"),
                rs.getString("sizes"),
                rs.getString("flavours"),
                rs.getString("toppings"),
                rs.getBigDecimal("base_price")
        );
        product.setImageData(rs.getBytes("image_data"));
        product.setImageContentType(rs.getString("image_content_type"));
        return product;
    }

    private ProductSize mapSize(ResultSet rs) throws SQLException {
        return new ProductSize(
                rs.getInt("size_id"),
                rs.getInt("product_id"),
                rs.getString("name"),
                rs.getBigDecimal("price_modifier"),
                rs.getInt("display_order")
        );
    }

    private ProductTopping mapTopping(ResultSet rs) throws SQLException {
        return new ProductTopping(
                rs.getInt("topping_id"),
                rs.getInt("product_id"),
                rs.getString("name"),
                rs.getBigDecimal("price_modifier"),
                rs.getBoolean("is_available")
        );
    }

    private BigDecimal defaultAmount(BigDecimal value) {
        return value == null ? BigDecimal.ZERO : value;
    }
}
