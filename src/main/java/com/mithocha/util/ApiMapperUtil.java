package com.mithocha.util;

import com.mithocha.model.CartItem;
import com.mithocha.model.Order;
import com.mithocha.model.OrderItem;
import com.mithocha.model.Payment;
import com.mithocha.model.Product;
import com.mithocha.model.ProductSize;
import com.mithocha.model.ProductTopping;
import com.mithocha.model.Profile;
import com.mithocha.model.User;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * ApiMapperUtil – turns models into API-friendly response maps.
 */
public final class ApiMapperUtil {

    private ApiMapperUtil() {}

    public static Map<String, Object> toUserProfile(User user, Profile profile) {
        Map<String, Object> data = new LinkedHashMap<>();
        data.put("userId", user.getUserId());
        data.put("name", user.getName());
        data.put("email", user.getEmail());
        data.put("role", user.getRole());
        data.put("createdAt", user.getCreatedAt());

        Map<String, Object> profileData = new LinkedHashMap<>();
        if (profile != null) {
            profileData.put("phone", profile.getPhone());
            profileData.put("address", profile.getAddress());
            profileData.put("city", profile.getCity());
            profileData.put("postalCode", profile.getPostalCode());
            profileData.put("bio", profile.getBio());
            profileData.put("dateOfBirth", profile.getDateOfBirth());
            profileData.put("profileImageUrl", profile.getProfileImageUrl());
        } else {
            profileData.put("phone", null);
            profileData.put("address", null);
            profileData.put("city", null);
            profileData.put("postalCode", null);
            profileData.put("bio", null);
            profileData.put("dateOfBirth", null);
            profileData.put("profileImageUrl", null);
        }
        data.put("profile", profileData);
        return data;
    }

    public static Map<String, Object> toProduct(Product product, boolean detailed) {
        Map<String, Object> data = new LinkedHashMap<>();
        data.put("productId", product.getProductId());
        data.put("name", product.getName());
        data.put("description", product.getDescription());
        data.put("category", product.getCategory());
        data.put("basePrice", product.getBasePrice());
        data.put("imageUrl", product.getImageUrl());
        data.put("available", product.isAvailable());

        if (detailed) {
            data.put("sizes", toSizeList(product.getSizeOptions()));
            data.put("toppings", toToppingList(product.getToppingOptions()));
            data.put("flavours", product.getFlavours());
            data.put("additionalImages", product.getAdditionalImages());
        }
        return data;
    }

    public static Map<String, Object> toCart(CartItem cartItem) {
        Map<String, Object> data = new LinkedHashMap<>();
        data.put("cartItemId", cartItem.getCartItemId());
        data.put("quantity", cartItem.getQuantity());
        data.put("unitPrice", cartItem.getUnitPrice());
        data.put("itemTotal", cartItem.getItemTotal());
        data.put("product", cartItem.getProduct() == null ? null : toProduct(cartItem.getProduct(), false));
        data.put("selectedSize", cartItem.getSelectedSize() == null ? null : toSize(cartItem.getSelectedSize()));
        data.put("selectedToppings", toToppingList(cartItem.getSelectedToppings()));
        data.put("createdAt", cartItem.getCreatedAt());
        data.put("updatedAt", cartItem.getUpdatedAt());
        return data;
    }

    public static Map<String, Object> toOrder(Order order) {
        Map<String, Object> data = new LinkedHashMap<>();
        data.put("orderId", order.getOrderId());
        data.put("userId", order.getUserId());
        data.put("totalAmount", order.getTotalAmount());
        data.put("status", order.getStatus());
        data.put("orderDate", order.getOrderDate());
        data.put("shippingAddress", order.getShippingAddress());

        List<Map<String, Object>> itemMaps = new ArrayList<>();
        for (OrderItem item : order.getOrderItems()) {
            itemMaps.add(toOrderItem(item));
        }
        data.put("items", itemMaps);
        data.put("payment", order.getPaymentRecord() == null ? null : toPayment(order.getPaymentRecord()));
        return data;
    }

    public static Map<String, Object> toPayment(Payment payment) {
        Map<String, Object> data = new LinkedHashMap<>();
        data.put("paymentId", payment.getPaymentId());
        data.put("orderId", payment.getOrderId());
        data.put("transactionId", payment.getTransactionId());
        data.put("status", payment.getStatus());
        data.put("amount", payment.getAmount());
        data.put("method", payment.getMethod());
        data.put("createdAt", payment.getCreatedAt());
        return data;
    }

    public static BigDecimal cartTotal(List<CartItem> items) {
        return items.stream()
                .map(CartItem::getItemTotal)
                .filter(value -> value != null)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    public static Map<String, Object> toOrderItem(OrderItem item) {
        Map<String, Object> data = new LinkedHashMap<>();
        data.put("orderItemId", item.getOrderItemId());
        data.put("productId", item.getProductId());
        data.put("productName", item.getProductName());
        data.put("size", item.getSizeName());
        data.put("quantity", item.getQuantity());
        data.put("unitPrice", item.getUnitPrice());
        data.put("itemTotal", item.getItemTotal());
        data.put("selectedToppings", toToppingList(item.getSelectedToppings()));
        return data;
    }

    public static Map<String, Object> toSize(ProductSize size) {
        Map<String, Object> data = new LinkedHashMap<>();
        data.put("sizeId", size.getSizeId());
        data.put("name", size.getName());
        data.put("priceModifier", size.getPriceModifier());
        data.put("displayOrder", size.getDisplayOrder());
        return data;
    }

    public static List<Map<String, Object>> toSizeList(List<ProductSize> sizes) {
        List<Map<String, Object>> items = new ArrayList<>();
        if (sizes == null) {
            return items;
        }
        for (ProductSize size : sizes) {
            items.add(toSize(size));
        }
        return items;
    }

    public static Map<String, Object> toTopping(ProductTopping topping) {
        Map<String, Object> data = new LinkedHashMap<>();
        data.put("toppingId", topping.getToppingId());
        data.put("name", topping.getName());
        data.put("priceModifier", topping.getPriceModifier());
        data.put("available", topping.isAvailable());
        return data;
    }

    public static List<Map<String, Object>> toToppingList(List<ProductTopping> toppings) {
        List<Map<String, Object>> items = new ArrayList<>();
        if (toppings == null) {
            return items;
        }
        for (ProductTopping topping : toppings) {
            items.add(toTopping(topping));
        }
        return items;
    }
}
