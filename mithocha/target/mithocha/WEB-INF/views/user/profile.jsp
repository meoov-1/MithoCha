<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.List,java.time.format.DateTimeFormatter,com.mithocha.model.User,com.mithocha.model.Profile,com.mithocha.model.Order,com.mithocha.util.ValidationUtil" %>
<%
    User user = (User) request.getAttribute("user");
    Profile profile = (Profile) request.getAttribute("profile");
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    String contextPath = request.getContextPath();
    String profileGender = (String) request.getAttribute("profileGender");
    String profileFavoriteDrink = (String) request.getAttribute("profileFavoriteDrink");
    String profileNotes = (String) request.getAttribute("profileNotes");
    String placeholderImage = "https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=900&q=80";
    String imageUrl = profile != null && !ValidationUtil.isNullOrEmpty(profile.getProfileImageUrl()) ? profile.getProfileImageUrl() : "";
    String resolvedImageUrl = imageUrl;
    if (!ValidationUtil.isNullOrEmpty(imageUrl) && !imageUrl.startsWith("http://") && !imageUrl.startsWith("https://") && !imageUrl.startsWith("/")) {
        resolvedImageUrl = contextPath + "/" + imageUrl;
    }
    DateTimeFormatter orderFormatter = DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MithoCha Profile</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@400;600;700&family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@400" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user/profile.css">
</head>
<body>
<header class="navbar">
    <div class="container nav-container">
        <a class="logo" href="${pageContext.request.contextPath}/dashboard">MithoCha</a>
        <nav class="nav-links" aria-label="Primary">
            <a href="${pageContext.request.contextPath}/dashboard">Home</a>
            <a href="${pageContext.request.contextPath}/products">Menu</a>
            <a class="active" href="${pageContext.request.contextPath}/profile">Profile</a>
        </nav>
        <a class="nav-icon cart-icon" href="${pageContext.request.contextPath}/cart" aria-label="Shopping Cart">
            <span class="material-symbols-outlined">shopping_cart</span>
            <span class="cart-count">0</span>
        </a>
    </div>
</header>

