-- =========================================
-- TABLE: users
-- =========================================
-- This table stores all registered users
-- in the e-commerce system.
--
-- Concepts Used:
-- 1. PRIMARY KEY
--    - Uniquely identifies each user.
--
-- 2. SERIAL
--    - Auto-increment integer value.
--
-- 3. NOT NULL
--    - Prevents empty values.
--
-- 4. UNIQUE
--    - Prevents duplicate emails.
--
-- 5. DEFAULT
--    - Sets a default value automatically.
--
-- 6. TIMESTAMP
--    - Stores date and time information.
-- =========================================
CREATE TABLE users (

    -- Unique ID for each user
    id SERIAL PRIMARY KEY,

    -- User full name
    -- VARCHAR(100) limits text length to 100 characters
    -- NOT NULL means the field is required
    name VARCHAR(100) NOT NULL,

    -- User email address
    -- UNIQUE prevents duplicate emails
    -- NOT NULL means every user must have an email
    email VARCHAR(150) UNIQUE NOT NULL,

    -- Encrypted password storage
    -- TEXT is used because hash length may vary
    password_hash TEXT NOT NULL,

    -- User role in the system
    -- DEFAULT value is 'customer'
    -- Possible examples: admin, customer, seller
    role VARCHAR(20) DEFAULT 'customer',

    -- Stores account creation date and time
    -- CURRENT_TIMESTAMP automatically inserts current date/time
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);