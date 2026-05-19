package com.mithocha.dao.impl;

import com.google.gson.reflect.TypeToken;
import com.mithocha.dao.OrderDAO;
import com.mithocha.model.Order;
import com.mithocha.model.OrderItem;
import com.mithocha.model.Payment;
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
 * OrderDAOImpl – JDBC implementation of order persistence with normalized
 * order items and payment records.
 */
public class OrderDAOImpl implements OrderDAO {

    private static final Type TOPPING_LIST_TYPE = new TypeToken<List<ProductTopping>>() {}.getType();

    @Override
    public int insertOrder(Order order) {
        try (Connection conn = DBUtil.getConnection()) {
            return insertOrder(conn, order);
        } catch (SQLException e) {
            System.err.println("[OrderDAOImpl] insertOrder error: " + e.getMessage());
            return -1;
        }
    }

    public int insertOrder(Connection conn, Order order) throws SQLException {
        String sql = "INSERT INTO orders (user_id, total_amount, status, items, payment, shipping_address) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            if (order.getUserId() > 0) {
                ps.setInt(1, order.getUserId());
            } else {
                ps.setNull(1, java.sql.Types.INTEGER);
            }
            ps.setBigDecimal(2, order.getTotalAmount());
            ps.setString(3, order.getStatus() == null ? "pending" : order.getStatus());
            ps.setString(4, order.getItems());
            ps.setString(5, order.getPayment());
            ps.setString(6, order.getShippingAddress());
            int affected = ps.executeUpdate();
            if (affected <= 0) {
                return -1;
            }
            try (ResultSet keys = ps.getGeneratedKeys()) {
                return keys.next() ? keys.getInt(1) : -1;
            }
        }
    }

    public void insertOrderItems(Connection conn, int orderId, List<OrderItem> orderItems) throws SQLException {
        if (orderItems == null || orderItems.isEmpty()) {
            return;
        }

        String sql = "INSERT INTO order_items "
                + "(order_id, product_id, product_name, product_size_id, size_name, selected_topping_ids_json, "
                + "selected_toppings_json, quantity, unit_price, item_total) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            for (OrderItem item : orderItems) {
                ps.setInt(1, orderId);
                if (item.getProductId() == null) {
                    ps.setNull(2, java.sql.Types.INTEGER);
                } else {
                    ps.setInt(2, item.getProductId());
                }
                ps.setString(3, item.getProductName());
                if (item.getProductSizeId() == null) {
                    ps.setNull(4, java.sql.Types.INTEGER);
                } else {
                    ps.setInt(4, item.getProductSizeId());
                }
                ps.setString(5, item.getSizeName());
                ps.setString(6, item.getSelectedToppingIdsJson());
                ps.setString(7, item.getSelectedToppingsJson());
                ps.setInt(8, item.getQuantity());
                ps.setBigDecimal(9, item.getUnitPrice());
                ps.setBigDecimal(10, item.getItemTotal());
                ps.executeUpdate();
            }
        }
    }

    @Override
    public Order findById(int orderId) {
        String sql = "SELECT * FROM orders WHERE order_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    return null;
                }
                Order order = mapOrder(rs);
                attachDetails(conn, order);
                return order;
            }
        } catch (SQLException e) {
            System.err.println("[OrderDAOImpl] findById error: " + e.getMessage());
            return null;
        }
    }

    @Override
    public List<Order> findByUserId(int userId) {
        return queryOrders("SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC", userId, true);
    }

    @Override
    public List<Order> findAll() {
        return queryOrders("SELECT * FROM orders ORDER BY order_date DESC", null, false);
    }

    @Override
    public List<OrderItem> findItemsByOrderId(int orderId) {
        try (Connection conn = DBUtil.getConnection()) {
            return findItemsByOrderId(conn, orderId);
        } catch (SQLException e) {
            System.err.println("[OrderDAOImpl] findItemsByOrderId error: " + e.getMessage());
            return Collections.emptyList();
        }
    }

    @Override
    public Payment findPaymentByOrderId(int orderId) {
        try (Connection conn = DBUtil.getConnection()) {
            return findPaymentByOrderId(conn, orderId);
        } catch (SQLException e) {
            System.err.println("[OrderDAOImpl] findPaymentByOrderId error: " + e.getMessage());
            return null;
        }
    }

    @Override
    public boolean updateSnapshots(int orderId, String itemsJson, String paymentJson, String shippingAddress) {
        try (Connection conn = DBUtil.getConnection()) {
            return updateSnapshots(conn, orderId, itemsJson, paymentJson, shippingAddress);
        } catch (SQLException e) {
            System.err.println("[OrderDAOImpl] updateSnapshots error: " + e.getMessage());
            return false;
        }
    }

    public boolean updateSnapshots(Connection conn, int orderId, String itemsJson, String paymentJson,
                                   String shippingAddress) throws SQLException {
        String sql = "UPDATE orders SET items = ?, payment = ?, shipping_address = ? WHERE order_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, itemsJson);
            ps.setString(2, paymentJson);
            ps.setString(3, shippingAddress);
            ps.setInt(4, orderId);
            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public boolean updateStatus(int orderId, String status) {
        try (Connection conn = DBUtil.getConnection()) {
            return updateStatus(conn, orderId, status);
        } catch (SQLException e) {
            System.err.println("[OrderDAOImpl] updateStatus error: " + e.getMessage());
            return false;
        }
    }

    public boolean updateStatus(Connection conn, int orderId, String status) throws SQLException {
        String sql = "UPDATE orders SET status = ? WHERE order_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public boolean deleteOrder(int orderId) {
        String sql = "DELETE FROM orders WHERE order_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[OrderDAOImpl] deleteOrder error: " + e.getMessage());
            return false;
        }
    }

    private List<Order> queryOrders(String sql, Integer userId, boolean bindUserId) {
        List<Order> orders = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            if (bindUserId && userId != null) {
                ps.setInt(1, userId);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = mapOrder(rs);
                    attachDetails(conn, order);
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            System.err.println("[OrderDAOImpl] queryOrders error: " + e.getMessage());
        }
        return orders;
    }

    private void attachDetails(Connection conn, Order order) throws SQLException {
        order.setOrderItems(findItemsByOrderId(conn, order.getOrderId()));
        order.setPaymentRecord(findPaymentByOrderId(conn, order.getOrderId()));
    }

    private List<OrderItem> findItemsByOrderId(Connection conn, int orderId) throws SQLException {
        String sql = "SELECT * FROM order_items WHERE order_id = ? ORDER BY order_item_id";
        List<OrderItem> items = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    items.add(mapOrderItem(rs));
                }
            }
        }
        return items;
    }

    private Payment findPaymentByOrderId(Connection conn, int orderId) throws SQLException {
        String sql = "SELECT * FROM payments WHERE order_id = ? ORDER BY payment_id DESC LIMIT 1";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? mapPayment(rs) : null;
            }
        }
    }

    private Order mapOrder(ResultSet rs) throws SQLException {
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

    private OrderItem mapOrderItem(ResultSet rs) throws SQLException {
        OrderItem item = new OrderItem();
        item.setOrderItemId(rs.getInt("order_item_id"));
        item.setOrderId(rs.getInt("order_id"));
        int productId = rs.getInt("product_id");
        item.setProductId(rs.wasNull() ? null : productId);
        item.setProductName(rs.getString("product_name"));
        int productSizeId = rs.getInt("product_size_id");
        item.setProductSizeId(rs.wasNull() ? null : productSizeId);
        item.setSizeName(rs.getString("size_name"));
        item.setSelectedToppingIdsJson(rs.getString("selected_topping_ids_json"));
        item.setSelectedToppingsJson(rs.getString("selected_toppings_json"));
        item.setQuantity(rs.getInt("quantity"));
        item.setUnitPrice(rs.getBigDecimal("unit_price"));
        item.setItemTotal(rs.getBigDecimal("item_total"));

        String toppingsJson = item.getSelectedToppingsJson();
        if (toppingsJson != null) {
            try {
                List<ProductTopping> toppings = JsonUtil.fromJson(toppingsJson, TOPPING_LIST_TYPE);
                item.setSelectedToppings(toppings == null ? Collections.emptyList() : toppings);
            } catch (Exception ignored) {
                item.setSelectedToppings(Collections.emptyList());
            }
        }
        return item;
    }

    private Payment mapPayment(ResultSet rs) throws SQLException {
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
}
