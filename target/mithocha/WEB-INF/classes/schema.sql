-- ============================================================
-- MithoCha — Full Database Schema
-- MySQL 8.x compatible
--
-- Run this script once to set up the complete database.
-- Tables are created in dependency order (no FK violations).
-- ============================================================

-- Create and select the database
CREATE DATABASE IF NOT EXISTS mithocha
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE mithocha;

-- ============================================================
-- 1. users
--    Core user accounts for both customers and admins.
-- ============================================================
CREATE TABLE IF NOT EXISTS users (
    user_id    INT          AUTO_INCREMENT PRIMARY KEY,
    name       VARCHAR(100) NOT NULL,
    email      VARCHAR(100) NOT NULL UNIQUE,
    password   VARCHAR(255) NOT NULL,                        -- BCrypt hash (or PLAIN:<value> for seed)
    role       VARCHAR(20)  NOT NULL DEFAULT 'customer',     -- 'customer' | 'admin'
    created_at TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- 2. profile
--    One-to-one extension of users with personal/contact info.
-- ============================================================
CREATE TABLE IF NOT EXISTS profile (
    profile_id                INT          AUTO_INCREMENT PRIMARY KEY,
    user_id                   INT          NOT NULL UNIQUE,
    phone                     VARCHAR(20),
    address                   TEXT,
    city                      VARCHAR(100),
    postal_code               VARCHAR(20),
    profile_image_url         VARCHAR(500),
    profile_image_data        LONGBLOB,                      -- binary upload (optional)
    profile_image_content_type VARCHAR(100),                 -- MIME type of uploaded image
    cover_image_url           VARCHAR(500),
    bio                       TEXT,
    date_of_birth             DATE,

    CONSTRAINT fk_profile_user
        FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- ============================================================
-- 3. products
--    Product catalogue. JSON columns store denormalised
--    snapshots; normalised rows live in product_sizes /
--    product_toppings.
-- ============================================================
CREATE TABLE IF NOT EXISTS products (
    product_id        INT           AUTO_INCREMENT PRIMARY KEY,
    name              VARCHAR(100)  NOT NULL,
    description       TEXT,
    image_url         VARCHAR(500),
    image_data        LONGBLOB,                              -- binary upload (optional)
    image_content_type VARCHAR(100),                        -- MIME type of uploaded image
    additional_images LONGTEXT,                             -- JSON array of extra image URLs
    category          VARCHAR(100),
    is_available      BOOLEAN       NOT NULL DEFAULT TRUE,
    sizes             LONGTEXT,                             -- JSON snapshot of size options
    flavours          LONGTEXT,                             -- JSON snapshot of flavour options
    toppings          LONGTEXT,                             -- JSON snapshot of topping options
    base_price        DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    created_at        TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
    updated_at        TIMESTAMP     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ============================================================
-- 4. product_sizes
--    Normalised size options for a product (Small / Medium / Large …).
-- ============================================================
CREATE TABLE IF NOT EXISTS product_sizes (
    size_id        INT           AUTO_INCREMENT PRIMARY KEY,
    product_id     INT           NOT NULL,
    name           VARCHAR(50)   NOT NULL,                  -- e.g. 'Small', 'Medium', 'Large'
    price_modifier DECIMAL(10,2) NOT NULL DEFAULT 0.00,     -- extra cost on top of base_price
    display_order  INT           NOT NULL DEFAULT 0,        -- UI sort order

    CONSTRAINT fk_product_sizes_product
        FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

-- ============================================================
-- 5. product_toppings
--    Normalised topping options for a product (Boba / Jelly …).
-- ============================================================
CREATE TABLE IF NOT EXISTS product_toppings (
    topping_id     INT           AUTO_INCREMENT PRIMARY KEY,
    product_id     INT           NOT NULL,
    name           VARCHAR(50)   NOT NULL,                  -- e.g. 'Boba', 'Jelly', 'Pudding'
    price_modifier DECIMAL(10,2) NOT NULL DEFAULT 0.00,     -- extra cost on top of base_price
    is_available   BOOLEAN       NOT NULL DEFAULT TRUE,

    CONSTRAINT fk_product_toppings_product
        FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

-- ============================================================
-- 6. cart_items
--    Server-side shopping cart (one row per product/size/topping
--    combination per user).
-- ============================================================
CREATE TABLE IF NOT EXISTS cart_items (
    cart_item_id             INT           AUTO_INCREMENT PRIMARY KEY,
    user_id                  INT           NOT NULL,
    product_id               INT           NOT NULL,
    product_size_id          INT           NULL,            -- NULL = no size selected
    selected_topping_ids_json TEXT,                         -- JSON array of topping IDs
    selected_toppings_json   LONGTEXT,                      -- JSON array of topping objects (snapshot)
    quantity                 INT           NOT NULL,
    unit_price               DECIMAL(10,2) NOT NULL,        -- price at time of adding to cart
    item_total               DECIMAL(10,2) NOT NULL,        -- quantity × unit_price
    created_at               TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
    updated_at               TIMESTAMP     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_cart_items_user
        FOREIGN KEY (user_id)         REFERENCES users(user_id)              ON DELETE CASCADE,
    CONSTRAINT fk_cart_items_product
        FOREIGN KEY (product_id)      REFERENCES products(product_id)        ON DELETE CASCADE,
    CONSTRAINT fk_cart_items_size
        FOREIGN KEY (product_size_id) REFERENCES product_sizes(size_id)      ON DELETE SET NULL
);

-- ============================================================
-- 7. orders
--    Customer order headers. JSON columns store denormalised
--    snapshots for historical accuracy.
-- ============================================================
CREATE TABLE IF NOT EXISTS orders (
    order_id         INT           AUTO_INCREMENT PRIMARY KEY,
    user_id          INT           NULL,                    -- NULL if user was deleted
    total_amount     DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    order_date       TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    status           VARCHAR(20)   NOT NULL DEFAULT 'pending', -- 'pending' | 'completed' | 'cancelled'
    items            LONGTEXT,                              -- JSON snapshot of ordered items
    payment          LONGTEXT,                              -- JSON snapshot of payment info
    shipping_address LONGTEXT,                              -- JSON object with delivery address

    CONSTRAINT fk_orders_user
        FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL
);

-- ============================================================
-- 8. order_items
--    Normalised line items for each order. Snapshots of name /
--    size are stored so historical records survive catalogue edits.
-- ============================================================
CREATE TABLE IF NOT EXISTS order_items (
    order_item_id             INT           AUTO_INCREMENT PRIMARY KEY,
    order_id                  INT           NOT NULL,
    product_id                INT           NULL,           -- NULL if product was deleted
    product_name              VARCHAR(100)  NOT NULL,       -- snapshot at time of order
    product_size_id           INT           NULL,           -- NULL if size was deleted
    size_name                 VARCHAR(50),                  -- snapshot at time of order
    selected_topping_ids_json TEXT,                         -- JSON array of topping IDs
    selected_toppings_json    LONGTEXT,                     -- JSON array of topping objects (snapshot)
    quantity                  INT           NOT NULL,
    unit_price                DECIMAL(10,2) NOT NULL,       -- price at time of order
    item_total                DECIMAL(10,2) NOT NULL,       -- quantity × unit_price

    CONSTRAINT fk_order_items_order
        FOREIGN KEY (order_id)          REFERENCES orders(order_id)          ON DELETE CASCADE,
    CONSTRAINT fk_order_items_product
        FOREIGN KEY (product_id)        REFERENCES products(product_id)      ON DELETE SET NULL,
    CONSTRAINT fk_order_items_size
        FOREIGN KEY (product_size_id)   REFERENCES product_sizes(size_id)    ON DELETE SET NULL
);

-- ============================================================
-- 9. payments
--    Payment records linked to orders.
-- ============================================================
CREATE TABLE IF NOT EXISTS payments (
    payment_id     INT           AUTO_INCREMENT PRIMARY KEY,
    order_id       INT           NOT NULL,
    transaction_id VARCHAR(120)  NOT NULL UNIQUE,           -- payment gateway reference
    status         VARCHAR(20)   NOT NULL,                  -- 'pending' | 'completed' | 'failed'
    amount         DECIMAL(10,2) NOT NULL,
    method         VARCHAR(50)   NOT NULL,                  -- e.g. 'credit_card', 'gcash', 'cod'
    created_at     TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_payments_order
        FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);

-- ============================================================
-- 10. reviews
--     Product reviews submitted by customers.
-- ============================================================
CREATE TABLE IF NOT EXISTS reviews (
    review_id  INT          AUTO_INCREMENT PRIMARY KEY,
    user_id    INT          NOT NULL,
    product_id INT          NOT NULL,
    rating     INT          NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment    TEXT,
    image_url  VARCHAR(500),
    created_at TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_reviews_user
        FOREIGN KEY (user_id)    REFERENCES users(user_id)       ON DELETE CASCADE,
    CONSTRAINT fk_reviews_product
        FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

-- ============================================================
-- Seed Data
-- ============================================================

-- Default admin account.
-- Password is stored as PLAIN:admin — the app hashes it on first login.
-- UserService.ensureAdminExists() also creates this row automatically,
-- so this INSERT is only needed if you want it pre-seeded.
INSERT INTO users (name, email, password, role)
VALUES ('Admin', 'admin@gmail.com', 'PLAIN:admin', 'admin')
ON DUPLICATE KEY UPDATE role = 'admin';
