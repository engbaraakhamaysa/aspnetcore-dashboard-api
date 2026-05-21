-- =========================================
-- REVIEWS TABLE - SAMPLE DATA & ANALYTICS
-- =========================================

-- =========================================
-- 1. INSERT SAMPLE REVIEWS
-- =========================================
INSERT INTO reviews
(user_id, product_id, rating, comment)
VALUES
(1, 1, 5, 'Excellent product'),
(2, 1, 4, 'Very good phone'),
(3, 2, 3, 'Average experience'),
(1, 3, 5, 'Amazing laptop'),
(2, 4, 2, 'Battery is weak'),
(3, 5, 4, 'Good quality clothes');



-- =========================================
-- 2. AVERAGE RATING FOR EACH PRODUCT
-- =========================================
SELECT
    p.name,

    ROUND(AVG(r.rating), 2) AS average_rating

FROM reviews r

JOIN products p
ON r.product_id = p.id

GROUP BY p.name

ORDER BY average_rating DESC;



-- =========================================
-- 3. TOTAL NUMBER OF REVIEWS PER PRODUCT
-- =========================================
SELECT
    p.name,

    COUNT(r.id) AS total_reviews

FROM products p

LEFT JOIN reviews r
ON p.id = r.product_id

GROUP BY p.name;



-- =========================================
-- 4. TOP RATED PRODUCTS
-- Only products with at least 2 reviews
-- =========================================
SELECT
    p.name,

    AVG(r.rating) AS avg_rating

FROM reviews r

JOIN products p
ON r.product_id = p.id

GROUP BY p.name

HAVING COUNT(r.id) >= 2

ORDER BY avg_rating DESC;



-- =========================================
-- 5. REVIEW SENTIMENT ANALYSIS
-- Convert numeric rating into text label
-- =========================================
SELECT
    rating,

    CASE
        WHEN rating = 5 THEN 'Excellent'
        WHEN rating = 4 THEN 'Good'
        WHEN rating = 3 THEN 'Average'
        WHEN rating = 2 THEN 'Poor'
        ELSE 'Bad'
    END AS sentiment

FROM reviews;



-- =========================================
-- 6. PRODUCT RANKING BY AVERAGE RATING
-- Using Window Function
-- =========================================
SELECT
    p.name,

    ROUND(AVG(r.rating), 2) AS avg_rating,

    RANK() OVER (
        ORDER BY AVG(r.rating) DESC
    ) AS ranking

FROM reviews r

JOIN products p
ON r.product_id = p.id

GROUP BY p.name;



-- =========================================
-- 7. TOP REVIEWERS
-- Users who wrote the most reviews
-- =========================================
SELECT
    u.name,

    COUNT(r.id) AS total_reviews

FROM reviews r

JOIN users u
ON r.user_id = u.id

GROUP BY u.name

ORDER BY total_reviews DESC;



-- =========================================
-- 8. PRODUCTS WITHOUT REVIEWS
-- =========================================
SELECT
    p.name

FROM products p

LEFT JOIN reviews r
ON p.id = r.product_id

WHERE r.id IS NULL;



-- =========================================
-- 9. USERS WHO REVIEWED PRODUCTS
-- Count reviewed products per user
-- =========================================
SELECT
    u.name,

    COUNT(DISTINCT r.product_id) AS reviewed_products

FROM users u

JOIN reviews r
ON u.id = r.user_id

GROUP BY u.name;



-- =========================================
-- 10. PREVENT DUPLICATE REVIEWS
-- One review per user per product
-- =========================================
ALTER TABLE reviews

ADD CONSTRAINT unique_user_product_review

UNIQUE(user_id, product_id);



-- =========================================
-- 11. TRIGGER:
-- User can review only purchased products
-- =========================================

-- Create Trigger Function
CREATE OR REPLACE FUNCTION check_product_purchase()

RETURNS TRIGGER AS $$

BEGIN

    -- Check whether the user purchased the product
    IF NOT EXISTS (

        SELECT 1

        FROM order_items oi

        JOIN orders o
        ON oi.order_id = o.id

        WHERE o.user_id = NEW.user_id
        AND oi.product_id = NEW.product_id

    )

    THEN

        RAISE EXCEPTION
        'User cannot review a product not purchased';

    END IF;

    RETURN NEW;

END;

$$ LANGUAGE plpgsql;



-- Create Trigger
CREATE TRIGGER trg_check_purchase

BEFORE INSERT
ON reviews

FOR EACH ROW

EXECUTE FUNCTION check_product_purchase();



-- =========================================
-- 12. MATERIALIZED VIEW
-- Store rating statistics for faster queries
-- =========================================
CREATE MATERIALIZED VIEW product_rating_summary AS

SELECT
    product_id,

    ROUND(AVG(rating), 2) AS avg_rating,

    COUNT(*) AS total_reviews

FROM reviews

GROUP BY product_id;



-- Refresh Materialized View
REFRESH MATERIALIZED VIEW product_rating_summary;



-- =========================================
-- 13. FULL PRODUCT ANALYTICS
-- Comprehensive review statistics
-- =========================================
SELECT
    p.name,

    COUNT(r.id) AS total_reviews,

    ROUND(AVG(r.rating), 2) AS avg_rating,

    MIN(r.rating) AS lowest_rating,

    MAX(r.rating) AS highest_rating

FROM products p

LEFT JOIN reviews r
ON p.id = r.product_id

GROUP BY p.name

ORDER BY avg_rating DESC NULLS LAST;



-- =========================================
-- 14. INDEX OPTIMIZATION
-- Improve query performance
-- =========================================

-- Index for product reviews
CREATE INDEX idx_reviews_product
ON reviews(product_id);

-- Index for user reviews
CREATE INDEX idx_reviews_user
ON reviews(user_id);



-- =========================================
-- 15. CTE FOR RATING ANALYSIS
-- Products with average rating above 4
-- =========================================
WITH rating_stats AS (

    SELECT
        product_id,

        AVG(rating) AS avg_rating

    FROM reviews

    GROUP BY product_id
)

SELECT
    p.name,

    rs.avg_rating

FROM rating_stats rs

JOIN products p
ON rs.product_id = p.id

WHERE rs.avg_rating > 4;