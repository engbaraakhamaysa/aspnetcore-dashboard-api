# 🧱 Database Design Guide

دليل شامل ومفصل لأساسيات تصميم قواعد البيانات (Database Design) مع شرح المفاهيم المهمة التي يجب فهمها قبل بناء أي مشروع احترافي.

---

# 📌 ما هو Database Design ؟

تصميم قاعدة البيانات هو عملية تنظيم البيانات بطريقة:

- تقلل التكرار (Duplicate Data)
- تجعل البيانات مترابطة بشكل صحيح
- تسهل عمليات البحث والتعديل
- تحسن الأداء
- تجعل المشروع قابل للتوسع مستقبلاً

أي مشروع حقيقي مثل:

- متجر إلكتروني
- نظام مستشفى
- تطبيق حجوزات
- نظام جامعي
- تطبيق بنكي

يعتمد بشكل أساسي على تصميم قاعدة بيانات قوي.

---

# 🧩 أهم مفاهيم Database Design

1. Normalization
2. ERD (Entity Relationship Diagram)
3. Primary Key & Foreign Key
4. Data Modeling
5. Choosing Correct Data Types

---

# 1️⃣ Normalization

## 📌 ما هي Normalization ؟

هي عملية تنظيم الجداول داخل قاعدة البيانات لتقليل:

- تكرار البيانات
- المشاكل أثناء التعديل
- الأخطاء المنطقية

والهدف منها جعل البيانات:

- نظيفة
- مترابطة
- سهلة الإدارة

---

# 🔹 First Normal Form (1NF)

## ✅ القواعد

لكي يكون الجدول في 1NF يجب:

- كل خلية تحتوي قيمة واحدة فقط
- لا يوجد Arrays أو Lists داخل العمود
- كل صف يكون فريد

---

## ❌ مثال خطأ

| id  | name  | phones    |
| --- | ----- | --------- |
| 1   | Ahmad | 0599,0568 |

المشكلة:

العمود يحتوي أكثر من قيمة.

---

## ✅ الحل الصحيح

### users

| id  | name  |
| --- | ----- |
| 1   | Ahmad |

### user_phones

| id  | user_id | phone |
| --- | ------- | ----- |
| 1   | 1       | 0599  |
| 2   | 1       | 0568  |

---

# 🔹 Second Normal Form (2NF)

## ✅ القواعد

لكي يكون الجدول في 2NF:

- يجب أن يكون أصلاً في 1NF
- كل عمود يعتمد على Primary Key بالكامل
- لا يوجد Partial Dependency

---

## ❌ مثال خطأ

### order_items

| order_id | product_id | product_name | quantity |
| -------- | ---------- | ------------ | -------- |
| 1        | 2          | Keyboard     | 3        |

المشكلة:

product_name يعتمد على product_id فقط وليس على المفتاح الكامل.

---

## ✅ الحل الصحيح

### products

| id  | name     |
| --- | -------- |
| 2   | Keyboard |

### order_items

| order_id | product_id | quantity |
| -------- | ---------- | -------- |
| 1        | 2          | 3        |

---

# 🔹 Third Normal Form (3NF)

## ✅ القواعد

لكي يكون الجدول في 3NF:

- يجب أن يكون في 2NF
- لا يوجد Transitive Dependency

يعني:

أي عمود لا يعتمد على عمود غير Primary Key.

---

## ❌ مثال خطأ

| user_id | city_id | city_name |
| ------- | ------- | --------- |
| 1       | 3       | Jenin     |

المشكلة:

city_name يعتمد على city_id وليس على user_id.

---

## ✅ الحل الصحيح

### cities

| id  | name  |
| --- | ----- |
| 3   | Jenin |

### users

| id  | city_id |
| --- | ------- |
| 1   | 3       |

---

# 🎯 فوائد Normalization

- تقليل حجم البيانات
- منع التكرار
- تسهيل التعديل
- منع الأخطاء
- تحسين العلاقات
- تنظيم المشروع

---

