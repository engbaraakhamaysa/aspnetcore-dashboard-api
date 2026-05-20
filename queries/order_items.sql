--1- Full Invoice Query
-- The most important query in almost the entire project
SELECT
    o.id AS order_id,
    u.name AS customer,
    p.name AS product,
    oi.quantity,
    oi.price,
    (oi.quantity * oi.price) AS total
FROM order_items oi

JOIN orders o
ON oi.order_id = o.id

JOIN users u
ON o.user_id = u.id

JOIN products p
ON oi.product_id = p.id

ORDER BY o.id;

--2- Calculate Total Order Dynamically
SELECT 
    order_id,
    SUM(quantity * price) AS order_total
FROM order_items
GROUP BY order_id;

--3- Top Selling Products
-- Best-selling products

SELECT 
    p.name,
    SUM(oi.quantity) AS total_sold
FROM order_items oi

JOIN products p
ON oi.product_id = p.id

GROUP BY p.id
ORDER BY total_sold DESC;

--4- Most Profitable Products Most profitable products
SELECT
    p.name,
    SUM(oi.quantity * oi.price) AS revenue
FROM order_items oi

JOIN products p
ON oi.product_id = p.id

GROUP BY p.name
ORDER BY revenue DESC;

--5- Best Customers
SELECT
    u.name,
    SUM(oi.quantity * oi.price) AS total_spent
FROM order_items oi

JOIN orders o
ON oi.order_id = o.id

JOIN users u
ON o.user_id = u.id

GROUP BY u.name
ORDER BY total_spent DESC;

--6- Advanced Window Function
SELECT
    p.name,
    SUM(oi.quantity) AS total_sold,

    RANK() OVER (
        ORDER BY SUM(oi.quantity) DESC
    ) AS sales_rank

FROM order_items oi

JOIN products p
ON oi.product_id = p.id

GROUP BY p.name;

--7- Running Revenue
SELECT
    o.created_at,
    SUM(oi.quantity * oi.price) AS revenue,

    SUM(
        SUM(oi.quantity * oi.price)
    ) OVER (
        ORDER BY o.created_at
    ) AS running_total

FROM order_items oi

JOIN orders o
ON oi.order_id = o.id

GROUP BY o.created_at;

--8-Recursive Analytics Number of products included in each order
SELECT
    order_id,
    COUNT(product_id) AS total_products
FROM order_items
GROUP BY order_id;


--9--Composite UNIQUE Constraint Prevent duplication of the same product within the same order
ALTER TABLE order_items
ADD CONSTRAINT unique_order_product
UNIQUE(order_id, product_id);

-- 10. Trigger Update total_price automatically
CREATE OR REPLACE FUNCTION update_order_total()
RETURNS TRIGGER AS $$

BEGIN

    UPDATE orders
    SET total_price = (

        SELECT COALESCE(
            SUM(quantity * price),
            0
        )
        FROM order_items
        WHERE order_id = NEW.order_id

    )

    WHERE id = NEW.order_id;

    RETURN NEW;

END;

$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trg_update_order_total

AFTER INSERT OR UPDATE OR DELETE
ON order_items

FOR EACH ROW

EXECUTE FUNCTION update_order_total();


--10- Trigger to automatically update Stock When purchasing a product, the stock decreases.
CREATE OR REPLACE FUNCTION decrease_stock()
RETURNS TRIGGER AS $$

BEGIN

    UPDATE products
    SET stock = stock - NEW.quantity
    WHERE id = NEW.product_id;

    RETURN NEW;

END;

$$ LANGUAGE plpgsql;
--Trigger
CREATE TRIGGER trg_decrease_stock

AFTER INSERT
ON order_items

FOR EACH ROW

EXECUTE FUNCTION decrease_stock();

--11-The transaction is completely legitimate. A complete order has been created.
BEGIN;

INSERT INTO orders(user_id, status)
VALUES (1, 'pending');

INSERT INTO order_items
(order_id, product_id, quantity, price)
VALUES
(1, 1, 2, 1200);

UPDATE products
SET stock = stock - 2
WHERE id = 1;

COMMIT;

-- 12-VIEW INVOICES
CREATE VIEW invoice_view AS

SELECT
    o.id AS order_id,
    u.name AS customer,
    p.name AS product,
    oi.quantity,
    oi.price,
    (oi.quantity * oi.price) AS total

FROM order_items oi

JOIN orders o
ON oi.order_id = o.id

JOIN users u
ON o.user_id = u.id

JOIN products p
ON oi.product_id = p.id;

--16-Index Optimization
CREATE INDEX idx_order_items_order
ON order_items(order_id);

CREATE INDEX idx_order_items_product
ON order_items(product_id);

--17- The strongest query in the project Top Categories Revenue
SELECT
    c.name AS category,
    SUM(oi.quantity * oi.price) AS revenue

FROM order_items oi

JOIN products p
ON oi.product_id = p.id

JOIN categories c
ON p.category_id = c.id

GROUP BY c.name

ORDER BY revenue DESC;
