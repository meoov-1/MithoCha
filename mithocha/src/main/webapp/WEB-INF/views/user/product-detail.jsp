<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.List,com.mithocha.model.Product,com.mithocha.model.Review,com.mithocha.model.User,com.mithocha.util.SessionUtil,com.mithocha.util.ValidationUtil" %>
<%
    Product product = (Product) request.getAttribute("product");
    if (product == null) {
        response.sendRedirect(request.getContextPath() + "/products");
        return;
    }

    List<Review> reviews = (List<Review>) request.getAttribute("reviews");
    User loggedInUser = SessionUtil.getUser(request);
    boolean loggedIn = loggedInUser != null;
    String contextPath = request.getContextPath();
    String placeholderImage = "https://images.unsplash.com/photo-1515823064-d6e0c04616a7?auto=format&fit=crop&w=1200&q=80";
    String imageUrl = ValidationUtil.isNullOrEmpty(product.getImageUrl()) ? placeholderImage : product.getImageUrl();
    String category = ValidationUtil.isNullOrEmpty(product.getCategory()) ? "Signature" : product.getCategory();
    String basePrice = product.getBasePrice() == null ? "0" : product.getBasePrice().stripTrailingZeros().toPlainString();
    String sizesJson = ValidationUtil.isNullOrEmpty(product.getSizes()) ? "" : product.getSizes();
    String flavoursJson = ValidationUtil.isNullOrEmpty(product.getFlavours()) ? "" : product.getFlavours();
    String toppingsJson = ValidationUtil.isNullOrEmpty(product.getToppings()) ? "" : product.getToppings();
%>
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

<main class="detail-main container">
    <a class="back-link" href="${pageContext.request.contextPath}/products">
        <span class="material-symbols-outlined">arrow_back</span>
        Back to Menu
    </a>

    <% if ("true".equals(request.getParameter("reviewed"))) { %>
        <div class="form-message success">Your review was saved to the database.</div>
    <% } %>
    <% if ("rating".equals(request.getParameter("error"))) { %>
        <div class="form-message error">Please choose a rating between 1 and 5.</div>
    <% } %>

    <section
        class="detail-layout"
        id="productConfigurator"
        data-context-path="<%= contextPath %>"
        data-product-id="<%= product.getProductId() %>"
        data-product-name="<%= ValidationUtil.sanitise(product.getName()) %>"
        data-product-image="<%= ValidationUtil.sanitise(imageUrl) %>"
        data-product-description="<%= ValidationUtil.sanitise(product.getDescription()) %>"
        data-product-category="<%= ValidationUtil.sanitise(category) %>"
        data-base-price="<%= basePrice %>"
        data-sizes="<%= ValidationUtil.sanitise(sizesJson) %>"
        data-flavours="<%= ValidationUtil.sanitise(flavoursJson) %>"
        data-toppings="<%= ValidationUtil.sanitise(toppingsJson) %>"
        data-logged-in="<%= loggedIn %>"
        data-available="<%= product.isAvailable() %>">
        <div class="detail-config">
            <div class="product-heading">
                <img id="productImage" src="<%= ValidationUtil.sanitise(imageUrl) %>" alt="<%= ValidationUtil.sanitise(product.getName()) %>">
                <div>
                    <h1 id="productName"><%= ValidationUtil.sanitise(product.getName()) %></h1>
                    <p id="productDescription"><%= ValidationUtil.sanitise(product.getDescription()) %></p>
                    <div class="product-tags">
                        <span><%= ValidationUtil.sanitise(category) %></span>
                        <span><%= product.isAvailable() ? "Available Now" : "Currently Unavailable" %></span>
                    </div>
                </div>
            </div>

            <div class="option-group" id="sizeGroup">
                <h2>Cup Size</h2>
                <div class="size-grid" id="sizeOptions"></div>
            </div>

            <div class="option-group" id="flavourGroup">
                <h2>Flavour</h2>
                <div class="pill-options" id="flavourOptions"></div>
            </div>

            <div class="option-group" id="toppingGroup">
                <h2>Toppings</h2>
                <div class="pill-options" id="toppingOptions"></div>
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
                    <strong id="summaryName"><%= ValidationUtil.sanitise(product.getName()) %></strong>
                    <p id="summaryOptions">Regular • Medium (50%) Sugar • Regular Ice</p>
                </div>
                <span id="summaryPrice">Rs. <%= basePrice %></span>
            </div>
            <div class="summary-row">
                <span>Base Price</span>
                <strong id="basePrice">Rs. <%= basePrice %></strong>
            </div>
            <div class="summary-row">
                <span>Customization Add-ons</span>
                <strong id="sizeExtra">Rs. 0</strong>
            </div>
            <div class="summary-total">
                <span>Total</span>
                <strong id="itemTotal">Rs. <%= basePrice %></strong>
            </div>
            <button class="confirm-button" type="button" id="addToCart"><%= loggedIn ? "Add to Cart" : "Login to Order" %></button>
            <p class="helper-copy">The selected drink configuration is stored in your browser cart, then submitted to the backend during checkout.</p>
        </aside>
    </section>

    <section class="review-panel">
        <div class="review-panel-header">
            <div>
                <p class="page-tag">Reviews</p>
                <h2>Customer Feedback</h2>
            </div>
            <p class="review-copy">Submitted reviews are saved through `ReviewDAOImpl` into the `reviews` table.</p>
        </div>

        <% if (loggedIn) { %>
            <form class="review-form" method="post" action="${pageContext.request.contextPath}/product-detail">
                <input type="hidden" name="action" value="review">
                <input type="hidden" name="productId" value="<%= product.getProductId() %>">
                <div class="review-grid">
                    <label class="review-field">
                        <span>Rating</span>
                        <select name="rating" required>
                            <option value="">Choose rating</option>
                            <option value="5">5 - Excellent</option>
                            <option value="4">4 - Great</option>
                            <option value="3">3 - Good</option>
                            <option value="2">2 - Fair</option>
                            <option value="1">1 - Poor</option>
                        </select>
                    </label>
                    <label class="review-field">
                        <span>Image URL</span>
                        <input type="url" name="imageUrl" placeholder="Optional review image link">
                    </label>
                    <label class="review-field review-field-full">
                        <span>Comment</span>
                        <textarea name="comment" rows="4" placeholder="Tell other customers what stood out about this drink."></textarea>
                    </label>
                </div>
                <button class="review-submit" type="submit">Submit Review</button>
            </form>
        <% } else { %>
            <div class="review-login-card">
                <p>Log in to add this drink to your cart and leave a review.</p>
                <a class="review-login-link" href="${pageContext.request.contextPath}/login">Go to Login</a>
            </div>
        <% } %>

        <div class="reviews-grid">
            <% if (reviews == null || reviews.isEmpty()) { %>
                <div class="review-empty">
                    <span class="material-symbols-outlined">rate_review</span>
                    <p>No reviews yet. The first saved review will appear here.</p>
                </div>
            <% } else {
                   for (Review review : reviews) {
            %>
                <article class="review-card">
                    <div class="review-card-head">
                        <div>
                            <strong>Customer #<%= review.getUserId() %></strong>
                            <p><%= review.getCreatedAt() == null ? "Recently added" : review.getCreatedAt().toLocalDateTime().toLocalDate().toString() %></p>
                        </div>
                        <div class="review-stars">
                            <% for (int i = 1; i <= 5; i++) { %>
                                <span class="material-symbols-outlined"><%= i <= review.getRating() ? "star" : "star_outline" %></span>
                            <% } %>
                        </div>
                    </div>
                    <% if (!ValidationUtil.isNullOrEmpty(review.getComment())) { %>
                        <p class="review-comment"><%= ValidationUtil.sanitise(review.getComment()) %></p>
                    <% } %>
                    <% if (!ValidationUtil.isNullOrEmpty(review.getImageUrl())) { %>
                        <img class="review-image" src="<%= ValidationUtil.sanitise(review.getImageUrl()) %>" alt="Review image">
                    <% } %>
                </article>
            <%     }
               } %>
        </div>
    </section>
