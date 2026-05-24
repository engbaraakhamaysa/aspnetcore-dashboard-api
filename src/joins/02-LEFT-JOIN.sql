-- =========================================
-- LEFT JOIN
-- =========================================
-- Definition:
-- LEFT JOIN returns ALL rows from the left table
-- and the matching rows from the right table.
--
-- Meaning:
-- It shows all data from the main table,
-- even if there is no match in the second table.
--
-- When to Use:
-- Use LEFT JOIN when you want to keep all records
-- from the first (left) table.
--
-- Example:
-- Show all users, even those who did not make orders.
--
-- Relationship Type:
-- One-to-Many (commonly used)
--
-- users (1) ---- (M) orders
--
-- Important:
-- If there is no match in the right table,
-- the result will show NULL values.
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

-- Join orders table with users table
LEFT JOIN orders o

-- Relationship condition
-- users.id matches orders.user_id
ON u.id = o.user_id;

SELECT 
    -- User name from users table
    u.name, 
    
    -- Order ID from orders table
    o.id,

    -- Order status
    o.status,

    -- Total price of the order
    o.total_price

FROM orders o

-- Join orders table with users table
LEFT JOIN users u

-- Relationship condition
-- users.id matches orders.user_id
ON u.id = o.user_id;