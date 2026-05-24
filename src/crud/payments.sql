SELECT * FROM payments;

INSERT INTO payments (
    order_id,
    method,
    status,
    paid_at
)
VALUES

-- Payment 1
(7, 'credit_card', 'paid', NOW()),

-- Payment 2
(8, 'paypal', 'pending', NULL),

-- Payment 3
(9, 'cash', 'paid', NOW());


UPDATE payments
SET paid_at = null
WHERE id =3
RETURNING *;


DELETE FROM payment
WHERE id = 3
RETURNING *;


