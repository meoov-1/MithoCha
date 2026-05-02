<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    <link rel="stylesheet" href="css/user/profile.css">
    <link rel="stylesheet" href="../../../css/user/profile.css">
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
        </a>
    </div>
</header>

<main class="content-shell">
    <div class="content-wrap">
        <section class="page-hero">
            <p class="page-tag">Profile</p>
            <h1 class="page-title">My Profile</h1>
            <p class="page-copy">Keep your contact details, delivery preferences, and MithoCha profile photo ready for faster ordering.</p>
        </section>

        <section class="profile-layout">
            <aside class="page-card profile-photo-card">
                <div class="avatar-preview" aria-label="Profile photo preview">
                    <img id="profileImagePreview" alt="Selected profile preview">
                    <span class="material-symbols-outlined">person</span>
                </div>
                <div>
                    <h2 class="placeholder-title">Profile Photo</h2>
                    <p class="placeholder-copy">Choose a clear image for your account. JPG, PNG, or WEBP works best.</p>
                </div>
                <label class="upload-button" for="profileImage">
                    <span class="material-symbols-outlined">add_photo_alternate</span>
                    Add Image
                </label>
                <input class="file-input" id="profileImage" name="profileImage" type="file" accept="image/*">
            </aside>

            <section class="page-card profile-form-card">
                <div class="section-heading">
                    <h2 class="placeholder-title">Personal Details</h2>
                    <p class="placeholder-copy">Fill in the information needed for your MithoCha customer profile.</p>
                </div>

                <form class="profile-form" action="#" method="post" enctype="multipart/form-data">
                    <div class="form-grid">
                        <label class="placeholder-field">
                            <span>Full Name</span>
                            <input type="text" name="fullName" placeholder="Enter your full name">
                        </label>

                        <label class="placeholder-field">
                            <span>Email Address</span>
                            <input type="email" name="email" placeholder="name@example.com">
                        </label>

                        <label class="placeholder-field">
                            <span>Phone Number</span>
                            <input type="tel" name="phone" placeholder="+977 98XXXXXXXX">
                        </label>

                        <label class="placeholder-field">
                            <span>Date of Birth</span>
                            <input type="date" name="dateOfBirth">
                        </label>

                        <label class="placeholder-field">
                            <span>Gender</span>
                            <select name="gender">
                                <option value="">Select gender</option>
                                <option value="female">Female</option>
                                <option value="male">Male</option>
                                <option value="other">Other</option>
                                <option value="prefer-not-to-say">Prefer not to say</option>
                            </select>
                        </label>

                        <label class="placeholder-field">
                            <span>Favorite Drink</span>
                            <input type="text" name="favoriteDrink" placeholder="Milk tea, matcha, fruit tea">
                        </label>

                        <label class="placeholder-field full-span">
                            <span>Delivery Address</span>
                            <textarea name="address" rows="3" placeholder="Street, city, landmark"></textarea>
                        </label>

                        <label class="placeholder-field full-span">
                            <span>Profile Notes</span>
                            <textarea name="profileNotes" rows="3" placeholder="Allergies, sweetness preference, or delivery instructions"></textarea>
                        </label>
                    </div>

                    <div class="placeholder-actions">
                        <button class="primary-button" type="button">Save Profile</button>
                        <button class="ghost-button" type="reset">Clear</button>
                    </div>
                </form>
            </section>
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


</body>
</html>


