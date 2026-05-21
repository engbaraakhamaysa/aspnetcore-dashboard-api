-- =========================================
-- TABLE: reviews
-- =========================================
-- This table stores user reviews and ratings
-- for products in the e-commerce system.
--
-- Concepts Used:
-- 1. PRIMARY KEY
--    - Unique identifier for each review.
--
-- 2. FOREIGN KEY
--    - Connects reviews to users and products.
--
-- 3. CHECK CONSTRAINT
--    - Restricts rating values between 1 and 5.
--
-- 4. TEXT
--    - Used for long review comments.
--
-- 5. ON DELETE CASCADE
--    - Automatically deletes reviews when
--      the related user or product is removed.
-- =========================================

CREATE TABLE reviews (

    -- Unique ID for each review
    id SERIAL PRIMARY KEY,

    -- User who wrote the review
    -- Required field
    user_id INTEGER NOT NULL,

    -- Reviewed product
    -- Required field
    product_id INTEGER NOT NULL,

    -- Product rating
    -- Allowed values: 1 to 5
    rating INTEGER
        CHECK (rating >= 1 AND rating <= 5),

    -- User review comment
    -- Optional field
    comment TEXT,

    -- Date and time when the review was created
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Foreign key constraint
    -- Links reviews to users table
    CONSTRAINT fk_review_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE,

    -- Foreign key constraint
    -- Links reviews to products table
    CONSTRAINT fk_review_product
        FOREIGN KEY (product_id)
        REFERENCES products(id)
        ON DELETE CASCADE
);