
--1- Show All Orders
SELECT * FROM orders;

--2-JOIN between orders and users
-- View requests with username
SELECT
    o.id,
    u.name AS customer_name,
    u.role AS customer_role,
    o.status,
    o.total_price,
    o.created_at
FROM orders o
INNER JOIN users u
ON o.user_id = u.id;
--3-View requests from a specific user
SELECT 
    o.id AS orders_id,
    u.name,
    u.id AS user_id,
    o.total_price
FROM orders o
JOIN users u
ON o.user_id = u.id
WHERE u.id = 1;


--4- Aggregate Functions
--Total profits
SELECT SUM(total_price) AS total_revenue
FROM orders;

--Average order value
SELECT AVG(total_price) AS average_order_price
FROM orders;

--Top order
SELECT MAX(total_price) AS highest_order
FROM orders;

--5- GROUP BY
--Number of requests per user
SELECT 
    u.name,
    COUNT(o.id) AS total_orders
FROM users u
LEFT JOIN orders o
ON u.id = o.user_id
GROUP BY u.id;

--6- JOIN Total purchases per user
SELECT 
    u.name,
    SUM(o.total_price) AS total_spent
FROM users u
JOIN orders o
ON u.id = o.user_id
GROUP BY u.name;

--7-HAVING
--Users who spent more than 1000
SELECT 
    u.name,
    SUM(o.total_price) AS total_spent
FROM users u
JOIN orders o
ON u.id = o.user_id
GROUP BY u.id
HAVING SUM(o.total_price) > 1000;

--8- CASE
--Order status classification
SELECT
    id,
    status,
    CASE
        WHEN status = 'pending' THEN 'Waiting'
        WHEN status = 'shipped' THEN 'On The Way'
        WHEN status = 'delivered' THEN 'Completed'
        ELSE 'Cancelled'
    END AS status_description
FROM orders;

--9- WHERE + DATE
--Today's requests
SELECT *
FROM orders
WHERE DATE(created_at) = CURRENT_DATE;


--10-BETWEEN
--Orders between two prices
SELECT *
FROM orders
WHERE total_price BETWEEN 555 AND 1500;

--11- ORDER BY
--Top Requests
SELECT *
FROM orders
ORDER BY total_price DESC
LIMIT 3;

--12- Subquery
--Orders higher than average orders
SELECT * 
FROM orders
WHERE total_price > (
    SELECT AVG(total_price)
    FROM orders
);

--13- EXISTS
--Users with requests
SELECT * 
FROM users u
WHERE EXISTS(
    SELECT 1
    FROM orders o
    WHERE o.user_id = u.id
);


--14- Window Function
SELECT 
    u.name,
    SUM(o.total_price) AS total_spent,
    RANK() OVER(
        ORDER BY SUM(o.total_price) DESC
    ) AS spending_rank
FROM users u
JOIN orders o
ON u.id = o.user_id
GROUP BY u.id;

--15-Order status update
UPDATE orders
SET status = 'delivered'
WHERE id = 1
RETURNING *;

--16-Delete request
DELETE FROM orders
WHERE id = 4;

--17- VIEW
CREATE VIEW order_summary AS
SELECT
    o.id,
    u.name AS customer,
    o.status,
    o.total_price,
    o.created_at
FROM orders o
JOIN users u
ON o.user_id = u.id;
--Using View
SELECT * FROM order_summary;

--18- INDEX
CREATE INDEX idx_orders_user_id
ON orders(user_id);


--19-Transaction
BEGIN;

UPDATE products
SET stock = stock - 1
WHERE id = 1;

INSERT INTO orders
(user_id, status, total_price)
VALUES
(1, 'pending', 1200);

COMMIT;


--20- CTE
WITH customer_spending AS (

    SELECT
        u.name,
        SUM(o.total_price) AS total_spent
    FROM users u
    JOIN orders o
    ON u.id = o.user_id
    GROUP BY u.name
)

SELECT *
FROM customer_spending
WHERE total_spent > 1000;