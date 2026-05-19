
--1- View all categories
SELECT * FROM categories;

--2-Display only the main categories (Root Categories)
SELECT * FROM categories
WHERE parent_id IS NULL;

--3- View Subcategories Only
SELECT * FROM categories
WHERE parent_id IS NOT NULL

--4- Self-Join — the most important part
SELECT 
    c1.id,
    c1.name AS category_name,
    c2.name AS parent_name
FROM categories c1
LEFT JOIN categories c2
ON c1.parent_id = c2.id;

--5- INNER JOIN (Godfather categories only)
SELECT c1.name , c2.name AS parent_name
FROM categories c1
INNER JOIN categories c2
ON c1.parent_id = c2.id

--6- RIGHT JOIN (Same idea but in reverse)
SELECT c1.name, c2.name
FROM categories c1
RIGHT JOIN categories c2
ON c1.parent_id = c2.id;

--7-CROSS JOIN (for testing purposes only)
SELECT c1.name, c2.name
FROM categories c1
CROSS JOIN categories c2;


--8- Display a complete tree in an organized manner
SELECT
    parent.name AS parent,
    child.name AS child
FROM categories child
LEFT JOIN categories parent
ON child.parent_id = parent.id
ORDER BY parent.name;

--9- Number of categories under each Parent
SELECT
    parent_id,
    COUNT(*) AS total_subcategories
FROM categories
GROUP BY parent_id;

--10- Display the number of subcategories per category (professional)
SELECT
    c.name,
    COUNT(sub.id) AS sub_count
FROM categories c
LEFT JOIN categories sub
ON sub.parent_id = c.id
GROUP BY c.name;

--11- UPDATE — Change Parent
UPDATE categories
SET parent_id = 2
WHERE name = 'Smartphones'
RETURNING *;

--12- DELETE — Delete Category
--Delete Category (only the children will be separated, not deleted)
DELETE FROM categories
WHERE id = 1;
--because of
ON DELETE SET NULL

--13- Search (LIKE)
SELECT * FROM categories
WHERE name LIKE '%p%';

--14-IN
SELECT * FROM categories
WHERE id IN(1,2,3);

--15- CASE — Data Classification
SELECT 
    name,
    CASE
        WHEN parent_id IS NULL THEN 'Main Category'
        ELSE 'Sub Category'
    END AS type
FROM categories;





---------------------------------------------
-- مراجعة
---------------------------------------------

WITH RECURSIVE category_tree AS (

    SELECT
        id,
        name,
        parent_id,
        1 AS level
    FROM categories
    WHERE parent_id IS NULL

    UNION ALL

    SELECT
        c.id,
        c.name,
        c.parent_id,
        ct.level + 1
    FROM categories c
    INNER JOIN category_tree ct
    ON c.parent_id = ct.id
)

SELECT * FROM category_tree;


---INDEX
CREATE INDEX idx_categories_parent_id
ON categories(parent_id);