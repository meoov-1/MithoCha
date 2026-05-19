package com.mithocha.filter;

import com.mithocha.dao.UserDAO;
import com.mithocha.dao.impl.UserDAOImpl;
import com.mithocha.model.User;
import com.mithocha.util.ApiResponseUtil;
import com.mithocha.util.JwtUtil;
import com.mithocha.util.ValidationUtil;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebFilter("/api/*")
public class JwtAuthFilter implements Filter {

    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        if ("OPTIONS".equalsIgnoreCase(httpRequest.getMethod()) || isPublicRoute(httpRequest)) {
            chain.doFilter(request, response);
            return;
        }

        String header = httpRequest.getHeader("Authorization");
        if (ValidationUtil.isNullOrEmpty(header) || !header.startsWith("Bearer ")) {
            ApiResponseUtil.writeError(httpResponse, HttpServletResponse.SC_UNAUTHORIZED, "Missing bearer token.");
            return;
        }

        String token = header.substring("Bearer ".length()).trim();
        try {
            JwtUtil.JwtClaims claims = JwtUtil.verifyToken(token);
            User user = userDAO.findById(claims.getUserId());
            if (user == null) {
                ApiResponseUtil.writeError(httpResponse, HttpServletResponse.SC_UNAUTHORIZED, "User no longer exists.");
                return;
            }

            httpRequest.setAttribute("authenticatedUser", user);
            httpRequest.setAttribute("jwtClaims", claims);
            chain.doFilter(request, response);
        } catch (IllegalArgumentException ex) {
            ApiResponseUtil.writeError(httpResponse, HttpServletResponse.SC_UNAUTHORIZED, ex.getMessage());
        }
    }

    private boolean isPublicRoute(HttpServletRequest request) {
        String method = request.getMethod();
        String path = request.getRequestURI().substring(request.getContextPath().length());

        if (path.equals("/api/auth/login") || path.equals("/api/auth/register")) {
            return true;
        }

        if ("GET".equalsIgnoreCase(method) && (path.equals("/api/products") || path.equals("/api/products/"))) {
            return true;
        }

        return "GET".equalsIgnoreCase(method) && path.matches("/api/products/\\d+/?");
    }

    @Override public void init(FilterConfig filterConfig) {}
    @Override public void destroy() {}
}
