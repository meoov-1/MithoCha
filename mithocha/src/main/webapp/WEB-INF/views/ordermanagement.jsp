<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MithoCha Order Management</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@400;600;700&family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/app.css">
</head>
<body>
<main class="content-shell">
    <div class="content-wrap">
        <section class="page-hero">
            <p class="page-tag">Order Management</p>
            <h1 class="page-title">Order Queue Placeholder</h1>
            <p class="page-copy">Connect this page to order, order item, customer, and fulfillment tables. Demo orders and statuses have been removed.</p>
        </section>
        <section class="page-card placeholder-stack">
            <h2 class="placeholder-title">Orders Table</h2>
            <table class="placeholder-table">
                <thead><tr><th>Order Id</th><th>Customer</th><th>Status</th><th>Total</th><th>Created At</th></tr></thead>
                <tbody><tr><td data-field="orderId">--</td><td data-field="orderCustomer">--</td><td data-field="orderStatus">--</td><td data-field="orderTotal">--</td><td data-field="orderCreatedAt">--</td></tr></tbody>
            </table>
        </section>
    </div>
</main>
</body>
</html>
