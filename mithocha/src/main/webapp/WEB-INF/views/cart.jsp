<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MithoCha Cart</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@400;600;700&family=Be+Vietnam+Pro:wght@400;500;600;700&family=Material+Symbols+Outlined:wght@400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/app.css">
</head>
<body>
<main class="content-shell">
    <div class="content-wrap">
        <section class="page-hero">
            <p class="page-tag">Cart</p>
            <h1 class="page-title">Cart And Checkout Placeholder</h1>
            <p class="page-copy">This view no longer contains sample products, prices, or customer totals. Bind it to cart, cart item, product, and payment data.</p>
        </section>

        <section class="placeholder-grid">
            <article class="page-card placeholder-stack">
                <h2 class="placeholder-title">Selected Item</h2>
                <table class="placeholder-table">
                    <tbody>
                    <tr><td>Product Name</td><td data-field="cartProductName">--</td></tr>
                    <tr><td>Variant</td><td data-field="cartVariant">--</td></tr>
                    <tr><td>Quantity</td><td data-field="cartQuantity">--</td></tr>
                    <tr><td>Unit Price</td><td data-field="cartUnitPrice">--</td></tr>
                    </tbody>
                </table>
            </article>

            <article class="page-card placeholder-stack">
                <h2 class="placeholder-title">Checkout Summary</h2>
                <table class="placeholder-table">
                    <tbody>
                    <tr><td>Subtotal</td><td data-field="cartSubtotal">--</td></tr>
                    <tr><td>Delivery Fee</td><td data-field="deliveryFee">--</td></tr>
                    <tr><td>Discount</td><td data-field="cartDiscount">--</td></tr>
                    <tr><td>Total</td><td data-field="cartTotal">--</td></tr>
                    </tbody>
                </table>
            </article>
        </section>

        <section class="page-card placeholder-stack">
            <h2 class="placeholder-title">Checkout Inputs</h2>
            <div class="placeholder-grid">
                <div class="placeholder-field">
                    <label>Delivery Address</label>
                    <textarea data-field="deliveryAddress" rows="3" placeholder="Bind address"></textarea>
                </div>
                <div class="placeholder-field">
                    <label>Payment Method</label>
                    <select data-field="paymentMethod">
                        <option>Select from database-backed payment methods</option>
                    </select>
                </div>
            </div>
            <div class="placeholder-actions">
                <button class="primary-button" type="button">Place Order</button>
                <button class="ghost-button" type="button">Update Cart</button>
            </div>
        </section>
    </div>
</main>
</body>
</html>
