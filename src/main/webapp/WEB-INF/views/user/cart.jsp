<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.mithocha.model.User,com.mithocha.model.Profile,com.mithocha.util.ValidationUtil,com.mithocha.util.SessionUtil" %>
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
            <a href="${pageContext.request.contextPath}/blog">Blog</a>
            <a href="${pageContext.request.contextPath}/contact">Contact</a>
            <a href="${pageContext.request.contextPath}/profile">Profile</a>
        </nav>
        <div style="display:flex;align-items:center;gap:8px;">
            <a class="nav-icon cart-icon" href="${pageContext.request.contextPath}/cart" aria-label="Shopping Cart">
                <span class="material-symbols-outlined">shopping_cart</span>
                <span class="cart-count">0</span>
            </a>
            <a class="nav-icon" href="${pageContext.request.contextPath}/logout" aria-label="Logout" title="Logout"
               style="color:#ba1a1a;" onclick="return confirm('Log out of MithoCha?')">
                <span class="material-symbols-outlined">logout</span>
            </a>
        </div>
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
                            <input type="radio" name="paymentMethod" value="khalti" checked>
                            <span class="material-symbols-outlined">payment</span>
                            <span>Khalti (Online Payment)</span>
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

<%-- ── Khalti Web Checkout SDK ── --%>
<script src="https://khalti.s3.ap-south-1.amazonaws.com/KPG/dist/2020.12.17.0.0.0/khalti-checkout.iffe.js"></script>

<script src="${pageContext.request.contextPath}/js/user/storefront.js"></script>

<%-- ── COD Confirmation Modal ── --%>
<div id="codOverlay" class="cod-overlay" role="presentation"></div>
<div id="codModal" class="cod-modal" role="dialog" aria-modal="true" aria-labelledby="codModalTitle">
    <div class="cod-modal-header">
        <span class="material-symbols-outlined cod-modal-icon">local_shipping</span>
        <h2 id="codModalTitle">Confirm Cash on Delivery</h2>
        <p>Please verify your details before we place your order.</p>
    </div>

    <div class="cod-modal-body">
        <div class="cod-info-row">
            <span class="material-symbols-outlined">info</span>
            <p>Our delivery team will collect payment when your order arrives. Please have the exact amount ready.</p>
        </div>

        <div class="cod-field">
            <label for="codConfirmName">Full Name</label>
            <input id="codConfirmName" type="text" placeholder="Your full name" autocomplete="name">
        </div>
        <div class="cod-field">
            <label for="codConfirmPhone">Phone Number</label>
            <input id="codConfirmPhone" type="tel" placeholder="+977 98XXXXXXXX" autocomplete="tel">
        </div>

        <p id="codModalError" class="cod-error" style="display:none;"></p>
    </div>

    <div class="cod-modal-footer">
        <button id="codCancelBtn" class="cod-btn-cancel" type="button">Cancel</button>
        <button id="codSubmitBtn" class="cod-btn-confirm" type="button">
            <span class="material-symbols-outlined">check_circle</span>
            Place COD Order
        </button>
    </div>
</div>

