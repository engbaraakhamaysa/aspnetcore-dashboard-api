-- CRUD

-- CREATE 
INSERT INTO order_items
(order_id, product_id, quantity, price)
VALUES
(7,7,1,40000.00),
(7,9,2,40000.00),
(7,10,1,45000.00)
RETURNING * ;

-- READ
SELECT * FROM order_items;

-- UPDATE
UPDATE order_items
SET quantity = 2
WHERE id = 7
RETURNING *;

-- DELETE
DELETE order_items
WHERE id = 7;