# 2️⃣ ERD (Entity Relationship Diagram)

## 📌 ما هو ERD ؟

ERD هو مخطط يوضح:

- الجداول (Entities)
- الأعمدة (Attributes)
- العلاقات (Relationships)

بين الجداول داخل قاعدة البيانات.

---

# 📦 Example

## نظام متجر إلكتروني

### Entities

- users
- products
- orders
- categories
- payments

---

# 🔗 أنواع العلاقات

---

## 1. One To One (1:1)

كل صف يرتبط بصف واحد فقط.

### مثال

- user
- passport

كل مستخدم لديه جواز واحد.

---

## 2. One To Many (1:N)

أكثر علاقة شائعة.

### مثال

- category → products

كل category تحتوي منتجات كثيرة.

---

## 3. Many To Many (N:M)

كل طرف يرتبط بعدة عناصر من الطرف الآخر.

### مثال

- students
- courses

الطالب يسجل عدة مواد.
والمادة فيها عدة طلاب.

نستخدم جدول وسيط:

### student_courses

| student_id | course_id |
| ---------- | --------- |

---

# 🧠 لماذا ERD مهم ؟

- يساعدك تخطط قبل كتابة SQL
- يمنع الأخطاء التصميمية
- يسهل فهم المشروع
- يساعد الفريق بالكامل
- يعطي رؤية واضحة للعلاقات

---

# 3️⃣ Primary Key & Foreign Key

---

# 🔑 Primary Key

## 📌 ما هو ؟

عمود يميز كل صف بشكل فريد.

لا يمكن أن يتكرر.

---

## ✅ مثال

```sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);
```

هنا:

id هو Primary Key.

---

# 🎯 خصائص Primary Key

- Unique
- NOT NULL
- لكل صف قيمة مختلفة
- يستخدم للربط بين الجداول

---

# 🔗 Foreign Key

## 📌 ما هو ؟

عمود يشير إلى Primary Key في جدول آخر.

يستخدم لإنشاء العلاقات.

---

## ✅ مثال

```sql
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,

    user_id INTEGER,

    CONSTRAINT fk_order_user
    FOREIGN KEY (user_id)
    REFERENCES users(id)
);
```

هنا:

user_id مرتبط بجدول users.

---

# 🎯 فوائد Foreign Key

- حماية العلاقات
- منع البيانات الخاطئة
- ضمان التكامل (Data Integrity)
- تنظيم البيانات

---

# 📌 أنواع ON DELETE

---

## CASCADE

عند حذف المستخدم:

يتم حذف جميع الطلبات المرتبطة به.

```sql
ON DELETE CASCADE
```

---

## SET NULL

عند حذف السجل الأساسي:

القيمة تصبح NULL.

```sql
ON DELETE SET NULL
```

---

## RESTRICT

يمنع الحذف إذا توجد بيانات مرتبطة.

```sql
ON DELETE RESTRICT
```

---

# 4️⃣ Data Modeling

## 📌 ما هو Data Modeling ؟

هو عملية تحويل فكرة المشروع إلى:

- جداول
- علاقات
- أعمدة
- قيود

بطريقة منظمة.

---

# 🧠 خطوات Data Modeling

---

## 1. فهم المشروع

مثال:

متجر إلكتروني.

---

## 2. استخراج Entities

مثل:

- users
- products
- orders
- categories
- reviews
- payments

---

## 3. تحديد العلاقات

مثال:

- المستخدم يملك عدة طلبات
- الطلب يحتوي منتجات
- المنتج ينتمي لتصنيف

---

## 4. تحديد الأعمدة

مثال users:

- id
- name
- email
- password
- created_at

---

## 5. تحديد أنواع البيانات

مثال:

- name → VARCHAR
- created_at → TIMESTAMP
- price → DECIMAL

---

# 📦 Example Data Model

## users

| column | type    |
| ------ | ------- |
| id     | SERIAL  |
| name   | VARCHAR |
| email  | VARCHAR |

---

## products

