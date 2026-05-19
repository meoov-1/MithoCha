package com.mithocha.dao.impl;

import com.google.gson.reflect.TypeToken;
import com.mithocha.dao.CartDAO;
import com.mithocha.dao.ProductDAO;
import com.mithocha.model.CartItem;
import com.mithocha.model.Product;
import com.mithocha.model.ProductSize;
import com.mithocha.model.ProductTopping;
import com.mithocha.util.DBUtil;
import com.mithocha.util.JsonUtil;

import java.lang.reflect.Type;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * CartDAOImpl – JDBC implementation of server-side cart storage.
 */
public class CartDAOImpl implements CartDAO {

    private static final Type TOPPING_LIST_TYPE = new TypeToken<List<ProductTopping>>() {}.getType();
    private final ProductDAO productDAO = new ProductDAOImpl();

    @Override
    public int insertCartItem(CartItem cartItem) {
        String sql = "INSERT INTO cart_items "
                + "(user_id, product_id, product_size_id, selected_topping_ids_json, selected_toppings_json, "
                + "quantity, unit_price, item_total) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            bindCartItem(ps, cartItem);
            int affected = ps.executeUpdate();
            if (affected <= 0) {
                return -1;
            }

            try (ResultSet keys = ps.getGeneratedKeys()) {
                return keys.next() ? keys.getInt(1) : -1;
            }
        } catch (SQLException e) {
            System.err.println("[CartDAOImpl] insertCartItem error: " + e.getMessage());
            return -1;
        }
    }

    @Override
    public CartItem findById(int userId, int cartItemId) {
        String sql = "SELECT * FROM cart_items WHERE user_id = ? AND cart_item_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, cartItemId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? mapCartItem(rs) : null;
            }
        } catch (SQLException e) {
            System.err.println("[CartDAOImpl] findById error: " + e.getMessage());
            return null;
        }
    }

    @Override
    public List<CartItem> findByUserId(int userId) {
        String sql = "SELECT * FROM cart_items WHERE user_id = ? ORDER BY created_at DESC, cart_item_id DESC";
        List<CartItem> items = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    items.add(mapCartItem(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("[CartDAOImpl] findByUserId error: " + e.getMessage());
        }
        return items;
    }

    @Override
    public boolean updateCartItem(CartItem cartItem) {
        String sql = "UPDATE cart_items SET product_id = ?, product_size_id = ?, selected_topping_ids_json = ?, "
                + "selected_toppings_json = ?, quantity = ?, unit_price = ?, item_total = ? "
                + "WHERE cart_item_id = ? AND user_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, cartItem.getProductId());
            if (cartItem.getProductSizeId() == null) {
                ps.setNull(2, java.sql.Types.INTEGER);
            } else {
                ps.setInt(2, cartItem.getProductSizeId());
            }
            ps.setString(3, cartItem.getSelectedToppingIdsJson());
            ps.setString(4, cartItem.getSelectedToppingsJson());
            ps.setInt(5, cartItem.getQuantity());
            ps.setBigDecimal(6, cartItem.getUnitPrice());
            ps.setBigDecimal(7, cartItem.getItemTotal());
            ps.setInt(8, cartItem.getCartItemId());
            ps.setInt(9, cartItem.getUserId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[CartDAOImpl] updateCartItem error: " + e.getMessage());
            return false;
        }
    }

    @Override
    public boolean deleteCartItem(int userId, int cartItemId) {
        String sql = "DELETE FROM cart_items WHERE user_id = ? AND cart_item_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, cartItemId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[CartDAOImpl] deleteCartItem error: " + e.getMessage());
            return false;
        }
    }

    @Override
    public boolean clearCart(int userId) {
        String sql = "DELETE FROM cart_items WHERE user_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.err.println("[CartDAOImpl] clearCart error: " + e.getMessage());
            return false;
        }
    }

    private void bindCartItem(PreparedStatement ps, CartItem cartItem) throws SQLException {
        ps.setInt(1, cartItem.getUserId());
        ps.setInt(2, cartItem.getProductId());
        if (cartItem.getProductSizeId() == null) {
            ps.setNull(3, java.sql.Types.INTEGER);
        } else {
            ps.setInt(3, cartItem.getProductSizeId());
        }
        ps.setString(4, cartItem.getSelectedToppingIdsJson());
        ps.setString(5, cartItem.getSelectedToppingsJson());
        ps.setInt(6, cartItem.getQuantity());
        ps.setBigDecimal(7, cartItem.getUnitPrice());
        ps.setBigDecimal(8, cartItem.getItemTotal());
    }

    private CartItem mapCartItem(ResultSet rs) throws SQLException {
        CartItem cartItem = new CartItem();
        cartItem.setCartItemId(rs.getInt("cart_item_id"));
        cartItem.setUserId(rs.getInt("user_id"));
        cartItem.setProductId(rs.getInt("product_id"));
        int productSizeId = rs.getInt("product_size_id");
        cartItem.setProductSizeId(rs.wasNull() ? null : productSizeId);
        cartItem.setSelectedToppingIdsJson(rs.getString("selected_topping_ids_json"));
        cartItem.setSelectedToppingsJson(rs.getString("selected_toppings_json"));
        cartItem.setQuantity(rs.getInt("quantity"));
        cartItem.setUnitPrice(rs.getBigDecimal("unit_price"));
        cartItem.setItemTotal(rs.getBigDecimal("item_total"));
        cartItem.setCreatedAt(rs.getTimestamp("created_at"));
        cartItem.setUpdatedAt(rs.getTimestamp("updated_at"));

        Product product = productDAO.findById(cartItem.getProductId());
        cartItem.setProduct(product);

        if (cartItem.getProductSizeId() != null) {
            ProductSize size = productDAO.findSizeById(cartItem.getProductSizeId());
            cartItem.setSelectedSize(size);
        }

        String toppingsJson = cartItem.getSelectedToppingsJson();
        if (toppingsJson != null) {
            try {
                List<ProductTopping> toppings = JsonUtil.fromJson(toppingsJson, TOPPING_LIST_TYPE);
                cartItem.setSelectedToppings(toppings == null ? Collections.emptyList() : toppings);
            } catch (Exception ignored) {
                cartItem.setSelectedToppings(Collections.emptyList());
            }
        }
        return cartItem;
    }
}
