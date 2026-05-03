package com.mithocha.servlet;

import com.mithocha.dao.ProductDAO;
import com.mithocha.dao.ReviewDAO;
import com.mithocha.dao.impl.ProductDAOImpl;
import com.mithocha.dao.impl.ReviewDAOImpl;
import com.mithocha.model.Product;
import com.mithocha.model.Review;
import com.mithocha.util.SessionUtil;
import com.mithocha.util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

/**
 * ProductServlet – serves the product listing and product-detail pages,
 * and handles admin CRUD for products.
 *
 * URL mappings:
 *   GET  /products                → product listing (all available products)
 *   GET  /product-detail?id=X    → single product detail page
 *   POST /products                → admin: add new product
 *   POST /product-detail?action=delete&id=X  → admin: delete product
 *   POST /product-detail?action=review       → customer: submit review
 *
 * ── Frontend form mapping ──────────────────────────────────────────────────
 *
 * PRODUCT LISTING (products.jsp)
 *   Each "Order" button links to:
 *     /product-detail?id={productId}
 *
 * PRODUCT DETAIL (product-detail.jsp)
 *   Review form:
 *   <form method="post" action="${pageContext.request.contextPath}/product-detail?action=review">
 *     <input  name="productId" type="hidden" value="${product.productId}">
 *     <input  name="rating"    type="number" min="1" max="5">
 *     <textarea name="comment"></textarea>
 *     <input  name="imageUrl"  type="text">
 *   </form>
 */
@WebServlet(urlPatterns = {"/products", "/product-detail"})
public class ProductServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAOImpl();
    private final ReviewDAO  reviewDAO  = new ReviewDAOImpl();

    // ── GET ───────────────────────────────────────────────────────────────────

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/products".equals(path)) {
            showProductList(request, response);
        } else if ("/product-detail".equals(path)) {
            showProductDetail(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    // ── POST ──────────────────────────────────────────────────────────────────

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if ("review".equals(action)) {
            handleSubmitReview(request, response);
        } else if ("toggle".equals(action)) {
            handleToggleProduct(request, response);
        } else if ("add".equals(action)) {
            handleAddProduct(request, response);
        } else if ("delete".equals(action)) {
            handleDeleteProduct(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unknown action");
        }
    }

    // ── HANDLERS ──────────────────────────────────────────────────────────────

    private void showProductList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String category = request.getParameter("category");
        List<Product> products;

        if (category != null && !category.trim().isEmpty()) {
            products = productDAO.findByCategory(category.trim());
            request.setAttribute("selectedCategory", category.trim());
        } else {
            products = productDAO.findAllAvailable();
        }

        List<String> categories = productDAO.findAllCategories();
        request.setAttribute("products",   products);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/WEB-INF/views/user/products.jsp")
               .forward(request, response);
    }

    private void showProductDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }

        try {
            int productId = Integer.parseInt(idParam);
            Product product = productDAO.findById(productId);
            if (product == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
                return;
            }
            List<Review> reviews = reviewDAO.findByProductId(productId);
            request.setAttribute("product", product);
            request.setAttribute("reviews", reviews);
            request.getRequestDispatcher("/WEB-INF/views/user/product-detail.jsp")
                   .forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/products");
        }
    }

    private void handleSubmitReview(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        if (!SessionUtil.isLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId    = SessionUtil.getUser(request).getUserId();
        String pidStr = request.getParameter("productId");
        String rStr   = request.getParameter("rating");
        String comment = request.getParameter("comment");
        String imageUrl = request.getParameter("imageUrl");

        try {
            int productId = Integer.parseInt(pidStr);
            int rating    = Integer.parseInt(rStr);

            if (!ValidationUtil.isValidRating(rating)) {
                response.sendRedirect(request.getContextPath()
                        + "/product-detail?id=" + productId + "&error=rating");
                return;
            }

            Review review = new Review(userId, productId, rating, comment, imageUrl);
            reviewDAO.insertReview(review);
            response.sendRedirect(request.getContextPath()
                    + "/product-detail?id=" + productId + "&reviewed=true");

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/products");
        }
    }

    private void handleToggleProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        if (!SessionUtil.isAdmin(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            com.mithocha.model.Product p = productDAO.findById(productId);
            if (p != null) {
                productDAO.setAvailability(productId, !p.isAvailable());
            }
        } catch (NumberFormatException ignored) {}

        response.sendRedirect(request.getContextPath() + "/admin/menu");
    }

    private void handleAddProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        if (!SessionUtil.isAdmin(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        Product product = new Product(
            request.getParameter("name"),
            request.getParameter("description"),
            request.getParameter("imageUrl"),
            request.getParameter("additionalImages"),
            request.getParameter("category"),
            "true".equals(request.getParameter("isAvailable")),
            request.getParameter("sizes"),
            request.getParameter("flavours"),
            request.getParameter("toppings"),
            new BigDecimal(request.getParameter("basePrice"))
        );

        productDAO.insertProduct(product);
        response.sendRedirect(request.getContextPath() + "/admin/menu");
    }

    private void handleDeleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        if (!SessionUtil.isAdmin(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        try {
            int productId = Integer.parseInt(request.getParameter("id"));
            productDAO.deleteProduct(productId);
        } catch (NumberFormatException ignored) {}

        response.sendRedirect(request.getContextPath() + "/admin/menu");
    }
}
