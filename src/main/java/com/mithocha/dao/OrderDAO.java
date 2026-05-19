package com.mithocha.dao;

import com.mithocha.model.Order;
import com.mithocha.model.OrderItem;
import com.mithocha.model.Payment;
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

    /** Return all order items for an order. */
    List<OrderItem> findItemsByOrderId(int orderId);

    /** Return the payment record for an order, if it exists. */
    Payment findPaymentByOrderId(int orderId);

    /** Update the order JSON snapshots used by the older page layer. */
    boolean updateSnapshots(int orderId, String itemsJson, String paymentJson, String shippingAddress);

    /** Update the status of an order ('pending' → 'completed' / 'cancelled'). */
    boolean updateStatus(int orderId, String status);

    /** Delete an order by id. */
    boolean deleteOrder(int orderId);
}
