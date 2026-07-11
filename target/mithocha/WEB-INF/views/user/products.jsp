<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.List,java.net.URLEncoder,com.mithocha.model.Product,com.mithocha.model.User,com.mithocha.util.SessionUtil,com.mithocha.util.ValidationUtil" %>
<%
    List<Product> products = (List<Product>) request.getAttribute("products");
    List<String> categories = (List<String>) request.getAttribute("categories");
    String selectedCategory = (String) request.getAttribute("selectedCategory");
    String contextPath = request.getContextPath();
    String placeholderImage = "https://images.unsplash.com/photo-1515823064-d6e0c04616a7?auto=format&fit=crop&w=1200&q=80";
    User loggedInUser = SessionUtil.getUser(request);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MithoCha Products</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@400;600;700&family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@400" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user/products.css">
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
                <span class="cart-count"></span>
            </a>
            <button class="nav-icon logout-trigger" 
                    data-logout-url="${pageContext.request.contextPath}/logout"
                    aria-label="Logout" title="Logout"
                    style="color:#ba1a1a;background:none;border:none;cursor:pointer;">
                <span class="material-symbols-outlined">logout</span>
            </button>
        </div>
    </div>
</header>

<main class="products-main">

    <%-- ── Page Hero ── --%>
    <header class="page-hero container">
        <p class="eyebrow">MithoCha Menu</p>
        <h1 class="page-title">Our Bubble Tea Collection</h1>
        <p class="page-copy">Handcrafted daily with premium Ilam tea leaves, fresh milk, and house-made syrups. Every cup made to order.</p>
    </header>

    <section class="container product-section">

        <%-- ── Category filter ── --%>
        <% if (categories != null && !categories.isEmpty()) { %>
        <div class="category-bar">
            <a class="category-pill <%= selectedCategory == null || selectedCategory.trim().isEmpty() ? "active" : "" %>"
               href="<%= contextPath %>/products">All</a>
            <% for (String category : categories) {
                   if (ValidationUtil.isNullOrEmpty(category)) continue; %>
                <a class="category-pill <%= category.equalsIgnoreCase(selectedCategory == null ? "" : selectedCategory) ? "active" : "" %>"
                   href="<%= contextPath %>/products?category=<%= URLEncoder.encode(category, "UTF-8") %>">
                   <%= ValidationUtil.sanitise(category) %>
                </a>
            <% } %>
        </div>
        <% } %>

        <%-- ── Product count + Search ── --%>
        <% if (products != null && !products.isEmpty()) { %>
        <div class="results-row" style="display:flex;align-items:center;justify-content:space-between;gap:12px;">
            <p class="results-count" style="margin:0;">
                <span id="productResultsCount"><%= products.size() %> drink<%= products.size() != 1 ? "s" : "" %></span>
                <% if (selectedCategory != null && !selectedCategory.trim().isEmpty()) { %>
                    in <strong><%= ValidationUtil.sanitise(selectedCategory) %></strong>
                <% } %>
            </p>
            <div class="search-bar" style="display:flex;align-items:center;gap:8px;">
                <span class="material-symbols-outlined">search</span>
                <input id="productSearch" type="text" placeholder="Search menu by name or category…" oninput="filterProductCards()" style="padding:8px;border-radius:8px;border:1px solid #e8dbd7;min-width:220px;">
            </div>
        </div>
        <% } %>

        <% if (products == null || products.isEmpty()) { %>
            <section class="empty-state">
                <span class="material-symbols-outlined">local_cafe</span>
                <h2>No drinks here yet</h2>
                <p>Add products via the admin panel and they'll appear here instantly.</p>
                <a class="primary-action empty-action" href="<%= contextPath %>/products">Show All</a>
            </section>

        <% } else { %>
            <div class="product-grid">
                <% for (Product product : products) {
                       String imageUrl = ValidationUtil.isNullOrEmpty(product.getImageUrl()) ? placeholderImage : product.getImageUrl();
                       String category = ValidationUtil.isNullOrEmpty(product.getCategory()) ? "Signature" : product.getCategory();
                       String price    = product.getBasePrice() == null ? "0" : product.getBasePrice().stripTrailingZeros().toPlainString();
                       String desc     = ValidationUtil.isNullOrEmpty(product.getDescription()) ? "" : product.getDescription();
                %>
                    <article class="product-card">
                        <%-- Large image --%>
                        <div class="product-media">
                            <img src="<%= ValidationUtil.sanitise(imageUrl) %>"
                                 alt="<%= ValidationUtil.sanitise(product.getName()) %>"
                                 loading="lazy">
                        </div>

                        <%-- Card body --%>
                        <div class="product-body product-card-body"
                             data-product-id="<%= product.getProductId() %>"
                             data-product-name="<%= ValidationUtil.sanitise(product.getName()) %>"
                             data-product-image="<%= ValidationUtil.sanitise(imageUrl) %>"
                             data-product-description="<%= ValidationUtil.sanitise(desc) %>"
                             data-product-category="<%= ValidationUtil.sanitise(category) %>"
                             data-product-base-price="<%= price %>"
                             data-product-sizes="<%= ValidationUtil.sanitise(product.getSizes() == null ? "" : product.getSizes()) %>"
                             data-product-flavours="<%= ValidationUtil.sanitise(product.getFlavours() == null ? "" : product.getFlavours()) %>"
                             data-product-toppings="<%= ValidationUtil.sanitise(product.getToppings() == null ? "" : product.getToppings()) %>">

                            <%-- Name + Price row --%>
                            <div class="pc-title-row">
                                <h3 class="pc-name"><%= ValidationUtil.sanitise(product.getName()) %></h3>
                                <span class="pc-price">Rs. <%= price %></span>
                            </div>

                            <%-- Description --%>
                            <p class="pc-desc"><%= ValidationUtil.sanitise(desc) %></p>

                            <%-- Tags --%>
                            <div class="pc-tags">
                                <span class="pc-tag"><%= ValidationUtil.sanitise(category) %></span>
                                <% if (!ValidationUtil.isNullOrEmpty(product.getSizes()) || !ValidationUtil.isNullOrEmpty(product.getFlavours())) { %>
                                    <span class="pc-tag">Customizable</span>
                                <% } %>
                            </div>

                            <%-- Actions: wide Order button + settings icon --%>
                            <div class="pc-actions">
                                <button class="pc-order-btn quick-cart-button" type="button">Order</button>
                                <a class="pc-settings-btn" href="<%= contextPath %>/product-detail?id=<%= product.getProductId() %>"
                                   title="Customize order" aria-label="Customize">
                                    <span class="material-symbols-outlined">settings</span>
                                </a>
                            </div>
                        </div>
                    </article>
                <% } %>
            </div>
        <% } %>

    </section>
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

            <div>
                <h4>Follow Us</h4>
                <p>Facebook</p>
                <p>Instagram</p>
                <p>Twitter</p>
            </div>
        </div>

        <div class="footer-bottom">
            <p>© 2026 MithoCha Beverages. All rights reserved.</p>
        </div>
    </div>
