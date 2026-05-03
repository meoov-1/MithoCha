package com.mithocha.dao;

import com.mithocha.model.CartItem;

import java.util.List;

/**
 * CartDAO – contract for server-side cart persistence.
 */
public interface CartDAO {

    int insertCartItem(CartItem cartItem);

    CartItem findById(int userId, int cartItemId);

    List<CartItem> findByUserId(int userId);

    boolean updateCartItem(CartItem cartItem);

    boolean deleteCartItem(int userId, int cartItemId);

    boolean clearCart(int userId);
}
