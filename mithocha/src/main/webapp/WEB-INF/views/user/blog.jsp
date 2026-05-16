<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
                <span class="cart-count">0</span>
            </a>
            <a class="nav-icon" href="${pageContext.request.contextPath}/logout" aria-label="Logout" title="Logout"
               style="color:#ba1a1a;" onclick="return confirm('Log out of MithoCha?')">
                <span class="material-symbols-outlined">logout</span>
            </a>
        </div>
    </div>
</header>

<main>

    <%-- ── Hero ── --%>
    <section class="blog-hero">
        <div class="container">
            <p class="eyebrow">Stories &amp; Sips</p>
            <h1 class="hero-title">The MithoCha Journal</h1>
            <p class="hero-sub">Tea culture, brewing tips, seasonal flavours, and the people behind every cup.</p>
        </div>
    </section>

    <%-- ── Featured Post ── --%>
    <section class="section container">
        <article class="featured-post">
            <div class="featured-image-wrap">
                <img src="https://images.unsplash.com/photo-1556679343-c7306c1976bc?auto=format&fit=crop&w=1200&q=80"
                     alt="Golden Milk Tea being poured" loading="lazy">
                <span class="post-tag">Featured</span>
            </div>
            <div class="featured-body">
                <div class="post-meta">
                    <span class="meta-cat">Tea Culture</span>
                    <span class="meta-dot">·</span>
                    <span class="meta-date">April 28, 2026</span>
                    <span class="meta-dot">·</span>
                    <span class="meta-read">5 min read</span>
                </div>
                <h2 class="post-title">Why Brown Sugar Milk Tea Became Nepal's Favourite Comfort Drink</h2>
                <p class="post-excerpt">
                    From the bustling streets of Thamel to quiet study corners in Lalitpur, the caramelised warmth
                    of brown sugar milk tea has quietly become a daily ritual for thousands of Nepalis. We trace
                    its journey from Taiwanese origins to a distinctly Himalayan identity.
                </p>
                <a class="read-more" href="#post-1">
                    Read Article
                    <span class="material-symbols-outlined">arrow_forward</span>
                </a>
            </div>
        </article>
    </section>

    <%-- ── Category Filter ── --%>
    <section class="container">
        <div class="category-strip">
            <button class="cat-btn active" onclick="filterPosts('all', this)">All</button>
            <button class="cat-btn" onclick="filterPosts('tea-culture', this)">Tea Culture</button>
            <button class="cat-btn" onclick="filterPosts('recipes', this)">Recipes</button>
            <button class="cat-btn" onclick="filterPosts('health', this)">Health &amp; Wellness</button>
            <button class="cat-btn" onclick="filterPosts('behind-the-cup', this)">Behind the Cup</button>
            <button class="cat-btn" onclick="filterPosts('seasonal', this)">Seasonal</button>
        </div>
    </section>

    <%-- ── Post Grid ── --%>
    <section class="section container">
        <div class="posts-grid" id="postsGrid">

            <%-- Post 1 --%>
            <article class="post-card" data-category="tea-culture" id="post-1">
                <div class="post-image-wrap">
                    <img src="https://images.unsplash.com/photo-1515823064-d6e0c04616a7?auto=format&fit=crop&w=800&q=80"
                         alt="Matcha preparation" loading="lazy">
                    <span class="post-tag">Tea Culture</span>
                </div>
                <div class="post-body">
                    <div class="post-meta">
                        <span class="meta-date">April 20, 2026</span>
                        <span class="meta-dot">·</span>
                        <span class="meta-read">4 min read</span>
                    </div>
                    <h3 class="post-title">The Art of Matcha: From Ceremony to Bubble Tea</h3>
                    <p class="post-excerpt">
                        Matcha has travelled centuries from Japanese tea ceremonies to modern bubble tea shops.
                        Here's how we honour that heritage in every MithoCha Matcha Float.
                    </p>
                    <div class="post-footer">
                        <div class="author">
                            <div class="author-avatar" style="background:linear-gradient(135deg,#f0bd8b,#7d562d);">A</div>
                            <span>Aarav Shrestha</span>
                        </div>
                        <a class="read-more-sm" href="#post-1-full">Read more</a>
                    </div>
                </div>
            </article>

            <%-- Post 2 --%>
            <article class="post-card" data-category="recipes">
                <div class="post-image-wrap">
                    <img src="https://images.unsplash.com/photo-1470337458703-46ad1756a187?auto=format&fit=crop&w=800&q=80"
                         alt="Fruit tea ingredients" loading="lazy">
                    <span class="post-tag">Recipes</span>
                </div>
                <div class="post-body">
                    <div class="post-meta">
                        <span class="meta-date">April 14, 2026</span>
                        <span class="meta-dot">·</span>
                        <span class="meta-read">6 min read</span>
                    </div>
                    <h3 class="post-title">How to Make Peach Jasmine Tea at Home</h3>
                    <p class="post-excerpt">
                        Our Peach Jasmine Sparkle is one of the most-ordered drinks on the menu. We're sharing
                        the recipe so you can recreate the magic in your own kitchen.
                    </p>
                    <div class="post-footer">
                        <div class="author">
                            <div class="author-avatar" style="background:linear-gradient(135deg,#ffdcbd,#9a6113);">P</div>
                            <span>Priya Tamang</span>
                        </div>
                        <a class="read-more-sm" href="#recipe-peach">Read more</a>
                    </div>
                </div>
            </article>

            <%-- Post 3 --%>
            <article class="post-card" data-category="health">
                <div class="post-image-wrap">
                    <img src="https://images.unsplash.com/photo-1556679343-c7306c1976bc?auto=format&fit=crop&w=800&q=80"
                         alt="Healthy tea" loading="lazy">
                    <span class="post-tag">Health &amp; Wellness</span>
                </div>
                <div class="post-body">
                    <div class="post-meta">
                        <span class="meta-date">April 8, 2026</span>
                        <span class="meta-dot">·</span>
                        <span class="meta-read">3 min read</span>
                    </div>
                    <h3 class="post-title">5 Reasons Bubble Tea Can Be Part of a Balanced Diet</h3>
                    <p class="post-excerpt">
                        Bubble tea gets a bad reputation for sugar content — but with the right choices,
                        it can fit comfortably into a healthy lifestyle. Here's what the science says.
                    </p>
                    <div class="post-footer">
                        <div class="author">
                            <div class="author-avatar" style="background:linear-gradient(135deg,#ffe9e4,#7b5647);">R</div>
                            <span>Rohan Gurung</span>
                        </div>
                        <a class="read-more-sm" href="#health-bubble">Read more</a>
                    </div>
                </div>
            </article>

            <%-- Post 4 --%>
            <article class="post-card" data-category="behind-the-cup">
                <div class="post-image-wrap">
                    <img src="https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=800&q=80"
                         alt="MithoCha team" loading="lazy">
                    <span class="post-tag">Behind the Cup</span>
                </div>
                <div class="post-body">
                    <div class="post-meta">
                        <span class="meta-date">March 30, 2026</span>
                        <span class="meta-dot">·</span>
                        <span class="meta-read">7 min read</span>
                    </div>
                    <h3 class="post-title">Meet the Farmers Behind Our Ilam Tea Leaves</h3>
                    <p class="post-excerpt">
                        Every cup of MithoCha starts in the misty hills of Ilam. We visited the farms that
                        supply our premium tea leaves and spoke to the families who grow them.
                    </p>
                    <div class="post-footer">
                        <div class="author">
                            <div class="author-avatar" style="background:linear-gradient(135deg,#f0bd8b,#7d562d);">A</div>
                            <span>Aarav Shrestha</span>
                        </div>
                        <a class="read-more-sm" href="#ilam-farmers">Read more</a>
                    </div>
                </div>
            </article>

            <%-- Post 5 --%>
            <article class="post-card" data-category="seasonal">
                <div class="post-image-wrap">
                    <img src="https://images.unsplash.com/photo-1470337458703-46ad1756a187?auto=format&fit=crop&w=800&q=80"
                         alt="Seasonal drinks" loading="lazy">
                    <span class="post-tag">Seasonal</span>
                </div>
                <div class="post-body">
                    <div class="post-meta">
                        <span class="meta-date">March 22, 2026</span>
                        <span class="meta-dot">·</span>
                        <span class="meta-read">2 min read</span>
                    </div>
                    <h3 class="post-title">Introducing Our Summer 2026 Seasonal Menu</h3>
                    <p class="post-excerpt">
                        Mango Lassi Boba, Lychee Rose Sparkle, and Himalayan Mint Cooler — our summer
                        specials are here for a limited time. Here's what inspired each one.
                    </p>
                    <div class="post-footer">
                        <div class="author">
                            <div class="author-avatar" style="background:linear-gradient(135deg,#ffdcbd,#9a6113);">P</div>
                            <span>Priya Tamang</span>
                        </div>
                        <a class="read-more-sm" href="#summer-menu">Read more</a>
                    </div>
                </div>
            </article>

            <%-- Post 6 --%>
            <article class="post-card" data-category="recipes">
                <div class="post-image-wrap">
                    <img src="https://images.unsplash.com/photo-1515823064-d6e0c04616a7?auto=format&fit=crop&w=800&q=80"
                         alt="Tapioca pearls" loading="lazy">
                    <span class="post-tag">Recipes</span>
                </div>
                <div class="post-body">
                    <div class="post-meta">
                        <span class="meta-date">March 15, 2026</span>
                        <span class="meta-dot">·</span>
                        <span class="meta-read">5 min read</span>
                    </div>
                    <h3 class="post-title">The Perfect Tapioca Pearl: Chewy, Not Gummy</h3>
                    <p class="post-excerpt">
                        Getting the boba texture right is harder than it looks. Our head brewer shares
                        the exact timing, temperature, and resting technique we use every morning.
                    </p>
                    <div class="post-footer">
                        <div class="author">
                            <div class="author-avatar" style="background:linear-gradient(135deg,#ffe9e4,#7b5647);">R</div>
                            <span>Rohan Gurung</span>
                        </div>
                        <a class="read-more-sm" href="#tapioca-guide">Read more</a>
                    </div>
                </div>
            </article>

        </div><%-- /posts-grid --%>

        <%-- Empty state (shown by JS when filter has no results) --%>
        <div id="noPostsMsg" style="display:none;text-align:center;padding:60px 20px;color:#504440;">
            <span class="material-symbols-outlined" style="font-size:48px;opacity:.3;display:block;margin-bottom:12px;">article</span>
            <p style="font-size:16px;font-weight:500;">No posts in this category yet. Check back soon!</p>
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
