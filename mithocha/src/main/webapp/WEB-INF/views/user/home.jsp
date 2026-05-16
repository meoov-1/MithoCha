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
            <a class="nav-icon" href="${pageContext.request.contextPath}/logout" aria-label="Logout" title="Logout"
               style="color:#ba1a1a;" onclick="return confirm('Log out of MithoCha?')">
                <span class="material-symbols-outlined">logout</span>
            </a>
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
            <img class="hero-image"
                 src="https://lh3.googleusercontent.com/aida-public/AB6AXuDYZrGNHM-JSrZ_-EjQi0OE19cCc7gMWzcDxsbuq4KfoTE7CtfKH5v9F2rLZXPMtAlkDMkFtxfZICYUWw_eIZ6LfISL9yvx2lNmx3olN6xdIeoH7K3Ee_K5Tz3yjZ432htCEc0WCNTCzV6LUYOFfsEs_J9k4X5j8M3lhBvZO4l85-hcR2R7Xx_rJUWQby4784tXie9wCktgeXSgu6aYRS8vPAfYlZ_R_7ZsDB-By-QVoD3UfnsEtSOQIv-6WTnDHaQs7WFJ_snolrQ2"
                 alt="MithoCha signature bubble tea" width="520" height="624">
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
            <%-- Card 1 — Gud-Caramel Butterscotch (featured/large) --%>
            <article class="menu-card menu-card-large">
                <img src="https://lh3.googleusercontent.com/aida-public/AB6AXuDYZrGNHM-JSrZ_-EjQi0OE19cCc7gMWzcDxsbuq4KfoTE7CtfKH5v9F2rLZXPMtAlkDMkFtxfZICYUWw_eIZ6LfISL9yvx2lNmx3olN6xdIeoH7K3Ee_K5Tz3yjZ432htCEc0WCNTCzV6LUYOFfsEs_J9k4X5j8M3lhBvZO4l85-hcR2R7Xx_rJUWQby4784tXie9wCktgeXSgu6aYRS8vPAfYlZ_R_7ZsDB-By-QVoD3UfnsEtSOQIv-6WTnDHaQs7WFJ_snolrQ2"
                     alt="Gud-Caramel Butterscotch bubble tea" width="620" height="380" loading="lazy">
                <button class="image-order-button" type="button"
                        data-name="Gud-Caramel Butterscotch"
                        data-price="350"
                        data-description="A rich, jaggery-infused butterscotch blend that captures the warmth of traditional Nepali sweetness.">
                    <span class="material-symbols-outlined">add_shopping_cart</span>
                    Order Now
                </button>
                <div class="menu-card-body">
                    <p class="menu-tag">Bestseller</p>
                    <h3>Gud-Caramel Butterscotch</h3>
                    <p>A rich, jaggery-infused butterscotch blend that captures the warmth of traditional Nepali sweetness.</p>
                </div>
            </article>

            <%-- Card 2 — Dark Chocolate --%>
            <article class="menu-card">
                <img src="https://lh3.googleusercontent.com/aida-public/AB6AXuBquX2fNKHlLm4aGMoIl5OqewCbVzo7BJDy19gbdy2Ln-en1dklix1Ih2kfAWeSbVhSA6J_kn1hsGEEVw_qFl-QZNN0Md4DwIX9Sx4zMNkHrFeitnutGAQTMJxW9TJl9Xc3P3rbm_qCkVI3J_gEqG5q-3X0UqobxtPHei962zde8ElnRyawz1spQALNeqLOawkrAc-OE6MXjTfddoh10SokxQ-b6IGsvZbc3m6KWNQZ4a1Qjcq6S-AiOg3l60fMoE-oMv13HFSMPIdo"
                     alt="Dark Chocolate bubble tea" width="380" height="250" loading="lazy">
                <button class="image-order-button" type="button"
                        data-name="Dark Chocolate"
                        data-price="380"
                        data-description="Deep cocoa layers met with fresh Himalayan milk for an intense, velvety chocolate escape.">
                    <span class="material-symbols-outlined">add_shopping_cart</span>
                    Order Now
                </button>
                <div class="menu-card-body">
                    <p class="menu-tag">Bold &amp; Indulgent</p>
                    <h3>Dark Chocolate</h3>
                    <p>Deep cocoa layers met with fresh Himalayan milk for an intense, velvety chocolate escape.</p>
                </div>
            </article>

            <%-- Card 3 — Red Strawberry --%>
            <article class="menu-card">
                <img src="https://lh3.googleusercontent.com/aida-public/AB6AXuBjKtMt-cGyRjuS3wBgvv9GGeZQg18oha7X_8eOHFae6vCPJjeh4fB4ROD2lOhGwSkucYk1HDc5wzBhWDNTltTAvFEwxzzcgDS2mjjKISVl-PxnnYJ4AWwgda-04CNuoaKlSKo2IcvmJAS5HM0Pex-vVwp-ndfz3B5N4Ay04jVEn5i6oMVl7BCP-2D9g5IHXFqULub4i1JTnch08XXber5QQW6jsuiS2bDB5nQYyf_V6DgU3QuG3Am0u_X52iO654WXwJvE8peSm2zT"
                     alt="Red Strawberry bubble tea" width="380" height="250" loading="lazy">
                <button class="image-order-button" type="button"
                        data-name="Red Strawberry"
                        data-price="400"
                        data-description="Sun-ripened strawberries blended into a refreshing tea for a burst of crimson joy.">
                    <span class="material-symbols-outlined">add_shopping_cart</span>
                    Order Now
                </button>
                <div class="menu-card-body">
                    <p class="menu-tag">Fruit Tea</p>
                    <h3>Red Strawberry</h3>
                    <p>Sun-ripened strawberries blended into a refreshing tea for a burst of crimson joy.</p>
                </div>
            </article>
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
    /* ── Home page "Order Now" buttons → add to cart ── */
    (function () {
        var store = window.MithoChaStorefront;

        document.querySelectorAll(".image-order-button").forEach(function (btn) {
            btn.addEventListener("click", function () {
                var name        = btn.dataset.name        || "Bubble Tea";
                var price       = parseFloat(btn.dataset.price) || 0;
                var description = btn.dataset.description || "";
                var imageUrl    = "";

                /* grab the nearest img inside the same article */
                var card = btn.closest("article");
                if (card) {
                    var img = card.querySelector("img");
                    if (img) imageUrl = img.src;
                }

                store.addCartItem({
                    productId:      0,
                    name:           name,
                    imageUrl:       imageUrl,
                    description:    description,
                    category:       "Signature",
                    basePrice:      price,
                    unitPrice:      price,
                    quantity:       1,
                    size:           "Regular",
                    flavour:        "",
                    topping:        "",
                    iceLevel:       "Regular Ice",
                    sugarLevel:     "50%",
                    optionsSummary: "Regular • 50% Sugar • Regular Ice"
                });

                /* visual feedback */
                var original = btn.innerHTML;
                btn.innerHTML = '<span class="material-symbols-outlined">check</span> Added!';
                btn.style.background = "var(--secondary)";
                btn.style.color = "#fff";
                setTimeout(function () {
                    btn.innerHTML = original;
                    btn.style.background = "";
                    btn.style.color = "";
                }, 1400);
            });
        });
    })();
</script>
</body>
</html>
