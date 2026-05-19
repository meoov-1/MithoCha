package com.mithocha.model;

import java.math.BigDecimal;

public class ProductTopping {

    private int toppingId;
    private int productId;
    private String name;
    private BigDecimal priceModifier;
    private boolean available = true;

    public ProductTopping() {}

    public ProductTopping(int productId, String name, BigDecimal priceModifier, boolean available) {
        this.productId = productId;
        this.name = name;
        this.priceModifier = priceModifier;
        this.available = available;
    }

    public ProductTopping(int toppingId, int productId, String name, BigDecimal priceModifier, boolean available) {
        this(productId, name, priceModifier, available);
        this.toppingId = toppingId;
    }

    public int getToppingId() {
        return toppingId;
    }

    public void setToppingId(int toppingId) {
        this.toppingId = toppingId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getPriceModifier() {
        return priceModifier;
    }

    public void setPriceModifier(BigDecimal priceModifier) {
        this.priceModifier = priceModifier;
    }

    public boolean isAvailable() {
        return available;
    }

    public void setAvailable(boolean available) {
        this.available = available;
    }
}
