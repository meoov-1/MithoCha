package com.mithocha.dao;

import com.mithocha.model.Order;
import java.util.List;

/**
 * OrderDAO – contract for all order-related database operations.
 */
public interface OrderDAO {

    /** Insert a new order. Returns the generated order_id, or -1 on failure. */
    int insertOrder(Order order);

    /** Find an order by its primary key. */
    Order findById(int orderId);

    /** Return all orders for a specific user. */
    List<Order> findByUserId(int userId);

    /** Return all orders (admin use). */
    List<Order> findAll();

    /** Update the status of an order ('pending' → 'completed' / 'cancelled'). */
    boolean updateStatus(int orderId, String status);

    /** Delete an order by id. */
    boolean deleteOrder(int orderId);
}
