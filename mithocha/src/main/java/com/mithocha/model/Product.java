package com.mithocha.model;

import java.math.BigDecimal;

/**
 * POJO for the `product` table.
 *
 * CREATE TABLE product (
 *   product_id        INT AUTO_INCREMENT PRIMARY KEY,
 *   name              VARCHAR(100) NOT NULL,
 *   description       TEXT,
 *   image_url         VARCHAR(500),
 *   additional_images JSON,
 *   category          VARCHAR(50),
 *   is_available      BOOLEAN DEFAULT TRUE,
 *   sizes             JSON,
 *   flavours          JSON,
 *   toppings          JSON,
 *   base_price        DECIMAL(10,2) DEFAULT 0
 * );
 *
 * JSON columns are stored/retrieved as raw String values.
 * Parse them with a JSON library (e.g. Gson) in the service/servlet layer.
 */
public class Product {

    private int        productId;
    private String     name;
    private String     description;
    private String     imageUrl;
    private String     additionalImages; // raw JSON string
    private String     category;
    private boolean    isAvailable;
    private String     sizes;            // raw JSON string
    private String     flavours;         // raw JSON string
    private String     toppings;         // raw JSON string
    private BigDecimal basePrice;

    // ── Constructors ──────────────────────────────────────────────────────────

    public Product() {}

    /** Constructor for creating a new product (no id yet). */
    public Product(String name, String description, String imageUrl,
                   String additionalImages, String category, boolean isAvailable,
                   String sizes, String flavours, String toppings, BigDecimal basePrice) {
        this.name             = name;
        this.description      = description;
        this.imageUrl         = imageUrl;
        this.additionalImages = additionalImages;
        this.category         = category;
        this.isAvailable      = isAvailable;
        this.sizes            = sizes;
        this.flavours         = flavours;
        this.toppings         = toppings;
        this.basePrice        = basePrice;
    }

    /** Full constructor (used when reading from DB). */
    public Product(int productId, String name, String description, String imageUrl,
                   String additionalImages, String category, boolean isAvailable,
                   String sizes, String flavours, String toppings, BigDecimal basePrice) {
        this(name, description, imageUrl, additionalImages, category,
             isAvailable, sizes, flavours, toppings, basePrice);
        this.productId = productId;
    }

    // ── Getters & Setters ─────────────────────────────────────────────────────

    public int getProductId()                            { return productId; }
    public void setProductId(int productId)              { this.productId = productId; }

    public String getName()                              { return name; }
    public void setName(String name)                     { this.name = name; }

    public String getDescription()                       { return description; }
    public void setDescription(String description)       { this.description = description; }

    public String getImageUrl()                          { return imageUrl; }
    public void setImageUrl(String imageUrl)             { this.imageUrl = imageUrl; }

    public String getAdditionalImages()                          { return additionalImages; }
    public void setAdditionalImages(String additionalImages)     { this.additionalImages = additionalImages; }

    public String getCategory()                          { return category; }
    public void setCategory(String category)             { this.category = category; }

    public boolean isAvailable()                         { return isAvailable; }
    public void setAvailable(boolean available)          { isAvailable = available; }

    public String getSizes()                             { return sizes; }
    public void setSizes(String sizes)                   { this.sizes = sizes; }

    public String getFlavours()                          { return flavours; }
    public void setFlavours(String flavours)             { this.flavours = flavours; }

    public String getToppings()                          { return toppings; }
    public void setToppings(String toppings)             { this.toppings = toppings; }

    public BigDecimal getBasePrice()                     { return basePrice; }
    public void setBasePrice(BigDecimal basePrice)       { this.basePrice = basePrice; }

    @Override
    public String toString() {
        return "Product{productId=" + productId + ", name='" + name
                + "', category='" + category + "', basePrice=" + basePrice + "}";
    }
}
