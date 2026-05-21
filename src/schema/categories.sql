-- =========================================
-- TABLE: categories
-- =========================================
-- This table stores product categories.
-- It supports hierarchical categories using
-- a self-referencing parent_id column.
--
-- Concepts Used:
-- 1. PRIMARY KEY: unique identifier for each category
-- 2. SELF-REFERENCING FOREIGN KEY: category can have a parent category
-- 3. ON DELETE SET NULL: removes relationship if parent is deleted
-- 4. TIMESTAMP: stores creation time
-- =========================================

CREATE TABLE categories (

    -- Unique ID for each category
    id SERIAL PRIMARY KEY,

    -- Category name
    -- Required field (cannot be null)
    name VARCHAR(100) NOT NULL,

    -- Parent category ID (for subcategories)
    -- NULL means it is a main/root category
    parent_id INTEGER NULL,

    -- Date when category was created
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Foreign key constraint for hierarchical structure
    -- Electronics (father)
    -- Phones (son)
    -- Android (son)
    CONSTRAINT fk_parent_category
        FOREIGN KEY (parent_id)
        REFERENCES categories(id)
        ON DELETE SET NULL
);



-- | id | name        | parent_id |
-- | -- | ----------- | --------- |
-- | 1  | Electronics | NULL      |
-- | 2  | Phones      | 1         |
-- | 3  | Laptops     | 1         |
-- | 4  | Android     | 2         |
