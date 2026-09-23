# Database Design

The database is designed around users, artisans, products, orders, payments, shipping, and AI-generated metadata.

## Core tables

- users
- artisans
- products
- product_images
- artisan_stories
- orders
- order_items
- payments
- shipping
- reviews

## Notes

- Product images are stored as metadata in the database with Cloudinary URLs.
- Payment and shipping state transitions are tracked through service logic.
