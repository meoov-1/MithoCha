<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MithoCha Menu Management</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@400;600;700&family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/app.css">
</head>
<body>
<main class="content-shell">
    <div class="content-wrap">
        <section class="page-hero">
            <p class="page-tag">Menu Management</p>
            <h1 class="page-title">Menu Administration Placeholder</h1>
            <p class="page-copy">Use this view to render categories, products, sizes, toppings, and price settings from database tables.</p>
        </section>
        <section class="placeholder-grid">
            <article class="page-card placeholder-stack">
                <h2 class="placeholder-title">Product Editor</h2>
                <div class="placeholder-field"><label>Product Name</label><input data-field="menuProductName" placeholder="Bind product name"></div>
                <div class="placeholder-field"><label>Category</label><input data-field="menuCategory" placeholder="Bind category"></div>
                <div class="placeholder-field"><label>Base Price</label><input data-field="menuBasePrice" placeholder="Bind price"></div>
            </article>
            <article class="page-card placeholder-stack">
                <h2 class="placeholder-title">Menu Listing</h2>
                <table class="placeholder-table">
                    <thead><tr><th>Product</th><th>Category</th><th>Status</th></tr></thead>
                    <tbody><tr><td data-field="menuTableProduct">--</td><td data-field="menuTableCategory">--</td><td data-field="menuTableStatus">--</td></tr></tbody>
                </table>
            </article>
        </section>
    </div>
</main>
</body>
</html>
