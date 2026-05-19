package com.mithocha.filter;

import com.mithocha.util.SessionUtil;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * AuthFilter – protects routes that require a logged-in user.
 *
 * Protected user routes:  /dashboard, /cart, /profile, /orders
 * Protected admin routes: /admin/*
 *
 * Public routes (no filter): /login, /register, /logout, /products, /product-detail
 */
@WebFilter(urlPatterns = {"/dashboard", "/cart", "/profile", "/orders", "/admin/*"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest  request  = (HttpServletRequest)  servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        String path = request.getServletPath();

        if (!SessionUtil.isLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Admin-only area
        if (path.startsWith("/admin") && !SessionUtil.isAdmin(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN,
                    "You do not have permission to access this page.");
            return;
        }

        chain.doFilter(servletRequest, servletResponse);
    }

    @Override public void init(FilterConfig config) {}
    @Override public void destroy() {}
}
