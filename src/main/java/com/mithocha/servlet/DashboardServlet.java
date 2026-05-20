package com.mithocha.servlet;

import com.mithocha.dao.ProductDAO;
import com.mithocha.dao.impl.ProductDAOImpl;
import com.mithocha.model.Product;
import com.mithocha.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * DashboardServlet – serves the user home page at /dashboard.
 * Loads the first 3 available products from the DB and passes them
 * to home.jsp so the "Discover our blends" section is always live.
 */
@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!SessionUtil.isLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Load first 3 available products for the home page showcase
        List<Product> allProducts = productDAO.findAllAvailable();
        List<Product> featuredProducts = allProducts.size() > 3
                ? allProducts.subList(0, 3)
                : allProducts;

        request.setAttribute("featuredProducts", featuredProducts);
        request.getRequestDispatcher("/WEB-INF/views/user/home.jsp")
               .forward(request, response);
    }
}
