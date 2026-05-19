package com.mithocha.model;

/**
 * Category is a logical grouping derived from the `product.category` column.
 * The database does not have a separate category table, so this POJO is used
 * as a lightweight value object when building category filter lists in the UI.
 */
public class Category {

    private String name;
    private int    productCount;

    // ── Constructors ──────────────────────────────────────────────────────────

    public Category() {}

    public Category(String name) {
        this.name = name;
    }

    public Category(String name, int productCount) {
        this.name         = name;
        this.productCount = productCount;
    }

    // ── Getters & Setters ─────────────────────────────────────────────────────

    public String getName()                      { return name; }
    public void setName(String name)             { this.name = name; }

    public int getProductCount()                         { return productCount; }
    public void setProductCount(int productCount)        { this.productCount = productCount; }

    @Override
    public String toString() {
        return "Category{name='" + name + "', productCount=" + productCount + "}";
    }
}
