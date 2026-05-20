<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"  uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
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
    <style>
        /* ── Floating Cup — bare, no card ── */
        .hero-cup-wrap {
            position: relative;
            display: flex;
            align-items: flex-end;
            justify-content: center;
            width: 420px;
            height: 540px;
        }

        .hero-cup-img {
            position: relative;
            z-index: 2;
            width: 360px;
            height: auto;
            filter:
                drop-shadow(0 40px 60px rgba(160, 90, 20, 0.50))
                drop-shadow(0 12px 24px rgba(50, 23, 13, 0.28))
                drop-shadow(0 -4px 18px rgba(220, 150, 60, 0.18));
            animation: cup-float 3.8s ease-in-out infinite;
            will-change: transform;
        }

        @keyframes cup-float {
            0%,  100% { transform: translateY(0px) scale(1); }
            50%        { transform: translateY(-22px) scale(1.012); }
        }

        /* Ambient warm glow behind the cup */
        .hero-cup-glow {
            position: absolute;
            top: 50%; left: 50%;
            transform: translate(-50%, -55%);
            width: 320px; height: 320px;
            border-radius: 50%;
            background: radial-gradient(circle,
                rgba(220, 140, 40, 0.22) 0%,
                rgba(180, 100, 20, 0.10) 45%,
                transparent 70%);
            z-index: 1;
            animation: glow-pulse 3.8s ease-in-out infinite;
        }

        @keyframes glow-pulse {
            0%,  100% { opacity: 0.8; transform: translate(-50%,-55%) scale(1); }
            50%        { opacity: 1;   transform: translate(-50%,-55%) scale(1.15); }
        }

        /* Ground shadow that breathes with the float */
        .hero-cup-shadow {
            position: absolute;
            bottom: 4px; left: 50%;
            transform: translateX(-50%);
            width: 200px; height: 24px;
            border-radius: 50%;
            background: radial-gradient(ellipse, rgba(100, 60, 20, 0.30) 0%, transparent 70%);
            animation: shadow-breathe 3.8s ease-in-out infinite;
            z-index: 1;
        }

        @keyframes shadow-breathe {
            0%,  100% { width: 200px; opacity: 0.75; }
            50%        { width: 150px; opacity: 0.28; }
        }

        /* ── Location / Map section — full-width, no card ── */
        .location-section {
            padding: 90px 0 0;
            background: transparent;
        }

        .location-section-header {
            text-align: center;
            margin-bottom: 56px;
        }

        .location-section-header .page-tag { margin-bottom: 10px; }

        .location-section-header h2 {
            font-family: 'Noto Serif', serif;
            font-size: clamp(28px, 4vw, 44px);
            font-weight: 700;
            color: #32170d;
            margin: 0 0 14px;
            line-height: 1.2;
        }

        .location-section-header p {
            color: #504440;
            font-size: 16px;
            line-height: 1.7;
            max-width: 520px;
            margin: 0 auto;
        }

        /* Info strip — 3 columns above the map */
        .location-info-strip {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 0;
            margin-bottom: 40px;
            border-radius: 20px;
            overflow: hidden;
            border: 1px solid rgba(125,86,45,0.12);
        }

        .location-info-item {
            display: flex;
            align-items: flex-start;
            gap: 14px;
            padding: 28px 28px;
            background: transparent;
            border-right: 1px solid rgba(125,86,45,0.12);
            transition: background .2s;
        }

        .location-info-item:last-child { border-right: none; }
        .location-info-item:hover { background: rgba(125,86,45,0.04); }

        .location-info-icon {
            width: 44px; height: 44px; border-radius: 12px;
            background: rgba(125,86,45,0.10);
            display: flex; align-items: center; justify-content: center;
            flex-shrink: 0;
        }

        .location-info-icon .material-symbols-outlined {
            font-size: 22px; color: #7d562d;
        }

        .location-info-text strong {
            display: block;
            font-size: 13px;
            font-weight: 700;
            color: #32170d;
            margin-bottom: 3px;
            text-transform: uppercase;
            letter-spacing: 0.04em;
        }

        .location-info-text span {
            font-size: 14px;
            color: #504440;
            line-height: 1.5;
        }

        /* Full-width map */
        .map-full-wrap {
            position: relative;
            border-radius: 24px;
            overflow: hidden;
            height: 460px;
            box-shadow: 0 24px 64px rgba(50,23,13,0.13), 0 4px 16px rgba(50,23,13,0.07);
        }

        .map-full-wrap iframe {
            width: 100%; height: 100%;
            border: none; display: block;
        }

        .map-overlay-badge {
            position: absolute;
            top: 20px; left: 20px;
            background: #32170d;
            color: #fff8f6;
            border-radius: 999px;
            padding: 8px 18px 8px 12px;
            font-size: 13px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 7px;
            box-shadow: 0 6px 20px rgba(50,23,13,0.30);
            z-index: 10;
            pointer-events: none;
        }

        .map-overlay-badge .material-symbols-outlined { font-size: 18px; color: #e8a040; }

        .map-directions-btn {
            position: absolute;
            bottom: 20px; right: 20px;
            background: #32170d;
            color: #fff8f6;
            border-radius: 12px;
            padding: 10px 20px;
            font-size: 13px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 7px;
            box-shadow: 0 6px 20px rgba(50,23,13,0.30);
            z-index: 10;
            text-decoration: none;
            transition: filter .2s;
        }

        .map-directions-btn:hover { filter: brightness(1.15); }
        .map-directions-btn .material-symbols-outlined { font-size: 18px; }

        /* Responsive */
        @media (max-width: 900px) {
            .location-info-strip { grid-template-columns: 1fr 1fr; }
            .location-info-item:nth-child(2) { border-right: none; }
            .location-info-item:nth-child(3) {
                border-right: none;
                border-top: 1px solid rgba(125,86,45,0.12);
                grid-column: 1 / -1;
            }
            .map-full-wrap { height: 340px; }
        }

        @media (max-width: 600px) {
            .location-info-strip { grid-template-columns: 1fr; border-radius: 16px; }
            .location-info-item { border-right: none; border-bottom: 1px solid rgba(125,86,45,0.12); }
            .location-info-item:last-child { border-bottom: none; border-top: none; }
            .location-info-item:nth-child(2) { border-right: none; }
            .location-info-item:nth-child(3) { border-top: none; grid-column: auto; }
            .map-full-wrap { height: 280px; border-radius: 16px; }
            .map-overlay-badge { font-size: 11px; padding: 6px 12px 6px 9px; }
            .map-directions-btn { font-size: 12px; padding: 8px 14px; }
        }

        @media (max-width: 768px) {
            .hero-cup-wrap  { width: 280px; height: 360px; }
            .hero-cup-img   { width: 240px; }
        }

        /* ── Logout popup ── */
        .logout-popup-overlay {
            display: none;
            position: fixed; inset: 0;
            background: rgba(39,24,20,0.45);
            backdrop-filter: blur(4px);
            z-index: 9000;
            align-items: center;
            justify-content: center;
        }
        .logout-popup-overlay.open { display: flex; }
        .logout-popup {
            background: #fff;
            border-radius: 20px;
            padding: 36px 32px 28px;
            width: min(380px, calc(100vw - 40px));
            box-shadow: 0 24px 60px rgba(39,24,20,0.22);
            text-align: center;
            animation: popup-in .22s cubic-bezier(.34,1.56,.64,1);
        }
        @keyframes popup-in {
            from { transform: scale(.88); opacity: 0; }
            to   { transform: scale(1);  opacity: 1; }
        }
        .logout-popup .popup-icon {
            width: 60px; height: 60px; border-radius: 50%;
            background: #fff1ed; display: flex; align-items: center;
            justify-content: center; margin: 0 auto 16px;
        }
        .logout-popup .popup-icon .material-symbols-outlined {
            font-size: 30px; color: #ba1a1a;
        }
        .logout-popup h3 {
            font-family: 'Noto Serif', serif;
            font-size: 20px; font-weight: 700;
            color: #32170d; margin-bottom: 8px;
        }
        .logout-popup p {
            font-size: 14px; color: #504440; margin-bottom: 24px; line-height: 1.6;
        }
        .logout-popup-btns {
            display: flex; gap: 10px;
        }
        .logout-popup-btns .btn-cancel-logout {
            flex: 1; padding: 12px; border: 1.5px solid #d5c3bd;
            border-radius: 10px; background: transparent;
            color: #504440; font-size: 14px; font-weight: 700;
            cursor: pointer; font-family: inherit;
        }
        .logout-popup-btns .btn-confirm-logout {
            flex: 1; padding: 12px; border: none;
            border-radius: 10px; background: #ba1a1a;
            color: #fff; font-size: 14px; font-weight: 700;
            cursor: pointer; font-family: inherit;
            display: flex; align-items: center; justify-content: center; gap: 6px;
        }
        .logout-popup-btns .btn-confirm-logout:hover { filter: brightness(1.1); }
    </style>
</head>
<body>

<header class="navbar">
    <div class="container nav-container">
        <a class="logo" href="${pageContext.request.contextPath}/dashboard">MithoCha</a>
        <nav class="nav-links" aria-label="Primary">
            <a class="active" href="${pageContext.request.contextPath}/dashboard">Home</a>
            <a href="${pageContext.request.contextPath}/products">Menu</a>
            <a href="${pageContext.request.contextPath}/blog">Blog</a>
            <a href="${pageContext.request.contextPath}/contact">Contact</a>
            <a href="${pageContext.request.contextPath}/profile">Profile</a>
        </nav>
        <div style="display:flex;align-items:center;gap:8px;">
            <a class="nav-icon cart-icon" href="${pageContext.request.contextPath}/cart" aria-label="Shopping Cart">
                <span class="material-symbols-outlined">shopping_cart</span>
                <span class="cart-count" id="cartCount"></span>
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
            <div class="hero-cup-wrap">
                <div class="hero-cup-glow"></div>
                <img class="hero-cup-img"
                     src="${pageContext.request.contextPath}/assets/images/Bubble_tea__1_-removebg-preview.png"
                     alt="MithoCha bubble tea with boba and straw">
                <div class="hero-cup-shadow"></div>
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
        <div class="section-heading split-heading">
            <div>
                <p class="page-tag">Discover our blends</p>
                <h2 class="section-title">Designed for your daily craving</h2>
                <p class="section-copy">Explore smooth classics, fruit-forward refreshers, and signature tea specials that match the mood of your day.</p>
            </div>
            <a class="btn-outline view-all-btn" href="${pageContext.request.contextPath}/products">
                View Full Menu
                <span class="material-symbols-outlined">arrow_forward</span>
            </a>
        </div>

        <div class="menu-grid">
            <%-- Dynamic: first 3 products from DB via DashboardServlet --%>
            <c:choose>
              <c:when test="${not empty featuredProducts}">
                <c:forEach var="p" items="${featuredProducts}" varStatus="st">
                  <article class="menu-card ${st.first ? 'menu-card-large' : ''}">
                    <c:choose>
                      <c:when test="${not empty p.imageUrl}">
                        <img src="${p.imageUrl}" alt="${p.name}" loading="lazy">
                      </c:when>
                      <c:otherwise>
                        <div style="width:100%;height:220px;background:#fff1ed;display:flex;align-items:center;justify-content:center;">
                          <span class="material-symbols-outlined" style="font-size:48px;color:#d5c3bd;">local_cafe</span>
                        </div>
                      </c:otherwise>
                    </c:choose>
                    <button class="image-order-button" type="button"
                            data-id="${p.productId}"
                            data-name="${fn:escapeXml(p.name)}"
                            data-price="${p.basePrice}"
                            data-category="${fn:escapeXml(p.category)}"
                            data-description="${fn:escapeXml(p.description)}">
                        <span class="material-symbols-outlined">add_shopping_cart</span>
                        Order Now
                    </button>
                    <div class="menu-card-body">
                        <p class="menu-tag">${p.category}</p>
                        <h3>${p.name}</h3>
                        <p>${p.description}</p>
                    </div>
                  </article>
                </c:forEach>
              </c:when>
              <c:otherwise>
                <div style="grid-column:1/-1;text-align:center;padding:60px 20px;color:#a08070;">
                  <span class="material-symbols-outlined" style="font-size:48px;display:block;margin-bottom:12px;">local_cafe</span>
                  <p style="font-size:16px;margin-bottom:16px;">Our menu is being prepared — check back soon!</p>
                  <a href="${pageContext.request.contextPath}/products" class="btn-outline">Browse All Drinks</a>
                </div>
              </c:otherwise>
            </c:choose>
        </div>

        <%-- "See more" row — always visible, links to full menu --%>
        <div class="see-more-row">
            <div class="see-more-dots">
                <span></span><span></span><span></span>
            </div>
            <a class="see-more-link" href="${pageContext.request.contextPath}/products">
                <span class="material-symbols-outlined">restaurant_menu</span>
                See all drinks
                <span class="material-symbols-outlined">chevron_right</span>
            </a>
            <div class="see-more-dots">
                <span></span><span></span><span></span>
            </div>
        </div>
    </section>

    <%-- ── LOCATION / MAP — full width, no card, placed last ── --%>
    <section class="location-section">
        <div class="container">

            <div class="location-section-header">
                <p class="page-tag">Find Us</p>
                <h2>Come visit us in Pokhara</h2>
                <p>We're right at Informatics College Pokhara, Matepani — easy to find, impossible to miss the aroma. Drop by between classes or after a long day.</p>
            </div>

            <%-- Info strip: 3 columns, no card background ── --%>
            <div class="location-info-strip">
                <div class="location-info-item">
                    <div class="location-info-icon">
                        <span class="material-symbols-outlined">location_on</span>
                    </div>
                    <div class="location-info-text">
                        <strong>Address</strong>
                        <span>Informatics College Pokhara<br>Matepani, Pokhara, Nepal</span>
                    </div>
                </div>
                <div class="location-info-item">
                    <div class="location-info-icon">
                        <span class="material-symbols-outlined">schedule</span>
                    </div>
                    <div class="location-info-text">
                        <strong>Open Hours</strong>
                        <span>Sun – Fri &nbsp;·&nbsp; 9:00 AM – 7:00 PM</span>
                    </div>
                </div>
                <div class="location-info-item">
                    <div class="location-info-icon">
                        <span class="material-symbols-outlined">phone</span>
                    </div>
                    <div class="location-info-text">
                        <strong>Contact</strong>
                        <span>9000000000<br>mithocha@gmail.com</span>
                    </div>
                </div>
            </div>

            <%-- Full-width map — Google Maps pinned to Informatics College Pokhara Matepani ── --%>
            <div class="map-full-wrap">
                <div class="map-overlay-badge">
                    <span class="material-symbols-outlined">location_on</span>
                    MithoCha · Informatics College Pokhara, Matepani
                </div>
                <iframe
                    src="https://maps.google.com/maps?q=Informatics+College+Pokhara+Matepani&t=m&z=16&output=embed&iwloc=near"
                    title="Informatics College Pokhara Matepani"
                    loading="lazy"
                    allowfullscreen
                    referrerpolicy="no-referrer-when-downgrade">
                </iframe>
                <a class="map-directions-btn"
                   href="https://maps.google.com/?q=Informatics+College+Pokhara+Matepani"
                   target="_blank" rel="noopener">
                    <span class="material-symbols-outlined">directions</span>
                    Get Directions
                </a>
            </div>

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
<script>
    /* Server-side values injected by JSP */
    var _mithocha = {
        isLoggedIn: <%= com.mithocha.util.SessionUtil.isLoggedIn(request) ? "true" : "false" %>,
        loginUrl:   "<%= request.getContextPath() %>/login",
        cartUrl:    "<%= request.getContextPath() %>/cart"
    };
</script>
<script>
    /* ── Home page "Order Now" buttons → add to cart ── */
    document.addEventListener("DOMContentLoaded", function () {
        var store = window.MithoChaStorefront;
        if (!store) {
            console.error("MithoChaStorefront not loaded");
            return;
        }

        var isLoggedIn = _mithocha.isLoggedIn;
        var loginUrl   = _mithocha.loginUrl;
        var cartUrl    = _mithocha.cartUrl;

        document.querySelectorAll(".image-order-button").forEach(function (btn) {
            btn.addEventListener("click", function () {
                if (!isLoggedIn) {
                    window.location.href = loginUrl;
                    return;
                }

                var name        = btn.dataset.name        || "Bubble Tea";
                var price       = parseFloat(btn.dataset.price) || 0;
                var description = btn.dataset.description || "";
                var imageUrl    = "";

                var card = btn.closest("article");
                if (card) {
                    var img = card.querySelector("img");
                    // Prefer dataset productImage (SSR-provided), then data-src (lazy-loaded), then src
                    imageUrl = card.dataset.productImage || "";
                    if (!imageUrl && img) {
                        imageUrl = img.getAttribute('data-src') || img.src || "";
                    }
                }

                var item = {
                    productId:      parseInt(btn.dataset.id) || 0,
                    name:           name,
                    imageUrl:       imageUrl,
                    description:    description,
                    category:       btn.dataset.category || "Signature",
                    basePrice:      price,
                    unitPrice:      price,
                    quantity:       1,
                    size:           "Regular",
                    flavour:        "",
                    topping:        "",
                    iceLevel:       "Regular Ice",
                    sugarLevel:     "50%",
                    optionsSummary: "Regular \u2022 50% Sugar \u2022 Regular Ice"
                };

                store.addCartItem(item);
                store.updateCartCount();

                /* visual feedback then redirect to cart */
                btn.innerHTML = '<span class="material-symbols-outlined">check<\/span> Added!';
                btn.style.background = "#7d562d";
                btn.style.color = "#fff";
                btn.disabled = true;
            });
        });
    });
</script>
<script src="${pageContext.request.contextPath}/js/logout-popup.js"></script>
</body>
</html>
