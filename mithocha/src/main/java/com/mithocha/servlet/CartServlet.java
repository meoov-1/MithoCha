package com.mithocha.servlet;

import com.mithocha.dao.ProfileDAO;
import com.mithocha.dao.impl.ProfileDAOImpl;
import com.mithocha.model.User;
import com.mithocha.service.CartService;
import com.mithocha.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;

/**
 * CartServlet – serves the cart page and handles order placement.
 */
@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private final CartService cartService = new CartService();
    private final ProfileDAO profileDAO = new ProfileDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = SessionUtil.getUser(request);
        if (user != null) {
            request.setAttribute("user", user);
            request.setAttribute("profile", profileDAO.findByUserId(user.getUserId()));
        }

        request.getRequestDispatcher("/WEB-INF/views/user/cart.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        if (!SessionUtil.isLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = SessionUtil.getUser(request).getUserId();
        String itemsJson = request.getParameter("items");
        String paymentJson = request.getParameter("payment");
        String shippingJson = request.getParameter("shippingAddress");
        String totalAmountStr = request.getParameter("totalAmount");

        if (itemsJson == null || itemsJson.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Your cart is empty.");
            doGet(request, response);
            return;
        }

        BigDecimal totalAmount;
        try {
            totalAmount = new BigDecimal(totalAmountStr);
        } catch (NumberFormatException | NullPointerException e) {
            request.setAttribute("errorMessage", "Invalid order total.");
            doGet(request, response);
            return;
        }

        int orderId = cartService.placeOrder(userId, itemsJson, paymentJson,
                shippingJson, totalAmount);

        if (orderId > 0) {
            response.sendRedirect(request.getContextPath()
                    + "/profile?orderPlaced=true&orderId=" + orderId);
        } else {
            request.setAttribute("errorMessage", "Failed to place order. Please try again.");
            doGet(request, response);
        }
    }
}
