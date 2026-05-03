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
            <a href="${pageContext.request.contextPath}/profile">Profile</a>
        </nav>
        <a class="nav-icon cart-icon" href="${pageContext.request.contextPath}/cart" aria-label="Shopping Cart">
            <span class="material-symbols-outlined">shopping_cart</span>
            <span class="cart-count">0</span>
        </a>
    </div>
</header>

<main class="products-main">
    <header class="page-hero container">
        <p class="eyebrow">MithoCha Menu</p>
        <h1 class="page-title">Freshly Brewed From Your Database</h1>
        <p class="page-copy">Every product card below is rendered from the `product` table, so updates in your `mithocha` database now show up directly in the storefront.</p>
    </header>

    <section class="container product-section">
        <div class="category-bar">
            <a class="category-pill <%= selectedCategory == null || selectedCategory.trim().isEmpty() ? "active" : "" %>" href="<%= contextPath %>/products">All Drinks</a>
            <% if (categories != null) {
                   for (String category : categories) {
                       if (ValidationUtil.isNullOrEmpty(category)) {
                           continue;
                       }
            %>
                <a class="category-pill <%= category.equalsIgnoreCase(selectedCategory == null ? "" : selectedCategory) ? "active" : "" %>"
                   href="<%= contextPath %>/products?category=<%= URLEncoder.encode(category, "UTF-8") %>"><%= ValidationUtil.sanitise(category) %></a>
            <%     }
               } %>
        </div>

        <% if (products == null || products.isEmpty()) { %>
            <section class="empty-state">
                <span class="material-symbols-outlined">local_cafe</span>
                <h2>No drinks matched this view yet</h2>
                <p>Add rows to the `product` table in `mithocha`, or clear the current category filter to see the full menu.</p>
                <a class="primary-action empty-action" href="<%= contextPath %>/products">Show Full Menu</a>
            </section>
        <% } else { %>
            <div class="product-grid">
                <% for (Product product : products) {
                       String imageUrl = ValidationUtil.isNullOrEmpty(product.getImageUrl()) ? placeholderImage : product.getImageUrl();
                       String category = ValidationUtil.isNullOrEmpty(product.getCategory()) ? "Signature" : product.getCategory();
                       String price = product.getBasePrice() == null ? "0" : product.getBasePrice().stripTrailingZeros().toPlainString();
                %>
                    <article class="product-card">
                        <div class="product-media">
                            <img src="<%= ValidationUtil.sanitise(imageUrl) %>" alt="<%= ValidationUtil.sanitise(product.getName()) %>">
                            <span class="badge"><%= ValidationUtil.sanitise(category) %></span>
                        </div>
                        <div class="product-body product-card-body"
                             data-product-id="<%= product.getProductId() %>"
                             data-product-name="<%= ValidationUtil.sanitise(product.getName()) %>"
                             data-product-image="<%= ValidationUtil.sanitise(imageUrl) %>"
                             data-product-description="<%= ValidationUtil.sanitise(product.getDescription()) %>"
                             data-product-category="<%= ValidationUtil.sanitise(category) %>"
                             data-product-base-price="<%= price %>"
                             data-product-sizes="<%= ValidationUtil.sanitise(product.getSizes() == null ? "" : product.getSizes()) %>"
                             data-product-flavours="<%= ValidationUtil.sanitise(product.getFlavours() == null ? "" : product.getFlavours()) %>"
                             data-product-toppings="<%= ValidationUtil.sanitise(product.getToppings() == null ? "" : product.getToppings()) %>">
                            <div class="product-title-row">
                                <h3><%= ValidationUtil.sanitise(product.getName()) %></h3>
                                <span class="price">Rs. <%= price %></span>
                            </div>
                            <p class="product-copy"><%= ValidationUtil.sanitise(product.getDescription()) %></p>
                            <div class="tag-row">
                                <span class="mini-tag"><%= ValidationUtil.sanitise(category) %></span>
                                <% if (!ValidationUtil.isNullOrEmpty(product.getSizes()) || !ValidationUtil.isNullOrEmpty(product.getFlavours()) || !ValidationUtil.isNullOrEmpty(product.getToppings())) { %>
                                    <span class="mini-tag">Customizable</span>
                                <% } %>
                            </div>
                            <div class="card-actions">
                                <button class="primary-action quick-cart-button" type="button"><%= loggedInUser != null ? "Add to Cart" : "Save to Cart" %></button>
                                <a class="primary-action product-link" href="<%= contextPath %>/product-detail?id=<%= product.getProductId() %>">Customize Order</a>
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
<script>
    (function () {
        const store = window.MithoChaStorefront;
        const fallbackSizes = [
            { label: "Regular", extra: 0, meta: "500ml" }
        ];

        document.querySelectorAll(".quick-cart-button").forEach(function (button) {
            button.addEventListener("click", function () {
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

                button.textContent = "Added";
                window.setTimeout(function () {
                    button.textContent = "<%= loggedInUser != null ? "Add to Cart" : "Save to Cart" %>";
                }, 1400);
            });
        });
    })();
</script>
</body>
</html>
