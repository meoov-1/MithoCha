package com.mithocha.model;

import java.sql.Timestamp;

/**
 * POJO for the `reviews` table.
 *
 * CREATE TABLE reviews (
 *   review_id  INT AUTO_INCREMENT PRIMARY KEY,
 *   user_id    INT,
 *   product_id INT,
 *   rating     INT CHECK (rating >= 1 AND rating <= 5),
 *   comment    TEXT,
 *   image_url  VARCHAR(500),
 *   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 *   FOREIGN KEY (user_id)    REFERENCES users(user_id)      ON DELETE CASCADE,
 *   FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE CASCADE
 * );
 */
public class Review {

    private int       reviewId;
    private int       userId;
    private int       productId;
    private int       rating;
    private String    comment;
    private String    imageUrl;
    private Timestamp createdAt;

    // ── Constructors ──────────────────────────────────────────────────────────

    public Review() {}

    /** Constructor for submitting a new review. */
    public Review(int userId, int productId, int rating, String comment, String imageUrl) {
        this.userId    = userId;
        this.productId = productId;
        this.rating    = rating;
        this.comment   = comment;
        this.imageUrl  = imageUrl;
    }

    /** Full constructor (used when reading from DB). */
    public Review(int reviewId, int userId, int productId, int rating,
                  String comment, String imageUrl, Timestamp createdAt) {
        this(userId, productId, rating, comment, imageUrl);
        this.reviewId  = reviewId;
        this.createdAt = createdAt;
    }

    // ── Getters & Setters ─────────────────────────────────────────────────────

    public int getReviewId()                         { return reviewId; }
    public void setReviewId(int reviewId)            { this.reviewId = reviewId; }

    public int getUserId()                           { return userId; }
    public void setUserId(int userId)                { this.userId = userId; }

    public int getProductId()                        { return productId; }
    public void setProductId(int productId)          { this.productId = productId; }

    public int getRating()                           { return rating; }
    public void setRating(int rating)                { this.rating = rating; }

    public String getComment()                       { return comment; }
    public void setComment(String comment)           { this.comment = comment; }

    public String getImageUrl()                      { return imageUrl; }
    public void setImageUrl(String imageUrl)         { this.imageUrl = imageUrl; }

    public Timestamp getCreatedAt()                  { return createdAt; }
    public void setCreatedAt(Timestamp createdAt)    { this.createdAt = createdAt; }

    @Override
    public String toString() {
        return "Review{reviewId=" + reviewId + ", userId=" + userId
                + ", productId=" + productId + ", rating=" + rating + "}";
    }
}
