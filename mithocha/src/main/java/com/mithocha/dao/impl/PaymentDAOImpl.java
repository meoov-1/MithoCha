package com.mithocha.dao.impl;

import com.mithocha.dao.PaymentDAO;
import com.mithocha.model.Payment;
import com.mithocha.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class PaymentDAOImpl implements PaymentDAO {

    @Override
    public int insertPayment(Payment payment) {
        try (Connection conn = DBUtil.getConnection()) {
            return insertPayment(conn, payment);
        } catch (SQLException e) {
            System.err.println("[PaymentDAOImpl] insertPayment error: " + e.getMessage());
            return -1;
        }
    }

    public int insertPayment(Connection conn, Payment payment) throws SQLException {
        String sql = "INSERT INTO payments (order_id, transaction_id, status, amount, method) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, payment.getOrderId());
            ps.setString(2, payment.getTransactionId());
            ps.setString(3, payment.getStatus());
            ps.setBigDecimal(4, payment.getAmount());
            ps.setString(5, payment.getMethod());
            int affected = ps.executeUpdate();
            if (affected <= 0) {
                return -1;
            }
            try (ResultSet keys = ps.getGeneratedKeys()) {
                return keys.next() ? keys.getInt(1) : -1;
            }
        }
    }

    @Override
    public Payment findByOrderId(int orderId) {
        String sql = "SELECT * FROM payments WHERE order_id = ? ORDER BY payment_id DESC LIMIT 1";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    return null;
                }
                return new Payment(
                        rs.getInt("payment_id"),
                        rs.getInt("order_id"),
                        rs.getString("transaction_id"),
                        rs.getString("status"),
                        rs.getBigDecimal("amount"),
                        rs.getString("method"),
                        rs.getTimestamp("created_at")
                );
            }
        } catch (SQLException e) {
            System.err.println("[PaymentDAOImpl] findByOrderId error: " + e.getMessage());
            return null;
        }
    }
}
