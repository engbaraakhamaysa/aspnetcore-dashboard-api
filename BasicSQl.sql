-- =========================================
-- BASIC SQL COMPLETE GUIDE
-- =========================================
-- This file includes basic SQL operations:
-- SELECT, INSERT, UPDATE, DELETE,
-- WHERE, ORDER BY, LIMIT
--
-- These are the core commands used in every database system.
-- =========================================


-- =========================================
-- 1️⃣ SELECT
-- =========================================
-- Definition:
-- Used to retrieve data from a table.

SELECT * FROM users;

SELECT name, email FROM users;


-- =========================================
-- 2️⃣ INSERT
-- =========================================
-- Definition:
-- Used to add new records.

INSERT INTO users (name, email, password_hash)
VALUES ('Ali', 'ali@gmail.com', 'hashed_password');


-- =========================================
-- 3️⃣ UPDATE
-- =========================================
-- Definition:
-- Used to modify existing data.

UPDATE users
SET name = 'Ahmad'
WHERE id = 1;


-- =========================================
-- 4️⃣ DELETE
-- =========================================
-- Definition:
-- Used to remove data from a table.

DELETE FROM users
WHERE id = 1;


-- =========================================
-- 5️⃣ WHERE
-- =========================================
-- Definition:
-- Filters rows based on conditions.

SELECT *
FROM orders
WHERE status = 'pending';

SELECT *
FROM products
WHERE price > 100;


-- =========================================
-- 6️⃣ ORDER BY
-- =========================================
-- Definition:
-- Sorts results (ASC or DESC).

SELECT *
FROM products
ORDER BY price DESC;

SELECT *
FROM users
ORDER BY created_at ASC;


-- =========================================
-- 7️⃣ LIMIT
-- =========================================
-- Definition:
-- Limits number of returned rows.

SELECT *
FROM products
LIMIT 5;

SELECT *
FROM orders
ORDER BY created_at DESC
LIMIT 10;


-- =========================================
-- END OF FILE
-- =========================================