package com.mithocha.model;

import java.math.BigDecimal;

public class ProductSize {

    private int sizeId;
    private int productId;
    private String name;
    private BigDecimal priceModifier;
    private int displayOrder;

    public ProductSize() {}

    public ProductSize(int productId, String name, BigDecimal priceModifier, int displayOrder) {
        this.productId = productId;
        this.name = name;
        this.priceModifier = priceModifier;
        this.displayOrder = displayOrder;
    }

    public ProductSize(int sizeId, int productId, String name, BigDecimal priceModifier, int displayOrder) {
        this(productId, name, priceModifier, displayOrder);
        this.sizeId = sizeId;
    }

    public int getSizeId() {
        return sizeId;
    }

    public void setSizeId(int sizeId) {
        this.sizeId = sizeId;
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

    public int getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(int displayOrder) {
        this.displayOrder = displayOrder;
    }
}
