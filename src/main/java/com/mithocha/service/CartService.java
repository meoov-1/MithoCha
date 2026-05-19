package com.mithocha.service;

import com.mithocha.dao.CartDAO;
import com.mithocha.dao.OrderDAO;
import com.mithocha.dao.PaymentDAO;
import com.mithocha.dao.ProductDAO;
import com.mithocha.dao.impl.CartDAOImpl;
import com.mithocha.dao.impl.OrderDAOImpl;
import com.mithocha.dao.impl.PaymentDAOImpl;
import com.mithocha.dao.impl.ProductDAOImpl;
import com.mithocha.model.CartItem;
import com.mithocha.model.Order;
import com.mithocha.model.OrderItem;
import com.mithocha.model.Payment;
import com.mithocha.model.Product;
import com.mithocha.model.ProductSize;
import com.mithocha.model.ProductTopping;
import com.mithocha.util.DBUtil;
import com.mithocha.util.JsonUtil;
import com.mithocha.util.ValidationUtil;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * CartService – server-side cart and checkout business logic.
 */
public class CartService {

    private final CartDAO cartDAO = new CartDAOImpl();
    private final ProductDAO productDAO = new ProductDAOImpl();
    private final OrderDAO orderDAO = new OrderDAOImpl();
    private final PaymentDAO paymentDAO = new PaymentDAOImpl();

    /**
     * Legacy checkout helper used by the existing JSP flow.
     */
    public int placeOrder(int userId, String itemsJson, String paymentJson,
                          String shippingJson, BigDecimal totalAmount) {

        Order order = new Order(userId, totalAmount, "pending",
                itemsJson, paymentJson, shippingJson);
        return orderDAO.insertOrder(order);
    }

    public List<CartItem> getCart(int userId) {
        return cartDAO.findByUserId(userId);
    }

    public CartItem addCartItem(int userId, int productId, Integer sizeId, List<Integer> toppingIds, int quantity) {
        CartItem cartItem = buildCartItem(userId, productId, sizeId, toppingIds, quantity);
        int cartItemId = cartDAO.insertCartItem(cartItem);
        if (cartItemId <= 0) {
            return null;
        }
        return cartDAO.findById(userId, cartItemId);
    }

    public CartItem updateCartItem(int userId, int cartItemId, Integer sizeId, List<Integer> toppingIds, int quantity) {
        CartItem existing = cartDAO.findById(userId, cartItemId);
        if (existing == null) {
            return null;
        }

        CartItem updated = buildCartItem(userId, existing.getProductId(), sizeId, toppingIds, quantity);
        updated.setCartItemId(cartItemId);
        if (!cartDAO.updateCartItem(updated)) {
            return null;
        }
        return cartDAO.findById(userId, cartItemId);
    }

    public boolean removeCartItem(int userId, int cartItemId) {
        return cartDAO.deleteCartItem(userId, cartItemId);
    }

    public boolean clearCart(int userId) {
        return cartDAO.clearCart(userId);
    }

    public Order checkout(int userId, String shippingAddress, String paymentMethod,
                          String transactionId, String paymentStatus) {
        List<CartItem> cartItems = cartDAO.findByUserId(userId);
        if (cartItems.isEmpty()) {
            return null;
        }

        String normalisedStatus = ValidationUtil.isNullOrEmpty(paymentStatus)
                ? "paid"
                : paymentStatus.trim().toLowerCase();
        if (!ValidationUtil.isValidOrderStatus(normalisedStatus)) {
            throw new IllegalArgumentException("Invalid payment status.");
        }
        if (ValidationUtil.isNullOrEmpty(paymentMethod) || ValidationUtil.isNullOrEmpty(transactionId)) {
            throw new IllegalArgumentException("Payment method and transaction ID are required.");
        }

        BigDecimal total = cartItems.stream()
                .map(CartItem::getItemTotal)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        List<OrderItem> orderItems = new ArrayList<>();
        for (CartItem cartItem : cartItems) {
            orderItems.add(toOrderItem(cartItem));
        }

        Payment payment = new Payment(0, transactionId.trim(), normalisedStatus, total, paymentMethod.trim());
        Order order = new Order(userId, total, "pending", null, null, shippingAddress);
        order.setOrderItems(orderItems);
        order.setPaymentRecord(payment);

        try (Connection conn = DBUtil.getConnection()) {
            conn.setAutoCommit(false);

            OrderDAOImpl orderDAOImpl = (OrderDAOImpl) orderDAO;
            PaymentDAOImpl paymentDAOImpl = (PaymentDAOImpl) paymentDAO;

            int orderId = orderDAOImpl.insertOrder(conn, order);
            if (orderId <= 0) {
                conn.rollback();
                return null;
            }

            orderDAOImpl.insertOrderItems(conn, orderId, orderItems);

            payment.setOrderId(orderId);
            int paymentId = paymentDAOImpl.insertPayment(conn, payment);
            if (paymentId <= 0) {
                conn.rollback();
                return null;
            }
            payment.setPaymentId(paymentId);

            String snapshotPaymentJson = JsonUtil.toJson(payment);
            String snapshotItemsJson = JsonUtil.toJson(orderItems);
            orderDAOImpl.updateSnapshots(conn, orderId, snapshotItemsJson, snapshotPaymentJson, shippingAddress);

            if ("paid".equals(normalisedStatus)) {
                orderDAOImpl.updateStatus(conn, orderId, "paid");
                clearCart(conn, userId);
            }

            conn.commit();
            return orderDAO.findById(orderId);
        } catch (SQLException e) {
            throw new IllegalStateException("Checkout failed.", e);
        }
    }

