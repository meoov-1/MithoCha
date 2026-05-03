<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MithoCha | Artisanal Bubble Tea</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@400;600;700&family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@400" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user/home.css">
</head>
<body>

<header class="navbar">
    <div class="container nav-container">
        <a class="logo" href="${pageContext.request.contextPath}/dashboard">MithoCha</a>
        <nav class="nav-links" aria-label="Primary">
            <a class="active" href="${pageContext.request.contextPath}/dashboard">Home</a>
            <a  href="${pageContext.request.contextPath}/products">Menu</a>
            <a href="${pageContext.request.contextPath}/profile">Profile</a>
        </nav>
        <a class="nav-icon cart-icon" href="${pageContext.request.contextPath}/cart" aria-label="Shopping Cart">
            <span class="material-symbols-outlined">shopping_cart</span>
            <span class="cart-count" id="cartCount"></span>
        </a>
    </div>
</header>

<main>
    <section class="hero container" id="hero">
        <div class="hero-copy">
            <span class="badge">NEW SEASONAL BLENDS</span>
            <h1>Elevating the <span>Art of Tea</span></h1>
            <p>
                Discover handcrafted bubble tea made with premium leaves, silky milk, and fresh toppings.
                Every cup is blended to feel warm, refined, and indulgent.
            </p>
            <div class="buttons">
                <a class="btn-primary" href="${pageContext.request.contextPath}/products">Explore Menu</a>
            </div>
        </div>

        <div class="hero-image-wrap">
            <img class="hero-image" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDF8SgqpiGHpWx_a3eXW4KfUvGhW65fpx9ztHhnlhjgDwmfWV35r7nDv5gKWcywovvCze4KKKf57feGVSxa2niRA2JyyrqZIPvvbi_z-SkEmbh8ab-DD3-cwIkZ3EgSN1kI-Z2gaxUC-AS8hdTcPS8IpRhTb4yB-wulTrLI5vz3WlrzwCGxcqZWwzLMLStegoIc1YgydRFQF95wmASkCYurZsS1MUliTYa0hvwpUSF4lBe3oKgZFyLolAlLhtooOoT_wcxnLLTsCNdb" alt="Bubble tea drink" width="520" height="624">
            <div class="hero-floating-card">
                <span class="material-symbols-outlined">coffee</span>
                <div>
                    <strong>Freshly brewed</strong>
                    <p>Floral, nutty, and creamy notes in every sip.</p>
                </div>
            </div>
        </div>
    </section>

    <section class="section container">
        <div class="feature-strip">
            <article class="feature-card">
                <span class="material-symbols-outlined">water_drop</span>
                <div>
                    <h3>Handcrafted daily</h3>
                    <p>Small-batch brewing for a smoother, richer flavor profile.</p>
                </div>
            </article>

            <article class="feature-card">
                <span class="material-symbols-outlined">local_cafe</span>
                <div>
                    <h3>Premium ingredients</h3>
                    <p>Carefully selected tea leaves, milk, and toppings for every cup.</p>
                </div>
            </article>

            <article class="feature-card">
                <span class="material-symbols-outlined">schedule</span>
                <div>
                    <h3>Fast pickup</h3>
                    <p>Order ahead and enjoy your favorite drink without the wait.</p>
                </div>
            </article>
        </div>
    </section>

    <section class="section container" id="discover">
        <div class="section-heading">
            <p class="page-tag">Discover our blends</p>
            <h2 class="section-title">Designed for your daily craving</h2>
            <p class="section-copy">Explore smooth classics, fruit-forward refreshers, and signature tea specials that match the mood of your day.</p>
        </div>

        <div class="menu-grid">
            <article class="menu-card menu-card-large">
                <img src="https://images.unsplash.com/photo-1515823064-d6e0c04616a7?auto=format&fit=crop&w=1200&q=80" alt="Creamy matcha latte" width="620" height="380" loading="lazy">
                <button class="image-order-button" type="button" data-name="Classic Matcha Float" data-price="360" data-description="A silky matcha blend with a creamy finish and soft sweetness.">
                    <span class="material-symbols-outlined">add_shopping_cart</span>
                    Order Now
                </button>
                <div class="menu-card-body">
                    <p class="menu-tag">Customer favorite</p>
                    <h3>Classic Matcha Float</h3>
                    <p>A silky matcha blend with a creamy finish and soft sweetness.</p>
                </div>
            </article>

            <article class="menu-card">
                <img src="https://images.unsplash.com/photo-1556679343-c7306c1976bc?auto=format&fit=crop&w=1200&q=80" alt="Iced tea drink" width="380" height="250" loading="lazy">
                <button class="image-order-button" type="button" data-name="Golden Milk Tea" data-price="340" data-description="Roasted tea, brown sugar pearls, and creamy milk layered beautifully.">
                    <span class="material-symbols-outlined">add_shopping_cart</span>
                    Order Now
                </button>
                <div class="menu-card-body">
                    <p class="menu-tag">Brewed fresh</p>
                    <h3>Golden Milk Tea</h3>
                    <p>Roasted tea, brown sugar pearls, and creamy milk layered beautifully.</p>
                </div>
            </article>

            <article class="menu-card">
                <img src="https://images.unsplash.com/photo-1470337458703-46ad1756a187?auto=format&fit=crop&w=1200&q=80" alt="Fruit tea and herbal tea" width="380" height="250" loading="lazy">
                <button class="image-order-button" type="button" data-name="Peach Jasmine Sparkle" data-price="390" data-description="Light floral notes with juicy peach flavor and a refreshing finish.">
                    <span class="material-symbols-outlined">add_shopping_cart</span>
                    Order Now
                </button>
                <div class="menu-card-body">
                    <p class="menu-tag">Limited time</p>
                    <h3>Peach Jasmine Sparkle</h3>
                    <p>Light floral notes with juicy peach flavor and a refreshing finish.</p>
                </div>
            </article>
        </div>
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
</body>
</html>
