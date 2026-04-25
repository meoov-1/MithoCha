<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MithoCha Inventory</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@400;600;700&family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/app.css">
</head>
<body>
<main class="content-shell">
    <div class="content-wrap">
        <section class="page-hero">
            <p class="page-tag">Inventory</p>
            <h1 class="page-title">Inventory Placeholder View</h1>
            <p class="page-copy">This page is ready for stock, reorder, and supplier values. All sample stock levels and progress bars have been removed.</p>
        </section>
        <section class="page-card placeholder-stack">
            <h2 class="placeholder-title">Inventory Items</h2>
            <table class="placeholder-table">
                <thead>
                <tr><th>Item</th><th>Category</th><th>Stock Level</th><th>Reorder Point</th><th>Status</th></tr>
                </thead>
                <tbody>
                <tr>
                    <td data-field="inventoryItemName">--</td>
                    <td data-field="inventoryCategory">--</td>
                    <td data-field="inventoryStock">--</td>
                    <td data-field="inventoryReorderPoint">--</td>
                    <td data-field="inventoryStatus">--</td>
                </tr>
                </tbody>
            </table>
        </section>
    </div>
</main>
</body>
</html>
