<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MithoCha Billing</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@400;600;700&family=Be+Vietnam+Pro:wght@400;500;600;700&family=Material+Symbols+Outlined:wght@400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/app.css">
</head>
<body>
<main class="content-shell">
    <div class="content-wrap">
        <section class="page-hero">
            <p class="page-tag">Billing</p>
            <h1 class="page-title">Billing And Invoice View</h1>
            <p class="page-copy">All invoice, payment, and billing fields below are placeholders. Replace them with values loaded from order, customer, and payment tables.</p>
        </section>

        <section class="placeholder-grid">
            <article class="page-card placeholder-stack">
                <h2 class="placeholder-title">Invoice Header</h2>
                <div class="placeholder-field">
                    <label>Invoice Number</label>
                    <input data-field="invoiceNumber" placeholder="Bind invoice number">
                </div>
                <div class="placeholder-field">
                    <label>Customer Id</label>
                    <input data-field="customerId" placeholder="Bind customer id">
                </div>
                <div class="placeholder-field">
                    <label>Billing Date</label>
                    <input data-field="billingDate" placeholder="Bind billing date">
                </div>
            </article>

            <article class="page-card placeholder-stack">
                <h2 class="placeholder-title">Payment Summary</h2>
                <table class="placeholder-table">
                    <thead>
                    <tr>
                        <th>Field</th>
                        <th>Database Placeholder</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr><td>Subtotal</td><td data-field="subtotal">--</td></tr>
                    <tr><td>Tax</td><td data-field="taxAmount">--</td></tr>
                    <tr><td>Discount</td><td data-field="discountAmount">--</td></tr>
                    <tr><td>Total</td><td data-field="totalAmount">--</td></tr>
                    <tr><td>Payment Status</td><td data-field="paymentStatus">--</td></tr>
                    </tbody>
                </table>
            </article>
        </section>

        <section class="page-card placeholder-stack">
            <h2 class="placeholder-title">Invoice Line Items</h2>
            <p class="placeholder-copy">Render invoice rows here from joined order item and product records.</p>
            <table class="placeholder-table">
                <thead>
                <tr>
                    <th>Item</th>
                    <th>Quantity</th>
                    <th>Unit Price</th>
                    <th>Amount</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td data-field="billingItemName">Item placeholder</td>
                    <td data-field="billingItemQuantity">--</td>
                    <td data-field="billingItemPrice">--</td>
                    <td data-field="billingItemAmount">--</td>
                </tr>
                </tbody>
            </table>
        </section>
    </div>
</main>
</body>
</html>
