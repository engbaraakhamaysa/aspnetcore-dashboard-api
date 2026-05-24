--CRUD--

-- CREATE 
INSERT INTO users(name,email,password_hash,role)
VALUES
('reem','reem@gmail.com','hash23423','customer')
RETURNING * ;

-- READ
SELECT * FROM users
WHERE id = 1;

-- UPDATE
UPDATE users
SET role = 'customer'
WHERE id = 2
RETURNING * ;


-- DELETE
DELETE FROM users
WHERE id = 8
RETURNING *;