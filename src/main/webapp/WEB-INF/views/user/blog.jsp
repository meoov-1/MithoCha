<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.List,com.mithocha.model.Product,com.mithocha.dao.impl.ProductDAOImpl,com.mithocha.util.ValidationUtil" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blog — MithoCha</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:ital,wght@0,400;0,600;0,700;1,400&family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@400" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user/blog.css">
</head>
<body>

<%-- ── Navbar ── --%>
<header class="navbar">
    <div class="container nav-container">
        <a class="logo" href="${pageContext.request.contextPath}/dashboard">MithoCha</a>
        <nav class="nav-links" aria-label="Primary">
            <a href="${pageContext.request.contextPath}/dashboard">Home</a>
            <a href="${pageContext.request.contextPath}/products">Menu</a>
            <a class="active" href="${pageContext.request.contextPath}/blog">Blog</a>
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

<main>

    <%-- ── Hero — About MithoCha ── --%>
    <section class="blog-hero">
        <div class="container">
            <p class="eyebrow">About</p>
            <h1 class="hero-title">About MithoCha</h1>
            <p class="hero-sub">A community-focused tea house celebrating Himalayan teas, craftsmanship, and warm hospitality.</p>
        </div>
    </section>

    <%-- ── About MithoCha — Story & Visit ── --%>
    <section class="section container">
        <article class="featured-post">
            <div class="featured-image-wrap">
                <img src="${pageContext.request.contextPath}/assets/images/coffee-beans.jpg"
                     alt="Coffee beans and ground coffee" loading="lazy">
            </div>
            <div class="featured-body">
                <div class="post-meta">
                    <span class="meta-cat">Our Story</span>
                    <span class="meta-dot">·</span>
                    <span class="meta-date">Established 2020</span>
                </div>
                <h2 class="post-title">MithoCha — From Farm to Cup</h2>
                <p class="post-excerpt">
                    What began as a small stall in Kathmandu has grown into a community tea house dedicated to
                    celebrating Himalayan tea traditions. We partner with smallholder farmers in Ilam, blend
                    time-honoured techniques with modern flavours, and craft each cup by hand.
                </p>
                <p class="post-excerpt">
                    Our mission is simple: make every cup meaningful. That means sourcing responsibly, reducing waste,
                    and training our team to brew with care. Whether you're here for a quick pick-up or to linger over
                    a book, MithoCha is designed to feel like a warm, familiar pause in your day.
                </p>
                <div style="display:flex;gap:12px;margin-top:18px;flex-wrap:wrap;">
                    <a class="read-more" href="#values">Our Values</a>
                    <a class="read-more" href="#visit" style="background:#fff8f6;color:#4b2c20;">Visit Us</a>
                </div>
            </div>
        </article>

        <div id="values" style="display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:18px;margin-top:30px;">
            <div style="background:#fff;border:1px solid var(--border);padding:20px;border-radius:16px;">
                <h3 style="margin:0 0 8px;color:var(--primary);">Craftsmanship</h3>
                <p style="margin:0;color:var(--muted);">Every recipe is hand-tested; our baristas are trained to extract precise flavour and texture.</p>
            </div>
            <div style="background:#fff;border:1px solid var(--border);padding:20px;border-radius:16px;">
                <h3 style="margin:0 0 8px;color:var(--primary);">Sourcing</h3>
                <p style="margin:0;color:var(--muted);">We work directly with Ilam tea growers to ensure fair compensation and sustainable practices.</p>
            </div>
            <div style="background:#fff;border:1px solid var(--border);padding:20px;border-radius:16px;">
                <h3 style="margin:0 0 8px;color:var(--primary);">Community</h3>
                <p style="margin:0;color:var(--muted);">MithoCha hosts local events, brew workshops, and supports neighborhood initiatives.</p>
            </div>
        </div>

        <section id="visit" style="margin-top:34px;display:flex;gap:22px;flex-wrap:wrap;align-items:flex-start;">
            <div style="flex:1;min-width:300px;background:#fff;border-radius:16px;padding:20px;border:1px solid var(--border);">
                <h3 style="margin-top:0;color:var(--primary);">Visit Our Cafe</h3>
                <p style="color:var(--muted);">Drop in for daily favourites or try one of our seasonal specials. We offer pickup, dine-in, and light snacks.</p>
                <ul style="color:var(--muted);padding-left:18px;">
                    <li><strong>Address:</strong> Informatics College Pokhara</li>
                    <li><strong>Hours:</strong> Mon–Sun 09:00 — 21:00</li>
                    <li><strong>Phone:</strong> 90000000</li>
                    <li><strong>Email:</strong> mithocha@gmail.com</li>
                </ul>
                <p style="margin-top:12px;color:var(--muted);">Find us on Google Maps or send us a message — we're happy to answer questions about menu items and accessibility.</p>
            </div>
            <div style="flex:1;min-width:320px;">
                <div style="border-radius:16px;overflow:hidden;border:1px solid var(--border);box-shadow:var(--shadow-soft);">
                    <img src="${pageContext.request.contextPath}/assets/images/cafe-interior.jpg" alt="Cafe interior and seating" style="width:100%;height:100%;object-fit:cover;display:block;">
                </div>
            </div>
        </section>

        <div style="margin-top:34px;display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:18px;">
            <div style="background:#fff;border-radius:12px;padding:18px;border:1px solid var(--border);">
                <h4 style="margin:0 0 8px;color:var(--primary);">Our Story</h4>
                <p style="margin:0;color:var(--muted);">Started by friends who loved tea and conversation, MithoCha grew from a shared dream: to make quality tea approachable. We began with community pop-ups and today maintain the same curiosity and warmth that started it all.</p>
            </div>
            <div style="background:#fff;border-radius:12px;padding:18px;border:1px solid var(--border);">
                <h4 style="margin:0 0 8px;color:var(--primary);">Sustainability</h4>
                <p style="margin:0;color:var(--muted);">We minimise single-use packaging, recycle tea waste as compost, and choose suppliers who share our environmental goals.</p>
            </div>
            <div style="background:#fff;border-radius:12px;padding:18px;border:1px solid var(--border);">
                <h4 style="margin:0 0 8px;color:var(--primary);">Community Events</h4>
                <p style="margin:0;color:var(--muted);">From cupping sessions to local artist nights, join our calendar of events to meet neighbors and learn something new.</p>
            </div>
        </div>
    </section>
    <%-- ── Newsletter CTA ── --%>
    <section class="newsletter-section">
        <div class="container newsletter-card">
            <div class="newsletter-text">
                <p class="eyebrow-light">Stay in the loop</p>
                <h2 class="newsletter-title">Get Tea Stories in Your Inbox</h2>
                <p class="newsletter-sub">New recipes, seasonal menus, and behind-the-scenes stories — delivered monthly.</p>
            </div>
            <form class="newsletter-form" onsubmit="handleNewsletterSubmit(event)">
                <input type="email" id="newsletterEmail" placeholder="your@email.com" required
                       class="newsletter-input" autocomplete="email">
                <button type="submit" class="newsletter-btn">
                    Subscribe
                    <span class="material-symbols-outlined">send</span>
                </button>
            </form>
            <p id="newsletterMsg" style="display:none;margin-top:12px;font-size:14px;font-weight:600;color:#ffdcbd;"></p>
        </div>
    </section>

