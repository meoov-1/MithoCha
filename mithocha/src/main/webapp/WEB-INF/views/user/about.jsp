<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us — MithoCha</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:ital,wght@0,400;0,600;0,700;1,400&family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@400" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user/about.css">
</head>
<body>

<header class="navbar">
    <div class="container nav-container">
        <a class="logo" href="${pageContext.request.contextPath}/dashboard">MithoCha</a>
        <nav class="nav-links" aria-label="Primary">
            <a href="${pageContext.request.contextPath}/dashboard">Home</a>
            <a href="${pageContext.request.contextPath}/products">Menu</a>
            <a class="active" href="${pageContext.request.contextPath}/about">About</a>
            <a href="${pageContext.request.contextPath}/contact">Contact</a>
            <a href="${pageContext.request.contextPath}/profile">Profile</a>
        </nav>
        <a class="nav-icon cart-icon" href="${pageContext.request.contextPath}/cart" aria-label="Shopping Cart">
            <span class="material-symbols-outlined">shopping_cart</span>
        </a>
    </div>
</header>

<main>

    <!-- ── Hero ── -->
    <section class="about-hero">
        <div class="hero-overlay"></div>
        <img class="hero-bg"
             src="https://images.unsplash.com/photo-1556679343-c7306c1976bc?auto=format&fit=crop&w=1600&q=80"
             alt="MithoCha bubble tea">
        <div class="container hero-content">
            <p class="eyebrow">Our Story</p>
            <h1>Crafted with Passion,<br>Served with Love</h1>
            <p class="hero-sub">From the hills of Nepal to your cup — MithoCha is more than a drink, it's a feeling.</p>
        </div>
    </section>

    <!-- ── Mission ── -->
    <section class="section container">
        <div class="two-col-layout">
            <div class="text-block">
                <p class="eyebrow-dark">Who We Are</p>
                <h2 class="section-title">A Nepali Bubble Tea Brand Born from Curiosity</h2>
                <p class="body-text">
                    MithoCha (मिठो चा — "sweet tea" in Nepali) was founded in 2022 by a group of tea enthusiasts
                    who wanted to bring the joy of artisanal bubble tea to Nepal. We blend traditional Himalayan
                    tea culture with modern flavour innovation to create drinks that feel both familiar and exciting.
                </p>
                <p class="body-text">
                    Every cup is handcrafted using premium tea leaves sourced from the Ilam region, fresh local
                    milk, and house-made syrups. We believe great tea deserves great ingredients — no shortcuts,
                    no compromises.
                </p>
            </div>
            <div class="image-block">
                <img src="https://images.unsplash.com/photo-1515823064-d6e0c04616a7?auto=format&fit=crop&w=800&q=80"
                     alt="MithoCha team crafting tea" class="rounded-img">
            </div>
        </div>
    </section>

    <!-- ── Values ── -->
    <section class="section values-section">
        <div class="container">
            <div class="section-heading centered">
                <p class="eyebrow-dark">What Drives Us</p>
                <h2 class="section-title">Our Core Values</h2>
            </div>
            <div class="values-grid">
                <article class="value-card">
                    <div class="value-icon">
                        <span class="material-symbols-outlined">eco</span>
                    </div>
                    <h3>Sustainability</h3>
                    <p>We source ingredients responsibly and use eco-friendly packaging to protect the environment we love.</p>
                </article>
                <article class="value-card">
                    <div class="value-icon">
                        <span class="material-symbols-outlined">favorite</span>
                    </div>
                    <h3>Craftsmanship</h3>
                    <p>Every drink is made to order with care. We never pre-make or compromise on freshness.</p>
                </article>
                <article class="value-card">
                    <div class="value-icon">
                        <span class="material-symbols-outlined">diversity_3</span>
                    </div>
                    <h3>Community</h3>
                    <p>We partner with local farmers and support Nepali artisans to keep our roots strong.</p>
                </article>
                <article class="value-card">
                    <div class="value-icon">
                        <span class="material-symbols-outlined">science</span>
                    </div>
                    <h3>Innovation</h3>
                    <p>We constantly experiment with new flavours, seasonal specials, and unique Nepali-inspired blends.</p>
                </article>
            </div>
        </div>
    </section>

    <!-- ── Team ── -->
    <section class="section container">
        <div class="section-heading centered">
            <p class="eyebrow-dark">The People Behind the Cup</p>
            <h2 class="section-title">Meet Our Team</h2>
        </div>
        <div class="team-grid">
            <article class="team-card">
                <div class="team-avatar" style="background:linear-gradient(135deg,#f0bd8b,#7d562d);">
                    <span class="material-symbols-outlined">person</span>
                </div>
                <h3>Aarav Shrestha</h3>
                <p class="team-role">Founder &amp; Head Brewer</p>
                <p class="team-bio">Tea enthusiast with 10+ years of experience blending Himalayan teas.</p>
            </article>
            <article class="team-card">
                <div class="team-avatar" style="background:linear-gradient(135deg,#ffdcbd,#9a6113);">
                    <span class="material-symbols-outlined">person</span>
                </div>
                <h3>Priya Tamang</h3>
                <p class="team-role">Creative Director</p>
                <p class="team-bio">Designs every flavour experience from concept to cup with artistic precision.</p>
            </article>
            <article class="team-card">
                <div class="team-avatar" style="background:linear-gradient(135deg,#ffe9e4,#7b5647);">
                    <span class="material-symbols-outlined">person</span>
                </div>
                <h3>Rohan Gurung</h3>
                <p class="team-role">Operations Manager</p>
                <p class="team-bio">Ensures every order reaches you fresh, fast, and exactly as you imagined.</p>
            </article>
        </div>
    </section>

    <!-- ── Stats ── -->
    <section class="stats-strip">
        <div class="container stats-grid">
            <div class="stat-item">
                <span class="stat-number">50+</span>
                <span class="stat-label">Unique Flavours</span>
            </div>
            <div class="stat-item">
                <span class="stat-number">10K+</span>
                <span class="stat-label">Happy Customers</span>
            </div>
            <div class="stat-item">
                <span class="stat-number">3</span>
                <span class="stat-label">Locations</span>
            </div>
            <div class="stat-item">
                <span class="stat-number">2022</span>
                <span class="stat-label">Founded</span>
            </div>
        </div>
    </section>

    <!-- ── CTA ── -->
    <section class="section container">
        <div class="cta-card">
            <div>
                <p class="eyebrow-dark">Ready to taste?</p>
                <h2 class="section-title">Explore Our Full Menu</h2>
                <p class="body-text">From classic milk teas to seasonal fruit blends — there's a perfect cup waiting for you.</p>
            </div>
            <a class="btn-primary" href="${pageContext.request.contextPath}/products">
                View Menu
                <span class="material-symbols-outlined">arrow_forward</span>
            </a>
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
                <p><a href="${pageContext.request.contextPath}/about">About Us</a></p>
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

</body>
</html>
