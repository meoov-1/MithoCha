<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
            <span class="cart-count" id="cartCount">0</span>
        </a>
    </div>
</header>

<main class="products-main">
    <header class="page-hero container">
        <p class="eyebrow">MithoCha Menu</p>
        <h1 class="page-title">Mitho Bubble Tea</h1>
        <p class="page-copy">Delight in every sip. Our authentic bubble teas are crafted with premium tea leaves, fresh milk, and the perfect chewy pearls.</p>
    </header>

    <section class="container product-section">

        <div class="product-grid">
            <article class="product-card featured">
                <div class="product-media">
                    <img src="https://lh3.googleusercontent.com/aida-public/AB6AXuDYZrGNHM-JSrZ_-EjQi0OE19cCc7gMWzcDxsbuq4KfoTE7CtfKH5v9F2rLZXPMtAlkDMkFtxfZICYUWw_eIZ6LfISL9yvx2lNmx3olN6xdIeoH7K3Ee_K5Tz3yjZ432htCEc0WCNTCzV6LUYOFfsEs_J9k4X5j8M3lhBvZO4l85-hcR2R7Xx_rJUWQby4784tXie9wCktgeXSgu6aYRS8vPAfYlZ_R_7ZsDB-By-QVoD3UfnsEtSOQIv-6WTnDHaQs7WFJ_snolrQ2" alt="caramel colored bubble tea with syrup swirls">
                    <span class="badge">Bestseller</span>
                </div>
                <div class="product-body">
                    <div class="product-title-row">
                        <h3>Gud-Caramel Butterscotch</h3>
                        <span class="price">Rs. 350</span>
                    </div>
                    <p class="product-copy">A rich, jaggery-infused butterscotch blend that captures the warmth of traditional Nepali sweetness.</p>
                    <div class="tag-row">
                        <span class="mini-tag">Gurmuri</span>
                        <span class="mini-tag">Caramelized</span>
                    </div>
                    <div class="card-actions">
                        <button class="primary-action" type="button">Order</button>
                        <button class="icon-action" type="button" aria-label="Product settings">
                            <span class="material-symbols-outlined">settings</span>
                        </button>
                    </div>
                </div>
            </article>

            <article class="product-card">
                <div class="product-media">
                    <img src="https://lh3.googleusercontent.com/aida-public/AB6AXuBquX2fNKHlLm4aGMoIl5OqewCbVzo7BJDy19gbdy2Ln-en1dklix1Ih2kfAWeSbVhSA6J_kn1hsGEEVw_qFl-QZNN0Md4DwIX9Sx4zMNkHrFeitnutGAQTMJxW9TJl9Xc3P3rbm_qCkVI3J_gEqG5q-3X0UqobxtPHei962zde8ElnRyawz1spQALNeqLOawkrAc-OE6MXjTfddoh10SokxQ-b6IGsvZbc3m6KWNQZ4a1Qjcq6S-AiOg3l60fMoE-oMv13HFSMPIdo" alt="rich dark chocolate bubble tea">
                </div>
                <div class="product-body">
                    <div class="product-title-row">
                        <h3>Dark Chocolate</h3>
                        <span class="price">Rs. 380</span>
                    </div>
                    <p class="product-copy">Deep cocoa layers met with fresh Himalayan milk for an intense, velvety chocolate escape.</p>
                    <div class="tag-row">
                        <span class="mini-tag">Bold</span>
                        <span class="mini-tag">Indulgent</span>
                    </div>
                    <div class="card-actions">
                        <button class="primary-action" type="button">Order</button>
                    </div>
                </div>
            </article>

            <article class="product-card">
                <div class="product-media">
                    <img src="https://lh3.googleusercontent.com/aida-public/AB6AXuCsV8N6lfd0nZJ_tE4Kk3Wvf-qo4Qw5eiRl6-t3zusw0K-IHaZGd5WJjtk6-nVxVQl43jhFQSILOzm4BMSO2x-kKoVpgVG3Z2gHN3TGpSW6vFIiZL2D8zWkT0mYWGDAxYyaNKsk3rZSZ5HH3eiFwXTaA7zhhH_3enTRWDhFQ83FiW_yG9FDPrN6F0KdLcDqoLQusQa25hajZ8f3b80lBQr1WHydmT8yT0LDGRD5N0bwXlW0D10GwifLqhh1dp6XRxK-FHziYTr4OusY" alt="creamy white vanilla bubble tea">
                </div>
                <div class="product-body">
                    <div class="product-title-row">
                        <h3>Pure Vanilla</h3>
                        <span class="price">Rs. 320</span>
                    </div>
                    <p class="product-copy">Classic, pure, and elegant. A serene vanilla blend that tastes like snow-capped mountain mornings.</p>
                    <div class="tag-row">
                        <span class="mini-tag">Pure</span>
                        <span class="mini-tag">Smooth</span>
                    </div>
                    <div class="card-actions">
                        <button class="primary-action" type="button">Order</button>

                    </div>
                </div>
            </article>
        </div>
    </section>

    <section class="container product-section">
        <div class="section-heading">
            <h2>Fruit Teas</h2>
        </div>

        <div class="product-grid">
            <article class="product-card">
                <div class="product-media">
                    <img src="https://lh3.googleusercontent.com/aida-public/AB6AXuBjKtMt-cGyRjuS3wBgvv9GGeZQg18oha7X_8eOHFae6vCPJjeh4fB4ROD2lOhGwSkucYk1HDc5wzBhWDNTltTAvFEwxzzcgDS2mjjKISVl-PxnnYJ4AWwgda-04CNuoaKlSKo2IcvmJAS5HM0Pex-vVwp-ndfz3B5N4Ay04jVEn5i6oMVl7BCP-2D9g5IHXFqULub4i1JTnch08XXber5QQW6jsuiS2bDB5nQYyf_V6DgU3QuG3Am0u_X52iO654WXwJvE8peSm2zT" alt="vibrant pink strawberry bubble tea">
                </div>
                <div class="product-body">
                    <div class="product-title-row">
                        <h3>Red Strawberry</h3>
                        <span class="price">Rs. 400</span>
                    </div>
                    <p class="product-copy">Sun-ripened strawberries blended into a refreshing tea for a burst of crimson joy.</p>
                    <div class="tag-row">
                        <span class="mini-tag">Tangy</span>
                        <span class="mini-tag">Sweet</span>
                    </div>
                    <div class="card-actions">
                        <button class="primary-action" type="button">Order</button>
                    </div>
                </div>
            </article>

            <article class="product-card">
                <div class="product-media">
                    <img src="https://lh3.googleusercontent.com/aida-public/AB6AXuC7SeL4pRya8ife9IlLFFFzp9eD8AKIRoGGdxwNkOMaoW--dspOvTfCkvayr-23Ryms2nP8ykipJi6ULdxemCNZyHYjDQZHsF6yYhWzh3FEUpZrsU4rHvlA4Ok_mBKxdhbBqFEm5jYMzZABmDgftj32j8XwXeGwblK6TpzjhnqrSWKg1vsoPLCqNalW7e7dMAjyWljLeLkQxgCbYO8kqlZfYDYQ5q8Tly8HZ1wULU_MRUan53-GItmlutxTet4jSi3vHsidL3GQB_X_" alt="deep purple blueberry bubble tea">
                </div>
                <div class="product-body">
                    <div class="product-title-row">
                        <h3>Blueberry Bliss</h3>
                        <span class="price">Rs. 420</span>
                    </div>
                    <p class="product-copy">A magical purple-blue infusion of forest blueberries and premium jasmine green tea.</p>
                    <div class="tag-row">
                        <span class="mini-tag">Tart</span>
                        <span class="mini-tag">Antioxidant</span>
                    </div>
                    <div class="card-actions">
                        <button class="primary-action" type="button">Order</button>
                    </div>
                </div>
            </article>

            <article class="product-card">
                <div class="product-media">
                    <img src="https://lh3.googleusercontent.com/aida-public/AB6AXuB9P67L4BG5zx620CFzS9qoNhi4iANNoYSMgOnXr_k8TOZaNieM5f2Q-lNaKT4uIZzVia82UUNhrFS5DYycYNQSZ7UHRRVyle90pOkV_OT0cVQWaj1BXjCpU7LygfqhWAO-LLuF7IlpXySpt6nSh9KR6eU-KrboT0MSO7_4lS7d7xZ6BcFS6v6sdijpKt_Pyq1G0tuqkbPqYRgkvd3fznL6m5HatqWkyu0tiGw-HgZFEEqGqjpZ2DKUC-0O8xgGGY3ERFMztGFZUlhj" alt="soft green honeydew bubble tea">
                </div>
                <div class="product-body">
                    <div class="product-title-row">
                        <h3>Honey Dew</h3>
                        <span class="price">Rs. 390</span>
                    </div>
                    <p class="product-copy">Refreshing light green melon essence that cools the soul like a breeze from the valley.</p>
                    <div class="tag-row">
                        <span class="mini-tag">Cooling</span>
                        <span class="mini-tag">Refreshing</span>
                    </div>
                    <div class="card-actions">
                        <button class="primary-action" type="button">Order</button>
                    </div>
                </div>
            </article>
        </div>
    </section>
