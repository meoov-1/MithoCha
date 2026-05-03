package com.mithocha.servlet;

import com.mithocha.dao.OrderDAO;
import com.mithocha.dao.impl.OrderDAOImpl;
import com.mithocha.model.Order;
import com.mithocha.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * OrderServlet – lets customers view their order history and admins manage orders.
 *
 * URL mappings:
 *   GET  /orders              → customer: list own orders
 *   GET  /orders?id=X         → customer: view single order detail
 *   POST /orders?action=updateStatus  → admin: change order status
 *   POST /orders?action=delete        → admin: delete order
 *
 * ── Frontend form mapping ──────────────────────────────────────────────────
 *
 * STATUS UPDATE (admin ordermanagement.jsp):
 *   <form method="post" action="${pageContext.request.contextPath}/orders?action=updateStatus">
 *     <input type="hidden" name="orderId" value="${order.orderId}">
 *     <select name="status">
 *       <option value="pending">Pending</option>
 *       <option value="completed">Completed</option>
 *       <option value="cancelled">Cancelled</option>
 *     </select>
 *   </form>
 */
@WebServlet("/orders")
public class OrderServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAOImpl();

    // ── GET ───────────────────────────────────────────────────────────────────

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!SessionUtil.isLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String idParam = request.getParameter("id");

        if (idParam != null) {
            // Single order detail
            try {
                int orderId = Integer.parseInt(idParam);
                Order order = orderDAO.findById(orderId);

                // Security: customers can only see their own orders
                if (order == null || (!SessionUtil.isAdmin(request)
                        && order.getUserId() != SessionUtil.getUser(request).getUserId())) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN);
                    return;
                }

                request.setAttribute("order", order);
                request.getRequestDispatcher("/WEB-INF/views/user/profile.jsp")
                       .forward(request, response);

            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/orders");
            }

        } else {
            // Order list
            List<Order> orders;
            if (SessionUtil.isAdmin(request)) {
                orders = orderDAO.findAll();
            } else {
                int userId = SessionUtil.getUser(request).getUserId();
                orders = orderDAO.findByUserId(userId);
            }
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/WEB-INF/views/user/profile.jsp")
                   .forward(request, response);
        }
    }

    // ── POST ──────────────────────────────────────────────────────────────────

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        if (!SessionUtil.isAdmin(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String action = request.getParameter("action");

        if ("updateStatus".equals(action)) {
            handleUpdateStatus(request, response);
        } else if ("delete".equals(action)) {
            handleDeleteOrder(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unknown action");
        }
    }

    // ── HANDLERS ──────────────────────────────────────────────────────────────

    private void handleUpdateStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int    orderId = Integer.parseInt(request.getParameter("orderId"));
            String status  = request.getParameter("status");
            orderDAO.updateStatus(orderId, status);
        } catch (NumberFormatException ignored) {}
        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }

    private void handleDeleteOrder(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            orderDAO.deleteOrder(orderId);
        } catch (NumberFormatException ignored) {}
        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }
}
