package com.mithocha.servlet;

import com.mithocha.dao.OrderDAO;
import com.mithocha.dao.ProductDAO;
import com.mithocha.dao.UserDAO;
import com.mithocha.dao.impl.OrderDAOImpl;
import com.mithocha.dao.impl.ProductDAOImpl;
import com.mithocha.dao.impl.UserDAOImpl;
import com.mithocha.model.Order;
import com.mithocha.model.Product;
import com.mithocha.model.User;
import com.mithocha.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

/**
 * AdminServlet – handles all /admin/* routes.
 *
 * Routes:
 *   GET  /admin/dashboard   → dashboard with stats + recent orders
 *   GET  /admin/orders      → all orders
 *   POST /admin/orders      → update order status
 *   GET  /admin/menu        → product list + add form
 *   GET  /admin/customers   → all users
 *   GET  /admin/customers?id=X → single customer profile
 *   POST /admin/customers   → delete customer
 *   GET  /admin/inventory   → product availability overview
 *   GET  /admin/analytics   → reports and stats
 *   GET  /admin/billing     → payment records
 */
@WebServlet("/admin/*")
public class AdminServlet extends HttpServlet {

    private final OrderDAO   orderDAO   = new OrderDAOImpl();
    private final ProductDAO productDAO = new ProductDAOImpl();
    private final UserDAO    userDAO    = new UserDAOImpl();

