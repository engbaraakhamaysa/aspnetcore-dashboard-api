INSERT INTO products(name, description, price, stock, category_id)
VALUES
('K3', 'family car', 40000.00, 20, 12),
('Sportage', 'family car', 45000.00, 20, 12)
RETURNING *;


SELECT * FROM products;

UPDATE products
SET stock = 25
WHERE id = 8
RETURNING *;


DELETE FROM products
WHERE id = 8
RETURNING name;