-- =========================================
-- TABLE: order_items
-- =========================================
-- This table stores the products included
-- in each order.
--
-- It represents a many-to-many relationship
-- between orders and products.
--
-- Concepts Used:
-- 1. PRIMARY KEY
--    - Unique identifier for each order item.
--
-- 2. FOREIGN KEY
--    - Connects order_items to orders and products.
--
-- 3. CHECK CONSTRAINT
--    - Ensures quantity is greater than zero.
--
-- 4. NUMERIC(10,2)
--    - Stores product price with decimal values.
--
-- 5. ON DELETE CASCADE
--    - Automatically deletes related records
--      when an order or product is removed.
-- =========================================

CREATE TABLE order_items (

    -- Unique ID for each order item
    id SERIAL PRIMARY KEY,

    -- Related order ID
    -- Required field
    order_id INTEGER NOT NULL,

    -- Related product ID
    -- Required field
    product_id INTEGER NOT NULL,

    -- Quantity of the product in the order
    -- Must be greater than 0
    quantity INTEGER NOT NULL
        CHECK (quantity > 0),

    -- Product price at the time of purchase
    -- Stored separately because product price
    -- may change later
    price NUMERIC(10,2) NOT NULL,

    -- Foreign key constraint
    -- Links order_items to orders table
    CONSTRAINT fk_item_order
        FOREIGN KEY (order_id)
        REFERENCES orders(id)
        ON DELETE CASCADE,

    -- Foreign key constraint
    -- Links order_items to products table
    CONSTRAINT fk_item_product
        FOREIGN KEY (product_id)
        REFERENCES products(id)
        ON DELETE CASCADE
);