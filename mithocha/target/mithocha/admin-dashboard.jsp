<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
String role = (String) session.getAttribute("role");
if (!"admin".equals(role)) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}
String userEmail = (String) session.getAttribute("userEmail");
if (userEmail == null || userEmail.trim().isEmpty()) {
    userEmail = "admin@mithocha.com";
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MithoCha Admin Dashboard</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@400;600;700&family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@400" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/app.css">
</head>
<body>
<main class="dashboard-shell">
    <section class="dashboard-header">
        <div class="topbar">
            <div class="topbar-main">
                <p class="eyebrow">Admin Dashboard</p>
                <h1 class="dashboard-title">MithoCha Control Room</h1>
                <p class="dashboard-copy">
                    Welcome, <strong><%= userEmail %></strong>. This admin area is reserved for operational control, inventory oversight, order flow, and customer performance monitoring.
                </p>
            </div>
            <div class="topbar-actions">
                <a class="secondary-button" href="<%= request.getContextPath() %>/customer-dashboard.jsp">View Customer Side</a>
                <a class="ghost-button" href="<%= request.getContextPath() %>/login.jsp?action=logout">Log Out</a>
            </div>
        </div>
    </section>

    <section class="dashboard-grid">
        <div class="metric-grid">
            <article class="metric-card">
                <p class="metric-label">Daily Orders</p>
                <h2 class="metric-value">284</h2>
                <p class="metric-note">+18% from yesterday</p>
            </article>
            <article class="metric-card">
                <p class="metric-label">Revenue</p>
                <h2 class="metric-value">$4,820</h2>
                <p class="metric-note">Premium drinks driving margin growth</p>
            </article>
            <article class="metric-card">
                <p class="metric-label">Inventory Alerts</p>
                <h2 class="metric-value">06</h2>
                <p class="metric-note">Brown sugar pearls need restock today</p>
            </article>
            <article class="metric-card">
                <p class="metric-label">Customer Satisfaction</p>
                <h2 class="metric-value">4.9/5</h2>
                <p class="metric-note">Based on recent in-app ratings</p>
            </article>
        </div>
    </section>

    <section class="card-grid two-col">
        <article class="dashboard-card">
            <h2 class="card-title">Admin Controls</h2>
            <p class="card-copy">Everything needed for the management team is grouped here for fast daily operations.</p>
            <ul class="feature-list">
                <li class="feature-item">
                    <span class="feature-icon material-symbols-outlined">inventory_2</span>
                    <div class="feature-text">
                        <strong>Inventory Monitoring</strong>
                        <span>Track pearls, syrups, tea leaves, cream toppings, and packaging supplies.</span>
                    </div>
                </li>
                <li class="feature-item">
                    <span class="feature-icon material-symbols-outlined">receipt_long</span>
                    <div class="feature-text">
                        <strong>Order Supervision</strong>
                        <span>Review incoming orders, preparation status, and outlet-level fulfillment speed.</span>
                    </div>
                </li>
                <li class="feature-item">
                    <span class="feature-icon material-symbols-outlined">group</span>
                    <div class="feature-text">
                        <strong>Customer Insights</strong>
                        <span>See customer trends, repeat purchases, and high-value loyalty members.</span>
                    </div>
                </li>
            </ul>
        </article>

        <article class="dashboard-card">
            <h2 class="card-title">Recent Admin Activity</h2>
            <p class="card-copy">A quick view of the latest system events across stores and operations.</p>
            <ul class="activity-list">
                <li class="activity-item">
                    <span class="activity-icon material-symbols-outlined">shopping_bag</span>
                    <div class="activity-text">
                        <strong>47 new orders in the last hour</strong>
                        <span>Most demand is concentrated on brown sugar milk tea and taro cream specials.</span>
                    </div>
                </li>
                <li class="activity-item">
                    <span class="activity-icon material-symbols-outlined">warning</span>
                    <div class="activity-text">
                        <strong>Low stock warning issued</strong>
                        <span>Tapioca pearls at the central branch fell below the configured safety threshold.</span>
                    </div>
                </li>
                <li class="activity-item">
                    <span class="activity-icon material-symbols-outlined">monitoring</span>
                    <div class="activity-text">
                        <strong>Sales trend updated</strong>
                        <span>Weekend tea bundles are outperforming the prior weekly campaign by 24%.</span>
                    </div>
                </li>
            </ul>
        </article>

        <article class="dashboard-card">
            <div class="info-banner">
                <span class="material-symbols-outlined">shield_lock</span>
                <p>This page is restricted to the admin login. Direct access without the admin session sends users back to the login page.</p>
            </div>
        </article>

        <article class="dashboard-card">
            <h2 class="card-title">Recommended Actions</h2>
            <p class="card-copy">Operational suggestions based on current load and stock movement.</p>
            <ul class="feature-list">
                <li class="feature-item">
                    <span class="feature-icon material-symbols-outlined">local_shipping</span>
                    <div class="feature-text">
                        <strong>Place supplier request</strong>
                        <span>Restock pearls, Assam black tea, and signature brown sugar syrup before evening rush.</span>
                    </div>
                </li>
                <li class="feature-item">
                    <span class="feature-icon material-symbols-outlined">sell</span>
                    <div class="feature-text">
                        <strong>Push premium combo offer</strong>
                        <span>Bundle best-selling drinks with mochi toppings to lift average order value.</span>
                    </div>
                </li>
            </ul>
        </article>
    </section>
</main>
</body>
</html>