<script>
    /* ================================================================
       MithoCha Cart Page — cookie-based cart + Khalti + COD popup
       ================================================================ */
    (function () {
        var store    = window.MithoChaStorefront;

        /* Guard: storefront must be loaded */
        if (!store) {
            var c = document.getElementById("cartItemsContainer");
            if (c) c.innerHTML = '<div class="empty-cart-message"><p>Cart could not load. Please <a href="">refresh</a>.</p></div>';
            return;
        }
        var DELIVERY = 50;

        /* ── DOM refs ── */
        var cartContainer    = document.getElementById("cartItemsContainer");
        var summaryContainer = document.getElementById("summaryItemsContainer");
        var checkoutStatus   = document.getElementById("checkoutStatus");
        var confirmBtn       = document.getElementById("confirmOrderBtn");
        var codModal         = document.getElementById("codModal");
        var codOverlay       = document.getElementById("codOverlay");

        /* ── Helpers ── */
        function esc(v) {
            return String(v || "")
                .replace(/&/g,"&amp;").replace(/</g,"&lt;")
                .replace(/>/g,"&gt;").replace(/"/g,"&quot;").replace(/'/g,"&#x27;");
        }
        function showError(msg) {
            checkoutStatus.textContent = msg;
            checkoutStatus.classList.remove("hidden","success");
            checkoutStatus.classList.add("error");
            checkoutStatus.scrollIntoView({ behavior:"smooth", block:"nearest" });
        }
        function showInfo(msg) {
            checkoutStatus.textContent = msg;
            checkoutStatus.classList.remove("hidden","error");
            checkoutStatus.classList.add("success");
        }

        /* ── Payment option highlight ── */
        function syncPaymentUI() {
            document.querySelectorAll(".payment-option").forEach(function(lbl) {
                lbl.classList.toggle("selected", lbl.querySelector("input").checked);
            });
        }
        document.querySelectorAll('input[name="paymentMethod"]').forEach(function(r) {
            r.addEventListener("change", syncPaymentUI);
        });

        /* ── Render cart from cookie ── */
        function renderCart() {
            var cart     = store.getCart();
            var subtotal = cart.reduce(function(s, item) {
                return s + store.toNumber(item.unitPrice) * Math.max(1, store.toNumber(item.quantity));
            }, 0);
            var total = subtotal + DELIVERY;

            if (!cart.length) {
                cartContainer.innerHTML =
                    '<div class="empty-cart-message">' +
                    '<p>Your cart is empty.</p>' +
                    '<a class="btn-primary" href="${pageContext.request.contextPath}/products">View Menu</a>' +
                    '</div>';
                summaryContainer.innerHTML = '<p class="summary-empty">No items yet.</p>';
                confirmBtn.disabled = true;
            } else {
                cartContainer.innerHTML = cart.map(function(item, idx) {
                    var lineTotal = store.toNumber(item.unitPrice) * Math.max(1, store.toNumber(item.quantity));
                    var tags = [item.size, item.flavour, item.topping, item.iceLevel, item.sugarLevel]
                        .filter(Boolean)
                        .map(function(t){ return "<span>" + esc(t) + "</span>"; }).join("");
                    return [
                        '<article class="cart-item">',
                          '<div class="item-image"><img src="' + esc(item.imageUrl||"") + '" alt="' + esc(item.name||"Drink") + '"></div>',
                          '<div class="item-details">',
                            '<h3 class="item-name">' + esc(item.name||"Drink") + '</h3>',
                            '<p class="item-description">' + esc(item.description||"") + '</p>',
                            '<div class="item-tags">' + tags + '</div>',
                            '<p class="item-price">Unit: ' + store.formatCurrency(item.unitPrice) + '</p>',
                          '</div>',
                          '<div class="item-actions">',
                            '<div class="quantity-control">',
                              '<button type="button" onclick="window._cartQty(' + idx + ',-1)">-</button>',
                              '<input type="text" value="' + Math.max(1,store.toNumber(item.quantity)) + '" readonly>',
                              '<button type="button" onclick="window._cartQty(' + idx + ',1)">+</button>',
                            '</div>',
                            '<strong class="item-price">' + store.formatCurrency(lineTotal) + '</strong>',
                            '<button class="remove-btn" type="button" onclick="window._cartRemove(' + idx + ')">Remove</button>',
                          '</div>',
                        '</article>'
                    ].join("");
                }).join("");

                summaryContainer.innerHTML = cart.map(function(item) {
                    var lineTotal = store.toNumber(item.unitPrice) * Math.max(1, store.toNumber(item.quantity));
                    return [
                        '<div class="summary-item">',
                          '<div><strong>' + esc(item.name||"Drink") + '</strong>',
                          '<small>' + esc(item.optionsSummary||"Custom") + ' &bull; Qty ' + Math.max(1,store.toNumber(item.quantity)) + '</small></div>',
                          '<span>' + store.formatCurrency(lineTotal) + '</span>',
                        '</div>'
                    ].join("");
                }).join("");

                confirmBtn.disabled = false;
            }

            document.getElementById("subtotal").textContent     = store.formatCurrency(subtotal);
            document.getElementById("total").textContent        = store.formatCurrency(total);
            document.getElementById("checkoutTotalAmount").value = total.toFixed(2);
        }

        /* ── Quantity / remove ── */
        window._cartQty = function(idx, delta) {
            var cart = store.getCart();
            if (!cart[idx]) return;
            cart[idx].quantity   = Math.max(1, store.toNumber(cart[idx].quantity) + delta);
            cart[idx].totalPrice = store.toNumber(cart[idx].unitPrice) * cart[idx].quantity;
            store.saveCart(cart);
            renderCart();
        };
        window._cartRemove = function(idx) {
            var cart = store.getCart();
            cart.splice(idx, 1);
            store.saveCart(cart);
            renderCart();
        };

        /* ── Build shipping object ── */
        function buildShipping() {
            return {
                fullName:   document.getElementById("shippingFullName").value.trim(),
                email:      document.getElementById("shippingEmail").value.trim(),
                phone:      document.getElementById("shippingPhone").value.trim(),
                city:       document.getElementById("shippingCity").value.trim(),
                postalCode: document.getElementById("shippingPostalCode").value.trim(),
                address:    document.getElementById("shippingAddress").value.trim(),
                notes:      document.getElementById("shippingNotes").value.trim()
            };
        }

        /* ── Validate ── */
        function validateForm(s) {
            if (!s.fullName) { showError("Full name is required."); return false; }
            if (!s.phone)    { showError("Phone number is required."); return false; }
            if (!s.address)  { showError("Delivery address is required."); return false; }
            return true;
        }

        /* ── Submit hidden form to CartServlet (POST /cart) ── */
        function submitOrder(method, label, extra) {
            var cart     = store.getCart();
            var shipping = buildShipping();
            var total    = store.toNumber(document.getElementById("checkoutTotalAmount").value);

            var payment = Object.assign({
                method: method,
                label:  label,
                status: method === "cod" ? "pending" : "paid",
                amount: total,
                date:   new Date().toISOString()
            }, extra || {});

            document.getElementById("checkoutItems").value           = JSON.stringify(cart);
            document.getElementById("checkoutPayment").value         = JSON.stringify(payment);
            document.getElementById("checkoutShippingAddress").value = JSON.stringify(shipping);
            document.getElementById("checkoutForm").submit();
        }

        /* ── Khalti Payment ── */
        function initiateKhaltiPayment() {
            var cart     = store.getCart();
            var shipping = buildShipping();
            var total    = store.toNumber(document.getElementById("checkoutTotalAmount").value);

            /* Khalti amount is in paisa (1 Rs = 100 paisa) */
            var amountPaisa = Math.round(total * 100);

            /* ── REPLACE THIS KEY with your real Khalti public key ── */
            var KHALTI_PUBLIC_KEY = "test_public_key_dc74e0fd57cb46cd93832aee0a390234";

            var config = {
                publicKey: KHALTI_PUBLIC_KEY,
                productIdentity: "mithocha-order-" + Date.now(),
                productName: "MithoCha Order (" + cart.length + " item" + (cart.length !== 1 ? "s" : "") + ")",
                productUrl: window.location.origin + "${pageContext.request.contextPath}/products",
                paymentPreference: ["KHALTI", "EBANKING", "MOBILE_BANKING", "CONNECT_IPS", "SCT"],
                eventHandler: {
                    onSuccess: function(payload) {
                        /* payload.token and payload.amount come from Khalti */
                        showInfo("Payment successful! Saving your order…");
                        submitOrder("khalti", "Khalti Online Payment", {
                            transaction_id: payload.token,
                            khalti_amount:  payload.amount,
                            status:         "paid"
                        });
                    },
                    onError: function(error) {
                        showError("Khalti payment failed: " + (error.detail || "Please try again."));
                        confirmBtn.disabled = false;
                        confirmBtn.textContent = "Confirm Order";
                    },
                    onClose: function() {
                        confirmBtn.disabled = false;
                        confirmBtn.textContent = "Confirm Order";
                    }
                }
            };

            var checkout = new KhaltiCheckout(config);
            checkout.show({ amount: amountPaisa });
        }

        /* ── COD Modal open / close ── */
        function openCodModal() {
            codModal.classList.add("open");
            codOverlay.classList.add("open");
            document.body.style.overflow = "hidden";
            setTimeout(function(){ document.getElementById("codConfirmName").focus(); }, 80);
        }
        function closeCodModal() {
            codModal.classList.remove("open");
            codOverlay.classList.remove("open");
            document.body.style.overflow = "";
        }
        document.getElementById("codCancelBtn").addEventListener("click", closeCodModal);
        codOverlay.addEventListener("click", closeCodModal);
        document.addEventListener("keydown", function(e) {
            if (e.key === "Escape") closeCodModal();
        });

        /* ── COD confirm inside modal ── */
        document.getElementById("codSubmitBtn").addEventListener("click", function() {
            var name  = document.getElementById("codConfirmName").value.trim();
            var phone = document.getElementById("codConfirmPhone").value.trim();
            var err   = document.getElementById("codModalError");
            if (!name || !phone) {
                err.textContent = "Please enter your name and phone number to confirm.";
                err.style.display = "block";
                return;
            }
            err.style.display = "none";
            closeCodModal();
            submitOrder("cod", "Cash on Delivery", {
                confirmName:    name,
                confirmPhone:   phone,
                transaction_id: "COD-" + Date.now()
            });
        });

        /* ── Main Confirm Order button ── */
        confirmBtn.addEventListener("click", function() {
            var cart     = store.getCart();
            var shipping = buildShipping();
            if (!cart.length)           { showError("Add at least one drink before confirming."); return; }
            if (!validateForm(shipping)) return;

            var method = document.querySelector('input[name="paymentMethod"]:checked').value;

            if (method === "cod") {
                /* Pre-fill modal with shipping details */
                document.getElementById("codConfirmName").value  = shipping.fullName || "";
                document.getElementById("codConfirmPhone").value = shipping.phone    || "";
                document.getElementById("codModalError").style.display = "none";
                openCodModal();

            } else if (method === "khalti") {
                /* Check Khalti SDK loaded */
                if (typeof KhaltiCheckout === "undefined") {
                    showError("Khalti payment is not available right now. Please use Cash on Delivery.");
                    return;
                }
                confirmBtn.disabled = true;
                confirmBtn.textContent = "Opening Khalti…";
                initiateKhaltiPayment();
            }
        });

        /* ── Init ── */
        syncPaymentUI();
        renderCart();
    })();
</script>
</body>
</html>
