package com.mithocha.dao;

/**
 * CartDAO – the cart is managed client-side (localStorage / session JSON)
 * and is only persisted when an order is placed.
 *
 * This interface is intentionally minimal; extend it if you later add a
 * server-side `cart` table.
 */
public interface CartDAO {
    // Reserved for future server-side cart persistence.
}
