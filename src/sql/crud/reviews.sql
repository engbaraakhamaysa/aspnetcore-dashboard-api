SELECT * FROM reviews;

INSERT INTO reviews (user_id, product_id, rating, comment)
VALUES
(1,7,5,'Vary Good'),
(1,10,3,'Good'),
(1,9,1,'Not Good')
RETURNING *;

UPDATE reviews
SET rating = 4
WHERE id = 3
RETURNING *;

DELETE FROM review
WHERE id = 3;