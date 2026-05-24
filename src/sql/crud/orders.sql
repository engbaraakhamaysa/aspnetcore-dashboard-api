-- CRUD

--READ
SELECT * FROM orders;

-- CREATE 
INSERT INTO orders(user_id, status, total_price)
VALUES
(3,'pending',1200.00),
(3,'shipped',300.00),
(3,'delivered',999.99),
(4,'cancelled',500.00);

-- UPDATE 
UPDATE orders
SET total_price = 99.99
WHERE id = 10
RETURNING *;


--DELETE
-- DELETE all data
DELETE FROM  orders;

-- DELETE one Coullom;
DELETE FROM orders
WHERE id = 10
RETURNING *;


