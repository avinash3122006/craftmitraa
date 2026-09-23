CREATE TABLE IF NOT EXISTS users (
    id VARCHAR PRIMARY KEY,
    name VARCHAR NOT NULL,
    email VARCHAR UNIQUE NOT NULL,
    password_hash VARCHAR NOT NULL,
    role VARCHAR NOT NULL
);

CREATE TABLE IF NOT EXISTS artisans (
    id VARCHAR PRIMARY KEY,
    user_id VARCHAR NOT NULL,
    business_name VARCHAR,
    craft_type VARCHAR,
    location VARCHAR
);

CREATE TABLE IF NOT EXISTS products (
    id VARCHAR PRIMARY KEY,
    artisan_id VARCHAR NOT NULL,
    name VARCHAR NOT NULL,
    category VARCHAR NOT NULL,
    material VARCHAR,
    price NUMERIC NOT NULL,
    description TEXT
);

CREATE TABLE IF NOT EXISTS product_images (
    id VARCHAR PRIMARY KEY,
    product_id VARCHAR NOT NULL,
    image_url VARCHAR NOT NULL,
    public_id VARCHAR
);

CREATE TABLE IF NOT EXISTS artisan_stories (
    id VARCHAR PRIMARY KEY,
    artisan_id VARCHAR NOT NULL,
    title VARCHAR NOT NULL,
    story TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS orders (
    id VARCHAR PRIMARY KEY,
    user_id VARCHAR NOT NULL,
    total NUMERIC NOT NULL,
    status VARCHAR NOT NULL DEFAULT 'PENDING'
);

CREATE TABLE IF NOT EXISTS order_items (
    id VARCHAR PRIMARY KEY,
    order_id VARCHAR NOT NULL,
    product_id VARCHAR NOT NULL,
    quantity VARCHAR NOT NULL,
    price NUMERIC NOT NULL
);

CREATE TABLE IF NOT EXISTS payments (
    id VARCHAR PRIMARY KEY,
    order_id VARCHAR NOT NULL,
    payment_id VARCHAR,
    status VARCHAR NOT NULL DEFAULT 'PENDING',
    amount NUMERIC NOT NULL
);

CREATE TABLE IF NOT EXISTS reviews (
    id VARCHAR PRIMARY KEY,
    product_id VARCHAR NOT NULL,
    user_id VARCHAR NOT NULL,
    rating NUMERIC NOT NULL,
    comment TEXT
);
