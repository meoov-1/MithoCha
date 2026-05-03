package com.mithocha.servlet.api;

import com.mithocha.dao.ProductDAO;
import com.mithocha.dao.impl.ProductDAOImpl;
import com.mithocha.exception.ApiException;
import com.mithocha.model.Product;
import com.mithocha.util.ApiMapperUtil;
import com.mithocha.util.ValidationUtil;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/api/products/*")
public class ApiProductServlet extends BaseApiServlet {

    private final ProductDAO productDAO = new ProductDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String pathInfo = request.getPathInfo();
        if (ValidationUtil.isNullOrEmpty(pathInfo) || "/".equals(pathInfo)) {
            handleGroupedProducts(response);
            return;
        }

        int productId = parsePathId(pathInfo);
        Product product = productDAO.findById(productId);
        ensure(product != null && product.isAvailable(), HttpServletResponse.SC_NOT_FOUND, "Product not found.");
        writeSuccess(response, HttpServletResponse.SC_OK, ApiMapperUtil.toProduct(product, true));
    }

    private void handleGroupedProducts(HttpServletResponse response) throws IOException {
        List<Product> products = productDAO.findAllAvailable();
        Map<String, List<Map<String, Object>>> grouped = new LinkedHashMap<>();
        for (Product product : products) {
            String category = ValidationUtil.isNullOrEmpty(product.getCategory()) ? "Uncategorized" : product.getCategory();
            grouped.computeIfAbsent(category, key -> new ArrayList<>())
                    .add(ApiMapperUtil.toProduct(product, false));
        }
        writeSuccess(response, HttpServletResponse.SC_OK, grouped);
    }
}