</main>

<div class="order-modal" id="productDetailModal" aria-hidden="true">
    <div class="order-backdrop" data-close-detail></div>
    <section class="order-sheet" role="dialog" aria-modal="true" aria-labelledby="detailTitle">
        <button class="order-close" type="button" aria-label="Close product details" data-close-detail>
            <span class="material-symbols-outlined">close</span>
        </button>
        <div class="order-builder">
            <div class="order-config">
                <button class="back-button" type="button" data-close-detail>
                    <span class="material-symbols-outlined">arrow_back</span>
                    Back to Menu
                </button>
                <div class="order-product-heading">
                    <img id="detailImage" src="" alt="">
                    <div>
                        <h2 id="detailTitle">Bubble Tea</h2>
                        <p id="detailDescription">Customize your drink before adding it to cart.</p>
                        <div class="order-tags">
                            <span>Freshly Brewed</span>
                            <span>Handcrafted Pearls</span>
                        </div>
                    </div>
                </div>
                <div class="option-group">
                    <h3>Cup Size</h3>
                    <div class="size-grid">
                        <label class="option-card selected">
                            <input type="radio" name="detailCupSize" value="Regular" data-extra="0" checked>
                            <span class="material-symbols-outlined">local_cafe</span>
                            <strong>Regular</strong>
                            <small>500ml</small>
                        </label>
                        <label class="option-card">
                            <input type="radio" name="detailCupSize" value="Large" data-extra="150">
                            <span class="material-symbols-outlined">local_cafe</span>
                            <strong>Large</strong>
                            <small>+ Rs. 150</small>
                        </label>
                    </div>
                </div>
                <div class="option-group">
                    <h3>Ice Level</h3>
                    <div class="pill-options" id="detailIceOptions">
                        <button type="button" data-value="No Ice">No Ice</button>
                        <button type="button" data-value="Less Ice">Less Ice</button>
                        <button class="selected" type="button" data-value="Regular Ice">Regular</button>
                        <button type="button" data-value="Extra Ice">Extra Ice</button>
                    </div>
                </div>
                <div class="option-group">
                    <h3>Sugar Level</h3>
                    <input class="sugar-range" id="detailSugarRange" type="range" min="0" max="100" step="25" value="50">
                    <div class="range-labels">
                        <span>No Sugar</span>
                        <span>Low (25%)</span>
                        <span>Medium (50%)</span>
                        <span>Sweet (75%)</span>
                        <span>Full Sugar</span>
                    </div>
                </div>
                <div class="option-group">
                    <h3>Quantity</h3>
                    <div class="detail-quantity">
                        <button type="button" id="detailQtyMinus">-</button>
                        <input id="detailQuantity" type="text" value="1" readonly>
                        <button type="button" id="detailQtyPlus">+</button>
                    </div>
                </div>
            </div>
            <aside class="order-summary">
                <h2>Product Details</h2>
                <div class="summary-product">
                    <div>
                        <strong id="detailSummaryName">Bubble Tea</strong>
                        <p id="detailSummaryOptions">Regular • Medium (50%) Sugar • Regular Ice</p>
                    </div>
                    <span id="detailSummaryPrice">Rs. 0</span>
                </div>
                <div class="summary-line">
                    <span>Base Price</span>
                    <strong id="detailBasePrice">Rs. 0</strong>
                </div>
                <div class="summary-line">
                    <span>Size Add-on</span>
                    <strong id="detailSizeExtra">Rs. 0</strong>
                </div>
                <div class="summary-total">
                    <span>Item Total</span>
                    <strong id="detailItemTotal">Rs. 0</strong>
                </div>
                <button class="confirm-order" type="button" id="detailAddToCart">Add to Cart</button>
            </aside>
        </div>
    </section>
</div>

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



</body>
</html>
