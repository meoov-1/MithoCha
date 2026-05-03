<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.mithocha.model.User,com.mithocha.model.Profile,com.mithocha.util.ValidationUtil" %>
<%
    User user = (User) request.getAttribute("user");
    Profile profile = (Profile) request.getAttribute("profile");
    String fullName = user != null ? user.getName() : "";
    String email = user != null ? user.getEmail() : "";
    String phone = profile != null && profile.getPhone() != null ? profile.getPhone() : "";
    String address = profile != null && profile.getAddress() != null ? profile.getAddress() : "";
    String city = profile != null && profile.getCity() != null ? profile.getCity() : "";
    String postalCode = profile != null && profile.getPostalCode() != null ? profile.getPostalCode() : "";
%>
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
            <span class="cart-count">0</span>
        </a>
    </div>
</header>

<main class="content-shell">
    <div class="content-wrap">
        <section class="cart-container">
            <div class="cart-product-section">
                <div class="cart-back">
                    <span class="material-symbols-outlined">arrow_back</span>
                    <a href="${pageContext.request.contextPath}/products">Back to Menu</a>
                </div>

                <% if (request.getAttribute("errorMessage") != null) { %>
                    <div class="message-banner error"><%= ValidationUtil.sanitise(String.valueOf(request.getAttribute("errorMessage"))) %></div>
                <% } %>

                <div id="checkoutStatus" class="message-banner hidden"></div>

                <div id="cartItemsContainer">
                    <div class="empty-cart-message">
                        <p>Your cart is loading...</p>
                    </div>
                </div>

                <section class="page-card shipping-card">
                    <div class="section-heading">
                        <h2 class="placeholder-title">Delivery Details</h2>
                        <p class="placeholder-copy">These details are bundled into the checkout payload and stored with the order in your database.</p>
                    </div>

                    <div class="form-grid">
                        <label class="placeholder-field">
                            <span>Full Name</span>
                            <input id="shippingFullName" type="text" value="<%= ValidationUtil.sanitise(fullName) %>" placeholder="Your full name" required>
                        </label>

                        <label class="placeholder-field">
                            <span>Email Address</span>
                            <input id="shippingEmail" type="email" value="<%= ValidationUtil.sanitise(email) %>" readonly>
                        </label>

                        <label class="placeholder-field">
                            <span>Phone Number</span>
                            <input id="shippingPhone" type="tel" value="<%= ValidationUtil.sanitise(phone) %>" placeholder="+977 98XXXXXXXX" required>
                        </label>

                        <label class="placeholder-field">
                            <span>City</span>
                            <input id="shippingCity" type="text" value="<%= ValidationUtil.sanitise(city) %>" placeholder="Kathmandu">
                        </label>

                        <label class="placeholder-field">
                            <span>Postal Code</span>
                            <input id="shippingPostalCode" type="text" value="<%= ValidationUtil.sanitise(postalCode) %>" placeholder="44600">
                        </label>

                        <label class="placeholder-field full-span">
                            <span>Delivery Address</span>
                            <textarea id="shippingAddress" rows="3" placeholder="Street, area, landmark" required><%= ValidationUtil.sanitise(address) %></textarea>
                        </label>

                        <label class="placeholder-field full-span">
                            <span>Order Notes</span>
                            <textarea id="shippingNotes" rows="3" placeholder="Delivery instructions, allergies, sweetness notes"></textarea>
                        </label>
                    </div>
                </section>
            </div>

            <div class="order-summary-section">
                <div class="order-summary-card">
                    <h2 class="summary-title">Order Summary</h2>

                    <div id="summaryItemsContainer"></div>

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
                        <h3 class="payment-title">Payment Method</h3>
                        <label class="payment-option selected">
                            <input type="radio" name="paymentMethod" value="online" checked>
                            <span class="material-symbols-outlined">payment</span>
                            <span>Online Payment (Fonepay/Khalti)</span>
                        </label>
                        <label class="payment-option">
                            <input type="radio" name="paymentMethod" value="cod">
                            <span class="material-symbols-outlined">local_shipping</span>
                            <span>Cash on Delivery</span>
                        </label>
                    </div>

                    <form id="checkoutForm" method="post" action="${pageContext.request.contextPath}/cart">
                        <input type="hidden" name="items" id="checkoutItems">
                        <input type="hidden" name="payment" id="checkoutPayment">
                        <input type="hidden" name="shippingAddress" id="checkoutShippingAddress">
                        <input type="hidden" name="totalAmount" id="checkoutTotalAmount">
                    </form>

                    <button class="confirm-order-btn" id="confirmOrderBtn" type="button">Confirm Order</button>
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

