<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MithoCha Register</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@400;600;700&family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@400" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user/register.css">
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
                    Create your account to start your MithoCha journey today.
                </p>
            </div>
        </div>
    </section>

    <section class="form-panel">
        <div class="form-wrap">
            <p class="eyebrow">Account Creation</p>
            <h2 class="section-title">Create Account</h2>
            <p class="section-copy">Sign up now to enjoy exclusive access to our premium beverage collection.</p>

            <div class="login-switch">
                <span class="switch-item active">Register</span>
                <a class="switch-item" href="${pageContext.request.contextPath}/login">Login</a>
            </div>

            <%-- Error messages from AuthServlet --%>
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="form-error" style="color:#c0392b;margin-bottom:12px;">
                    ${errorMessage}
                </div>
            <% } %>

            <form class="login-form" method="post" action="${pageContext.request.contextPath}/register">
                <div class="field-group">
                    <label class="field-label" for="name">Full Name</label>
                    <input class="field-input" id="name" name="name" type="text" placeholder="Enter your full name" required>
                </div>

                <div class="field-group">
                    <label class="field-label" for="email">Email Address</label>
                    <input class="field-input" id="email" name="email" type="email" placeholder="Enter your email" required>
                </div>

                <div class="field-group">
                    <label class="field-label" for="password">Password</label>
                    <input class="field-input" id="password" name="password" type="password" placeholder="Enter password" required>
                </div>

                <div class="field-group">
                    <label class="field-label" for="confirmPassword">Confirm Password</label>
                    <input class="field-input" id="confirmPassword" name="confirmPassword" type="password" placeholder="Confirm password" required>
                </div>

                <button class="primary-button" type="submit">
                    Create Account
                    <span class="material-symbols-outlined">arrow_forward</span>
                </button>
            </form>

            <div class="form-divider">
                <p>Already have an account? <a class="inline-link" href="${pageContext.request.contextPath}/login">Login Here</a></p>
            </div>

            <p class="footer-note">Copyright 2026 MithoCha Beverages. All rights reserved.</p>
        </div>
    </section>
</main>
</body>
</html>


