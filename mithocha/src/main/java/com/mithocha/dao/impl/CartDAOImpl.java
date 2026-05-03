package com.mithocha.dao.impl;

import com.mithocha.dao.CartDAO;

/**
 * CartDAOImpl – the cart is managed client-side (localStorage / session JSON).
 * It is only persisted to the `orders` table when the user confirms checkout.
 *
 * Extend this class if a server-side `cart` table is added in the future.
 */
public class CartDAOImpl implements CartDAO {
    // No server-side cart table in the current schema.
    // Cart data flows: localStorage → CartServlet (session) → OrderDAOImpl.insertOrder()
}
