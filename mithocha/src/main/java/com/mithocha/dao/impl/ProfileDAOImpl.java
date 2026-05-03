package com.mithocha.dao.impl;

import com.mithocha.dao.ProfileDAO;
import com.mithocha.model.Profile;
import com.mithocha.util.DBUtil;

import java.sql.*;

/**
 * ProfileDAOImpl – JDBC implementation of ProfileDAO.
 */
public class ProfileDAOImpl implements ProfileDAO {

    // ── INSERT ────────────────────────────────────────────────────────────────

    @Override
    public int insertProfile(Profile profile) {
        String sql = "INSERT INTO profile "
                + "(user_id, phone, address, city, postal_code, "
                + " profile_image_url, cover_image_url, bio, date_of_birth) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1,    profile.getUserId());
            ps.setString(2, profile.getPhone());
            ps.setString(3, profile.getAddress());
            ps.setString(4, profile.getCity());
            ps.setString(5, profile.getPostalCode());
            ps.setString(6, profile.getProfileImageUrl());
            ps.setString(7, profile.getCoverImageUrl());
            ps.setString(8, profile.getBio());
            ps.setDate(9,   profile.getDateOfBirth());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                ResultSet keys = ps.getGeneratedKeys();
                if (keys.next()) return keys.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("[ProfileDAOImpl] insertProfile error: " + e.getMessage());
        } finally {
            DBUtil.close(conn);
        }
        return -1;
    }

    // ── SELECT ────────────────────────────────────────────────────────────────

    @Override
    public Profile findByUserId(int userId) {
        String sql = "SELECT * FROM profile WHERE user_id = ?";
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) {
            System.err.println("[ProfileDAOImpl] findByUserId error: " + e.getMessage());
        } finally {
            DBUtil.close(conn);
        }
        return null;
    }

    // ── UPDATE ────────────────────────────────────────────────────────────────

    @Override
    public boolean updateProfile(Profile profile) {
        String sql = "UPDATE profile SET phone=?, address=?, city=?, postal_code=?, "
                + "profile_image_url=?, cover_image_url=?, bio=?, date_of_birth=? "
                + "WHERE user_id=?";
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, profile.getPhone());
            ps.setString(2, profile.getAddress());
            ps.setString(3, profile.getCity());
            ps.setString(4, profile.getPostalCode());
            ps.setString(5, profile.getProfileImageUrl());
            ps.setString(6, profile.getCoverImageUrl());
            ps.setString(7, profile.getBio());
            ps.setDate(8,   profile.getDateOfBirth());
            ps.setInt(9,    profile.getUserId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[ProfileDAOImpl] updateProfile error: " + e.getMessage());
        } finally {
            DBUtil.close(conn);
        }
        return false;
    }

    // ── DELETE ────────────────────────────────────────────────────────────────

    @Override
    public boolean deleteByUserId(int userId) {
        String sql = "DELETE FROM profile WHERE user_id = ?";
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[ProfileDAOImpl] deleteByUserId error: " + e.getMessage());
        } finally {
            DBUtil.close(conn);
        }
        return false;
    }

    // ── HELPERS ───────────────────────────────────────────────────────────────

    private Profile mapRow(ResultSet rs) throws SQLException {
        return new Profile(
            rs.getInt("profile_id"),
            rs.getInt("user_id"),
            rs.getString("phone"),
            rs.getString("address"),
            rs.getString("city"),
            rs.getString("postal_code"),
            rs.getString("profile_image_url"),
            rs.getString("cover_image_url"),
            rs.getString("bio"),
            rs.getDate("date_of_birth")
        );
    }
}
