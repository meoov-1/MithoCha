package com.mithocha.util;

import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * ApiResponseUtil – JSON response helpers used by API servlets and filters.
 */
public final class ApiResponseUtil {

    private ApiResponseUtil() {}

    public static void writeJson(HttpServletResponse response, int status, Object payload) throws IOException {
        response.setStatus(status);
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.getWriter().write(JsonUtil.toJson(payload));
    }

    public static void writeError(HttpServletResponse response, int status, String message) throws IOException {
        Map<String, Object> payload = new LinkedHashMap<>();
        payload.put("success", false);
        payload.put("message", message);
        writeJson(response, status, payload);
    }

    public static void writeSuccess(HttpServletResponse response, int status, Object data) throws IOException {
        Map<String, Object> payload = new LinkedHashMap<>();
        payload.put("success", true);
        payload.put("data", data);
        writeJson(response, status, payload);
    }
}
