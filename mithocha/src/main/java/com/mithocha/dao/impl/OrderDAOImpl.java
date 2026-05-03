package com.mithocha.dao.impl;

import com.mithocha.dao.OrderDAO;
import com.mithocha.model.Order;
import com.mithocha.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * OrderDAOImpl – JDBC implementation of OrderDAO.
 */
public class OrderDAOImpl implements OrderDAO {

    // ── INSERT ────────────────────────────────────────────────────────────────

    @Override
    public int insertOrder(Order order) {
        String sql = "INSERT INTO orders "
                + "(user_id, total_amount, status, items, payment, shipping_address) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1,       order.getUserId());
            ps.setBigDecimal(2, order.getTotalAmount());
            ps.setString(3,    order.getStatus() != null ? order.getStatus() : "pending");
            ps.setString(4,    order.getItems());
            ps.setString(5,    order.getPayment());
            ps.setString(6,    order.getShippingAddress());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                ResultSet keys = ps.getGeneratedKeys();
                if (keys.next()) return keys.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("[OrderDAOImpl] insertOrder error: " + e.getMessage());
        } finally {
            DBUtil.close(conn);
        }
        return -1;
    }

    // ── SELECT ────────────────────────────────────────────────────────────────

    @Override
    public Order findById(int orderId) {
        String sql = "SELECT * FROM orders WHERE order_id = ?";
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) {
            System.err.println("[OrderDAOImpl] findById error: " + e.getMessage());
        } finally {
            DBUtil.close(conn);
        }
        return null;
    }

    @Override
    public List<Order> findByUserId(int userId) {
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";
        List<Order> list = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.err.println("[OrderDAOImpl] findByUserId error: " + e.getMessage());
        } finally {
            DBUtil.close(conn);
        }
        return list;
    }

    @Override
    public List<Order> findAll() {
        String sql = "SELECT * FROM orders ORDER BY order_date DESC";
        List<Order> list = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.err.println("[OrderDAOImpl] findAll error: " + e.getMessage());
        } finally {
            DBUtil.close(conn);
        }
        return list;
    }

    // ── UPDATE ────────────────────────────────────────────────────────────────

    @Override
    public boolean updateStatus(int orderId, String status) {
        String sql = "UPDATE orders SET status = ? WHERE order_id = ?";
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[OrderDAOImpl] updateStatus error: " + e.getMessage());
        } finally {
            DBUtil.close(conn);
        }
        return false;
    }

    // ── DELETE ────────────────────────────────────────────────────────────────

    @Override
    public boolean deleteOrder(int orderId) {
        String sql = "DELETE FROM orders WHERE order_id = ?";
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[OrderDAOImpl] deleteOrder error: " + e.getMessage());
        } finally {
            DBUtil.close(conn);
        }
        return false;
    }

    // ── HELPERS ───────────────────────────────────────────────────────────────

    private Order mapRow(ResultSet rs) throws SQLException {
        return new Order(
            rs.getInt("order_id"),
            rs.getInt("user_id"),
            rs.getBigDecimal("total_amount"),
            rs.getTimestamp("order_date"),
            rs.getString("status"),
            rs.getString("items"),
            rs.getString("payment"),
            rs.getString("shipping_address")
        );
    }
}
