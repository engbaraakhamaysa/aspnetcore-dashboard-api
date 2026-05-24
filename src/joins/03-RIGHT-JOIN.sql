-- =========================================
-- RIGHT JOIN
-- =========================================
-- Definition:
-- RIGHT JOIN returns ALL rows from the right table
-- and the matching rows from the left table.
--
-- Meaning:
-- It shows all data from the second (right) table,
-- even if there is no match in the first table.
--
-- When to Use:
-- Use RIGHT JOIN when you want to keep all records
-- from the second table (right side).
--
-- Example:
-- Show all orders, even if some orders
-- are not linked to a valid user.
--
-- Relationship Type:
-- One-to-Many (commonly used)
--
-- users (1) ---- (M) orders
--
-- Important:
-- If there is no match in the left table,
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
RIGHT JOIN orders o

-- Relationship condition
-- users.id matches orders.user_id
ON u.id = o.user_id;