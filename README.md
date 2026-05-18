# 🛒 E-Commerce Database Project (PostgreSQL)

## 📌 Overview

This project is a fully designed relational database for an E-Commerce system built using PostgreSQL.  
It follows best practices in database design including normalization, relationships, and indexing.

The system simulates a real-world online store including users, products, orders, payments, shipping, and advanced features like cart, wishlist, and reviews.

---

## 🧠 Features

- 👤 User management (customers & admins)
- 📦 Product catalog with categories
- 🗂️ Hierarchical categories (subcategories supported)
- 🛒 Order management system
- 📄 Order items (detailed purchase records)
- 💰 Payment system
- 🚚 Shipment tracking system
- ❤️ Wishlist feature
- 🛍️ Shopping cart system
- ⭐ Product reviews & ratings
- 📸 Product image management
- ⚡ Database indexes for performance optimization

---

## 🧱 Database Tables

- users
- categories
- products
- orders
- order_items
- payments
- shipments
- wishlist
- cart
- reviews
- product_images

---

## 🔗 Relationships

- Users 1 → N Orders
- Users 1 → N Reviews
- Users N ↔ N Products (Wishlist / Cart)

- Categories 1 → N Products
- Categories (self-referencing via parent_id)

- Orders 1 → N OrderItems
- Orders 1 → 1 Payments
- Orders 1 → 1 Shipments

- Products 1 → N OrderItems
- Products 1 → N Reviews
- Products 1 → N Images

---

## ⚙️ Technologies Used

- PostgreSQL
- SQL (DDL & DML)
- Relational Database Design
- Indexing for optimization

---

## 🚀 Performance Optimization

Indexes added on:

- users.email
- products.category_id
- orders.user_id
- order_items.order_id
- reviews.product_id

---

## 📊 Project Goal

This project was built for learning and demonstrating:

- Advanced relational database design
- Real-world e-commerce system modeling
- Proper use of foreign keys and normalization
- Scalable database structure

---

## 👨‍💻 Author

Baraa - Computer Systems Engineering Student

# SQL Relationships Examples

## 1) One To One (1:1)

A single record is related to only one record.

Example:

- One User → One Profile

```sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE profiles (
    id SERIAL PRIMARY KEY,

    user_id INTEGER UNIQUE,

    bio TEXT,

    FOREIGN KEY (user_id)
    REFERENCES users(id)
);
```

---

## 2) One To Many (1:M)

One record can have many related records.

Example:

- One Category → Many Products

```sql
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),

    category_id INTEGER,

    FOREIGN KEY (category_id)
    REFERENCES categories(id)
);
```

---

## 3) Many To One (M:1)

Many records belong to one record.

Example:

- Many Employees → One Department

```sql
CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),

    department_id INTEGER,

    FOREIGN KEY (department_id)
    REFERENCES departments(id)
);
```

---

## 4) Many To Many (M:M)

Many records are related to many records.

Example:

- Many Students ↔ Many Courses

```sql
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE courses (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100)
);

CREATE TABLE student_courses (
    student_id INTEGER,
    course_id INTEGER,

    PRIMARY KEY (student_id, course_id),

    FOREIGN KEY (student_id)
    REFERENCES students(id),

    FOREIGN KEY (course_id)
    REFERENCES courses(id)
);
```

---

# Summary

| Relationship | Example                |
| ------------ | ---------------------- |
| One To One   | User ↔ Profile         |
| One To Many  | Category → Products    |
| Many To One  | Employees → Department |
| Many To Many | Students ↔ Courses     |
