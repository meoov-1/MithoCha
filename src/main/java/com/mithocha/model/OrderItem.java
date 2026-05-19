package com.mithocha.model;

import com.mithocha.util.JsonUtil;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class OrderItem {

    private int orderItemId;
    private int orderId;
    private Integer productId;
    private String productName;
    private Integer productSizeId;
    private String sizeName;
    private List<ProductTopping> selectedToppings = new ArrayList<>();
    private String selectedToppingIdsJson;
    private String selectedToppingsJson;
    private int quantity;
    private BigDecimal unitPrice;
    private BigDecimal itemTotal;

    public int getOrderItemId() {
        return orderItemId;
    }

    public void setOrderItemId(int orderItemId) {
        this.orderItemId = orderItemId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Integer getProductSizeId() {
        return productSizeId;
    }

    public void setProductSizeId(Integer productSizeId) {
        this.productSizeId = productSizeId;
    }

    public String getSizeName() {
        return sizeName;
    }

    public void setSizeName(String sizeName) {
        this.sizeName = sizeName;
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
}
