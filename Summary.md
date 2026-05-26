# SQL Complete Summary

## 1. What is SQL?

SQL (Structured Query Language) is the standard language used to communicate with relational databases. It allows developers to:

- Store data
- Retrieve data
- Update data
- Delete data
- Manage database structures
- Control permissions and transactions

Popular database systems that use SQL:

- PostgreSQL
- MySQL
- SQL Server
- Oracle Database
- SQLite

---

# 2. Database Fundamentals

## Database

A database is an organized collection of related data.

Example:
An e-commerce database may contain:

- Users
- Products
- Orders
- Payments
- Reviews

## Table

A table stores data in rows and columns.

Example:

| id  | name | email                                 |
| --- | ---- | ------------------------------------- |
| 1   | Ali  | [ali@gmail.com](mailto:ali@gmail.com) |

## Row (Record)

Represents a single item.

## Column (Field)

Represents a property of the data.

---

# 3. Data Types

Common SQL data types:

| Type       | Description            |
| ---------- | ---------------------- |
| INTEGER    | Whole numbers          |
| SERIAL     | Auto increment integer |
| VARCHAR(n) | Text with length       |
| TEXT       | Long text              |
| BOOLEAN    | True/False             |
| DATE       | Date only              |
| TIMESTAMP  | Date and time          |
| DECIMAL    | Decimal numbers        |

Example:

```sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INTEGER,
    created_at TIMESTAMP
);
```

---

# 4. CRUD Operations

CRUD = Create, Read, Update, Delete

## INSERT

Adds data.

```sql
INSERT INTO users(name, age)
VALUES ('Baraa', 22);
```

## SELECT

Reads data.

```sql
SELECT * FROM users;
```

## UPDATE

Modifies data.

```sql
UPDATE users
SET age = 23
WHERE id = 1;
```

## DELETE

Removes data.

```sql
DELETE FROM users
WHERE id = 1;
```

---

# 5. WHERE Clause

Filters rows.

```sql
SELECT * FROM products
WHERE price > 100;
```

Common operators:

| Operator | Meaning          |
| -------- | ---------------- |
| =        | Equal            |
| !=       | Not equal        |
| >        | Greater than     |
| <        | Less than        |
| >=       | Greater or equal |
| <=       | Less or equal    |
| AND      | Both conditions  |
| OR       | One condition    |
| IN       | Multiple values  |
| BETWEEN  | Range            |
| LIKE     | Pattern matching |

---

# 6. Constraints

Constraints protect data integrity.

| Constraint  | Purpose            |
| ----------- | ------------------ |
| PRIMARY KEY | Unique identifier  |
| FOREIGN KEY | Links tables       |
| UNIQUE      | Prevent duplicates |
| NOT NULL    | Required value     |
| CHECK       | Validation rule    |
| DEFAULT     | Default value      |

Example:

```sql
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL CHECK(price > 0)
);
```

---

# 7. Relationships

## One-to-Many

One user can have many orders.

```sql
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id)
);
```

## Many-to-Many

Products and orders.

Uses a junction table:

```sql
CREATE TABLE order_items (
    order_id INTEGER,
    product_id INTEGER
);
```

---

# 8. JOINs

JOINs combine data from multiple tables.

## INNER JOIN

Returns matching rows.

```sql
SELECT users.name, orders.id
FROM users
INNER JOIN orders
ON users.id = orders.user_id;
```

## LEFT JOIN

Returns all rows from left table.

## RIGHT JOIN

Returns all rows from right table.

## FULL JOIN

Returns all rows from both tables.

---

# 9. Aggregate Functions

Used for calculations.

| Function | Description    |
| -------- | -------------- |
| COUNT()  | Counts rows    |
| SUM()    | Total          |
| AVG()    | Average        |
| MAX()    | Largest value  |
| MIN()    | Smallest value |

Example:

```sql
SELECT COUNT(*) FROM users;
```

---

# 10. GROUP BY & HAVING

## GROUP BY

Groups rows.

```sql
SELECT role, COUNT(*)
FROM users
GROUP BY role;
```

## HAVING

Filters grouped data.

```sql
SELECT role, COUNT(*)
FROM users
GROUP BY role
HAVING COUNT(*) > 5;
```

---

# 11. ORDER BY & LIMIT

## ORDER BY

Sorts data.

```sql
SELECT * FROM products
ORDER BY price DESC;
```

## LIMIT

Limits results.

```sql
SELECT * FROM products
LIMIT 10;
```

