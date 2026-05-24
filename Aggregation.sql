-- =========================================
-- AGGREGATION COMPLETE GUIDE
-- =========================================
-- This file includes all aggregation concepts:
-- COUNT, SUM, AVG, MIN, MAX, GROUP BY, HAVING
--
-- Aggregation is used to summarize data
-- from multiple rows into meaningful results.
--
-- Common Use Cases:
-- - Total sales
-- - Number of users
-- - Average order price
-- - Top customers
-- =========================================


-- =========================================
-- 1️⃣ COUNT
-- =========================================
-- Definition:
-- COUNT returns number of rows.

SELECT 
    COUNT(*) AS total_users
FROM users;


-- =========================================
-- 2️⃣ SUM
-- =========================================
-- Definition:
-- SUM returns total of numeric values.

SELECT 
    SUM(total_price) AS total_revenue
FROM orders;


-- =========================================
-- 3️⃣ AVG
-- =========================================
-- Definition:
-- AVG returns average value.

SELECT 
    AVG(total_price) AS avg_order_price
FROM orders;


-- =========================================
-- 4️⃣ MIN / MAX
-- =========================================
-- Definition:
-- MIN = smallest value
-- MAX = largest value

SELECT 
    MIN(total_price) AS lowest_order,
    MAX(total_price) AS highest_order
FROM orders;


-- =========================================
-- 5️⃣ GROUP BY
-- =========================================
-- Definition:
-- GROUP BY groups rows by a column.

-- Example:
-- Total orders per user

SELECT 
    user_id,
    COUNT(*) AS total_orders
FROM orders
GROUP BY user_id;


-- =========================================
-- 6️⃣ HAVING
-- =========================================
-- Definition:
-- HAVING filters groups AFTER aggregation.

-- Example:
-- Users with more than 2 orders

SELECT 
    user_id,
    COUNT(*) AS total_orders
FROM orders
GROUP BY user_id
HAVING COUNT(*) > 2;


-- =========================================
-- 7️⃣ REAL JOIN + AGGREGATION
-- =========================================
-- Example:
-- Total money spent per user

SELECT 
    u.name,
    SUM(o.total_price) AS total_spent
FROM users u
JOIN orders o
    ON u.id = o.user_id
GROUP BY u.name;


-- =========================================
-- END OF FILE
-- =========================================