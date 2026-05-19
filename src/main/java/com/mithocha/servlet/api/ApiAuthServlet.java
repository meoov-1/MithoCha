package com.mithocha.servlet.api;

import com.google.gson.JsonObject;
import com.mithocha.exception.ApiException;
import com.mithocha.model.User;
import com.mithocha.service.UserService;
import com.mithocha.util.ApiMapperUtil;
import com.mithocha.util.JwtUtil;
import com.mithocha.util.ValidationUtil;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

@WebServlet(urlPatterns = {"/api/auth/register", "/api/auth/login"})
public class ApiAuthServlet extends BaseApiServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String path = request.getServletPath();
        if ("/api/auth/register".equals(path)) {
            handleRegister(request, response);
            return;
        }
        if ("/api/auth/login".equals(path)) {
            handleLogin(request, response);
            return;
        }
        throw new ApiException(HttpServletResponse.SC_NOT_FOUND, "Auth route not found.");
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response) throws IOException {
        JsonObject body = readJsonBody(request);
        String name = requireString(body, "name");
        String email = requireString(body, "email").toLowerCase();
        String password = requireString(body, "password");

        ensure(ValidationUtil.isValidEmail(email), HttpServletResponse.SC_BAD_REQUEST, "A valid email is required.");
        ensure(ValidationUtil.isValidPassword(password), HttpServletResponse.SC_BAD_REQUEST,
                "Password must be at least 6 characters.");

        int result = userService.register(name, email, password);
        switch (result) {
            case -1:
                throw new ApiException(HttpServletResponse.SC_CONFLICT, "This email is already registered.");
            case -2:
                throw new ApiException(HttpServletResponse.SC_BAD_REQUEST, "A valid email is required.");
            case -3:
                throw new ApiException(HttpServletResponse.SC_BAD_REQUEST, "Password must be at least 6 characters.");
            case -4:
                throw new ApiException(HttpServletResponse.SC_BAD_REQUEST, "Name is required.");
            case -99:
                throw new ApiException(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Registration failed.");
            default:
                User user = userService.findById(result);
                writeSuccess(response, HttpServletResponse.SC_CREATED, ApiMapperUtil.toUserProfile(user, null));
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        JsonObject body = readJsonBody(request);
        String email = requireString(body, "email").toLowerCase();
        String password = requireString(body, "password");

        User user = userService.login(email, password);
        if (user == null) {
            throw new ApiException(HttpServletResponse.SC_UNAUTHORIZED, "Invalid email or password.");
        }

        Map<String, Object> payload = new LinkedHashMap<>();
        payload.put("token", JwtUtil.generateToken(user));
        payload.put("user", ApiMapperUtil.toUserProfile(user, null));
        writeSuccess(response, HttpServletResponse.SC_OK, payload);
    }
}
