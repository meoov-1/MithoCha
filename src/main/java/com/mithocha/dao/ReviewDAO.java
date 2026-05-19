package com.mithocha.dao;

import com.mithocha.model.Review;
import java.util.List;

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

    /** Delete a review by id. */
    boolean deleteReview(int reviewId);
}
