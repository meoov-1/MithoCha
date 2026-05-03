package com.mithocha.dao;

import com.mithocha.model.Product;
import java.util.List;

/**
 * ProductDAO – contract for all product-related database operations.
 */
public interface ProductDAO {

    /** Insert a new product. Returns the generated product_id, or -1 on failure. */
    int insertProduct(Product product);

    /** Find a product by its primary key. */
    Product findById(int productId);

    /** Return all products. */
    List<Product> findAll();

    /** Return only available products. */
    List<Product> findAllAvailable();

    /** Return products filtered by category. */
    List<Product> findByCategory(String category);

    /** Return all distinct category names. */
    List<String> findAllCategories();

    /** Update all fields of an existing product. */
    boolean updateProduct(Product product);

    /** Toggle the is_available flag. */
    boolean setAvailability(int productId, boolean available);

    /** Delete a product by id. */
    boolean deleteProduct(int productId);
}
