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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user/cart.css">
</head>
<body>
<header class="navbar">
    <div class="container nav-container">
        <a class="logo" href="${pageContext.request.contextPath}/dashboard">MithoCha</a>
        <nav class="nav-links" aria-label="Primary">
            <a href="${pageContext.request.contextPath}/dashboard">Home</a>
            <a href="${pageContext.request.contextPath}/products">Menu</a>
            <a href="${pageContext.request.contextPath}/profile">Profile</a>
        </nav>
        <a class="nav-icon cart-icon" href="${pageContext.request.contextPath}/cart" aria-label="Shopping Cart">
            <span class="material-symbols-outlined">shopping_cart</span>
            <span class="cart-count" id="cartCount">0</span>
        </a>
    </div>
</header>

<main class="content-shell">
    <div class="content-wrap">
        <section class="cart-container">
            <!-- Product Details Section -->
            <div class="cart-product-section">
                <div class="cart-back">
                    <span class="material-symbols-outlined">arrow_back</span>
                    <a href="${pageContext.request.contextPath}/products">BACK TO MENU</a>
                </div>

                <!-- Cart Items -->
                <div id="cartItemsContainer">
                    <!-- Items will be populated here by JavaScript -->
                    <div class="empty-cart-message">
                        <p>Your cart is empty</p>
                        <a class="btn-primary" href="${pageContext.request.contextPath}/products">View Menu</a>
                    </div>
                </div>
            </div>

            <!-- Order Summary Section -->
            <div class="order-summary-section">
                <div class="order-summary-card">
                    <h2 class="summary-title">Order Summary</h2>

                    <div id="summaryItemsContainer">
                        <!-- Summary items populated here -->
                    </div>

                    <div class="summary-divider"></div>

                    <div class="summary-row">
                        <span>Subtotal</span>
                        <span id="subtotal">Rs. 0</span>
                    </div>
                    <div class="summary-row">
                        <span>Delivery Fee</span>
                        <span id="deliveryFee">Rs. 50</span>
                    </div>

                    <div class="summary-divider"></div>

                    <div class="summary-row total">
                        <span>Total</span>
                        <span id="total">Rs. 50</span>
                    </div>

                    <div class="payment-section">
                        <h3 class="payment-title">PAYMENT METHOD</h3>
                        <label class="payment-option selected">
                            <input type="radio" name="payment" value="online" checked>
                            <span class="material-symbols-outlined">payment</span>
                            <span>Online Payment (Fonepay/Khalti)</span>
                        </label>
                        <label class="payment-option">
                            <input type="radio" name="payment" value="cod">
                            <span class="material-symbols-outlined">location_on</span>
                            <span>Cash on Delivery</span>
                        </label>
                    </div>

                    <button class="confirm-order-btn" onclick="handleConfirmOrder()">CONFIRM ORDER</button>
                </div>
            </div>
        </section>
    </div>
</main>

<footer class="footer">
    <div class="footer-container">
        <div class="footer-links">
            <div>
                <h4>Customer Care</h4>
                <p>Contact Us</p>
                <p>Track Order</p>
                <p>FAQ</p>
            </div>
            <div>
                <h4>Our Company</h4>
                <p>About Us</p>
                <p>Careers</p>
                <p>Sustainability</p>
            </div>
            <div>
                <h4>Legal</h4>
                <p>Terms of Use</p>
                <p>Privacy Policy</p>
                <p>Accessibility</p>
            </div>
        </div>
        <div class="footer-bottom">
            <p>© 2026 MithoCha Beverages. All rights reserved.</p>
        </div>
    </div>
</footer>


</body>
</html>

