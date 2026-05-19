package com.mithocha.model;

import com.mithocha.util.JsonUtil;
import com.mithocha.util.ValidationUtil;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Base64;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

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
    private byte[]     imageData;
    private String     imageContentType;
    private List<ProductSize>    sizeOptions    = new ArrayList<>();
    private List<ProductTopping> toppingOptions = new ArrayList<>();

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

    public String getImageUrl() {
        if (!ValidationUtil.isNullOrEmpty(imageUrl)) {
            return imageUrl;
        }
        if (imageData != null && imageData.length > 0
                && !ValidationUtil.isNullOrEmpty(imageContentType)) {
            return "data:" + imageContentType + ";base64,"
                    + Base64.getEncoder().encodeToString(imageData);
        }
        return null;
    }
    public void setImageUrl(String imageUrl)             { this.imageUrl = imageUrl; }
    public String getStoredImageUrl()                    { return imageUrl; }

    public String getAdditionalImages()                          { return additionalImages; }
    public void setAdditionalImages(String additionalImages)     { this.additionalImages = additionalImages; }

    public String getCategory()                          { return category; }
    public void setCategory(String category)             { this.category = category; }

    public boolean isAvailable()                         { return isAvailable; }
    public void setAvailable(boolean available)          { isAvailable = available; }

    public String getSizes() {
        if (!ValidationUtil.isNullOrEmpty(sizes)) {
            return sizes;
        }
        if (!sizeOptions.isEmpty()) {
            return JsonUtil.toJson(toSizeSnapshot(sizeOptions));
        }
        return sizes;
    }
    public void setSizes(String sizes)                   { this.sizes = sizes; }

    public String getFlavours()                          { return flavours; }
    public void setFlavours(String flavours)             { this.flavours = flavours; }

    public String getToppings() {
        if (!ValidationUtil.isNullOrEmpty(toppings)) {
            return toppings;
        }
        if (!toppingOptions.isEmpty()) {
            return JsonUtil.toJson(toToppingSnapshot(toppingOptions));
        }
        return toppings;
    }
    public void setToppings(String toppings)             { this.toppings = toppings; }

    public BigDecimal getBasePrice()                     { return basePrice; }
    public void setBasePrice(BigDecimal basePrice)       { this.basePrice = basePrice; }

    public byte[] getImageData()                         { return imageData; }
    public void setImageData(byte[] imageData)           { this.imageData = imageData; }

    public String getImageContentType()                  { return imageContentType; }
    public void setImageContentType(String imageContentType) { this.imageContentType = imageContentType; }

    public List<ProductSize> getSizeOptions()            { return sizeOptions; }
    public void setSizeOptions(List<ProductSize> sizeOptions) {
        this.sizeOptions = sizeOptions == null ? new ArrayList<>() : new ArrayList<>(sizeOptions);
        this.sizes = this.sizeOptions.isEmpty() ? this.sizes : JsonUtil.toJson(toSizeSnapshot(this.sizeOptions));
    }

    public List<ProductTopping> getToppingOptions()      { return toppingOptions; }
    public void setToppingOptions(List<ProductTopping> toppingOptions) {
        this.toppingOptions = toppingOptions == null ? new ArrayList<>() : new ArrayList<>(toppingOptions);
        this.toppings = this.toppingOptions.isEmpty() ? this.toppings : JsonUtil.toJson(toToppingSnapshot(this.toppingOptions));
    }

    @Override
    public String toString() {
        return "Product{productId=" + productId + ", name='" + name
                + "', category='" + category + "', basePrice=" + basePrice + "}";
    }

    private List<Map<String, Object>> toSizeSnapshot(List<ProductSize> options) {
        List<Map<String, Object>> snapshot = new ArrayList<>();
        for (ProductSize option : options) {
            Map<String, Object> entry = new LinkedHashMap<>();
            entry.put("label", option.getName());
            entry.put("value", option.getName());
            entry.put("extra", option.getPriceModifier());
            entry.put("meta", option.getPriceModifier() != null && option.getPriceModifier().compareTo(BigDecimal.ZERO) > 0
                    ? "Add Rs. " + option.getPriceModifier().stripTrailingZeros().toPlainString()
                    : "Included");
            snapshot.add(entry);
        }
        return snapshot;
    }

    private List<Map<String, Object>> toToppingSnapshot(List<ProductTopping> options) {
        List<Map<String, Object>> snapshot = new ArrayList<>();
        for (ProductTopping option : options) {
            Map<String, Object> entry = new LinkedHashMap<>();
            entry.put("label", option.getName());
            entry.put("value", option.getName());
            entry.put("extra", option.getPriceModifier());
            entry.put("meta", option.getPriceModifier() != null && option.getPriceModifier().compareTo(BigDecimal.ZERO) > 0
                    ? "Add Rs. " + option.getPriceModifier().stripTrailingZeros().toPlainString()
                    : "Included");
            snapshot.add(entry);
        }
        return snapshot;
    }
}
