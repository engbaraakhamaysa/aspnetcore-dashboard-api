-- =========================================
-- TABLE: payments
-- =========================================
-- This table stores payment information
-- related to customer orders.
--
-- Concepts Used:
-- 1. PRIMARY KEY
--    - Unique identifier for each payment.
--
-- 2. FOREIGN KEY
--    - Connects payments to orders.
--
-- 3. UNIQUE
--    - Ensures each order has only one payment.
--
-- 4. DEFAULT
--    - Automatically assigns default values.
--
-- 5. NULL
--    - Allows empty values until payment is completed.
--
-- 6. ON DELETE CASCADE
--    - Deletes payment records automatically
--      when the related order is removed.
-- =========================================

CREATE TABLE payments (

    -- Unique ID for each payment
    id SERIAL PRIMARY KEY,

    -- Related order ID
    -- UNIQUE ensures one payment per order
    order_id INTEGER NOT NULL UNIQUE,

    -- Payment method
    -- Examples: credit_card, paypal, cash
    method VARCHAR(30) NOT NULL,

    -- Payment status
    -- Default value is 'pending'
    -- Example values:
    -- pending, paid, failed, refunded
    status VARCHAR(30) DEFAULT 'pending',

    -- Date and time when payment was completed
    -- NULL means payment has not been completed yet
    paid_at TIMESTAMP NULL,

    -- Foreign key constraint
    -- Links payments to orders table
    CONSTRAINT fk_payment_order
        FOREIGN KEY (order_id)
        REFERENCES orders(id)
        ON DELETE CASCADE
);