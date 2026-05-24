-- =========================================
-- FULL OUTER JOIN
-- =========================================
-- Definition:
-- FULL OUTER JOIN returns ALL rows from BOTH tables
-- whether there is a match or not.
--
-- Meaning:
-- It combines LEFT JOIN + RIGHT JOIN.
-- It shows everything from both tables.
--
-- When to Use:
-- Use FULL OUTER JOIN when you want complete data
-- from both tables, including unmatched records.
--
-- Example:
-- Show all users and all orders,
-- even if some users have no orders
-- and some orders have no users.
--
-- Relationship Type:
-- One-to-Many (commonly used)
--
-- users (1) ---- (M) orders
--
-- Important:
-- Missing matches will appear as NULL values.
-- =========================================

SELECT 
    -- User name from users table
    u.name, 
    
    -- Order ID from orders table
    o.id,

    -- Order status
    o.status,

    -- Total price of the order
    o.total_price

FROM users u

-- Full join between users and orders
FULL OUTER JOIN orders o

-- Relationship condition
-- users.id matches orders.user_id
ON u.id = o.user_id;