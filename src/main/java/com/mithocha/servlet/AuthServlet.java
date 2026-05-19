package com.mithocha.servlet;

import com.mithocha.model.User;
import com.mithocha.service.UserService;
import com.mithocha.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * AuthServlet – handles Login, Registration, and Logout.
 *
 * URL mappings (also declared in web.xml for JSP direct-access fallback):
 *   GET  /login     → show login page
 *   POST /login     → process login form
 *   GET  /register  → show register page
 *   POST /register  → process register form
 *   GET  /logout    → invalidate session and redirect to login
 *
 * ── Frontend form mapping ──────────────────────────────────────────────────
 *
 * LOGIN  (login.jsp)
 *   <form method="post" action="${pageContext.request.contextPath}/login">
 *     <input name="email"    ...>   → request.getParameter("email")
 *     <input name="password" ...>   → request.getParameter("password")
 *   </form>
 *
 * REGISTER  (register.jsp)
 *   <form method="post" action="${pageContext.request.contextPath}/register">
 *     <input name="name"            ...>  → request.getParameter("name")
 *     <input name="email"           ...>  → request.getParameter("email")
 *     <input name="password"        ...>  → request.getParameter("password")
 *     <input name="confirmPassword" ...>  → request.getParameter("confirmPassword")
 *   </form>
 */
@WebServlet(urlPatterns = {"/login", "/register", "/logout"})
public class AuthServlet extends HttpServlet {

    private final UserService userService = new UserService();

    // ── GET ───────────────────────────────────────────────────────────────────

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        switch (path) {
            case "/login":
                // If already logged in, skip the login page
                if (SessionUtil.isLoggedIn(request)) {
                    response.sendRedirect(request.getContextPath() + "/dashboard");
                    return;
                }
                request.getRequestDispatcher("/WEB-INF/views/user/login.jsp")
                       .forward(request, response);
                break;

            case "/register":
                if (SessionUtil.isLoggedIn(request)) {
                    response.sendRedirect(request.getContextPath() + "/dashboard");
                    return;
                }
                request.getRequestDispatcher("/WEB-INF/views/user/register.jsp")
                       .forward(request, response);
                break;

            case "/logout":
                SessionUtil.invalidate(request);
                response.sendRedirect(request.getContextPath() + "/login");
                break;

            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    // ── POST ──────────────────────────────────────────────────────────────────

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String path = request.getServletPath();

        switch (path) {
            case "/login":
                handleLogin(request, response);
                break;
            case "/register":
                handleRegister(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        }
    }

    // ── HANDLERS ──────────────────────────────────────────────────────────────

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email    = request.getParameter("email");
        String password = request.getParameter("password");

        User user = userService.login(email, password);

        if (user == null) {
            request.setAttribute("errorMessage", "Invalid email or password. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/user/login.jsp")
                   .forward(request, response);
            return;
        }

        SessionUtil.setUser(request, user);

        // Route by role
        if ("admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        } else {
            response.sendRedirect(request.getContextPath() + "/dashboard");
        }
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name            = request.getParameter("name");
        String email           = request.getParameter("email");
        String password        = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Passwords must match
        if (password == null || !password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match.");
            request.getRequestDispatcher("/WEB-INF/views/user/register.jsp")
                   .forward(request, response);
            return;
        }

        int result = userService.register(name, email, password);

        switch (result) {
            case -1:
                request.setAttribute("errorMessage", "This email is already registered.");
                break;
            case -2:
                request.setAttribute("errorMessage", "Please enter a valid email address.");
                break;
            case -3:
                request.setAttribute("errorMessage", "Password must be at least 6 characters.");
                break;
            case -4:
                request.setAttribute("errorMessage", "Full name is required.");
                break;
            case -99:
                request.setAttribute("errorMessage", "Registration failed. Please try again.");
                break;
            default:
                // Success – redirect to login with a success flag
                response.sendRedirect(request.getContextPath() + "/login?registered=true");
                return;
        }

        request.getRequestDispatcher("/WEB-INF/views/user/register.jsp")
               .forward(request, response);
    }
}
