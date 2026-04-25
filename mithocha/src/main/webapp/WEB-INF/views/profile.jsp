<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MithoCha Profile</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@400;600;700&family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/app.css">
</head>
<body>
<main class="content-shell">
    <div class="content-wrap">
        <section class="page-hero">
            <p class="page-tag">Profile</p>
            <h1 class="page-title">Customer Profile Placeholder</h1>
            <p class="page-copy">Personal details, payment methods, loyalty balances, and order history should be rendered here from user-related tables.</p>
        </section>
        <section class="placeholder-grid">
            <article class="page-card placeholder-stack">
                <h2 class="placeholder-title">Profile Details</h2>
                <table class="placeholder-table">
                    <tbody>
                    <tr><td>Name</td><td data-field="profileName">--</td></tr>
                    <tr><td>Email</td><td data-field="profileEmail">--</td></tr>
                    <tr><td>Phone</td><td data-field="profilePhone">--</td></tr>
                    <tr><td>Loyalty Points</td><td data-field="profilePoints">--</td></tr>
                    </tbody>
                </table>
            </article>
            <article class="page-card placeholder-stack">
                <h2 class="placeholder-title">Recent Orders</h2>
                <table class="placeholder-table">
                    <thead><tr><th>Order Id</th><th>Status</th><th>Total</th></tr></thead>
                    <tbody><tr><td data-field="profileOrderId">--</td><td data-field="profileOrderStatus">--</td><td data-field="profileOrderTotal">--</td></tr></tbody>
                </table>
            </article>
        </section>
    </div>
</main>
</body>
</html>