<script src="${pageContext.request.contextPath}/js/user/storefront.js"></script>
<script>
    (function () {
        const store = window.MithoChaStorefront;
        const deliveryFee = 50;
        const cartContainer = document.getElementById("cartItemsContainer");
        const summaryContainer = document.getElementById("summaryItemsContainer");
        const checkoutStatus = document.getElementById("checkoutStatus");

        function escapeHtml(value) {
            return String(value || "")
                .replace(/&/g, "&amp;")
                .replace(/</g, "&lt;")
                .replace(/>/g, "&gt;")
                .replace(/"/g, "&quot;")
                .replace(/'/g, "&#x27;");
        }

        function showStatus(message) {
            checkoutStatus.textContent = message;
            checkoutStatus.classList.remove("hidden");
            checkoutStatus.classList.add("error");
        }

        function updatePaymentState() {
            document.querySelectorAll(".payment-option").forEach(function (label) {
                const input = label.querySelector("input");
                label.classList.toggle("selected", input.checked);
            });
        }

        function renderCart() {
            const cart = store.getCart();
            const subtotal = cart.reduce(function (total, item) {
                return total + store.toNumber(item.unitPrice) * Math.max(1, store.toNumber(item.quantity));
            }, 0);
            const total = subtotal + deliveryFee;

            if (!cart.length) {
                cartContainer.innerHTML = [
                    '<div class="empty-cart-message">',
                    "<p>Your cart is empty.</p>",
                    '<a class="btn-primary" href="${pageContext.request.contextPath}/products">View Menu</a>',
                    "</div>"
                ].join("");
                summaryContainer.innerHTML = '<p class="summary-empty">No saved drinks yet.</p>';
                document.getElementById("confirmOrderBtn").disabled = true;
            } else {
                cartContainer.innerHTML = cart.map(function (item, index) {
                    const lineTotal = store.toNumber(item.unitPrice) * Math.max(1, store.toNumber(item.quantity));
                    const optionTags = [
                        item.size,
                        item.flavour,
                        item.topping,
                        item.iceLevel,
                        item.sugarLevel
                    ].filter(Boolean).map(function (tag) {
                        return "<span>" + escapeHtml(tag) + "</span>";
                    }).join("");

                    return [
                        '<article class="cart-item">',
                        '<div class="item-image"><img src="' + escapeHtml(item.imageUrl || "") + '" alt="' + escapeHtml(item.name || "Drink") + '"></div>',
                        '<div class="item-details">',
                        '<h3 class="item-name">' + escapeHtml(item.name || "Drink") + "</h3>",
                        '<p class="item-description">' + escapeHtml(item.description || "Saved from the product detail page.") + "</p>",
                        '<div class="item-tags">' + optionTags + "</div>",
                        '<p class="item-price">Unit Price: ' + store.formatCurrency(item.unitPrice) + "</p>",
                        "</div>",
                        '<div class="item-actions">',
                        '<div class="quantity-control">',
                        '<button type="button" onclick="window.changeCartQuantity(' + index + ', -1)">-</button>',
                        '<input type="text" value="' + Math.max(1, store.toNumber(item.quantity)) + '" readonly>',
                        '<button type="button" onclick="window.changeCartQuantity(' + index + ', 1)">+</button>',
                        "</div>",
                        '<strong class="item-price">' + store.formatCurrency(lineTotal) + "</strong>",
                        '<button class="remove-btn" type="button" onclick="window.removeCartItem(' + index + ')">Remove</button>',
                        "</div>",
                        "</article>"
                    ].join("");
                }).join("");

                summaryContainer.innerHTML = cart.map(function (item) {
                    return [
                        '<div class="summary-item">',
                        "<div>",
                        "<strong>" + escapeHtml(item.name || "Drink") + "</strong>",
                        "<small>" + escapeHtml(item.optionsSummary || "Custom selection") + " • Qty " + Math.max(1, store.toNumber(item.quantity)) + "</small>",
                        "</div>",
                        "<span>" + store.formatCurrency(store.toNumber(item.unitPrice) * Math.max(1, store.toNumber(item.quantity))) + "</span>",
                        "</div>"
                    ].join("");
                }).join("");

                document.getElementById("confirmOrderBtn").disabled = false;
            }

            document.getElementById("subtotal").textContent = store.formatCurrency(subtotal);
            document.getElementById("total").textContent = store.formatCurrency(total);
            document.getElementById("checkoutTotalAmount").value = total.toFixed(2);
        }

        window.changeCartQuantity = function (index, delta) {
            const cart = store.getCart();
            if (!cart[index]) {
                return;
            }
            const currentQuantity = Math.max(1, store.toNumber(cart[index].quantity));
            const nextQuantity = Math.max(1, currentQuantity + delta);
            cart[index].quantity = nextQuantity;
            cart[index].totalPrice = store.toNumber(cart[index].unitPrice) * nextQuantity;
            store.saveCart(cart);
            renderCart();
        };

        window.removeCartItem = function (index) {
            const cart = store.getCart();
            cart.splice(index, 1);
            store.saveCart(cart);
            renderCart();
        };

        document.querySelectorAll('input[name="paymentMethod"]').forEach(function (input) {
            input.addEventListener("change", updatePaymentState);
        });

        document.getElementById("confirmOrderBtn").addEventListener("click", function () {
            const cart = store.getCart();
            if (!cart.length) {
                showStatus("Add at least one drink before confirming the order.");
                return;
            }

            const shipping = {
                fullName: document.getElementById("shippingFullName").value.trim(),
                email: document.getElementById("shippingEmail").value.trim(),
                phone: document.getElementById("shippingPhone").value.trim(),
                city: document.getElementById("shippingCity").value.trim(),
                postalCode: document.getElementById("shippingPostalCode").value.trim(),
                address: document.getElementById("shippingAddress").value.trim(),
                notes: document.getElementById("shippingNotes").value.trim()
            };

            if (!shipping.fullName || !shipping.phone || !shipping.address) {
                showStatus("Full name, phone number, and delivery address are required.");
                return;
            }

            const paymentInput = document.querySelector('input[name="paymentMethod"]:checked');
            const payment = {
                method: paymentInput.value,
                label: paymentInput.value === "online" ? "Online Payment (Fonepay/Khalti)" : "Cash on Delivery"
            };

            document.getElementById("checkoutItems").value = JSON.stringify(cart);
            document.getElementById("checkoutPayment").value = JSON.stringify(payment);
            document.getElementById("checkoutShippingAddress").value = JSON.stringify(shipping);
            document.getElementById("checkoutForm").submit();
        });

        updatePaymentState();
        renderCart();
    })();
</script>
</body>
</html>
