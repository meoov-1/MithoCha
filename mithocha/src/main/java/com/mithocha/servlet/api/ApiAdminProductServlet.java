package com.mithocha.servlet.api;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.mithocha.dao.ProductDAO;
import com.mithocha.dao.impl.ProductDAOImpl;
import com.mithocha.exception.ApiException;
import com.mithocha.model.Product;
import com.mithocha.model.ProductSize;
import com.mithocha.model.ProductTopping;
import com.mithocha.util.ApiMapperUtil;
import com.mithocha.util.ValidationUtil;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/api/admin/products/*")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 6 * 1024 * 1024
)
public class ApiAdminProductServlet extends BaseApiServlet {

    private final ProductDAO productDAO = new ProductDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        ProductMutation mutation = parseMutation(request, true);
        Product product = toNewProduct(mutation);
        int productId = productDAO.insertProduct(product);
        ensure(productId > 0, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Product could not be created.");
        Product saved = productDAO.findById(productId);
        writeSuccess(response, HttpServletResponse.SC_CREATED, ApiMapperUtil.toProduct(saved, true));
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int productId = parsePathId(request.getPathInfo());
        Product existing = productDAO.findById(productId);
        ensure(existing != null, HttpServletResponse.SC_NOT_FOUND, "Product not found.");

        ProductMutation mutation = parseMutation(request, false);
        Product updated = merge(existing, mutation);
        updated.setProductId(productId);
        ensure(productDAO.updateProduct(updated), HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Product could not be updated.");
        writeSuccess(response, HttpServletResponse.SC_OK, ApiMapperUtil.toProduct(productDAO.findById(productId), true));
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int productId = parsePathId(request.getPathInfo());
        ensure(productDAO.deleteProduct(productId), HttpServletResponse.SC_NOT_FOUND, "Product not found.");
        writeSuccess(response, HttpServletResponse.SC_OK, "Product deleted.");
    }

    private ProductMutation parseMutation(HttpServletRequest request, boolean requireFields) throws IOException {
        String contentType = request.getContentType();
        if (contentType != null && contentType.toLowerCase().startsWith("multipart/form-data")) {
            return parseMultipartMutation(request, requireFields);
        }
        return parseJsonMutation(request, requireFields);
    }

    private ProductMutation parseJsonMutation(HttpServletRequest request, boolean requireFields) throws IOException {
        JsonObject body = readJsonBody(request);
        ProductMutation mutation = new ProductMutation();
        mutation.name = optionalString(body, "name");
        mutation.description = optionalString(body, "description");
        mutation.category = optionalString(body, "category");
        mutation.imageUrl = optionalString(body, "imageUrl");
        mutation.additionalImages = optionalString(body, "additionalImages");
        mutation.flavours = optionalString(body, "flavours");
        mutation.available = body.has("isAvailable") && !body.get("isAvailable").isJsonNull()
                ? body.get("isAvailable").getAsBoolean()
                : null;
        mutation.basePrice = body.has("basePrice") && !body.get("basePrice").isJsonNull()
                ? requireNonNegativeAmount(body, "basePrice")
                : null;
        if (body.has("sizes")) {
            mutation.sizes = parseSizeOptions(body.get("sizes"));
            mutation.sizesProvided = true;
        }
        if (body.has("toppings")) {
            mutation.toppings = parseToppingOptions(body.get("toppings"));
            mutation.toppingsProvided = true;
        }
        validateMutation(mutation, requireFields);
        return mutation;
    }

    private ProductMutation parseMultipartMutation(HttpServletRequest request, boolean requireFields) throws IOException {
        ProductMutation mutation = new ProductMutation();
        mutation.name = request.getParameter("name");
        mutation.description = request.getParameter("description");
        mutation.category = request.getParameter("category");
        mutation.imageUrl = request.getParameter("imageUrl");
        mutation.additionalImages = request.getParameter("additionalImages");
        mutation.flavours = request.getParameter("flavours");
        mutation.available = parseOptionalBoolean(request.getParameter("isAvailable"));
        mutation.basePrice = parseOptionalAmount(request.getParameter("basePrice"));

        String sizesRaw = request.getParameter("sizes");
        if (sizesRaw != null) {
            mutation.sizes = parseSizeOptions(parseRawJsonOrString(sizesRaw));
            mutation.sizesProvided = true;
        }
        String toppingsRaw = request.getParameter("toppings");
        if (toppingsRaw != null) {
            mutation.toppings = parseToppingOptions(parseRawJsonOrString(toppingsRaw));
            mutation.toppingsProvided = true;
        }

        try {
            Part imagePart = request.getPart("image");
            mutation.imageData = readPartBytes(imagePart);
            mutation.imageContentType = imagePart != null ? imagePart.getContentType() : null;
        } catch (Exception ex) {
            throw new ApiException(HttpServletResponse.SC_BAD_REQUEST, "Invalid multipart product payload.");
        }

        if (mutation.imageData != null) {
            ensure(ValidationUtil.isSupportedImageContentType(mutation.imageContentType),
                    HttpServletResponse.SC_BAD_REQUEST, "Unsupported product image type.");
        }

        validateMutation(mutation, requireFields);
        return mutation;
    }

    private void validateMutation(ProductMutation mutation, boolean requireFields) {
        if (requireFields) {
            ensure(!ValidationUtil.isNullOrEmpty(mutation.name), HttpServletResponse.SC_BAD_REQUEST, "name is required.");
            ensure(!ValidationUtil.isNullOrEmpty(mutation.category), HttpServletResponse.SC_BAD_REQUEST, "category is required.");
            ensure(ValidationUtil.isNonNegativeAmount(mutation.basePrice),
                    HttpServletResponse.SC_BAD_REQUEST, "basePrice must be zero or greater.");
        }
    }

    private Product toNewProduct(ProductMutation mutation) {
        Product product = new Product();
        product.setName(mutation.name.trim());
        product.setDescription(ValidationUtil.trimToNull(mutation.description));
        product.setCategory(mutation.category.trim());
        product.setAvailable(mutation.available == null || mutation.available);
        product.setBasePrice(mutation.basePrice);
        product.setAdditionalImages(ValidationUtil.trimToNull(mutation.additionalImages));
        product.setFlavours(ValidationUtil.trimToNull(mutation.flavours));
        if (!ValidationUtil.isNullOrEmpty(mutation.imageUrl)) {
            product.setImageUrl(mutation.imageUrl.trim());
        }
        if (mutation.imageData != null) {
            product.setImageData(mutation.imageData);
            product.setImageContentType(mutation.imageContentType);
            product.setImageUrl(null);
        }
        product.setSizeOptions(mutation.sizes == null ? new ArrayList<>() : mutation.sizes);
        product.setToppingOptions(mutation.toppings == null ? new ArrayList<>() : mutation.toppings);
        return product;
    }

    private Product merge(Product existing, ProductMutation mutation) {
        if (!ValidationUtil.isNullOrEmpty(mutation.name)) {
            existing.setName(mutation.name.trim());
        }
        if (mutation.description != null) {
            existing.setDescription(ValidationUtil.trimToNull(mutation.description));
        }
        if (!ValidationUtil.isNullOrEmpty(mutation.category)) {
            existing.setCategory(mutation.category.trim());
        }
        if (mutation.available != null) {
            existing.setAvailable(mutation.available);
        }
        if (mutation.basePrice != null) {
            existing.setBasePrice(mutation.basePrice);
        }
        if (mutation.additionalImages != null) {
            existing.setAdditionalImages(ValidationUtil.trimToNull(mutation.additionalImages));
        }
        if (mutation.flavours != null) {
            existing.setFlavours(ValidationUtil.trimToNull(mutation.flavours));
        }
        if (!ValidationUtil.isNullOrEmpty(mutation.imageUrl)) {
            existing.setImageUrl(mutation.imageUrl.trim());
            existing.setImageData(null);
            existing.setImageContentType(null);
        }
        if (mutation.imageData != null) {
            existing.setImageUrl(null);
            existing.setImageData(mutation.imageData);
            existing.setImageContentType(mutation.imageContentType);
        }
        if (mutation.sizesProvided) {
            existing.setSizeOptions(mutation.sizes == null ? new ArrayList<>() : mutation.sizes);
        }
        if (mutation.toppingsProvided) {
            existing.setToppingOptions(mutation.toppings == null ? new ArrayList<>() : mutation.toppings);
        }
        return existing;
    }

    private List<ProductSize> parseSizeOptions(JsonElement element) {
        List<ProductSize> sizes = new ArrayList<>();
        if (element == null || element.isJsonNull()) {
            return sizes;
        }
        if (element.isJsonPrimitive() && ValidationUtil.isNullOrEmpty(element.getAsString())) {
            return sizes;
        }
        JsonArray array = element.isJsonArray() ? element.getAsJsonArray() : new JsonArray();
        if (!element.isJsonArray()) {
            array.add(element);
        }
        int index = 0;
        for (JsonElement item : array) {
            String name = extractLabel(item);
            if (ValidationUtil.isNullOrEmpty(name)) {
                continue;
            }
            ProductSize size = new ProductSize();
            size.setName(name.trim());
            size.setPriceModifier(extractAmount(item));
            size.setDisplayOrder(index++);
            sizes.add(size);
        }
        return sizes;
    }

    private List<ProductTopping> parseToppingOptions(JsonElement element) {
        List<ProductTopping> toppings = new ArrayList<>();
        if (element == null || element.isJsonNull()) {
            return toppings;
        }
        if (element.isJsonPrimitive() && ValidationUtil.isNullOrEmpty(element.getAsString())) {
            return toppings;
        }
        JsonArray array = element.isJsonArray() ? element.getAsJsonArray() : new JsonArray();
        if (!element.isJsonArray()) {
            array.add(element);
        }
        for (JsonElement item : array) {
            String name = extractLabel(item);
            if (ValidationUtil.isNullOrEmpty(name)) {
                continue;
            }
            ProductTopping topping = new ProductTopping();
            topping.setName(name.trim());
            topping.setPriceModifier(extractAmount(item));
            topping.setAvailable(true);
            toppings.add(topping);
        }
        return toppings;
    }

    private JsonElement parseRawJsonOrString(String raw) {
        try {
            return JsonParser.parseString(raw);
        } catch (Exception ex) {
            JsonArray array = new JsonArray();
            for (String part : raw.split(",")) {
                String value = ValidationUtil.trimToNull(part);
                if (value != null) {
                    array.add(value);
                }
            }
            return array;
        }
    }

    private String extractLabel(JsonElement element) {
        if (element == null || element.isJsonNull()) {
            return null;
        }
        if (element.isJsonPrimitive()) {
            return element.getAsString();
        }
        JsonObject object = element.getAsJsonObject();
        if (object.has("label")) return object.get("label").getAsString();
        if (object.has("name")) return object.get("name").getAsString();
        if (object.has("value")) return object.get("value").getAsString();
        if (object.has("size")) return object.get("size").getAsString();
        if (object.has("topping")) return object.get("topping").getAsString();
        return null;
    }

    private BigDecimal extractAmount(JsonElement element) {
        if (element == null || element.isJsonNull() || element.isJsonPrimitive()) {
            return BigDecimal.ZERO;
        }
        JsonObject object = element.getAsJsonObject();
        if (object.has("priceModifier")) return object.get("priceModifier").getAsBigDecimal();
        if (object.has("extra")) return object.get("extra").getAsBigDecimal();
        if (object.has("price")) return object.get("price").getAsBigDecimal();
        if (object.has("addOn")) return object.get("addOn").getAsBigDecimal();
        return BigDecimal.ZERO;
    }

    private BigDecimal parseOptionalAmount(String raw) {
        if (ValidationUtil.isNullOrEmpty(raw)) {
            return null;
        }
        try {
            BigDecimal value = new BigDecimal(raw.trim());
            ensure(ValidationUtil.isNonNegativeAmount(value),
                    HttpServletResponse.SC_BAD_REQUEST, "basePrice must be zero or greater.");
            return value;
        } catch (NumberFormatException ex) {
            throw new ApiException(HttpServletResponse.SC_BAD_REQUEST, "basePrice must be a valid amount.");
        }
    }

    private Boolean parseOptionalBoolean(String raw) {
        if (raw == null) {
            return null;
        }
        return Boolean.parseBoolean(raw);
    }

    private static final class ProductMutation {
        private String name;
        private String description;
        private String category;
        private String imageUrl;
        private String additionalImages;
        private String flavours;
        private Boolean available;
        private BigDecimal basePrice;
        private byte[] imageData;
        private String imageContentType;
        private List<ProductSize> sizes;
        private boolean sizesProvided;
        private List<ProductTopping> toppings;
        private boolean toppingsProvided;
    }
}
