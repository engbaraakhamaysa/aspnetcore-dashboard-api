-- =========================================
-- TABLE: products
-- =========================================
-- This table stores product information
-- for the e-commerce system.
--
-- Concepts Used:
-- 1. PRIMARY KEY
--    - Unique identifier for each product.
--
-- 2. NOT NULL
--    - Required fields that cannot be empty.
--
-- 3. NUMERIC(10,2)
--    - Stores decimal values for prices.
--    - Example: 99999999.99
--
-- 4. DEFAULT
--    - Assigns automatic default values.
--
-- 5. FOREIGN KEY
--    - Connects products to categories.
--
-- 6. ON DELETE CASCADE
--    - Deletes related products automatically
--      when a category is removed.
-- =========================================

CREATE TABLE products (

    -- Unique ID for each product
    id SERIAL PRIMARY KEY,

    -- Product name
    -- Maximum length: 150 characters
    -- Required field
    name VARCHAR(150) NOT NULL,

    -- Product description
    -- Optional field
    description TEXT,

    -- Product price
    -- Stores numbers with 2 decimal places
    -- Required field
    price NUMERIC(10,2) NOT NULL,

    -- Available quantity in stock
    -- Default value is 0
    stock INTEGER DEFAULT 0,

    -- Category reference
    -- Every product must belong to a category
    category_id INTEGER NOT NULL,

    -- Product creation date and time
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Foreign key constraint
    -- Links product to categories table
    CONSTRAINT fk_product_category
        FOREIGN KEY (category_id)
        REFERENCES categories(id)
        ON DELETE CASCADE
);