package com.mithocha.servlet.api;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.mithocha.exception.ApiException;
import com.mithocha.model.User;
import com.mithocha.util.ApiResponseUtil;
import com.mithocha.util.JsonUtil;
import com.mithocha.util.ValidationUtil;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.math.BigDecimal;
import java.nio.charset.StandardCharsets;
import java.util.Collections;
import java.util.List;

public abstract class BaseApiServlet extends HttpServlet {

    protected JsonObject readJsonBody(HttpServletRequest request) throws IOException {
        try {
            return JsonUtil.readObject(request);
        } catch (IllegalArgumentException ex) {
            throw new ApiException(HttpServletResponse.SC_BAD_REQUEST, "Invalid JSON payload.");
        }
    }

    protected void writeSuccess(HttpServletResponse response, int status, Object data) throws IOException {
        ApiResponseUtil.writeSuccess(response, status, data);
    }

    protected void ensure(boolean condition, int statusCode, String message) {
        if (!condition) {
            throw new ApiException(statusCode, message);
        }
    }

    protected User requireAuthenticatedUser(HttpServletRequest request) {
        User user = (User) request.getAttribute("authenticatedUser");
        if (user == null) {
            throw new ApiException(HttpServletResponse.SC_UNAUTHORIZED, "Authentication is required.");
        }
        return user;
    }

    protected String requireString(JsonObject body, String field) {
        String value = optionalString(body, field);
        if (ValidationUtil.isNullOrEmpty(value)) {
            throw new ApiException(HttpServletResponse.SC_BAD_REQUEST, field + " is required.");
        }
        return value.trim();
    }

    protected String optionalString(JsonObject body, String field) {
        return body != null && body.has(field) && !body.get(field).isJsonNull()
                ? body.get(field).getAsString()
                : null;
    }

    protected Integer optionalInt(JsonObject body, String field) {
        try {
            return body != null && body.has(field) && !body.get(field).isJsonNull()
                    ? body.get(field).getAsInt()
                    : null;
        } catch (Exception ex) {
            throw new ApiException(HttpServletResponse.SC_BAD_REQUEST, field + " must be a number.");
        }
    }

    protected int requirePositiveInt(JsonObject body, String field) {
        Integer value = optionalInt(body, field);
        ensure(value != null && value > 0, HttpServletResponse.SC_BAD_REQUEST, field + " must be greater than zero.");
        return value;
    }

    protected BigDecimal requireNonNegativeAmount(JsonObject body, String field) {
        try {
            BigDecimal value = body != null && body.has(field) && !body.get(field).isJsonNull()
                    ? body.get(field).getAsBigDecimal()
                    : null;
            ensure(ValidationUtil.isNonNegativeAmount(value),
                    HttpServletResponse.SC_BAD_REQUEST, field + " must be zero or greater.");
            return value;
        } catch (NumberFormatException ex) {
            throw new ApiException(HttpServletResponse.SC_BAD_REQUEST, field + " must be a valid amount.");
        }
    }

    protected List<Integer> optionalIntegerList(JsonObject body, String field) {
        if (body == null || !body.has(field) || body.get(field).isJsonNull()) {
            return Collections.emptyList();
        }
        if (!body.get(field).isJsonArray()) {
            throw new ApiException(HttpServletResponse.SC_BAD_REQUEST, field + " must be an array.");
        }
        JsonArray array = body.getAsJsonArray(field);
        return JsonUtil.toIntegerList(array);
    }

    protected int parsePathId(String pathInfo) {
        if (ValidationUtil.isNullOrEmpty(pathInfo) || "/".equals(pathInfo)) {
            throw new ApiException(HttpServletResponse.SC_BAD_REQUEST, "A resource id is required.");
        }
        String trimmed = pathInfo.startsWith("/") ? pathInfo.substring(1) : pathInfo;
        if (trimmed.contains("/")) {
            trimmed = trimmed.substring(0, trimmed.indexOf('/'));
        }
        try {
            return Integer.parseInt(trimmed);
        } catch (NumberFormatException ex) {
            throw new ApiException(HttpServletResponse.SC_BAD_REQUEST, "Invalid resource id.");
        }
    }

    protected byte[] readPartBytes(Part part) throws IOException {
        if (part == null || part.getSize() <= 0) {
            return null;
        }
        return part.getInputStream().readAllBytes();
    }

    protected String readPartText(Part part) throws IOException {
        if (part == null || part.getSize() <= 0) {
            return null;
        }
        return new String(readPartBytes(part), StandardCharsets.UTF_8);
    }
}
