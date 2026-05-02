<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MithoCha Product Details</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@400;600;700&family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@400" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user/product-detail.css">
</head>
<body>
<header class="navbar">
    <div class="container nav-container">
        <a class="logo" href="${pageContext.request.contextPath}/dashboard">MithoCha</a>
        <nav class="nav-links" aria-label="Primary">
            <a href="${pageContext.request.contextPath}/dashboard">Home</a>
            <a class="active" href="${pageContext.request.contextPath}/products">Menu</a>
            <a href="${pageContext.request.contextPath}/profile">Profile</a>
        </nav>
        <a class="nav-icon cart-icon" href="${pageContext.request.contextPath}/cart" aria-label="Shopping Cart">
            <span class="material-symbols-outlined">shopping_cart</span>
            <span class="cart-count" id="cartCount">0</span>
        </a>
    </div>
</header>

<main class="detail-main container">
    <a class="back-link" href="${pageContext.request.contextPath}/products">
        <span class="material-symbols-outlined">arrow_back</span>
        Back to Menu
    </a>

    <section class="detail-layout">
        <div class="detail-config">
            <div class="product-heading">
                <img id="productImage" src="" alt="Selected drink">
                <div>
                    <h1 id="productName">Bubble Tea</h1>
                    <p id="productDescription">Customize your drink before adding it to cart.</p>
                    <div class="product-tags">
                        <span>MithoCha Special</span>
                        <span>Freshly Brewed</span>
                    </div>
                </div>
            </div>

            <div class="option-group">
                <h2>Cup Size</h2>
                <div class="size-grid">
                    <label class="option-card selected">
                        <input type="radio" name="cupSize" value="Regular" data-extra="0" checked>
                        <span class="material-symbols-outlined">local_cafe</span>
                        <strong>Regular</strong>
                        <small>500ml</small>
                    </label>
                    <label class="option-card">
                        <input type="radio" name="cupSize" value="Large" data-extra="150">
                        <span class="material-symbols-outlined">local_cafe</span>
                        <strong>Large</strong>
                        <small>+ Rs. 150</small>
                    </label>
                </div>
            </div>

            <div class="option-group">
                <h2>Ice Level</h2>
                <div class="pill-options" id="iceOptions">
                    <button type="button" data-value="No Ice">No Ice</button>
                    <button type="button" data-value="Less Ice">Less Ice</button>
                    <button class="selected" type="button" data-value="Regular Ice">Regular</button>
                    <button type="button" data-value="Extra Ice">Extra Ice</button>
                </div>
            </div>

            <div class="option-group">
                <h2>Sugar Level</h2>
                <input class="sugar-range" id="sugarRange" type="range" min="0" max="100" step="25" value="50">
                <div class="range-labels">
                    <span>No Sugar</span>
                    <span>Low (25%)</span>
                    <span>Medium (50%)</span>
                    <span>Sweet (75%)</span>
                    <span>Full Sugar</span>
                </div>
            </div>

            <div class="option-group">
                <h2>Quantity</h2>
                <div class="quantity-control">
                    <button type="button" id="qtyMinus">-</button>
                    <input id="quantity" type="text" value="1" readonly>
                    <button type="button" id="qtyPlus">+</button>
                </div>
            </div>
        </div>

        <aside class="summary-card">
            <h2>Order Summary</h2>
            <div class="summary-product">
                <div>
                    <strong id="summaryName">Bubble Tea</strong>
                    <p id="summaryOptions">Regular • Medium (50%) Sugar • Regular Ice</p>
                </div>
                <span id="summaryPrice">Rs. 0</span>
            </div>
            <div class="summary-row">
                <span>Base Price</span>
                <strong id="basePrice">Rs. 0</strong>
            </div>
            <div class="summary-row">
                <span>Size Add-on</span>
                <strong id="sizeExtra">Rs. 0</strong>
            </div>
            <div class="summary-total">
                <span>Total</span>
                <strong id="itemTotal">Rs. 0</strong>
            </div>
            <button class="confirm-button" type="button" id="addToCart">Add to Cart</button>
        </aside>
    </section>
</main>


</body>
</html>
