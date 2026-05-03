package com.mithocha.dao.impl;

import com.mithocha.dao.ReviewDAO;
import com.mithocha.model.Review;
import com.mithocha.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * ReviewDAOImpl – JDBC implementation of ReviewDAO.
 */
public class ReviewDAOImpl implements ReviewDAO {

    // ── INSERT ────────────────────────────────────────────────────────────────

    @Override
    public int insertReview(Review review) {
        String sql = "INSERT INTO reviews (user_id, product_id, rating, comment, image_url) "
                + "VALUES (?, ?, ?, ?, ?)";
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1,    review.getUserId());
            ps.setInt(2,    review.getProductId());
            ps.setInt(3,    review.getRating());
            ps.setString(4, review.getComment());
            ps.setString(5, review.getImageUrl());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                ResultSet keys = ps.getGeneratedKeys();
                if (keys.next()) return keys.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("[ReviewDAOImpl] insertReview error: " + e.getMessage());
        } finally {
            DBUtil.close(conn);
        }
        return -1;
    }

    // ── SELECT ────────────────────────────────────────────────────────────────

    @Override
    public List<Review> findByProductId(int productId) {
        String sql = "SELECT * FROM reviews WHERE product_id = ? ORDER BY created_at DESC";
        List<Review> list = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.err.println("[ReviewDAOImpl] findByProductId error: " + e.getMessage());
        } finally {
            DBUtil.close(conn);
        }
        return list;
    }

    @Override
    public List<Review> findByUserId(int userId) {
        String sql = "SELECT * FROM reviews WHERE user_id = ? ORDER BY created_at DESC";
        List<Review> list = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.err.println("[ReviewDAOImpl] findByUserId error: " + e.getMessage());
        } finally {
            DBUtil.close(conn);
        }
        return list;
    }

    // ── DELETE ────────────────────────────────────────────────────────────────

    @Override
    public boolean deleteReview(int reviewId) {
        String sql = "DELETE FROM reviews WHERE review_id = ?";
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, reviewId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[ReviewDAOImpl] deleteReview error: " + e.getMessage());
        } finally {
            DBUtil.close(conn);
        }
        return false;
    }

    // ── HELPERS ───────────────────────────────────────────────────────────────

    private Review mapRow(ResultSet rs) throws SQLException {
        return new Review(
            rs.getInt("review_id"),
            rs.getInt("user_id"),
            rs.getInt("product_id"),
            rs.getInt("rating"),
            rs.getString("comment"),
            rs.getString("image_url"),
            rs.getTimestamp("created_at")
        );
    }
}
