SELECT 
    o.id,
    u.name,
    o.total_price,
    o.status
FROM orders o
JOIN users u ON o.user_id = u.id;



DROP SCHEMA public CASCADE;

CREATE SCHEMA public;
