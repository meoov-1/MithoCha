package com.mithocha.dao;

import java.util.List;

import com.mithocha.model.Review;

/**
 * ReviewDAO – contract for all review-related database operations.
 */
public interface ReviewDAO {

    /** Insert a new review. Returns the generated review_id, or -1 on failure. */
    int insertReview(Review review);

    /** Return all reviews for a specific product. */
    List<Review> findByProductId(int productId);

    /** Return all reviews written by a specific user. */
    List<Review> findByUserId(int userId);

    /** Return every review in the system. */
    List<Review> findAll();

    /** Delete a review by id. */
    boolean deleteReview(int reviewId);
}
