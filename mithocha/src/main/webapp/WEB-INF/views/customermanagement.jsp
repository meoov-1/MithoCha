<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MithoCha Customer Management</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@400;600;700&family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/app.css">
</head>
<body>
<main class="content-shell">
    <div class="content-wrap">
        <section class="page-hero">
            <p class="page-tag">Customer Management</p>
            <h1 class="page-title">Customer Records View</h1>
            <p class="page-copy">Use this page to render customer profiles, status, loyalty, and contact details from the database. All sample customers have been removed.</p>
        </section>
        <section class="page-card placeholder-stack">
            <h2 class="placeholder-title">Customer Table</h2>
            <table class="placeholder-table">
                <thead>
                <tr>
                    <th>Customer Id</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Status</th>
                    <th>Loyalty Points</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td data-field="customerId">--</td>
                    <td data-field="customerName">--</td>
                    <td data-field="customerEmail">--</td>
                    <td data-field="customerStatus">--</td>
                    <td data-field="customerPoints">--</td>
                </tr>
                </tbody>
            </table>
        </section>
    </div>
</main>
</body>
</html>