| column | type    |
| ------ | ------- |
| id     | SERIAL  |
| title  | VARCHAR |
| price  | DECIMAL |
| stock  | INTEGER |

---

## orders

| column  | type    |
| ------- | ------- |
| id      | SERIAL  |
| user_id | INTEGER |
| total   | DECIMAL |

---

# 🎯 فوائد Data Modeling

- بناء قاعدة قوية
- تسهيل التطوير
- منع المشاكل المستقبلية
- تحسين الأداء
- وضوح العلاقات

---

# 5️⃣ Choosing Correct Data Types

## 📌 لماذا اختيار Data Type مهم ؟

اختيار نوع بيانات صحيح يؤثر على:

- الأداء
- التخزين
- السرعة
- الدقة
- قابلية التوسع

---

# 🔹 أشهر أنواع البيانات

---

## INTEGER

للأرقام الصحيحة.

```sql
age INTEGER
```

---

## SERIAL

رقم تلقائي Auto Increment.

```sql
id SERIAL PRIMARY KEY
```

---

## VARCHAR

للنصوص القصيرة.

```sql
name VARCHAR(100)
```

---

## TEXT

للنصوص الطويلة.

```sql
description TEXT
```

---

## BOOLEAN

قيم True / False.

```sql
is_active BOOLEAN
```

---

## DECIMAL

للأسعار والقيم المالية.

```sql
price DECIMAL(10,2)
```

---

## TIMESTAMP

للتاريخ والوقت.

```sql
created_at TIMESTAMP
```

---

# ⚠️ أخطاء شائعة

---

## ❌ تخزين السعر بـ FLOAT

قد يسبب مشاكل دقة.

✅ الأفضل:

```sql
DECIMAL(10,2)
```

---

## ❌ استخدام TEXT دائماً

يجعل الأداء أسوأ أحياناً.

استخدم:

- VARCHAR للنصوص القصيرة
- TEXT للنصوص الطويلة

---

## ❌ استخدام VARCHAR للأرقام

مثال:

```sql
phone VARCHAR(20)
```

هذا صحيح لأن رقم الهاتف ليس قيمة حسابية.

لكن:

```sql
price VARCHAR(50)
```

هذا خطأ.

---

# 🎯 قواعد مهمة في Database Design

---

## ✅ لا تكرر البيانات

بدلاً من:

```text
category_name
```

استخدم:

```text
category_id
```

---

## ✅ استخدم Foreign Keys

لحماية العلاقات.

---

## ✅ سمّي الجداول بشكل واضح

```text
users
products
order_items
```

---

## ✅ استخدم أسماء مفهومة

```text
created_at
updated_at
```

---

## ✅ أضف Constraints

مثل:

```sql
UNIQUE
NOT NULL
CHECK
DEFAULT
```

---

# 📌 Example Professional Table

```sql
CREATE TABLE products (
    id SERIAL PRIMARY KEY,

    title VARCHAR(255) NOT NULL,

    description TEXT,

    price DECIMAL(10,2) NOT NULL,

    stock INTEGER DEFAULT 0,

    is_active BOOLEAN DEFAULT TRUE,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

---

# 🚀 الخلاصة

لكي تصبح محترف Database Design يجب أن تفهم:

- كيف تنظّم البيانات
- كيف تبني العلاقات
- كيف تمنع التكرار
- كيف تختار Data Types الصحيحة
- كيف تبني ERD احترافي
- كيف تطبق Normalization

---

# 📚 ماذا تتعلم بعد ذلك ؟

بعد فهم Database Design انتقل إلى:

1. Advanced SQL
2. Indexes
3. Query Optimization
4. Transactions
5. Views
6. Materialized Views
7. Triggers
8. Functions
9. Database Security
10. Scaling Databases

---

# 🏁 النهاية

إذا فهمت هذه المفاهيم بشكل ممتاز ستكون قادر على:

- تصميم أي Database
- بناء Backend احترافي
- فهم Architecture المشاريع الكبيرة
- كتابة SQL بشكل احترافي
- العمل على مشاريع حقيقية
