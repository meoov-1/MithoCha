package com.mithocha.dao.impl;

import com.mithocha.dao.ProductDAO;
import com.mithocha.model.Product;
import com.mithocha.util.DBUtil;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * ProductDAOImpl – JDBC implementation of ProductDAO.
 */
public class ProductDAOImpl implements ProductDAO {

    // ── INSERT ────────────────────────────────────────────────────────────────

    @Override
    public int insertProduct(Product product) {
        String sql = "INSERT INTO product "
                + "(name, description, image_url, additional_images, category, "
                + " is_available, sizes, flavours, toppings, base_price) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1,  product.getName());
            ps.setString(2,  product.getDescription());
            ps.setString(3,  product.getImageUrl());
            ps.setString(4,  product.getAdditionalImages());
            ps.setString(5,  product.getCategory());
            ps.setBoolean(6, product.isAvailable());
            ps.setString(7,  product.getSizes());
            ps.setString(8,  product.getFlavours());
            ps.setString(9,  product.getToppings());
            ps.setBigDecimal(10, product.getBasePrice());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                ResultSet keys = ps.getGeneratedKeys();
                if (keys.next()) return keys.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("[ProductDAOImpl] insertProduct error: " + e.getMessage());
        } finally {
            DBUtil.close(conn);
        }
        return -1;
    }

    // ── SELECT ────────────────────────────────────────────────────────────────

    @Override
    public Product findById(int productId) {
        String sql = "SELECT * FROM product WHERE product_id = ?";
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) {
            System.err.println("[ProductDAOImpl] findById error: " + e.getMessage());
        } finally {
            DBUtil.close(conn);
        }
        return null;
    }

    @Override
    public List<Product> findAll() {
        return queryList("SELECT * FROM product ORDER BY product_id DESC");
    }

    @Override
    public List<Product> findAllAvailable() {
        return queryList("SELECT * FROM product WHERE is_available = TRUE ORDER BY product_id DESC");
    }

    @Override
    public List<Product> findByCategory(String category) {
        String sql = "SELECT * FROM product WHERE category = ? AND is_available = TRUE ORDER BY product_id DESC";
        List<Product> list = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, category);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.err.println("[ProductDAOImpl] findByCategory error: " + e.getMessage());
        } finally {
            DBUtil.close(conn);
        }
        return list;
    }

    @Override
    public List<String> findAllCategories() {
        String sql = "SELECT DISTINCT category FROM product WHERE category IS NOT NULL ORDER BY category";
        List<String> categories = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) categories.add(rs.getString("category"));
        } catch (SQLException e) {
            System.err.println("[ProductDAOImpl] findAllCategories error: " + e.getMessage());
        } finally {
            DBUtil.close(conn);
        }
        return categories;
    }

    // ── UPDATE ────────────────────────────────────────────────────────────────

    @Override
    public boolean updateProduct(Product product) {
        String sql = "UPDATE product SET name=?, description=?, image_url=?, "
                + "additional_images=?, category=?, is_available=?, "
                + "sizes=?, flavours=?, toppings=?, base_price=? "
                + "WHERE product_id=?";
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1,  product.getName());
            ps.setString(2,  product.getDescription());
            ps.setString(3,  product.getImageUrl());
            ps.setString(4,  product.getAdditionalImages());
            ps.setString(5,  product.getCategory());
            ps.setBoolean(6, product.isAvailable());
            ps.setString(7,  product.getSizes());
            ps.setString(8,  product.getFlavours());
            ps.setString(9,  product.getToppings());
            ps.setBigDecimal(10, product.getBasePrice());
            ps.setInt(11, product.getProductId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[ProductDAOImpl] updateProduct error: " + e.getMessage());
        } finally {
            DBUtil.close(conn);
        }
        return false;
    }

    @Override
    public boolean setAvailability(int productId, boolean available) {
        String sql = "UPDATE product SET is_available = ? WHERE product_id = ?";
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setBoolean(1, available);
            ps.setInt(2, productId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[ProductDAOImpl] setAvailability error: " + e.getMessage());
        } finally {
            DBUtil.close(conn);
        }
        return false;
    }

    // ── DELETE ────────────────────────────────────────────────────────────────

    @Override
    public boolean deleteProduct(int productId) {
        String sql = "DELETE FROM product WHERE product_id = ?";
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, productId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[ProductDAOImpl] deleteProduct error: " + e.getMessage());
        } finally {
            DBUtil.close(conn);
        }
        return false;
    }

    // ── HELPERS ───────────────────────────────────────────────────────────────

    private List<Product> queryList(String sql) {
        List<Product> list = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.err.println("[ProductDAOImpl] queryList error: " + e.getMessage());
        } finally {
            DBUtil.close(conn);
        }
        return list;
    }

    private Product mapRow(ResultSet rs) throws SQLException {
        return new Product(
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
    }
}
