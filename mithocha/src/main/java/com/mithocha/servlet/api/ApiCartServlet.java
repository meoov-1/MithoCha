package com.mithocha.servlet.api;

import com.google.gson.JsonObject;
import com.mithocha.exception.ApiException;
import com.mithocha.model.CartItem;
import com.mithocha.model.User;
import com.mithocha.service.CartService;
import com.mithocha.util.ApiMapperUtil;
import com.mithocha.util.ValidationUtil;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet("/api/cart/*")
public class ApiCartServlet extends BaseApiServlet {

    private final CartService cartService = new CartService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        ensureCollectionPath(request.getPathInfo());
        User user = requireAuthenticatedUser(request);
        writeCartResponse(response, cartService.getCart(user.getUserId()));
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        ensure("/items".equals(request.getPathInfo()), HttpServletResponse.SC_NOT_FOUND, "Cart route not found.");
        User user = requireAuthenticatedUser(request);
        JsonObject body = readJsonBody(request);

        int productId = requirePositiveInt(body, "productId");
        Integer sizeId = optionalInt(body, "sizeId");
        List<Integer> toppingIds = optionalIntegerList(body, "toppingIds");
        int quantity = requirePositiveInt(body, "quantity");

        try {
            CartItem cartItem = cartService.addCartItem(user.getUserId(), productId, sizeId, toppingIds, quantity);
            ensure(cartItem != null, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Cart item could not be added.");
            writeSuccess(response, HttpServletResponse.SC_CREATED, ApiMapperUtil.toCart(cartItem));
        } catch (IllegalArgumentException ex) {
            throw new ApiException(HttpServletResponse.SC_BAD_REQUEST, ex.getMessage());
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int cartItemId = parseCartItemId(request.getPathInfo());
        User user = requireAuthenticatedUser(request);
        JsonObject body = readJsonBody(request);

        Integer sizeId = optionalInt(body, "sizeId");
        List<Integer> toppingIds = optionalIntegerList(body, "toppingIds");
        int quantity = requirePositiveInt(body, "quantity");

        try {
            CartItem cartItem = cartService.updateCartItem(user.getUserId(), cartItemId, sizeId, toppingIds, quantity);
            ensure(cartItem != null, HttpServletResponse.SC_NOT_FOUND, "Cart item not found.");
            writeSuccess(response, HttpServletResponse.SC_OK, ApiMapperUtil.toCart(cartItem));
        } catch (IllegalArgumentException ex) {
            throw new ApiException(HttpServletResponse.SC_BAD_REQUEST, ex.getMessage());
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        User user = requireAuthenticatedUser(request);
        String pathInfo = request.getPathInfo();
        if (ValidationUtil.isNullOrEmpty(pathInfo) || "/".equals(pathInfo)) {
            cartService.clearCart(user.getUserId());
            writeSuccess(response, HttpServletResponse.SC_OK, "Cart cleared.");
            return;
        }

        int cartItemId = parseCartItemId(pathInfo);
        ensure(cartService.removeCartItem(user.getUserId(), cartItemId),
                HttpServletResponse.SC_NOT_FOUND, "Cart item not found.");
        writeSuccess(response, HttpServletResponse.SC_OK, "Cart item removed.");
    }

    private void ensureCollectionPath(String pathInfo) {
        ensure(ValidationUtil.isNullOrEmpty(pathInfo) || "/".equals(pathInfo),
                HttpServletResponse.SC_NOT_FOUND, "Cart route not found.");
    }

    private int parseCartItemId(String pathInfo) {
        ensure(pathInfo != null && pathInfo.startsWith("/items/"),
                HttpServletResponse.SC_NOT_FOUND, "Cart route not found.");
        String idPart = pathInfo.substring("/items/".length());
        try {
            return Integer.parseInt(idPart);
        } catch (NumberFormatException ex) {
            throw new ApiException(HttpServletResponse.SC_BAD_REQUEST, "Invalid cart item id.");
        }
    }

    private void writeCartResponse(HttpServletResponse response, List<CartItem> items) throws IOException {
        Map<String, Object> payload = new LinkedHashMap<>();
        payload.put("items", items.stream().map(ApiMapperUtil::toCart).collect(Collectors.toList()));
        payload.put("totalAmount", ApiMapperUtil.cartTotal(items));
        writeSuccess(response, HttpServletResponse.SC_OK, payload);
    }
}
