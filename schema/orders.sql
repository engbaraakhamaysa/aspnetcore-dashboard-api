-- =========================================
-- TABLE: orders
-- =========================================
-- This table stores customer orders
-- in the e-commerce system.
--
-- Concepts Used:
-- 1. PRIMARY KEY
--    - Unique identifier for each order.
--
-- 2. FOREIGN KEY
--    - Connects orders to users.
--
-- 3. DEFAULT
--    - Automatically assigns default values.
--
-- 4. NUMERIC(10,2)
--    - Stores monetary values with decimals.
--
-- 5. ON DELETE CASCADE
--    - Deletes user orders automatically
--      when the related user is deleted.
-- =========================================

CREATE TABLE orders (

    -- Unique ID for each order
    id SERIAL PRIMARY KEY,

    -- User who created the order
    -- Required field
    user_id INTEGER NOT NULL,

    -- Current order status
    -- Default value is 'pending'
    -- Example values:
    -- pending, shipped, delivered, cancelled
    status VARCHAR(30) DEFAULT 'pending',

    -- Total price of the order
    -- Stores decimal values
    -- Default value is 0
    total_price NUMERIC(10,2) DEFAULT 0,

    -- Date and time when the order was created
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Foreign key constraint
    -- Links orders to users table
    CONSTRAINT fk_order_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE
);