</main>

<script src="${pageContext.request.contextPath}/js/user/storefront.js"></script>
<script>
    (function () {
        const store = window.MithoChaStorefront;
        const root = document.getElementById("productConfigurator");
        const contextPath = root.dataset.contextPath;
        const basePrice = store.toNumber(root.dataset.basePrice);
        const loggedIn = root.dataset.loggedIn === "true";
        const isAvailable = root.dataset.available === "true";

        const fallbackSizes = [
            { label: "Regular", extra: 0, meta: "500ml" },
            { label: "Large", extra: 150, meta: "+ Rs. 150" }
        ];

        const state = {
            size: null,
            flavour: null,
            topping: null,
            iceLevel: "Regular Ice",
            sugarLevel: 50,
            quantity: 1
        };

        function parseOptions(raw, fallback) {
            if (!raw) {
                return fallback || [];
            }

            try {
                const parsed = JSON.parse(raw);
                if (Array.isArray(parsed) && parsed.length) {
                    return parsed.map(normaliseOption).filter(Boolean);
                }
            } catch (error) {
                if (typeof raw === "string" && raw.trim()) {
                    return raw.split(",").map(function (value) {
                        return normaliseOption(value.trim());
                    }).filter(Boolean);
                }
            }

            return fallback || [];
        }

        function normaliseOption(option) {
            if (!option) {
                return null;
            }

            if (typeof option === "string") {
                return { label: option, value: option, extra: 0, meta: "Included" };
            }

            if (typeof option === "object") {
                const label = option.label || option.name || option.value || option.size || option.flavour || option.topping;
                if (!label) {
                    return null;
                }
                const extra = store.toNumber(option.extra || option.price || option.addOn);
                const meta = option.meta || option.volume || option.description || (extra > 0 ? "Add " + store.formatCurrency(extra) : "Included");
                return { label: label, value: label, extra: extra, meta: meta };
            }

            return null;
        }

        const sizeOptions = parseOptions(root.dataset.sizes, fallbackSizes);
        const flavourOptions = parseOptions(root.dataset.flavours, []);
        const toppingOptions = parseOptions(root.dataset.toppings, []);

        state.size = sizeOptions[0] || fallbackSizes[0];
        state.flavour = flavourOptions[0] || null;
        state.topping = toppingOptions[0] || null;

        function renderSizeOptions() {
            const container = document.getElementById("sizeOptions");
            container.innerHTML = "";

            sizeOptions.forEach(function (option) {
                const label = document.createElement("label");
                label.className = "option-card" + (state.size && state.size.value === option.value ? " selected" : "");
                label.innerHTML = [
                    '<input type="radio" name="cupSize" value="' + option.value + '">',
                    '<span class="material-symbols-outlined">local_cafe</span>',
                    "<strong>" + option.label + "</strong>",
                    "<small>" + option.meta + "</small>"
                ].join("");
                label.addEventListener("click", function () {
                    state.size = option;
                    renderSizeOptions();
                    updateSummary();
                });
                container.appendChild(label);
            });

            document.getElementById("sizeGroup").style.display = sizeOptions.length ? "grid" : "none";
        }

        function renderPillOptions(containerId, groupId, options, type) {
            const container = document.getElementById(containerId);
            const group = document.getElementById(groupId);

            if (!options.length) {
                group.style.display = "none";
                return;
            }

            group.style.display = "grid";
            container.innerHTML = "";

            options.forEach(function (option) {
                const button = document.createElement("button");
                button.type = "button";
                button.textContent = option.label;
                const selected = state[type] && state[type].value === option.value;
                if (selected) {
                    button.classList.add("selected");
                }
                button.addEventListener("click", function () {
                    state[type] = option;
                    renderPillOptions(containerId, groupId, options, type);
                    updateSummary();
                });
                container.appendChild(button);
            });
        }

        document.querySelectorAll("#iceOptions button").forEach(function (button) {
            button.addEventListener("click", function () {
                document.querySelectorAll("#iceOptions button").forEach(function (item) {
                    item.classList.remove("selected");
                });
                button.classList.add("selected");
                state.iceLevel = button.dataset.value;
                updateSummary();
            });
        });

        document.getElementById("sugarRange").addEventListener("input", function (event) {
            state.sugarLevel = store.toNumber(event.target.value);
            updateSummary();
        });

        document.getElementById("qtyMinus").addEventListener("click", function () {
            state.quantity = Math.max(1, state.quantity - 1);
            document.getElementById("quantity").value = state.quantity;
            updateSummary();
        });

        document.getElementById("qtyPlus").addEventListener("click", function () {
            state.quantity += 1;
            document.getElementById("quantity").value = state.quantity;
            updateSummary();
        });

        function sugarLabel() {
            return state.sugarLevel + "% Sugar";
        }

        function addOnsTotal() {
            return (state.size ? state.size.extra : 0)
                + (state.flavour ? state.flavour.extra : 0)
                + (state.topping ? state.topping.extra : 0);
        }

        function unitPrice() {
            return basePrice + addOnsTotal();
        }

        function updateSummary() {
            const options = [
                state.size ? state.size.label : "Regular",
                state.flavour ? state.flavour.label : null,
                state.topping ? state.topping.label : null,
                sugarLabel(),
                state.iceLevel
            ].filter(Boolean);

            document.getElementById("summaryOptions").textContent = options.join(" • ");
            document.getElementById("summaryPrice").textContent = store.formatCurrency(unitPrice() * state.quantity);
            document.getElementById("basePrice").textContent = store.formatCurrency(basePrice);
            document.getElementById("sizeExtra").textContent = store.formatCurrency(addOnsTotal());
            document.getElementById("itemTotal").textContent = store.formatCurrency(unitPrice() * state.quantity);
        }

        document.getElementById("addToCart").addEventListener("click", function () {
            if (!isAvailable) {
                return;
            }

            if (!loggedIn) {
                window.location.href = contextPath + "/login";
                return;
            }

            store.addCartItem({
                productId: store.toNumber(root.dataset.productId),
                name: root.dataset.productName,
                imageUrl: root.dataset.productImage,
                description: root.dataset.productDescription,
                category: root.dataset.productCategory,
                basePrice: basePrice,
                unitPrice: unitPrice(),
                quantity: state.quantity,
                size: state.size ? state.size.label : "",
                flavour: state.flavour ? state.flavour.label : "",
                topping: state.topping ? state.topping.label : "",
                iceLevel: state.iceLevel,
                sugarLevel: state.sugarLevel + "%",
                optionsSummary: document.getElementById("summaryOptions").textContent
            });

            window.location.href = contextPath + "/cart";
        });

        if (!isAvailable) {
            const button = document.getElementById("addToCart");
            button.disabled = true;
            button.textContent = "Currently Unavailable";
        }

        renderSizeOptions();
        renderPillOptions("flavourOptions", "flavourGroup", flavourOptions, "flavour");
        renderPillOptions("toppingOptions", "toppingGroup", toppingOptions, "topping");
        updateSummary();
    })();
</script>
</body>
</html>