<main class="content-shell">
    <div class="content-wrap">
        <section class="page-hero">
            <p class="page-tag">Profile</p>
            <h1 class="page-title">My Profile</h1>
            <p class="page-copy">This page now reads and writes real `users`, `profile`, and `orders` data, so the values you save here are persisted to your `mithocha` database.</p>
        </section>

        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="message-banner error"><%= ValidationUtil.sanitise(String.valueOf(request.getAttribute("errorMessage"))) %></div>
        <% } %>
        <% if ("true".equals(request.getParameter("saved"))) { %>
            <div class="message-banner success">Your profile was saved successfully.</div>
        <% } %>
        <% if ("true".equals(request.getParameter("orderPlaced"))) { %>
            <div class="message-banner success">Order #<%= ValidationUtil.sanitise(request.getParameter("orderId")) %> was saved successfully. Your cart has been cleared for the next checkout.</div>
        <% } %>

        <section class="profile-layout">
            <aside class="page-card profile-photo-card">
                <div class="avatar-preview" aria-label="Profile photo preview">
                    <img id="profileImagePreview" src="<%= ValidationUtil.sanitise(ValidationUtil.isNullOrEmpty(resolvedImageUrl) ? placeholderImage : resolvedImageUrl) %>" alt="Selected profile preview">
                    <span class="material-symbols-outlined">person</span>
                </div>
                <div>
                    <h2 class="placeholder-title">Account Snapshot</h2>
                    <p class="placeholder-copy">Your profile image, name, and saved order history all come from the backend now.</p>
                </div>
                <div class="profile-summary-list">
                    <div>
                        <strong>Name</strong>
                        <span><%= ValidationUtil.sanitise(user.getName()) %></span>
                    </div>
                    <div>
                        <strong>Email</strong>
                        <span><%= ValidationUtil.sanitise(user.getEmail()) %></span>
                    </div>
                    <div>
                        <strong>Orders Saved</strong>
                        <span><%= orders == null ? 0 : orders.size() %></span>
                    </div>
                </div>
            </aside>

            <section class="page-card profile-form-card">
                <div class="section-heading">
                    <h2 class="placeholder-title">Personal Details</h2>
                    <p class="placeholder-copy">Update your customer profile, delivery address, and upload your own profile image directly from your device.</p>
                </div>

                <form class="profile-form" action="${pageContext.request.contextPath}/profile" method="post" enctype="multipart/form-data">
                    <div class="form-grid">
                        <label class="placeholder-field">
                            <span>Full Name</span>
                            <input type="text" name="fullName" value="<%= ValidationUtil.sanitise(user.getName()) %>" placeholder="Enter your full name" required>
                        </label>

                        <label class="placeholder-field">
                            <span>Email Address</span>
                            <input type="email" name="email" value="<%= ValidationUtil.sanitise(user.getEmail()) %>" readonly>
                        </label>

                        <label class="placeholder-field">
                            <span>Phone Number</span>
                            <input type="tel" name="phone" value="<%= profile != null && profile.getPhone() != null ? ValidationUtil.sanitise(profile.getPhone()) : "" %>" placeholder="+977 98XXXXXXXX">
                        </label>

                        <label class="placeholder-field">
                            <span>Date of Birth</span>
                            <input type="date" name="dateOfBirth" value="<%= profile != null && profile.getDateOfBirth() != null ? profile.getDateOfBirth().toString() : "" %>">
                        </label>

                        <label class="placeholder-field">
                            <span>Gender</span>
                            <select name="gender">
                                <option value="">Select gender</option>
                                <option value="female" <%= "female".equalsIgnoreCase(profileGender) ? "selected" : "" %>>Female</option>
                                <option value="male" <%= "male".equalsIgnoreCase(profileGender) ? "selected" : "" %>>Male</option>
                                <option value="other" <%= "other".equalsIgnoreCase(profileGender) ? "selected" : "" %>>Other</option>
                                <option value="prefer-not-to-say" <%= "prefer-not-to-say".equalsIgnoreCase(profileGender) ? "selected" : "" %>>Prefer not to say</option>
                            </select>
                        </label>

                        <label class="placeholder-field">
                            <span>Favorite Drink</span>
                            <input type="text" name="favoriteDrink" value="<%= ValidationUtil.sanitise(profileFavoriteDrink) %>" placeholder="Milk tea, matcha, fruit tea">
                        </label>

                        <label class="placeholder-field">
                            <span>City</span>
                            <input type="text" name="city" value="<%= profile != null && profile.getCity() != null ? ValidationUtil.sanitise(profile.getCity()) : "" %>" placeholder="Kathmandu">
                        </label>

                        <label class="placeholder-field">
                            <span>Postal Code</span>
                            <input type="text" name="postalCode" value="<%= profile != null && profile.getPostalCode() != null ? ValidationUtil.sanitise(profile.getPostalCode()) : "" %>" placeholder="44600">
                        </label>

                        <label class="placeholder-field full-span">
                            <span>Profile Image</span>
                            <input id="profileImageFile" type="file" name="profileImage" accept="image/png,image/jpeg,image/webp,image/gif">
                            <small class="field-help">Upload JPG, PNG, WEBP, or GIF. Existing image stays if you do not choose a new file.</small>
                        </label>

                        <label class="placeholder-field full-span">
                            <span>Delivery Address</span>
                            <textarea name="address" rows="3" placeholder="Street, city, landmark"><%= profile != null && profile.getAddress() != null ? ValidationUtil.sanitise(profile.getAddress()) : "" %></textarea>
                        </label>

                        <label class="placeholder-field full-span">
                            <span>Profile Notes</span>
                            <textarea name="profileNotes" rows="3" placeholder="Allergies, sweetness preference, or delivery instructions"><%= ValidationUtil.sanitise(profileNotes) %></textarea>
                        </label>
                    </div>

                    <div class="placeholder-actions">
                        <button class="primary-button" type="submit">Save Profile</button>
                        <button class="ghost-button" type="reset">Clear</button>
                    </div>
                </form>
            </section>
        </section>

        <section class="page-card order-history-card">
            <div class="section-heading">
                <h2 class="placeholder-title">Saved Orders</h2>
                <p class="placeholder-copy">These are the orders already persisted through checkout into the `orders` table.</p>
            </div>

            <% if (orders == null || orders.isEmpty()) { %>
                <div class="order-empty">
                    <span class="material-symbols-outlined">receipt_long</span>
                    <p>No orders have been saved yet. Add drinks to your cart and confirm checkout to create your first order.</p>
                </div>
            <% } else { %>
                <div class="orders-grid">
                    <% for (Order order : orders) {
                           String status = order.getStatus() == null ? "pending" : order.getStatus().toLowerCase();
                    %>
                        <article class="order-card">
                            <div class="order-card-head">
                                <div>
                                    <p class="order-label">Order #<%= order.getOrderId() %></p>
                                    <h3><%= ValidationUtil.sanitise(order.getTotalAmount() == null ? "Rs. 0" : "Rs. " + order.getTotalAmount().stripTrailingZeros().toPlainString()) %></h3>
                                </div>
                                <span class="status-pill status-<%= ValidationUtil.sanitise(status) %>"><%= ValidationUtil.sanitise(status) %></span>
                            </div>
                            <p class="order-meta"><%= order.getOrderDate() == null ? "Waiting for timestamp" : orderFormatter.format(order.getOrderDate().toLocalDateTime()) %></p>
                            <details class="order-details">
                                <summary>View saved payload</summary>
                                <pre class="json-preview"><%= ValidationUtil.sanitise(order.getItems()) %></pre>
                            </details>
                        </article>
                    <% } %>
                </div>
            <% } %>
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
        const imageInput = document.getElementById("profileImageFile");
        const preview = document.getElementById("profileImagePreview");
        const fallbackPreview = preview.src;

        function updatePreview() {
            const file = imageInput.files && imageInput.files[0];
            if (!file) {
                preview.src = fallbackPreview;
                return;
            }

            const objectUrl = URL.createObjectURL(file);
            preview.src = objectUrl;
        }

        imageInput.addEventListener("change", updatePreview);

        if (new URLSearchParams(window.location.search).get("orderPlaced") === "true") {
            window.localStorage.removeItem("mithocha-cart");
            if (window.MithoChaStorefront) {
                window.MithoChaStorefront.updateCartCount();
            }
        }
    })();
</script>
</body>
</html>
