package com.mithocha.util;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.JsonSyntaxException;

import jakarta.servlet.http.HttpServletRequest;

import java.io.BufferedReader;
import java.io.IOException;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;

/**
 * JsonUtil – shared JSON parsing/serialization helpers for the API layer.
 */
public final class JsonUtil {

    private static final Gson GSON = new GsonBuilder()
            .serializeNulls()
            .disableHtmlEscaping()
            .create();

    private JsonUtil() {}

    public static Gson gson() {
        return GSON;
    }

    public static String toJson(Object value) {
        return GSON.toJson(value);
    }

    public static <T> T fromJson(String json, Class<T> type) {
        return GSON.fromJson(json, type);
    }

    public static <T> T fromJson(String json, Type type) {
        return GSON.fromJson(json, type);
    }

    public static JsonObject parseObject(String json) {
        if (ValidationUtil.isNullOrEmpty(json)) {
            return new JsonObject();
        }
        try {
            return JsonParser.parseString(json).getAsJsonObject();
        } catch (IllegalStateException | JsonSyntaxException ex) {
            throw new IllegalArgumentException("Invalid JSON object payload.", ex);
        }
    }

    public static JsonObject readObject(HttpServletRequest request) throws IOException {
        return parseObject(readBody(request));
    }

    public static String readBody(HttpServletRequest request) throws IOException {
        StringBuilder builder = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                builder.append(line);
            }
        }
        return builder.toString();
    }

    public static List<Integer> toIntegerList(JsonArray array) {
        List<Integer> values = new ArrayList<>();
        if (array == null) {
            return values;
        }
        array.forEach(element -> {
            if (element != null && element.isJsonPrimitive() && element.getAsJsonPrimitive().isNumber()) {
                values.add(element.getAsInt());
            }
        });
        return values;
    }
}
