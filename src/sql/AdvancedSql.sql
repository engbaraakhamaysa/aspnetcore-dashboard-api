-- =========================================
-- ADVANCED SQL COMPLETE GUIDE
-- =========================================
-- This file includes advanced SQL concepts:
-- Subqueries, CTE, Window Functions,
-- EXISTS, CASE WHEN
--
-- These concepts are used in real backend systems
-- and data analysis.
-- =========================================


-- =========================================
-- 1️⃣ SUBQUERIES
-- =========================================
-- Definition:
-- A query inside another query.

-- Example:
-- Users who have orders

SELECT name
FROM users
WHERE id IN (
    SELECT user_id
    FROM orders
);


-- =========================================
-- 2️⃣ CTE (WITH QUERY)
-- =========================================
-- Definition:
-- A temporary named result set.

-- Example:
-- Total orders per user

WITH user_orders AS (
    SELECT user_id, COUNT(*) AS total_orders
    FROM orders
    GROUP BY user_id
)
SELECT u.name, uo.total_orders
FROM users u
JOIN user_orders uo
    ON u.id = uo.user_id;


-- =========================================
-- 3️⃣ WINDOW FUNCTIONS
-- =========================================
-- Definition:
-- Performs calculations across rows
-- without collapsing results.

-- Example:
-- Rank users by total spending

SELECT 
    u.name,
    o.total_price,
    RANK() OVER (ORDER BY o.total_price DESC) AS rank_position
FROM users u
JOIN orders o
    ON u.id = o.user_id;


-- =========================================
-- 4️⃣ EXISTS
-- =========================================
-- Definition:
-- Checks if a record exists.

-- Example:
-- Users who have at least one order

SELECT name
FROM users u
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.user_id = u.id
);


-- =========================================
-- 5️⃣ CASE WHEN
-- =========================================
-- Definition:
-- Conditional logic inside SQL.

-- Example:
-- Categorize orders by price

SELECT 
    id,
    total_price,
    CASE 
        WHEN total_price > 500 THEN 'High'
        WHEN total_price > 100 THEN 'Medium'
        ELSE 'Low'
    END AS price_category
FROM orders;


-- =========================================
-- END OF FILE
-- =========================================