-- =========================================
-- PAYMENTS TABLE - SAMPLE DATA & ANALYTICS
-- =========================================


-- =========================================
-- 1. INSERT SAMPLE PAYMENTS
-- =========================================
INSERT INTO payments
(order_id, method, status, paid_at)
VALUES
(1, 'credit_card', 'paid', CURRENT_TIMESTAMP),
(2, 'paypal', 'paid', CURRENT_TIMESTAMP),
(3, 'cash', 'pending', NULL),
(4, 'credit_card', 'failed', NULL),
(5, 'paypal', 'refunded', CURRENT_TIMESTAMP);



-- =========================================
-- 2. PAYMENT LIFECYCLE QUERY
-- Track payment details with order info
-- =========================================
SELECT
    o.id AS order_id,

    u.name AS customer,

    o.total_price,

    p.method,

    p.status,

    p.paid_at

FROM payments p

JOIN orders o
ON p.order_id = o.id

JOIN users u
ON o.user_id = u.id;



-- =========================================
-- 3. REVENUE RECOGNITION
-- Calculate confirmed revenue only
-- =========================================
SELECT
    SUM(o.total_price) AS confirmed_revenue

FROM payments p

JOIN orders o
ON p.order_id = o.id

WHERE p.status = 'paid';



-- =========================================
-- 4. FAILED PAYMENTS ANALYSIS
-- Analyze failed transactions
-- =========================================
SELECT
    method,

    COUNT(*) AS failed_payments

FROM payments

WHERE status = 'failed'

GROUP BY method;



-- =========================================
-- 5. REFUND ANALYTICS
-- Total refunded amount
-- =========================================
SELECT
    SUM(o.total_price) AS refunded_amount

FROM payments p

JOIN orders o
ON p.order_id = o.id

WHERE p.status = 'refunded';



-- =========================================
-- 6. PAYMENT SUCCESS RATE
-- Calculate successful payment percentage
-- =========================================
SELECT

    ROUND(
        100.0 * SUM(

            CASE
                WHEN status = 'paid' THEN 1
                ELSE 0
            END

        ) / COUNT(*),

        2

    ) AS success_rate_percentage

FROM payments;



-- =========================================
-- 7. MOST USED PAYMENT METHOD
-- =========================================
SELECT
    method,

    COUNT(*) AS usage_count

FROM payments

GROUP BY method

ORDER BY usage_count DESC;



-- =========================================
-- 8. DETECT UNPAID ORDERS
-- Orders without successful payment
-- =========================================
SELECT
    o.id,

    o.total_price

FROM orders o

LEFT JOIN payments p
ON o.id = p.order_id
AND p.status = 'paid'

WHERE p.id IS NULL;



-- =========================================
-- 9. TRIGGER:
-- Update order status after successful payment
-- =========================================

-- Create Trigger Function
CREATE OR REPLACE FUNCTION update_order_status_after_payment()

RETURNS TRIGGER AS $$

BEGIN

    -- If payment is successful
    IF NEW.status = 'paid' THEN

        -- Update order status
        UPDATE orders

        SET status = 'completed'

        WHERE id = NEW.order_id;

    END IF;

    RETURN NEW;

END;

$$ LANGUAGE plpgsql;



-- Create Trigger
CREATE TRIGGER trg_payment_success

AFTER UPDATE
ON payments

FOR EACH ROW

EXECUTE FUNCTION update_order_status_after_payment();



-- =========================================
-- 10. VALIDATION TRIGGER
-- Prevent payment for empty orders
-- =========================================

-- Create Trigger Function
CREATE OR REPLACE FUNCTION validate_order_before_payment()

RETURNS TRIGGER AS $$

DECLARE
    item_count INTEGER;

BEGIN

    -- Count items in the order
    SELECT COUNT(*)

    INTO item_count

    FROM order_items

    WHERE order_id = NEW.order_id;

    -- Prevent payment if order is empty
    IF item_count = 0 THEN

        RAISE EXCEPTION
        'Cannot pay for an empty order';

    END IF;

    RETURN NEW;

END;

$$ LANGUAGE plpgsql;



-- Create Trigger
CREATE TRIGGER trg_validate_payment

BEFORE INSERT
ON payments

FOR EACH ROW

EXECUTE FUNCTION validate_order_before_payment();



-- =========================================
-- 11. ACID TRANSACTION
-- Safe payment processing transaction
-- =========================================
BEGIN;

-- Update payment status
UPDATE payments

SET
    status = 'paid',
    paid_at = CURRENT_TIMESTAMP

WHERE order_id = 1;

-- Update order status
UPDATE orders

SET status = 'completed'

WHERE id = 1;

COMMIT;



-- =========================================
-- 12. AUDIT QUERY
-- Financial transaction history
-- =========================================
SELECT
    p.id AS payment_id,

    u.name,

    p.method,

    p.status,

    o.total_price,

    p.paid_at

FROM payments p

JOIN orders o
ON p.order_id = o.id

JOIN users u
ON o.user_id = u.id

ORDER BY p.paid_at DESC NULLS LAST;



-- =========================================
-- 13. WINDOW FUNCTION
-- Rank customers by total payments
-- =========================================
SELECT
    u.name,

    SUM(o.total_price) AS total_paid,

    DENSE_RANK() OVER (

        ORDER BY SUM(o.total_price) DESC

    ) AS payment_rank

FROM payments p

JOIN orders o
ON p.order_id = o.id

JOIN users u
ON o.user_id = u.id

WHERE p.status = 'paid'

GROUP BY u.name;



-- =========================================
-- 14. MATERIALIZED VIEW
-- Financial analytics summary
-- =========================================
CREATE MATERIALIZED VIEW payment_summary AS

SELECT
    method,

    COUNT(*) AS total_transactions,

    SUM(

        CASE
            WHEN status = 'paid' THEN 1
            ELSE 0
        END

    ) AS successful_payments

FROM payments

GROUP BY method;



-- =========================================
-- Refresh Materialized View
-- =========================================
REFRESH MATERIALIZED VIEW payment_summary;



-- =========================================
-- 15. SECURITY CONSTRAINT
-- Allow only valid payment statuses
-- =========================================
ALTER TABLE payments

ADD CONSTRAINT chk_payment_status

CHECK (

    status IN (

        'pending',
        'paid',
        'failed',
        'refunded'

    )

);



-- =========================================
-- 16. PARTIAL INDEX
-- Optimize successful payment searches
-- =========================================
CREATE INDEX idx_paid_payments

ON payments(order_id)

WHERE status = 'paid';