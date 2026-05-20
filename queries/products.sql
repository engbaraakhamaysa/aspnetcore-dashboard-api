

--1- Show All product
SELECT * FROM products;

--2- Top Query Join between Products and Categories
SELECT 
    products.id,
    products.name,
    products.price,
    categories.name AS category_name
FROM products
INNER JOIN categories
ON products.category_id = categories.id;

--3- Displaying products with parental classification
SELECT
    p.name AS product_name,
    c.name AS sub_category,
    parent.name AS parent_category
FROM products p

LEFT JOIN categories c
ON p.category_id = c.id

LEFT JOIN categories parent
ON c.parent_id = parent.id;


--4- WHERE + JOIN Electronics products only
SELECT
    p.name,
    p.price,
    c.name AS category
FROM products p
INNER JOIN categories c
ON p.category_id = c.id
WHERE c.name = 'Phones';

--5- ORDER BY Sort products by price
SELECT * FROM products
ORDER BY price DESC;

--6- LIMIT The 3 most expensive products
SELECT * FROM products
ORDER BY price DESC
LIMIT 3;

--7-Aggregate Functions Average prices
SELECT AVG(price) AS average_price
FROM products;

--Total inventory
SELECT SUM(stock) AS total_stock
FROM products;

--8- MAX() & MIN
SELECT MIN(price) AS min_price
FROM products;

SELECT MAX(price) AS max_price
FROM products;

--9- GROUP BY Nubmers of products in each category
SELECT
    c.name AS category,
    COUNT(p.id) AS total_products
FROM categories c
LEFT JOIN products p
ON c.id = p.category_id
GROUP BY c.name;

--10- HAVING Categories that contain more than one product
SELECT 
    c.name,
    COUNT(p.id) AS total_products
FROM categories c
LEFT JOIN products p
ON c.id = p.category_id
GROUP BY c.name
HAVING COUNT(p.id) > 1;

--11- CASE Inventory status
SELECT
    name,
    stock,
    CASE
        WHEN stock = 0 THEN 'Out of Stock'
        WHEN stock < 10 THEN 'Low Stock'
        ELSE 'In Stock'
    END AS stock_status
FROM products;


--12- UPDATE Price update
UPDATE products
SET price = 1300
WHERE name = 'iPhone 15'
RETURNING *;

--Reduce inventory
UPDATE products
SET stock = stock - 1
WHERE id = 1
RETURNING * ;

--13- DELETE 
DELETE FROM  products
WHERE id = 6
RETURNING * ;


--14- BETWEEN 
SELECT * FROM products
WHERE price BETWEEN 500 AND 1500;

--15- LIKE 
SELECT * FROM products
WHERE name LIKE '%Laptop%';


--16- IN
SELECT * FROM products
WHERE category_id IN (3,4);

--17- Subquery Products that are more expensive than average

SELECT * FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);


--18- EXISTS
SELECT name FROM categories c
WHERE EXISTS(
    SELECT 1
    FROM products p
    WHERE p.category_id = c.id
);

--19- Window Function Sort products by price
SELECT 
    name,
    price,
    RANK() OVER (ORDER BY price DESC) AS price_rank
FROM products;

--20- VIEW Create a product view with categories
CREATE VIEW product_datails AS 
SELECT
    p.id,
    p.name,
    p.price,
    p.stock,
    c.name AS category_name
FROM products p
JOIN categories c
ON p.category_id = c_id;

--Using View
SELECT * FROM product_details;

--📌 22. Transaction 🔥
BEGIN;

UPDATE products
SET stock = stock - 1
WHERE id = 1;

UPDATE products
SET stock = stock + 1
WHERE id = 2;

COMMIT;


-- 21. INDEX
CREATE INDEX idx_products_name
ON products(name);