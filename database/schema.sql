-- CraftMitra AI Complete Relational Database Schema (PostgreSQL)

CREATE TABLE IF NOT EXISTS users (
    id VARCHAR PRIMARY KEY,
    name VARCHAR NOT NULL,
    email VARCHAR UNIQUE NOT NULL,
    phone VARCHAR,
    password_hash VARCHAR NOT NULL,
    role VARCHAR NOT NULL DEFAULT 'customer',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);

CREATE TABLE IF NOT EXISTS artisans (
    id VARCHAR PRIMARY KEY,
    user_id VARCHAR UNIQUE NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    business_name VARCHAR,
    craft_type VARCHAR NOT NULL,
    village VARCHAR,
    state VARCHAR,
    location VARCHAR,
    bio TEXT,
    years_of_experience INTEGER DEFAULT 10,
    rating DOUBLE PRECISION DEFAULT 5.0,
    review_count INTEGER DEFAULT 0,
    is_verified BOOLEAN DEFAULT TRUE,
    avatar_url VARCHAR,
    cover_image_url VARCHAR,
    awards VARCHAR,
    bank_account_verified BOOLEAN DEFAULT TRUE,
    upi_id VARCHAR,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_artisans_user_id ON artisans(user_id);
CREATE INDEX IF NOT EXISTS idx_artisans_craft_type ON artisans(craft_type);

CREATE TABLE IF NOT EXISTS products (
    id VARCHAR PRIMARY KEY,
    artisan_id VARCHAR NOT NULL REFERENCES artisans(id) ON DELETE CASCADE,
    name VARCHAR NOT NULL,
    category VARCHAR NOT NULL,
    material VARCHAR,
    price DOUBLE PRECISION NOT NULL,
    original_price DOUBLE PRECISION,
    description TEXT,
    cultural_story TEXT,
    dimensions VARCHAR,
    weight VARCHAR,
    time_to_create_hours INTEGER DEFAULT 12,
    is_verified_craft BOOLEAN DEFAULT TRUE,
    is_sustainable BOOLEAN DEFAULT TRUE,
    stock_quantity INTEGER DEFAULT 5,
    fair_price_min DOUBLE PRECISION,
    fair_price_max DOUBLE PRECISION,
    artisan_share_percent DOUBLE PRECISION DEFAULT 85.0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_products_category ON products(category);
CREATE INDEX IF NOT EXISTS idx_products_artisan_id ON products(artisan_id);
CREATE INDEX IF NOT EXISTS idx_products_name ON products(name);

CREATE TABLE IF NOT EXISTS product_images (
    id VARCHAR PRIMARY KEY,
    product_id VARCHAR NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    image_url VARCHAR NOT NULL,
    public_id VARCHAR,
    is_primary BOOLEAN DEFAULT FALSE
);

CREATE INDEX IF NOT EXISTS idx_product_images_product_id ON product_images(product_id);

CREATE TABLE IF NOT EXISTS artisan_stories (
    id VARCHAR PRIMARY KEY,
    artisan_id VARCHAR NOT NULL REFERENCES artisans(id) ON DELETE CASCADE,
    title VARCHAR NOT NULL,
    story TEXT NOT NULL,
    audio_url VARCHAR,
    audio_duration_seconds INTEGER DEFAULT 120,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_artisan_stories_artisan_id ON artisan_stories(artisan_id);

CREATE TABLE IF NOT EXISTS orders (
    id VARCHAR PRIMARY KEY,
    user_id VARCHAR NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    total_amount DOUBLE PRECISION NOT NULL,
    artisan_contribution DOUBLE PRECISION NOT NULL DEFAULT 0.0,
    status VARCHAR NOT NULL DEFAULT 'PLACED',
    delivery_address TEXT NOT NULL,
    payment_method VARCHAR NOT NULL DEFAULT 'UPI',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_orders_user_id ON orders(user_id);
CREATE INDEX IF NOT EXISTS idx_orders_status ON orders(status);

CREATE TABLE IF NOT EXISTS order_items (
    id VARCHAR PRIMARY KEY,
    order_id VARCHAR NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id VARCHAR NOT NULL REFERENCES products(id) ON DELETE RESTRICT,
    quantity INTEGER NOT NULL DEFAULT 1,
    unit_price DOUBLE PRECISION NOT NULL,
    artisan_share DOUBLE PRECISION NOT NULL DEFAULT 0.0
);

CREATE INDEX IF NOT EXISTS idx_order_items_order_id ON order_items(order_id);

CREATE TABLE IF NOT EXISTS payments (
    id VARCHAR PRIMARY KEY,
    order_id VARCHAR NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    payment_id VARCHAR,
    transaction_id VARCHAR,
    status VARCHAR NOT NULL DEFAULT 'COMPLETED',
    amount DOUBLE PRECISION NOT NULL,
    payment_method VARCHAR NOT NULL DEFAULT 'UPI',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_payments_order_id ON payments(order_id);

CREATE TABLE IF NOT EXISTS reviews (
    id VARCHAR PRIMARY KEY,
    product_id VARCHAR NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    user_id VARCHAR NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    rating DOUBLE PRECISION NOT NULL DEFAULT 5.0,
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_reviews_product_id ON reviews(product_id);