---

# 12. Subqueries

A query inside another query.

```sql
SELECT * FROM products
WHERE price > (
    SELECT AVG(price) FROM products
);
```

---

# 13. Common Table Expressions (CTE)

Improves readability.

```sql
WITH expensive_products AS (
    SELECT * FROM products
    WHERE price > 100
)
SELECT * FROM expensive_products;
```

---

# 14. Window Functions

Perform calculations without grouping rows.

Example:

```sql
SELECT name,
       salary,
       RANK() OVER (ORDER BY salary DESC)
FROM employees;
```

Useful functions:

- RANK()
- ROW_NUMBER()
- DENSE_RANK()
- LAG()
- LEAD()

---

# 15. Transactions

Transactions ensure data consistency.

```sql
BEGIN;

UPDATE accounts
SET balance = balance - 100
WHERE id = 1;

UPDATE accounts
SET balance = balance + 100
WHERE id = 2;

COMMIT;
```

Commands:

| Command  | Purpose           |
| -------- | ----------------- |
| BEGIN    | Start transaction |
| COMMIT   | Save changes      |
| ROLLBACK | Undo changes      |

---

# 16. Indexes

Indexes improve query performance.

```sql
CREATE INDEX idx_users_email
ON users(email);
```

Advantages:

- Faster search
- Faster filtering
- Better JOIN performance

Disadvantage:

- Slower INSERT/UPDATE sometimes

---

# 17. Views

A virtual table based on a query.

```sql
CREATE VIEW active_users AS
SELECT * FROM users
WHERE active = true;
```

Benefits:

- Simpler queries
- Better security
- Reusable logic

---

# 18. Functions & Triggers

## Function

Reusable SQL logic.

```sql
CREATE FUNCTION get_total()
RETURNS INTEGER AS $$
BEGIN
    RETURN 100;
END;
$$ LANGUAGE plpgsql;
```

## Trigger

Runs automatically after events.

```sql
CREATE TRIGGER log_update
AFTER UPDATE ON users
FOR EACH ROW
EXECUTE FUNCTION log_function();
```

---

# 19. Normalization

Normalization organizes tables to reduce duplication.

Main normal forms:

| Form | Purpose                      |
| ---- | ---------------------------- |
| 1NF  | Atomic values                |
| 2NF  | Remove partial dependency    |
| 3NF  | Remove transitive dependency |

Benefits:

- Cleaner database
- Less duplicate data
- Easier maintenance

---

# 20. Optimization Tips

Ways to improve SQL performance:

- Use indexes wisely
- Avoid SELECT \* in large tables
- Use proper JOINs
- Normalize correctly
- Analyze slow queries
- Use LIMIT when testing
- Index foreign keys

---

# 21. SQL Development Workflow

Typical workflow:

1. Design database
2. Create tables
3. Add relationships
4. Insert sample data
5. Write CRUD queries
6. Use JOINs and analytics
7. Optimize queries
8. Secure and maintain database

---

# 22. Real-World SQL Concepts

Common systems built with SQL:

- E-commerce systems
- Banking systems
- Hospital systems
- School systems
- Inventory management
- Social media platforms

Typical features:

- Authentication
- Orders and payments
- Analytics dashboards
- Reporting systems
- User permissions

---

# 23. Important SQL Keywords

| Keyword  | Purpose           |
| -------- | ----------------- |
| SELECT   | Retrieve data     |
| INSERT   | Add data          |
| UPDATE   | Modify data       |
| DELETE   | Remove data       |
| CREATE   | Create objects    |
| ALTER    | Modify structure  |
| DROP     | Delete objects    |
| JOIN     | Combine tables    |
| GROUP BY | Group rows        |
| ORDER BY | Sort results      |
| LIMIT    | Restrict rows     |
| DISTINCT | Remove duplicates |
| UNION    | Merge results     |

---

# 24. Final Notes

SQL is one of the most important skills in backend development and data engineering. A strong SQL foundation helps developers:

- Build scalable applications
- Design professional databases
- Analyze data efficiently
- Improve system performance
- Work with real-world production systems

Mastering SQL requires:

- Continuous practice
- Building real projects
- Writing complex queries
- Understanding database design
- Learning optimization techniques

The best way to improve is by creating complete projects such as:

- E-commerce database
- Blog system
- Barber appointment system
- School management system
- Finance tracking system

Practice consistently and focus on understanding relationships, normalization, and query optimization.
