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
                    Signed in as <strong>guest@mithocha.com</strong>. Explore drinks, check rewards, and follow your latest orders from one place.
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
                <p>Enjoy 15% off your next handcrafted drink and unlock double reward points before checkout closes tonight.</p>
            </div>
            <a class="secondary-button" href="#">Order Now</a>
        </div>
    </section>

    <section class="card-grid two-col">
        <article class="dashboard-card">
            <h2 class="card-title">Quick Access</h2>
            <p class="card-copy">The customer side focuses on ordering, rewards, and drink discovery.</p>
            <ul class="feature-list">
                <li class="feature-item">
                    <span class="feature-icon material-symbols-outlined">local_cafe</span>
                    <div class="feature-text">
                        <strong>Browse Signature Drinks</strong>
                        <span>Explore brown sugar classics, fruit teas, matcha blends, and creamy cheese foam favorites.</span>
                    </div>
                </li>
                <li class="feature-item">
                    <span class="feature-icon material-symbols-outlined">loyalty</span>
                    <div class="feature-text">
                        <strong>Rewards Wallet</strong>
                        <span>Track your loyalty balance, available coupons, and next milestone drink reward.</span>
                    </div>
                </li>
                <li class="feature-item">
                    <span class="feature-icon material-symbols-outlined">delivery_dining</span>
                    <div class="feature-text">
                        <strong>Order Tracking</strong>
                        <span>See whether your drink is being prepared, packed, or already on the way.</span>
                    </div>
                </li>
            </ul>
        </article>

        <article class="dashboard-card">
            <h2 class="card-title">Latest Activity</h2>
            <p class="card-copy">A customer-focused view of recent visits and current perks.</p>
            <ul class="activity-list">
                <li class="activity-item">
                    <span class="activity-icon material-symbols-outlined">receipt</span>
                    <div class="activity-text">
                        <strong>Last order: Brown Sugar Boba Latte</strong>
                        <span>Prepared successfully with less ice and extra cream foam.</span>
                    </div>
                </li>
                <li class="activity-item">
                    <span class="activity-icon material-symbols-outlined">stars</span>
                    <div class="activity-text">
                        <strong>Reward points available: 240</strong>
                        <span>You are one purchase away from a free large handcrafted milk tea.</span>
                    </div>
                </li>
                <li class="activity-item">
                    <span class="activity-icon material-symbols-outlined">campaign</span>
                    <div class="activity-text">
                        <strong>Weekend seasonal drop is live</strong>
                        <span>Try the roasted oolong cream line before the limited batch runs out.</span>
                    </div>
                </li>
            </ul>
        </article>

        <article class="dashboard-card">
            <h2 class="card-title">Recommended For You</h2>
            <p class="card-copy">Suggestions based on premium dessert-tea preferences.</p>
            <ul class="feature-list">
                <li class="feature-item">
                    <span class="feature-icon material-symbols-outlined">favorite</span>
                    <div class="feature-text">
                        <strong>Velvet Matcha Cloud</strong>
                        <span>Balanced matcha depth with smooth cream topping and soft sweetness.</span>
                    </div>
                </li>
                <li class="feature-item">
                    <span class="feature-icon material-symbols-outlined">cookie</span>
                    <div class="feature-text">
                        <strong>Brown Sugar Pearl Special</strong>
                        <span>A rich caramel profile with warm syrup ribbons and fresh chewy pearls.</span>
                    </div>
                </li>
            </ul>
        </article>

        <article class="dashboard-card">
            <div class="info-banner">
                <span class="material-symbols-outlined">person</span>
                <p>Non-admin logins land here automatically. This keeps customer browsing separate from store management tools.</p>
            </div>
        </article>
    </section>
</main>
</body>
</html>
