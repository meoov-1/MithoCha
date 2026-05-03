package com.mithocha.service;

import com.mithocha.dao.OrderDAO;
import com.mithocha.dao.impl.OrderDAOImpl;
import com.mithocha.model.Order;

import java.math.BigDecimal;

/**
 * CartService – converts a confirmed cart (JSON payload from the browser)
 * into a persisted Order row.
 *
 * The cart itself lives in the browser (localStorage). When the user clicks
 * "Confirm Order", the CartServlet calls this service to write the order to DB.
 */
public class CartService {

    private final OrderDAO orderDAO = new OrderDAOImpl();

    /**
     * Place an order from cart data.
     *
     * @param userId          logged-in user's id
     * @param itemsJson       JSON string of cart items (from browser)
     * @param paymentJson     JSON string of payment details
     * @param shippingJson    JSON string of shipping address
     * @param totalAmount     calculated total (server should re-validate in production)
     * @return generated order_id, or -1 on failure
     */
    public int placeOrder(int userId, String itemsJson, String paymentJson,
                          String shippingJson, BigDecimal totalAmount) {

        Order order = new Order(userId, totalAmount, "pending",
                                itemsJson, paymentJson, shippingJson);
        return orderDAO.insertOrder(order);
    }
}
