package com.mithocha.servlet.api;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.mithocha.dao.OrderDAO;
import com.mithocha.dao.impl.OrderDAOImpl;
import com.mithocha.exception.ApiException;
import com.mithocha.model.Order;
import com.mithocha.model.User;
import com.mithocha.service.CartService;
import com.mithocha.util.ApiMapperUtil;
import com.mithocha.util.ValidationUtil;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/api/orders/*")
public class ApiOrderServlet extends BaseApiServlet {

    private final CartService cartService = new CartService();
    private final OrderDAO orderDAO = new OrderDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        User user = requireAuthenticatedUser(request);
        String pathInfo = request.getPathInfo();
        if (ValidationUtil.isNullOrEmpty(pathInfo) || "/".equals(pathInfo)) {
            List<Order> orders = orderDAO.findByUserId(user.getUserId());
            writeSuccess(response, HttpServletResponse.SC_OK,
                    orders.stream().map(ApiMapperUtil::toOrder).collect(Collectors.toList()));
            return;
        }

        int orderId = parsePathId(pathInfo);
        Order order = orderDAO.findById(orderId);
        ensure(order != null, HttpServletResponse.SC_NOT_FOUND, "Order not found.");
        ensure("admin".equalsIgnoreCase(user.getRole()) || order.getUserId() == user.getUserId(),
                HttpServletResponse.SC_FORBIDDEN, "You do not have access to this order.");
        writeSuccess(response, HttpServletResponse.SC_OK, ApiMapperUtil.toOrder(order));
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        ensure("/checkout".equals(request.getPathInfo()), HttpServletResponse.SC_NOT_FOUND, "Order route not found.");
        User user = requireAuthenticatedUser(request);
        JsonObject body = readJsonBody(request);

        String paymentMethod = requireString(body, "paymentMethod");
        String transactionId = requireString(body, "transactionId");
        String paymentStatus = optionalString(body, "paymentStatus");
        String shippingAddress = extractShippingAddress(body.get("shippingAddress"));

        try {
            Order order = cartService.checkout(user.getUserId(), shippingAddress, paymentMethod, transactionId, paymentStatus);
            ensure(order != null, HttpServletResponse.SC_BAD_REQUEST, "Cart is empty or checkout failed.");
            writeSuccess(response, HttpServletResponse.SC_CREATED, ApiMapperUtil.toOrder(order));
        } catch (IllegalArgumentException ex) {
            throw new ApiException(HttpServletResponse.SC_BAD_REQUEST, ex.getMessage());
        } catch (IllegalStateException ex) {
            throw new ApiException(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, ex.getMessage());
        }
    }

    private String extractShippingAddress(JsonElement element) {
        if (element == null || element.isJsonNull()) {
            return null;
        }
        if (element.isJsonPrimitive()) {
            return element.getAsString();
        }
        return element.toString();
    }
}
