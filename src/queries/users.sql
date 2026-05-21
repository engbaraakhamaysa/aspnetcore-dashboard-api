
--1- Show All Users 
SELECT * FROM users;

--2- Display only selected columns
SELECT name, email, role FROM users;


--3- WHERE — Data Filtering
SELECT * FROM users
WHERE role='admin';

--4- ORDER BY — Sort the data
SELECT  * FROM users
ORDER BY name ASC;

--5- LIMIT — Limit the number of results
SELECT * FROM users
LIMIT 2;

-- 6- UPDATE — Data Modification
UPDATE users
SET role = 'admin'
WHERE id = 2
RETURNING id, name, role;


-- 7- DELETE — Delete data
DELETE FROM users
WHERE id = 5
RETURNING *;

--8- COUNT — Count
SELECT COUNT(*) FROM users;

SELECT COUNT(*) FROM users
WHERE role = 'customer';

--9- DISTINCT — Unique Values
SELECT DISTINCT role FROM users;

--10- LIKE — Search
SELECT * FROM users
WHERE name LIKE 'B%';

SELECT * FROM users
WHERE name LIKE '%a%';

--11- IN
SELECT * FROM users
WHERE role IN('admin','manager');


--12- BETWEEN 
SELECT * FROM users
WHERE id BETWEEN 1 AND 3;

--13- IS NULL
SELECT * FROM users
WHERE role IS NULL;

-- 14- ALIAS
SELECT name AS username, email AS user_email
FROM users;

--15- GROUP BY
SELECT role , COUNT(*)
FROM users
GROUP BY role;

--16- HAVING
SELECT role , COUNT(*)
FROM users
GROUP BY role
HAVING COUNT(*) > 1; 

-- 17-CASE
SELECT
    name,
    role,
    CASE
        WHEN role = 'admin' THEN 'Full Access'
        WHEN role = 'manager' THEN 'Medium Access'
        ELSE 'Limited Access'
    END AS access_level
FROM users;    


--18- Pagination
-- First Page
SELECT * FROM users
LIMIT 2 OFFSET 0;
-- Seconde Page
SELECT * FROM users
LIMIT 2 OFFSET 2;

--19- Advanced Search
SELECT * FROM users
WHERE role = 'customer'
AND name LIKE '%a%';

--20- Delete all data without deleting the table.
TRUNCATE TABLE users;

--21-Delete the entire table
DROP TABLE users;

---------------------------------------------------

SELECT * FROM users
ORDER BY id DESC;


SELECT * FROM users
WHERE role = 'manager' OR role ='admin';
SELECT * FROM users
 