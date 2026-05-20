package com.mithocha.servlet;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

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
import com.mithocha.util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

/**
 * AdminServlet – handles all /admin/* routes.
 *
 * GET  /admin/dashboard
 * GET  /admin/orders
 * POST /admin/orders          action=updateStatus | action=markPaid
 * GET  /admin/menu
 * POST /admin/menu            action=add | action=edit | action=delete | action=toggle
 * GET  /admin/customers
 * POST /admin/customers       action=delete
 * GET  /admin/inventory
 * GET  /admin/analytics
 * GET  /admin/billing
 * POST /admin/billing         action=markPaid
 */
@WebServlet("/admin/*")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,      // 1 MB
        maxFileSize       = 5 * 1024 * 1024,  // 5 MB
        maxRequestSize    = 6 * 1024 * 1024   // 6 MB
)
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

        transferFlash(request);

        String path = request.getPathInfo();
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
        if (path == null) path = "/";

        switch (path) {
            case "/orders":
                if ("updateStatus".equals(action))      handleUpdateOrderStatus(request, response);
                else if ("markPaid".equals(action))     handleMarkOrderPaid(request, response, "/admin/orders");
                else { flash(request, "error", "Unknown order action."); response.sendRedirect(request.getContextPath() + "/admin/orders"); }
                break;

            case "/menu":
                switch (action == null ? "" : action) {
                    case "add":    handleAddProduct(request, response);    break;
                    case "edit":   handleEditProduct(request, response);   break;
                    case "delete": handleDeleteProduct(request, response); break;
                    case "toggle": handleToggleProduct(request, response); break;
                    default:
                        flash(request, "error", "Unknown menu action.");
                        response.sendRedirect(request.getContextPath() + "/admin/menu");
                }
                break;

            case "/customers":
                if ("delete".equals(action)) handleDeleteCustomer(request, response);
                else { flash(request, "error", "Unknown customer action."); response.sendRedirect(request.getContextPath() + "/admin/customers"); }
                break;

            case "/billing":
                if ("markPaid".equals(action)) handleMarkOrderPaid(request, response, "/admin/billing");
                else { flash(request, "error", "Unknown billing action."); response.sendRedirect(request.getContextPath() + "/admin/billing"); }
                break;

            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unknown admin POST path: " + path);
        }
    }

    // ── PAGE HANDLERS ─────────────────────────────────────────────────────────

    private void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Order>   allOrders   = orderDAO.findAll();
        List<Product> allProducts = productDAO.findAll();
        List<User>    allUsers    = userDAO.findAll();

        BigDecimal totalRevenue = allOrders.stream()
                .filter(this::isRevenueOrder).map(Order::getTotalAmount)
                .filter(Objects::nonNull).reduce(BigDecimal.ZERO, BigDecimal::add);

        request.setAttribute("totalOrders",         allOrders.size());
        request.setAttribute("totalRevenue",        totalRevenue);
        request.setAttribute("totalCustomers",      (int) allUsers.stream().filter(u -> "customer".equals(u.getRole())).count());
        request.setAttribute("totalProducts",       allProducts.size());
        request.setAttribute("recentOrders",        allOrders.stream().limit(10).collect(Collectors.toList()));
        request.setAttribute("unavailableProducts", allProducts.stream().filter(p -> !p.isAvailable()).collect(Collectors.toList()));

        request.getRequestDispatcher("/WEB-INF/views/admin/admin-dashboard.jsp").forward(request, response);
    }

    private void showOrders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("orders", orderDAO.findAll());
        request.getRequestDispatcher("/WEB-INF/views/admin/ordermanagement.jsp").forward(request, response);
    }

    private void showMenu(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String editId = request.getParameter("editId");
        if (!ValidationUtil.isNullOrEmpty(editId)) {
            try { request.setAttribute("editProduct", productDAO.findById(Integer.parseInt(editId))); }
            catch (NumberFormatException ignored) {}
        }
        request.setAttribute("products", productDAO.findAll());
        request.getRequestDispatcher("/WEB-INF/views/admin/menumanagement.jsp").forward(request, response);
    }

    private void showCustomers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null) {
            try {
                int userId = Integer.parseInt(idParam);
                User user  = userDAO.findById(userId);
                if (user == null) { response.sendError(HttpServletResponse.SC_NOT_FOUND); return; }
                request.setAttribute("viewUser",   user);
                request.setAttribute("userOrders", orderDAO.findByUserId(userId));
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/customers"); return;
            }
        }
        request.setAttribute("users", userDAO.findAll());
        request.getRequestDispatcher("/WEB-INF/views/admin/customermanagement.jsp").forward(request, response);
    }

    private void showInventory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product> products = productDAO.findAll();
        request.setAttribute("products",         products);
        request.setAttribute("availableCount",   products.stream().filter(Product::isAvailable).count());
        request.setAttribute("unavailableCount", products.stream().filter(p -> !p.isAvailable()).count());
        request.setAttribute("categoryCount",    products.stream().map(Product::getCategory).filter(Objects::nonNull).distinct().count());
        request.getRequestDispatcher("/WEB-INF/views/admin/inventory.jsp").forward(request, response);
    }

    private void showAnalytics(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Order> orders = orderDAO.findAll();
        List<User>  users  = userDAO.findAll();

        BigDecimal totalRevenue = orders.stream().filter(this::isRevenueOrder)
                .map(Order::getTotalAmount).filter(Objects::nonNull)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        BigDecimal avgOrderValue = orders.isEmpty() ? BigDecimal.ZERO
                : totalRevenue.divide(BigDecimal.valueOf(orders.size()), 2, java.math.RoundingMode.HALF_UP);

        Map<String, Long> ordersByStatus = orders.stream()
                .collect(Collectors.groupingBy(o -> o.getStatus() != null ? o.getStatus() : "unknown", Collectors.counting()));

        Map<String, Long> productCounts = new LinkedHashMap<>();
        for (Order order : orders) {
            if (order.getItems() != null) {
                String items = order.getItems();
                int idx = 0;
                while ((idx = items.indexOf("\"product_name\"", idx)) != -1) {
                    int start = items.indexOf("\"", idx + 15) + 1;
                    int end   = items.indexOf("\"", start);
                    if (start > 0 && end > start) productCounts.merge(items.substring(start, end), 1L, Long::sum);
                    idx = end + 1;
                }
            }
        }
        List<Object[]> topProducts = productCounts.entrySet().stream()
                .sorted(Map.Entry.<String, Long>comparingByValue().reversed()).limit(5)
                .map(e -> new Object[]{e.getKey(), e.getValue()}).collect(Collectors.toList());

        request.setAttribute("orders",         orders);
        request.setAttribute("totalOrders",    orders.size());
        request.setAttribute("totalRevenue",   totalRevenue);
        request.setAttribute("avgOrderValue",  avgOrderValue);
        request.setAttribute("totalCustomers", (int) users.stream().filter(u -> "customer".equals(u.getRole())).count());
        request.setAttribute("ordersByStatus", ordersByStatus);
        request.setAttribute("topProducts",    topProducts);
        request.getRequestDispatcher("/WEB-INF/views/admin/reportanlytics.jsp").forward(request, response);
    }

    private void showBilling(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Order> orders = orderDAO.findAll();
        BigDecimal totalRevenue = orders.stream().filter(this::isRevenueOrder)
                .map(Order::getTotalAmount).filter(Objects::nonNull)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        request.setAttribute("orders",          orders);
        request.setAttribute("totalRevenue",    totalRevenue);
        request.setAttribute("paidOrders",      orders.stream().filter(this::isRevenueOrder).count());
        request.setAttribute("pendingOrders",   orders.stream().filter(o -> "pending".equals(o.getStatus())).count());
        request.setAttribute("cancelledOrders", orders.stream().filter(o -> "cancelled".equals(o.getStatus())).count());
        request.getRequestDispatcher("/WEB-INF/views/admin/billing.jsp").forward(request, response);
    }

    // ── ORDER ACTIONS ─────────────────────────────────────────────────────────

    private void handleUpdateOrderStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int    orderId = Integer.parseInt(request.getParameter("orderId"));
            String status  = request.getParameter("status");
            if (orderDAO.updateStatus(orderId, status))
                flash(request, "success", "Order #" + orderId + " updated to \"" + status + "\".");
            else
                flash(request, "error", "Could not update order #" + orderId + ".");
        } catch (NumberFormatException ignored) {
            flash(request, "error", "Invalid order ID.");
        }
        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }

    private void handleMarkOrderPaid(HttpServletRequest request, HttpServletResponse response,
                                     String redirectPath) throws IOException {
        try {
            int    orderId       = Integer.parseInt(request.getParameter("orderId"));
            String paymentMethod = request.getParameter("paymentMethod");
            String transactionId = request.getParameter("transactionId");
            if (ValidationUtil.isNullOrEmpty(paymentMethod)) paymentMethod = "cash";
            if (ValidationUtil.isNullOrEmpty(transactionId)) transactionId = "ADMIN-" + System.currentTimeMillis();

            Order order = orderDAO.findById(orderId);
            if (order == null) {
                flash(request, "error", "Order #" + orderId + " not found.");
            } else {
                String paymentJson = buildPaymentJson(paymentMethod, transactionId,
                        order.getTotalAmount(), "paid");
                orderDAO.updateSnapshots(orderId, order.getItems(), paymentJson, order.getShippingAddress());
                orderDAO.updateStatus(orderId, "completed");
                flash(request, "success", "Order #" + orderId + " marked as paid (Rs. "
                        + order.getTotalAmount() + ").");
            }
        } catch (NumberFormatException ignored) {
            flash(request, "error", "Invalid order ID.");
        }
        response.sendRedirect(request.getContextPath() + redirectPath);
    }

    // ── MENU ACTIONS ──────────────────────────────────────────────────────────

    private void handleAddProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            Product p = buildProductFromRequest(request, 0);
            // Prevent duplicates by name (case-insensitive)
            List<Product> existing = productDAO.findAll();
            boolean duplicate = existing.stream()
                    .anyMatch(pr -> pr.getName() != null && pr.getName().trim().equalsIgnoreCase(p.getName() == null ? "" : p.getName().trim()));
            if (duplicate) {
                flash(request, "error", "Product \"" + p.getName() + "\" already exists.");
            } else {
                int id = productDAO.insertProduct(p);
                if (id > 0) flash(request, "success", "Product \"" + p.getName() + "\" added successfully.");
                else        flash(request, "error",   "Failed to add product. Please try again.");
            }
        } catch (Exception e) {
            flash(request, "error", "Error adding product: " + e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/admin/menu");
    }

    private void handleEditProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            Product p = buildProductFromRequest(request, productId);
            if (productDAO.updateProduct(p)) flash(request, "success", "Product \"" + p.getName() + "\" updated.");
            else                             flash(request, "error",   "Failed to update product.");
        } catch (NumberFormatException e) {
            flash(request, "error", "Invalid product ID.");
        } catch (Exception e) {
            flash(request, "error", "Error updating product: " + e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/admin/menu");
    }

    private void handleDeleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            if (productDAO.deleteProduct(productId)) flash(request, "success", "Product deleted.");
            else                                     flash(request, "error",   "Failed to delete product.");
        } catch (NumberFormatException e) {
            flash(request, "error", "Invalid product ID.");
        }
        response.sendRedirect(request.getContextPath() + "/admin/menu");
    }

    private void handleToggleProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            Product p = productDAO.findById(productId);
            if (p != null) {
                boolean newState = !p.isAvailable();
                productDAO.setAvailability(productId, newState);
                flash(request, "success", "\"" + p.getName() + "\" is now " + (newState ? "available" : "unavailable") + ".");
            }
        } catch (NumberFormatException e) {
            flash(request, "error", "Invalid product ID.");
        }
        response.sendRedirect(request.getContextPath() + "/admin/menu");
    }

    // ── CUSTOMER ACTIONS ──────────────────────────────────────────────────────

    private void handleDeleteCustomer(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            if (userDAO.deleteUser(userId)) flash(request, "success", "Customer #" + userId + " deleted.");
            else                            flash(request, "error",   "Failed to delete customer.");
        } catch (NumberFormatException e) {
            flash(request, "error", "Invalid user ID.");
        }
        response.sendRedirect(request.getContextPath() + "/admin/customers");
    }

    // ── HELPERS ───────────────────────────────────────────────────────────────

    private Product buildProductFromRequest(HttpServletRequest req, int productId)
            throws IOException, ServletException {
        String name         = req.getParameter("name");
        String description  = req.getParameter("description");
        String imageUrl     = req.getParameter("imageUrl");
        String category     = req.getParameter("category");
        String basePriceStr = req.getParameter("basePrice");
        String sizes        = req.getParameter("sizes");
        String flavours     = req.getParameter("flavours");
        String toppings     = req.getParameter("toppings");
        boolean available   = "true".equals(req.getParameter("isAvailable"));

        BigDecimal basePrice;
        try { basePrice = new BigDecimal(basePriceStr); }
        catch (Exception e) { basePrice = BigDecimal.ZERO; }

        Product p = new Product(name, description, imageUrl, null, category,
                available, sizes, flavours, toppings, basePrice);
        if (productId > 0) p.setProductId(productId);

        // Handle uploaded image file (multipart)
        try {
            Part imagePart = req.getPart("imageFile");
            if (imagePart != null && imagePart.getSize() > 0) {
                String contentType = imagePart.getContentType();
                if (contentType != null && contentType.startsWith("image/")) {
                    try (InputStream is = imagePart.getInputStream()) {
                        byte[] imageData = is.readAllBytes();
                        p.setImageData(imageData);
                        p.setImageContentType(contentType);
                        p.setImageUrl(null); // uploaded file takes precedence over URL
                    }
                }
            }
        } catch (Exception ignored) {
            // Not a multipart request or no file — that's fine
        }

        return p;
    }

    private String buildPaymentJson(String method, String transactionId,
                                    BigDecimal amount, String status) {
        return "{\"method\":\"" + esc(method) + "\","
             + "\"transaction_id\":\"" + esc(transactionId) + "\","
             + "\"amount\":" + (amount != null ? amount.toPlainString() : "0") + ","
             + "\"status\":\"" + esc(status) + "\","
             + "\"date\":\"" + new java.util.Date() + "\"}";
    }

    private String esc(String s) {
        return s == null ? "" : s.replace("\\", "\\\\").replace("\"", "\\\"");
    }

    private boolean isRevenueOrder(Order order) {
        if (order == null || order.getStatus() == null) return false;
        String s = order.getStatus().toLowerCase();
        return "paid".equals(s) || "completed".equals(s);
    }

    private void flash(HttpServletRequest request, String type, String message) {
        request.getSession().setAttribute("flash_" + type, message);
    }

    private void transferFlash(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return;
        for (String type : new String[]{"success", "error"}) {
            String key = "flash_" + type;
            Object val = session.getAttribute(key);
            if (val != null) {
                request.setAttribute(type + "Message", val);
                session.removeAttribute(key);
            }
        }
        // Legacy key
        Object legacy = session.getAttribute("successMessage");
        if (legacy != null) {
            request.setAttribute("successMessage", legacy);
            session.removeAttribute("successMessage");
        }
    }
}