</main>

<%-- ── Footer ── --%>
<footer class="footer">
    <div class="footer-container">
        <div class="footer-links">
            <div>
                <h4>Customer Care</h4>
                <p><a href="${pageContext.request.contextPath}/contact">Contact Us</a></p>
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

<script src="${pageContext.request.contextPath}/js/user/storefront.js"></script>
<script src="${pageContext.request.contextPath}/js/logout-popup.js"></script>
<script>
    /* ── Category filter ── */
    function filterPosts(category, btn) {
        document.querySelectorAll('.cat-btn').forEach(function(b){ b.classList.remove('active'); });
        btn.classList.add('active');

        var cards   = document.querySelectorAll('.post-card');
        var visible = 0;
        cards.forEach(function(card) {
            var show = category === 'all' || card.dataset.category === category;
            card.style.display = show ? '' : 'none';
            if (show) visible++;
        });
        document.getElementById('noPostsMsg').style.display = visible === 0 ? 'block' : 'none';
    }

    /* ── Newsletter ── */
    function handleNewsletterSubmit(e) {
        e.preventDefault();
        var email = document.getElementById('newsletterEmail').value.trim();
        var msg   = document.getElementById('newsletterMsg');
        msg.textContent = 'Thanks! We\'ll send tea stories to ' + email + ' soon.';
        msg.style.display = 'block';
        document.getElementById('newsletterEmail').value = '';
    }
</script>
</body>
</html>
