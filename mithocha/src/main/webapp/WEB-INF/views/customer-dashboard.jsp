<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MithoCha Customer Dashboard</title>
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
                <p class="eyebrow">Customer Dashboard</p>
                <h1 class="dashboard-title">Your Tea Lounge</h1>
                <p class="dashboard-copy">
                    Signed in as <strong data-field="customerEmail">--</strong>. Explore drinks, rewards, and order updates from one place.
                </p>
            </div>
            <div class="topbar-actions">
                <a class="secondary-button" href="admin-dashboard">Back To Admin</a>
                <a class="ghost-button" href="login">Log Out</a>
            </div>
        </div>
    </section>

    <section class="dashboard-grid">
        <div class="welcome-strip">
            <div>
                <p class="eyebrow eyebrow-light">Welcome Offer</p>
                <p data-field="welcomeOfferMessage">Promotional message placeholder</p>
            </div>
            <a class="secondary-button" href="#">Order Now</a>
        </div>
    </section>

    <section class="card-grid two-col">
        <article class="dashboard-card">
            <h2 class="card-title">Quick Access</h2>
            <p class="card-copy">Customer actions can be populated here after product, reward, and order data are connected.</p>
            <ul class="feature-list">
                <li class="feature-item">
                    <span class="feature-icon material-symbols-outlined">local_cafe</span>
                    <div class="feature-text">
                        <strong>Browse Signature Drinks</strong>
                        <span data-field="browseDrinksDescription">Product description placeholder</span>
                    </div>
                </li>
                <li class="feature-item">
                    <span class="feature-icon material-symbols-outlined">loyalty</span>
                    <div class="feature-text">
                        <strong>Rewards Wallet</strong>
                        <span data-field="rewardsDescription">Rewards description placeholder</span>
                    </div>
                </li>
                <li class="feature-item">
                    <span class="feature-icon material-symbols-outlined">delivery_dining</span>
                    <div class="feature-text">
                        <strong>Order Tracking</strong>
                        <span data-field="orderTrackingDescription">Order tracking description placeholder</span>
                    </div>
                </li>
            </ul>
        </article>

        <article class="dashboard-card">
            <h2 class="card-title">Latest Activity</h2>
            <p class="card-copy">Recent customer records can be rendered here from the database.</p>
            <ul class="activity-list">
                <li class="activity-item">
                    <span class="activity-icon material-symbols-outlined">receipt</span>
                    <div class="activity-text">
                        <strong data-field="customerActivityTitle1">Activity title</strong>
                        <span data-field="customerActivityDescription1">Activity description placeholder</span>
                    </div>
                </li>
                <li class="activity-item">
                    <span class="activity-icon material-symbols-outlined">stars</span>
                    <div class="activity-text">
                        <strong data-field="customerActivityTitle2">Activity title</strong>
                        <span data-field="customerActivityDescription2">Activity description placeholder</span>
                    </div>
                </li>
                <li class="activity-item">
                    <span class="activity-icon material-symbols-outlined">campaign</span>
                    <div class="activity-text">
                        <strong data-field="customerActivityTitle3">Activity title</strong>
                        <span data-field="customerActivityDescription3">Activity description placeholder</span>
                    </div>
                </li>
            </ul>
        </article>

        <article class="dashboard-card">
            <h2 class="card-title">Recommended For You</h2>
            <p class="card-copy">Recommendation cards can be filled from customer preference data later.</p>
            <ul class="feature-list">
                <li class="feature-item">
                    <span class="feature-icon material-symbols-outlined">favorite</span>
                    <div class="feature-text">
                        <strong data-field="recommendationTitle1">Recommendation title</strong>
                        <span data-field="recommendationDescription1">Recommendation description placeholder</span>
                    </div>
                </li>
                <li class="feature-item">
                    <span class="feature-icon material-symbols-outlined">cookie</span>
                    <div class="feature-text">
                        <strong data-field="recommendationTitle2">Recommendation title</strong>
                        <span data-field="recommendationDescription2">Recommendation description placeholder</span>
                    </div>
                </li>
            </ul>
        </article>

        <article class="dashboard-card">
            <div class="info-banner">
                <span class="material-symbols-outlined">person</span>
                <p data-field="customerBannerMessage">Customer banner message placeholder</p>
            </div>
        </article>
    </section>
</main>
</body>
</html>
