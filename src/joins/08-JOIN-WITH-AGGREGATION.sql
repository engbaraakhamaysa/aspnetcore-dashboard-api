-- =========================================
-- JOIN WITH AGGREGATION
-- =========================================
-- Definition:
-- This combines JOIN with aggregation functions
-- like COUNT, SUM, AVG, MAX, MIN.
--
-- Meaning:
-- It is used to analyze data across related tables.
--
-- When to Use:
-- Use it when you want summary results
-- instead of detailed rows.
--
-- Example:
-- Show number of orders per user.
--
-- Relationship Type:
-- One-to-Many
--
-- users (1) ---- (M) orders
--
-- Important:
-- GROUP BY is required when using aggregation
-- with selected non-aggregated columns.
-- =========================================

SELECT 
    -- User name
    u.name,

    -- Total number of orders per user
    COUNT(o.id) AS total_orders,

    -- Total money spent by user
    SUM(o.total_price) AS total_spent

FROM users u

-- Link users with orders
LEFT JOIN orders o
    ON u.id = o.user_id

-- Group results by user
GROUP BY u.name;