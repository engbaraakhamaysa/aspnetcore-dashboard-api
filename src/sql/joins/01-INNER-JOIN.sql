-- =========================================
-- INNER JOIN
-- =========================================
-- Definition:
-- INNER JOIN returns only the matching rows
-- between two tables.
--
-- Meaning:
-- It shows data that exists in BOTH tables.
--
-- When to Use:
-- Use INNER JOIN when you want only related data.
--
-- Example:
-- Show users who created orders.
--
-- Relationship Type:
-- One-to-Many
--
-- users (1) ---- (M) orders
--
-- Important:
-- If there is no match between tables,
-- the row will NOT appear in the result.
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
INNER JOIN orders o

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
INNER JOIN users u

-- Relationship condition
-- users.id matches orders.user_id
ON u.id = o.user_id;


-- INNER JOIN is used to return only the matching rows between two related tables based on a common column.