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

@WebFilter("/api/admin/*")
public class AdminJwtFilter implements Filter {

    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        if ("OPTIONS".equalsIgnoreCase(httpRequest.getMethod())) {
            chain.doFilter(request, response);
            return;
        }

        User user = (User) httpRequest.getAttribute("authenticatedUser");
        if (user == null) {
            String header = httpRequest.getHeader("Authorization");
            if (ValidationUtil.isNullOrEmpty(header) || !header.startsWith("Bearer ")) {
                ApiResponseUtil.writeError(httpResponse, HttpServletResponse.SC_UNAUTHORIZED, "Missing bearer token.");
                return;
            }
            try {
                JwtUtil.JwtClaims claims = JwtUtil.verifyToken(header.substring("Bearer ".length()).trim());
                user = userDAO.findById(claims.getUserId());
                if (user != null) {
                    httpRequest.setAttribute("authenticatedUser", user);
                }
            } catch (IllegalArgumentException ex) {
                ApiResponseUtil.writeError(httpResponse, HttpServletResponse.SC_UNAUTHORIZED, ex.getMessage());
                return;
            }
        }

        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            ApiResponseUtil.writeError(httpResponse, HttpServletResponse.SC_FORBIDDEN, "Admin access is required.");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override public void init(FilterConfig filterConfig) {}
    @Override public void destroy() {}
}