</footer>

<script src="${pageContext.request.contextPath}/js/user/storefront.js"></script>
<script src="${pageContext.request.contextPath}/js/logout-popup.js"></script>
<script>
    (function () {
        const store = window.MithoChaStorefront;
        if (!store) {
            try { console.error('MithoChaStorefront not loaded on this page — quick-add disabled'); } catch(e){}
            return;
        }
        const contextPath = '<%= contextPath %>';
        const loggedIn = <%= loggedInUser != null ? "true" : "false" %>;
        const fallbackSizes = [
            { label: "Regular", extra: 0, meta: "500ml" }
        ];

        document.querySelectorAll(".quick-cart-button").forEach(function (button) {
            button.addEventListener("click", function () {
                if (!loggedIn) {
                    window.location.href = contextPath + '/login';
                    return;
                }

                const card = button.closest(".product-card-body");
                const sizes = store.parseProductOptions(card.dataset.productSizes, fallbackSizes);
                const flavours = store.parseProductOptions(card.dataset.productFlavours, []);
                const toppings = store.parseProductOptions(card.dataset.productToppings, []);

                const size = sizes[0] || fallbackSizes[0];
                const flavour = flavours[0] || null;
                const topping = toppings[0] || null;
                const addOnTotal = (size ? size.extra : 0)
                    + (flavour ? flavour.extra : 0)
                    + (topping ? topping.extra : 0);
                const unitPrice = store.toNumber(card.dataset.productBasePrice) + addOnTotal;
                const optionsSummary = [
                    size ? size.label : "Regular",
                    flavour ? flavour.label : null,
                    topping ? topping.label : null,
                    "50% Sugar",
                    "Regular Ice"
                ].filter(Boolean).join(" • ");

                store.addCartItem({
                    productId: store.toNumber(card.dataset.productId),
                    name: card.dataset.productName,
                    imageUrl: card.dataset.productImage,
                    description: card.dataset.productDescription,
                    category: card.dataset.productCategory,
                    basePrice: store.toNumber(card.dataset.productBasePrice),
                    unitPrice: unitPrice,
                    quantity: 1,
                    size: size ? size.label : "",
                    flavour: flavour ? flavour.label : "",
                    topping: topping ? topping.label : "",
                    iceLevel: "Regular Ice",
                    sugarLevel: "50%",
                    optionsSummary: optionsSummary
                });

                /* visual feedback then redirect to cart after 800ms */
                button.innerHTML = '<span class="material-symbols-outlined">check<\/span> Added!';
                button.style.background = '#2f7d32';
                button.disabled = true;
                window.setTimeout(function () {
                    window.location.href = contextPath + '/cart';
                }, 800);
            });
        });
    })();
</script>
<script>
    window.filterProductCards = function () {
        var searchInput = document.getElementById('productSearch');
        var query = ((searchInput && searchInput.value) || '').toLowerCase().trim();
        var cards = document.querySelectorAll('.product-card');
        var countEl = document.getElementById('productResultsCount');
        var visible = 0;

        cards.forEach(function(card) {
            var body = card.querySelector('.product-card-body') || card;
            var searchableText = [
                card.textContent,
                body.dataset.productName || '',
                body.dataset.productCategory || '',
                body.dataset.productDescription || ''
            ].join(' ').toLowerCase();

            var show = !query || searchableText.indexOf(query) !== -1;
            card.style.display = show ? '' : 'none';
            if (show) visible++;
        });

        if (countEl) {
            countEl.textContent = visible + (visible === 1 ? ' drink' : ' drinks');
        }
    };
</script>
</body>
</html>
