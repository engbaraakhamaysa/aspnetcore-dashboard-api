-- =========================================
-- SQL JOINS COMPLETE GUIDE
-- =========================================
-- This file includes all JOIN types:
-- INNER, LEFT, RIGHT, FULL, SELF, CROSS
-- + Multiple JOINs + Aggregation use
--
-- JOINS are used to combine data from multiple tables
-- based on relationships (Primary Key / Foreign Key).
-- =========================================


-- =========================================
-- 1️⃣ INNER JOIN
-- =========================================
-- Returns only matching rows in both tables

SELECT 
    u.name,
    o.id,
    o.status
FROM users u
INNER JOIN orders o
    ON u.id = o.user_id;


-- =========================================
-- 2️⃣ LEFT JOIN
-- =========================================
-- Returns all rows from left table + matches from right

SELECT 
    u.name,
    o.id
FROM users u
LEFT JOIN orders o
    ON u.id = o.user_id;


-- =========================================
-- 3️⃣ RIGHT JOIN
-- =========================================
-- Returns all rows from right table + matches from left

SELECT 
    u.name,
    o.id
FROM users u
RIGHT JOIN orders o
    ON u.id = o.user_id;


-- =========================================
-- 4️⃣ FULL OUTER JOIN
-- =========================================
-- Returns all rows from both tables

SELECT 
    u.name,
    o.id
FROM users u
FULL OUTER JOIN orders o
    ON u.id = o.user_id;


-- =========================================
-- 5️⃣ SELF JOIN
-- =========================================
-- Table joins itself (hierarchy data)

SELECT 
    child.name AS sub_category,
    parent.name AS parent_category
FROM categories child
LEFT JOIN categories parent
    ON child.parent_id = parent.id;


-- =========================================
-- 6️⃣ CROSS JOIN
-- =========================================
-- All possible combinations

SELECT 
    u.name,
    c.name
FROM users u
CROSS JOIN categories c;


-- =========================================
-- 7️⃣ MULTIPLE JOINS
-- =========================================
-- Joining multiple related tables

SELECT 
    u.name,
    o.id,
    p.name AS product_name,
    c.name AS category_name,
    oi.quantity
FROM users u
JOIN orders o ON u.id = o.user_id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
JOIN categories c ON p.category_id = c.id;


-- =========================================
-- 8️⃣ JOIN + AGGREGATION
-- =========================================
-- Example: total spending per user

SELECT 
    u.name,
    SUM(o.total_price) AS total_spent
FROM users u
JOIN orders o ON u.id = o.user_id
GROUP BY u.name;


-- =========================================
-- END OF FILE
-- =========================================