    private CartItem buildCartItem(int userId, int productId, Integer sizeId, List<Integer> toppingIds, int quantity) {
        if (!ValidationUtil.isPositiveInt(quantity)) {
            throw new IllegalArgumentException("Quantity must be greater than zero.");
        }

        Product product = productDAO.findById(productId);
        if (product == null || !product.isAvailable()) {
            throw new IllegalArgumentException("Selected product is not available.");
        }

        ProductSize selectedSize = null;
        BigDecimal sizeExtra = BigDecimal.ZERO;
        if (sizeId != null) {
            selectedSize = productDAO.findSizeById(sizeId);
            if (selectedSize == null || selectedSize.getProductId() != productId) {
                throw new IllegalArgumentException("Selected size does not belong to the product.");
            }
            sizeExtra = defaultAmount(selectedSize.getPriceModifier());
        }

        List<Integer> safeToppingIds = toppingIds == null ? Collections.emptyList() : new ArrayList<>(toppingIds);
        List<ProductTopping> toppings = safeToppingIds.isEmpty()
                ? Collections.emptyList()
                : productDAO.findToppingsByIds(safeToppingIds);
        if (toppings.size() != safeToppingIds.size()) {
            throw new IllegalArgumentException("One or more selected toppings are invalid.");
        }
        for (ProductTopping topping : toppings) {
            if (topping.getProductId() != productId) {
                throw new IllegalArgumentException("Selected toppings must belong to the same product.");
            }
        }

        BigDecimal toppingsTotal = toppings.stream()
                .map(ProductTopping::getPriceModifier)
                .map(this::defaultAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        BigDecimal unitPrice = defaultAmount(product.getBasePrice())
                .add(sizeExtra)
                .add(toppingsTotal);
        BigDecimal itemTotal = unitPrice.multiply(BigDecimal.valueOf(quantity));

        CartItem cartItem = new CartItem();
        cartItem.setUserId(userId);
        cartItem.setProductId(productId);
        cartItem.setProduct(product);
        cartItem.setProductSizeId(sizeId);
        cartItem.setSelectedSize(selectedSize);
        cartItem.setSelectedToppings(toppings);
        cartItem.setSelectedToppingIdsJson(JsonUtil.toJson(safeToppingIds));
        cartItem.setSelectedToppingsJson(JsonUtil.toJson(toppings));
        cartItem.setQuantity(quantity);
        cartItem.setUnitPrice(unitPrice);
        cartItem.setItemTotal(itemTotal);
        return cartItem;
    }

    private OrderItem toOrderItem(CartItem cartItem) {
        OrderItem orderItem = new OrderItem();
        orderItem.setProductId(cartItem.getProductId());
        orderItem.setProductName(cartItem.getProduct() != null ? cartItem.getProduct().getName() : null);
        orderItem.setProductSizeId(cartItem.getProductSizeId());
        orderItem.setSizeName(cartItem.getSelectedSize() != null ? cartItem.getSelectedSize().getName() : null);
        orderItem.setSelectedToppingIdsJson(cartItem.getSelectedToppingIdsJson());
        orderItem.setSelectedToppings(cartItem.getSelectedToppings());
        orderItem.setSelectedToppingsJson(cartItem.getSelectedToppingsJson());
        orderItem.setQuantity(cartItem.getQuantity());
        orderItem.setUnitPrice(cartItem.getUnitPrice());
        orderItem.setItemTotal(cartItem.getItemTotal());
        return orderItem;
    }

    private void clearCart(Connection conn, int userId) throws SQLException {
        try (PreparedStatement ps = conn.prepareStatement("DELETE FROM cart_items WHERE user_id = ?")) {
            ps.setInt(1, userId);
            ps.executeUpdate();
        }
    }

    private BigDecimal defaultAmount(BigDecimal value) {
        return value == null ? BigDecimal.ZERO : value;
    }
}
