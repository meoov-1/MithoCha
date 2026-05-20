<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us — MithoCha</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:ital,wght@0,400;0,600;0,700;1,400&family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@400" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user/contact.css">
</head>
<body>

<header class="navbar">
    <div class="container nav-container">
        <a class="logo" href="${pageContext.request.contextPath}/dashboard">MithoCha</a>
        <nav class="nav-links" aria-label="Primary">
            <a href="${pageContext.request.contextPath}/dashboard">Home</a>
            <a href="${pageContext.request.contextPath}/products">Menu</a>
            <a href="${pageContext.request.contextPath}/blog">Blog</a>
            <a class="active" href="${pageContext.request.contextPath}/contact">Contact</a>
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

    <!-- ── Page Hero ── -->
    <section class="page-hero container">
        <p class="eyebrow">Get in Touch</p>
        <h1 class="page-title">We'd Love to Hear From You</h1>
        <p class="page-copy">Have a question, feedback, or just want to say hello? Drop us a message and we'll get back to you within 24 hours.</p>
    </section>

    <!-- ── Contact Layout ── -->
    <section class="contact-layout container">

        <!-- Contact Info -->
        <aside class="contact-info">
            <div class="info-card">
                <h2 class="info-title">Contact Information</h2>
                <p class="info-sub">Reach us through any of these channels.</p>

                <ul class="info-list">
                    <li class="info-item">
                        <div class="info-icon">
                            <span class="material-symbols-outlined">location_on</span>
                        </div>
                        <div>
                            <strong>Visit Us</strong>
                            <p>Informatics College Pokhara, Bagar, Pokhara-8, Kaski, Nepal</p>
                        </div>
                    </li>
                    <li class="info-item">
                        <div class="info-icon">
                            <span class="material-symbols-outlined">phone</span>
                        </div>
                        <div>
                            <strong>Call Us</strong>
                            <p>9000000000</p>
                        </div>
                    </li>
                    <li class="info-item">
                        <div class="info-icon">
                            <span class="material-symbols-outlined">mail</span>
                        </div>
                        <div>
                            <strong>Email Us</strong>
                            <p>mithocha@gmail.com</p>
                        </div>
                    </li>
                    <li class="info-item">
                        <div class="info-icon">
                            <span class="material-symbols-outlined">schedule</span>
                        </div>
                        <div>
                            <strong>Opening Hours</strong>
                            <p>Sun – Fri: 9:00 AM – 9:00 PM</p>
                            <p>Saturday: 10:00 AM – 8:00 PM</p>
                        </div>
                    </li>
                </ul>

                <div class="social-row">
                    <a class="social-btn" href="#" aria-label="Facebook">
                        <span class="material-symbols-outlined">public</span>
                    </a>
                    <a class="social-btn" href="#" aria-label="Instagram">
                        <span class="material-symbols-outlined">photo_camera</span>
                    </a>
                    <a class="social-btn" href="#" aria-label="Twitter">
                        <span class="material-symbols-outlined">tag</span>
                    </a>
                </div>
            </div>
        </aside>

        <!-- Contact Form -->
        <section class="contact-form-card">
            <h2 class="form-title">Send Us a Message</h2>
            <p class="form-sub">Fill in the form below and we'll respond as soon as possible.</p>

            <%-- Success / error flash from ContactServlet --%>
            <% if ("true".equals(request.getParameter("sent"))) { %>
                <div class="msg-banner success">
                    <span class="material-symbols-outlined">check_circle</span>
                    Your message has been sent! We'll be in touch soon.
                </div>
            <% } %>
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="msg-banner error">
                    <span class="material-symbols-outlined">error</span>
                    ${errorMessage}
                </div>
            <% } %>

            <form class="contact-form" method="post" action="${pageContext.request.contextPath}/contact">
                <div class="form-row">
                    <div class="field-group">
                        <label class="field-label" for="contactName">Full Name</label>
                        <input class="field-input" id="contactName" name="name" type="text"
                               placeholder="Your full name" required>
                    </div>
                    <div class="field-group">
                        <label class="field-label" for="contactEmail">Email Address</label>
                        <input class="field-input" id="contactEmail" name="email" type="email"
                               placeholder="name@example.com" required>
                    </div>
                </div>

                <div class="field-group">
                    <label class="field-label" for="contactSubject">Subject</label>
                    <select class="field-input" id="contactSubject" name="subject">
                        <option value="" disabled selected>Select a topic</option>
                        <option value="Order Issue">Order Issue</option>
                        <option value="Product Feedback">Product Feedback</option>
                        <option value="Partnership">Partnership</option>
                        <option value="General Enquiry">General Enquiry</option>
                        <option value="Other">Other</option>
                    </select>
                </div>

                <div class="field-group">
                    <label class="field-label" for="contactMessage">Message</label>
                    <textarea class="field-input" id="contactMessage" name="message"
                              rows="6" placeholder="Tell us how we can help..." required></textarea>
                </div>

                <button class="submit-btn" type="submit">
                    Send Message
                    <span class="material-symbols-outlined">send</span>
                </button>
            </form>
        </section>

    </section>

    <!-- ── Map — Informatics College Pokhara ── -->
    <section class="map-section container">
        <div class="map-label">
            <span class="material-symbols-outlined">location_on</span>
            <div>
                <strong>Informatics College Pokhara</strong>
                <span>Pokhara, Kaski, Nepal</span>
            </div>
        </div>
        <div class="map-frame">
            <iframe
                title="Informatics College Pokhara Matepani location"
                src="https://maps.google.com/maps?q=Informatics+College+Pokhara+Matepani&t=m&z=16&output=embed&iwloc=near"
                width="100%"
                height="420"
                style="border:0;border-radius:20px;display:block;"
                allowfullscreen=""
                loading="lazy"
                referrerpolicy="no-referrer-when-downgrade">
            </iframe>
        </div>
    </section>

    <!-- ── FAQ ── -->
    <section class="section container">
        <div class="section-heading centered">
            <p class="eyebrow-dark">Quick Answers</p>
            <h2 class="section-title">Frequently Asked Questions</h2>
        </div>
        <div class="faq-grid">
            <details class="faq-item">
                <summary>How long does delivery take?</summary>
                <p>Orders within Kathmandu Valley are typically delivered within 30–45 minutes. You'll receive a confirmation once your order is on its way.</p>
            </details>
            <details class="faq-item">
                <summary>Can I customise my drink?</summary>
                <p>Absolutely! You can choose your cup size, ice level, sugar level, flavour, and toppings when placing your order.</p>
            </details>
            <details class="faq-item">
                <summary>Do you offer bulk or corporate orders?</summary>
                <p>Yes! Contact us at mithocha@gmail.com for bulk orders, events, or corporate packages.</p>
            </details>
            <details class="faq-item">
                <summary>What payment methods do you accept?</summary>
                <p>We accept Fonepay, Khalti, eSewa, and Cash on Delivery for all orders.</p>
            </details>
        </div>
    </section>

</main>

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

<script src="${pageContext.request.contextPath}/js/logout-popup.js"></script>
</body>
</html>
