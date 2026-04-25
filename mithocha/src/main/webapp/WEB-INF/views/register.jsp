<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MithoCha Register</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@400;600;700&family=Be+Vietnam+Pro:wght@400;500;600;700&family=Material+Symbols+Outlined:wght@400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/app.css">
</head>
<body>
<main class="content-shell">
    <div class="content-wrap">
        <section class="page-hero">
            <p class="page-tag">Register</p>
            <h1 class="page-title">Registration Form Placeholder</h1>
            <p class="page-copy">Registration fields remain in place, but mock account values have been removed so this can connect cleanly to user creation logic later.</p>
        </section>
        <section class="page-card placeholder-stack">
            <div class="placeholder-grid">
                <div class="placeholder-field"><label>Full Name</label><input data-field="registerName" placeholder="Bind user name"></div>
                <div class="placeholder-field"><label>Email</label><input data-field="registerEmail" placeholder="Bind email"></div>
                <div class="placeholder-field"><label>Phone</label><input data-field="registerPhone" placeholder="Bind phone"></div>
                <div class="placeholder-field"><label>Password</label><input type="password" data-field="registerPassword" placeholder="Bind password input"></div>
            </div>
            <div class="placeholder-actions">
                <button class="primary-button" type="button">Create Account</button>
                <a class="ghost-button" href="login">Back To Login</a>
            </div>
        </section>
    </div>
</main>
</body>
</html>
