-- =========================================
-- MULTIPLE JOINS (Complex Query)
-- =========================================
-- Definition:
-- Multiple JOINs combine more than two tables
-- in a single query.
--
-- Meaning:
-- It allows you to fetch data from several related tables
-- in one result set.
--
-- When to Use:
-- Use multiple joins when data is spread across
-- multiple related tables.
--
-- Example:
-- Show user orders with product details.
--
-- Relationships:
-- users (1) ---- (M) orders
-- orders (M) ---- (M) products (via order_items)
-- products (M) ---- (1) categories
--
-- Important:
-- Each JOIN must connect correct foreign keys.
-- =========================================

SELECT 
    -- User name
    u.name AS user_name,

    -- Order ID
    o.id AS order_id,

    -- Product name
    p.name AS product_name,

    -- Category name
    c.name AS category_name,

    -- Quantity in order
    oi.quantity,

    -- Price at purchase time
    oi.price

FROM users u

-- Link users to orders
INNER JOIN orders o
    ON u.id = o.user_id

-- Link orders to order_items
INNER JOIN order_items oi
    ON o.id = oi.order_id

-- Link order_items to products
INNER JOIN products p
    ON oi.product_id = p.id

-- Link products to categories
INNER JOIN categories c
    ON p.category_id = c.id;