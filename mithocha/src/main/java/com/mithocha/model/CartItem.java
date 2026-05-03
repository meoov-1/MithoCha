package com.mithocha.model;

import com.mithocha.util.JsonUtil;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class CartItem {

    private int cartItemId;
    private int userId;
    private int productId;
    private Product product;
    private Integer productSizeId;
    private ProductSize selectedSize;
    private List<ProductTopping> selectedToppings = new ArrayList<>();
    private String selectedToppingIdsJson;
    private String selectedToppingsJson;
    private int quantity;
    private BigDecimal unitPrice;
    private BigDecimal itemTotal;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public int getCartItemId() {
        return cartItemId;
    }

    public void setCartItemId(int cartItemId) {
        this.cartItemId = cartItemId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public Integer getProductSizeId() {
        return productSizeId;
    }

    public void setProductSizeId(Integer productSizeId) {
        this.productSizeId = productSizeId;
    }

    public ProductSize getSelectedSize() {
        return selectedSize;
    }

    public void setSelectedSize(ProductSize selectedSize) {
        this.selectedSize = selectedSize;
    }

    public List<ProductTopping> getSelectedToppings() {
        return selectedToppings;
    }

    public void setSelectedToppings(List<ProductTopping> selectedToppings) {
        this.selectedToppings = selectedToppings == null ? new ArrayList<>() : new ArrayList<>(selectedToppings);
    }

    public String getSelectedToppingIdsJson() {
        return selectedToppingIdsJson;
    }

    public void setSelectedToppingIdsJson(String selectedToppingIdsJson) {
        this.selectedToppingIdsJson = selectedToppingIdsJson;
    }

    public String getSelectedToppingsJson() {
        if (selectedToppingsJson != null) {
            return selectedToppingsJson;
        }
        return selectedToppings.isEmpty() ? null : JsonUtil.toJson(selectedToppings);
    }

    public void setSelectedToppingsJson(String selectedToppingsJson) {
        this.selectedToppingsJson = selectedToppingsJson;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    public BigDecimal getItemTotal() {
        return itemTotal;
    }

    public void setItemTotal(BigDecimal itemTotal) {
        this.itemTotal = itemTotal;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
}