    // ── GET ───────────────────────────────────────────────────────────────────

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!SessionUtil.isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String path = request.getPathInfo(); // e.g. "/dashboard"
        if (path == null || "/".equals(path)) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }

        switch (path) {
            case "/dashboard":  showDashboard(request, response);  break;
            case "/orders":     showOrders(request, response);     break;
            case "/menu":       showMenu(request, response);       break;
            case "/customers":  showCustomers(request, response);  break;
            case "/inventory":  showInventory(request, response);  break;
            case "/analytics":  showAnalytics(request, response);  break;
            case "/billing":    showBilling(request, response);    break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Admin page not found: " + path);
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

        String path   = request.getPathInfo();
        String action = request.getParameter("action");

        if ("/orders".equals(path) && "updateStatus".equals(action)) {
            handleUpdateOrderStatus(request, response);
        } else if ("/customers".equals(path) && "delete".equals(action)) {
            handleDeleteCustomer(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unknown admin action");
        }
    }

    // ── PAGE HANDLERS ─────────────────────────────────────────────────────────

    private void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Order>   allOrders  = orderDAO.findAll();
        List<Product> allProducts = productDAO.findAll();
        List<User>    allUsers   = userDAO.findAll();

        // Stats
        int totalOrders    = allOrders.size();
        int totalCustomers = (int) allUsers.stream().filter(u -> "customer".equals(u.getRole())).count();
        int totalProducts  = allProducts.size();
        BigDecimal totalRevenue = allOrders.stream()
                .filter(o -> "completed".equals(o.getStatus()))
                .map(Order::getTotalAmount)
                .filter(Objects::nonNull)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        // Recent 10 orders
        List<Order> recentOrders = allOrders.stream().limit(10).collect(Collectors.toList());

        // Unavailable products
        List<Product> unavailableProducts = allProducts.stream()
                .filter(p -> !p.isAvailable())
                .collect(Collectors.toList());

        request.setAttribute("totalOrders",          totalOrders);
        request.setAttribute("totalRevenue",         totalRevenue);
        request.setAttribute("totalCustomers",       totalCustomers);
        request.setAttribute("totalProducts",        totalProducts);
        request.setAttribute("recentOrders",         recentOrders);
        request.setAttribute("unavailableProducts",  unavailableProducts);

        request.getRequestDispatcher("/WEB-INF/views/admin/admin-dashboard.jsp")
               .forward(request, response);
    }

    private void showOrders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Order> orders = orderDAO.findAll();
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/WEB-INF/views/admin/ordermanagement.jsp")
               .forward(request, response);
    }

    private void showMenu(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Product> products = productDAO.findAll();
        request.setAttribute("products", products);
        request.getRequestDispatcher("/WEB-INF/views/admin/menumanagement.jsp")
               .forward(request, response);
    }

    private void showCustomers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam != null) {
            // Single customer profile view
            try {
                int userId = Integer.parseInt(idParam);
                User user  = userDAO.findById(userId);
                if (user == null) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Customer not found");
                    return;
                }
                List<Order> userOrders = orderDAO.findByUserId(userId);
                request.setAttribute("viewUser",   user);
                request.setAttribute("userOrders", userOrders);
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/customers");
                return;
            }
        }

        List<User> users = userDAO.findAll();
        request.setAttribute("users", users);
        request.getRequestDispatcher("/WEB-INF/views/admin/customermanagement.jsp")
               .forward(request, response);
    }

    private void showInventory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Product> products = productDAO.findAll();
        long available   = products.stream().filter(Product::isAvailable).count();
        long unavailable = products.stream().filter(p -> !p.isAvailable()).count();
        long categories  = products.stream()
                .map(Product::getCategory)
                .filter(Objects::nonNull)
                .distinct().count();

        request.setAttribute("products",        products);
        request.setAttribute("availableCount",  available);
        request.setAttribute("unavailableCount", unavailable);
        request.setAttribute("categoryCount",   categories);

        request.getRequestDispatcher("/WEB-INF/views/admin/inventory.jsp")
               .forward(request, response);
    }

    private void showAnalytics(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Order>   orders   = orderDAO.findAll();
        List<User>    users    = userDAO.findAll();
        List<Product> products = productDAO.findAll();

        // Revenue (completed orders only)
        BigDecimal totalRevenue = orders.stream()
                .filter(o -> "completed".equals(o.getStatus()))
                .map(Order::getTotalAmount)
                .filter(Objects::nonNull)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        // Avg order value
        BigDecimal avgOrderValue = orders.isEmpty() ? BigDecimal.ZERO
                : totalRevenue.divide(BigDecimal.valueOf(orders.size()), 2, java.math.RoundingMode.HALF_UP);

        // Orders by status
        Map<String, Long> ordersByStatus = orders.stream()
                .collect(Collectors.groupingBy(
                        o -> o.getStatus() != null ? o.getStatus() : "unknown",
                        Collectors.counting()));

        // Top products — parse product_name from items JSON (simple substring approach)
        Map<String, Long> productCounts = new LinkedHashMap<>();
        for (Order order : orders) {
            if (order.getItems() != null) {
                // Extract "product_name":"..." values from JSON string
                String items = order.getItems();
                int idx = 0;
                while ((idx = items.indexOf("\"product_name\"", idx)) != -1) {
                    int start = items.indexOf("\"", idx + 15) + 1;
                    int end   = items.indexOf("\"", start);
                    if (start > 0 && end > start) {
                        String name = items.substring(start, end);
                        productCounts.merge(name, 1L, Long::sum);
                    }
                    idx = end + 1;
                }
            }
        }
        // Sort by count desc, take top 5
        List<Object[]> topProducts = productCounts.entrySet().stream()
                .sorted(Map.Entry.<String, Long>comparingByValue().reversed())
                .limit(5)
                .map(e -> new Object[]{e.getKey(), e.getValue()})
                .collect(Collectors.toList());

        int totalCustomers = (int) users.stream().filter(u -> "customer".equals(u.getRole())).count();

        request.setAttribute("orders",          orders);
        request.setAttribute("totalOrders",     orders.size());
        request.setAttribute("totalRevenue",    totalRevenue);
        request.setAttribute("avgOrderValue",   avgOrderValue);
        request.setAttribute("totalCustomers",  totalCustomers);
        request.setAttribute("ordersByStatus",  ordersByStatus);
        request.setAttribute("topProducts",     topProducts);

        request.getRequestDispatcher("/WEB-INF/views/admin/reportanlytics.jsp")
               .forward(request, response);
    }

    private void showBilling(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Order> orders = orderDAO.findAll();

        BigDecimal totalRevenue = orders.stream()
                .filter(o -> "completed".equals(o.getStatus()))
                .map(Order::getTotalAmount)
                .filter(Objects::nonNull)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        long paidOrders      = orders.stream().filter(o -> "completed".equals(o.getStatus())).count();
        long pendingOrders   = orders.stream().filter(o -> "pending".equals(o.getStatus())).count();
        long cancelledOrders = orders.stream().filter(o -> "cancelled".equals(o.getStatus())).count();

        request.setAttribute("orders",          orders);
        request.setAttribute("totalRevenue",    totalRevenue);
        request.setAttribute("paidOrders",      paidOrders);
        request.setAttribute("pendingOrders",   pendingOrders);
        request.setAttribute("cancelledOrders", cancelledOrders);

        request.getRequestDispatcher("/WEB-INF/views/admin/billing.jsp")
               .forward(request, response);
    }

    // ── POST HANDLERS ─────────────────────────────────────────────────────────

    private void handleUpdateOrderStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int    orderId = Integer.parseInt(request.getParameter("orderId"));
            String status  = request.getParameter("status");
            orderDAO.updateStatus(orderId, status);
            request.getSession().setAttribute("successMessage", "Order #" + orderId + " updated to " + status);
        } catch (NumberFormatException ignored) {}
        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }

    private void handleDeleteCustomer(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            userDAO.deleteUser(userId);
            request.getSession().setAttribute("successMessage", "Customer #" + userId + " deleted.");
        } catch (NumberFormatException ignored) {}
        response.sendRedirect(request.getContextPath() + "/admin/customers");
    }
}
