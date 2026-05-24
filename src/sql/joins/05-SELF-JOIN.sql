-- =========================================
-- SELF JOIN (categories hierarchy)
-- =========================================
-- Definition:
-- SELF JOIN is when a table is joined with itself.
--
-- Meaning:
-- It is used to represent hierarchical data
-- like parent-child relationships.
--
-- When to Use:
-- Use SELF JOIN when a table references itself
-- using a foreign key.
--
-- Example:
-- categories table:
-- - Parent category
-- - Sub categories
--
-- Relationship Type:
-- One-to-Many (recursive relationship)
--
-- categories (parent) ---- categories (child)
--
-- Important:
-- We use aliases to treat the same table
-- as two different tables.
-- =========================================

SELECT 
    -- Child category name
    child.name AS sub_category,

    -- Parent category name
    parent.name AS parent_category

FROM categories child

-- Join table with itself
LEFT JOIN categories parent

-- Relationship condition
-- child.parent_id points to parent.id
ON child.parent_id = parent.id;