<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
String action = request.getParameter("action");
if ("logout".equals(action)) {
    session.invalidate();
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}

String role = (String) session.getAttribute("role");
if ("admin".equals(role)) {
    response.sendRedirect(request.getContextPath() + "/admin-dashboard.jsp");
    return;
}
if ("customer".equals(role)) {
    response.sendRedirect(request.getContextPath() + "/customer-dashboard.jsp");
    return;
}

String errorMessage = null;
String emailValue = "";

if ("POST".equalsIgnoreCase(request.getMethod())) {
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    emailValue = email == null ? "" : email.trim();
    String normalizedEmail = emailValue.toLowerCase();
    String safePassword = password == null ? "" : password.trim();

    if (normalizedEmail.isEmpty() || safePassword.isEmpty()) {
        errorMessage = "Enter both email and password to continue.";
    } else if ("admin@mithocha.com".equals(normalizedEmail) && "admin123".equals(safePassword)) {
        session.setAttribute("role", "admin");
        session.setAttribute("userEmail", emailValue);
        response.sendRedirect(request.getContextPath() + "/admin-dashboard.jsp");
        return;
    } else {
        session.setAttribute("role", "customer");
        session.setAttribute("userEmail", emailValue);
        response.sendRedirect(request.getContextPath() + "/customer-dashboard.jsp");
        return;
    }
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MithoCha Login</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@400;600;700&family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@400" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/app.css">
</head>
<body>
<main class="page-shell login-layout">
    <section class="hero-panel">
        <img
            class="hero-image"
            src="https://lh3.googleusercontent.com/aida-public/AB6AXuACGxO8xr0nyMb65vac8rXshEy74n8NXLgzH1WhC4z37UKePJS7CwUxDz5DCbTL3wvukoMYezjU_RcKkViyCcSOScg-rODKf1DB1OziEjE96dwUligoPxR0bTMwwfde3a4VJGl_lBoTKjMM3AtwoYv-fVn_LNuRrAshJXetlR6v70okFw4FkpsaMHqdXg8Az-8JmE0B8b3fWFec_7qsjsh3OO2gYjg5OP2Fe-LUwU4YN4fbd8qxxLTlifJznG3_MvRyXRWz2k-YB7YY"
            alt="Premium bubble tea">
        <div class="hero-overlay"></div>
        <div class="flavor-tags">
            <span class="tag">Floral</span>
            <span class="tag">Nutty</span>
            <span class="tag">Velvety</span>
        </div>
        <div class="hero-content">
            <div class="brand-row">
                <span class="material-symbols-outlined brand-mark">coffee</span>
                <h1 class="brand-title">MithoCha</h1>
            </div>
            <div>
                <h2 class="display-title">Mastering the Art of the Perfect Brew.</h2>
                <p class="hero-text">
                    The ultimate dashboard for managing your premium bubble tea experience. Secure, intuitive, and built for excellence.
                </p>
            </div>
        </div>
    </section>

    <section class="form-panel">
        <div class="form-wrap">
            <p class="eyebrow">Access Portal</p>
            <h2 class="section-title">Welcome Back</h2>
            <p class="section-copy">Use the admin account to enter the admin dashboard. Any other login opens the customer dashboard.</p>

            <% if (errorMessage != null) { %>
            <div class="login-message error"><%= errorMessage %></div>
            <% } %>

            <div class="login-switch">
                <span class="switch-item active">Login</span>
                <a class="switch-item" href="#">Register</a>
            </div>

            <form class="login-form" method="post" action="<%= request.getContextPath() %>/login.jsp">
                <div class="field-group">
                    <label class="field-label" for="email">Email Address</label>
                    <input class="field-input" id="email" name="email" type="email" placeholder="admin@mithocha.com" value="<%= emailValue %>">
                </div>

                <div class="field-group">
                    <div class="field-header">
                        <label class="field-label" for="password">Password</label>
                        <a class="field-link" href="#">Forgot?</a>
                    </div>
                    <input class="field-input" id="password" name="password" type="password" placeholder="Enter password">
                </div>

                <label class="checkbox-row" for="remember">
                    <input id="remember" name="remember" type="checkbox">
                    <span>Remember this device for 30 days</span>
                </label>

                <button class="primary-button" type="submit">
                    Log In
                    <span class="material-symbols-outlined">arrow_forward</span>
                </button>
            </form>

            <div class="form-divider">
                <p>Admin demo: <strong>admin@mithocha.com / admin123</strong></p>
                <p>Any other email/password goes to the customer dashboard.</p>
                <p>Need an account? <a class="inline-link" href="#">Register Now</a></p>
            </div>

            <p class="footer-note">© 2026 MithoCha Beverages. All rights reserved.</p>
        </div>
    </section>
</main>

<div class="status-badge">
    <span class="status-dot"></span>
    <span>System Status: Secure</span>
</div>
</body>
</html>
