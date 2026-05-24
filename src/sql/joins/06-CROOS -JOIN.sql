-- =========================================
-- CROSS JOIN
-- =========================================
-- Definition:
-- CROSS JOIN returns ALL possible combinations
-- between two tables.
--
-- Meaning:
-- It does NOT use a condition (no ON clause).
-- It combines every row from the first table
-- with every row from the second table.
--
-- When to Use:
-- Use CROSS JOIN when you need combinations
-- or pairing between all records.
--
-- Example:
-- Combine all users with all categories.
--
-- Relationship Type:
-- No real relationship (Cartesian Product)
--
-- Important:
-- If table A has 3 rows and table B has 4 rows,
-- result will be 3 × 4 = 12 rows.
-- =========================================

SELECT 
    u.name AS user_name,
    c.name AS category_name

FROM users u

-- Combine every user with every category
CROSS JOIN categories c;