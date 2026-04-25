<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    <link rel="stylesheet" href="css/app.css">
</head>
<body>
<main class="dashboard-shell">
    <section class="dashboard-header">
        <div class="topbar">
            <div class="topbar-main">
                <p class="eyebrow">Admin Dashboard</p>
                <h1 class="dashboard-title">MithoCha Control Room</h1>
                <p class="dashboard-copy">
                    Welcome, <strong data-field="adminEmail">--</strong>. This admin area is ready for operational, inventory, order, and customer data from the backend.
                </p>
            </div>
            <div class="topbar-actions">
                <a class="secondary-button" href="customer-dashboard">View Customer Side</a>
                <a class="ghost-button" href="login">Log Out</a>
            </div>
        </div>
    </section>

    <section class="dashboard-grid">
        <div class="metric-grid">
            <article class="metric-card">
                <p class="metric-label">Daily Orders</p>
                <h2 class="metric-value" data-field="dailyOrders">--</h2>
                <p class="metric-note" data-field="dailyOrdersTrend">Pending database value</p>
            </article>
            <article class="metric-card">
                <p class="metric-label">Revenue</p>
                <h2 class="metric-value" data-field="revenue">--</h2>
                <p class="metric-note" data-field="revenueNote">Pending database value</p>
            </article>
            <article class="metric-card">
                <p class="metric-label">Inventory Alerts</p>
                <h2 class="metric-value" data-field="inventoryAlerts">--</h2>
                <p class="metric-note" data-field="inventoryNote">Pending database value</p>
            </article>
            <article class="metric-card">
                <p class="metric-label">Customer Satisfaction</p>
                <h2 class="metric-value" data-field="customerSatisfaction">--</h2>
                <p class="metric-note" data-field="customerSatisfactionNote">Pending database value</p>
            </article>
        </div>
    </section>

    <section class="card-grid two-col">
        <article class="dashboard-card">
            <h2 class="card-title">Admin Controls</h2>
            <p class="card-copy">These sections are placeholders for admin functions that will be populated from backend modules.</p>
            <ul class="feature-list">
                <li class="feature-item">
                    <span class="feature-icon material-symbols-outlined">inventory_2</span>
                    <div class="feature-text">
                        <strong>Inventory Monitoring</strong>
                        <span data-field="inventoryMonitoringDescription">Inventory data placeholder</span>
                    </div>
                </li>
                <li class="feature-item">
                    <span class="feature-icon material-symbols-outlined">receipt_long</span>
                    <div class="feature-text">
                        <strong>Order Supervision</strong>
                        <span data-field="orderSupervisionDescription">Order data placeholder</span>
                    </div>
                </li>
                <li class="feature-item">
                    <span class="feature-icon material-symbols-outlined">group</span>
                    <div class="feature-text">
                        <strong>Customer Insights</strong>
                        <span data-field="customerInsightsDescription">Customer data placeholder</span>
                    </div>
                </li>
            </ul>
        </article>

        <article class="dashboard-card">
            <h2 class="card-title">Recent Admin Activity</h2>
            <p class="card-copy">Recent activity cards are ready for records loaded from the database.</p>
            <ul class="activity-list">
                <li class="activity-item">
                    <span class="activity-icon material-symbols-outlined">shopping_bag</span>
                    <div class="activity-text">
                        <strong data-field="activityTitle1">Activity title</strong>
                        <span data-field="activityDescription1">Activity description placeholder</span>
                    </div>
                </li>
                <li class="activity-item">
                    <span class="activity-icon material-symbols-outlined">warning</span>
                    <div class="activity-text">
                        <strong data-field="activityTitle2">Activity title</strong>
                        <span data-field="activityDescription2">Activity description placeholder</span>
                    </div>
                </li>
                <li class="activity-item">
                    <span class="activity-icon material-symbols-outlined">monitoring</span>
                    <div class="activity-text">
                        <strong data-field="activityTitle3">Activity title</strong>
                        <span data-field="activityDescription3">Activity description placeholder</span>
                    </div>
                </li>
            </ul>
        </article>

        <article class="dashboard-card">
            <div class="info-banner">
                <span class="material-symbols-outlined">shield_lock</span>
                <p data-field="adminBannerMessage">Admin banner message placeholder</p>
            </div>
        </article>

        <article class="dashboard-card">
            <h2 class="card-title">Recommended Actions</h2>
            <p class="card-copy">Action recommendations can be rendered here after database integration.</p>
            <ul class="feature-list">
                <li class="feature-item">
                    <span class="feature-icon material-symbols-outlined">local_shipping</span>
                    <div class="feature-text">
                        <strong data-field="recommendationTitle1">Recommendation title</strong>
                        <span data-field="recommendationDescription1">Recommendation description placeholder</span>
                    </div>
                </li>
                <li class="feature-item">
                    <span class="feature-icon material-symbols-outlined">sell</span>
                    <div class="feature-text">
                        <strong data-field="recommendationTitle2">Recommendation title</strong>
                        <span data-field="recommendationDescription2">Recommendation description placeholder</span>
                    </div>
                </li>
            </ul>
        </article>
    </section>
</main>
</body>
</html>
