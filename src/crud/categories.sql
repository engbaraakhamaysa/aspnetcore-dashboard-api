INSERT INTO categories(name , parent_id)
VALUES
('Car', NULL)
RETURNING * ;

SELECT * FROM categories;

UPDATE categories
SET name = 'Car'
WHERE id = 1
RETURNING *;

DELETE FROM categories
WHERE name = 'car'
RETURNING *;


INSERT INTO categories(name,parent_id)
VALUES
('KIA',1)
RETURNING *;