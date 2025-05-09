
## Joining tables

In relational databases, data is frequently organized into multiple tables to minimize redundancy and enhance data integrity. This design approach, known as normalization, avoids repeating the same information in different places. However, this means that useful information is often spread across multiple tables.  

Joins are essential SQL operations that bridge this gap, allowing you to combine rows from two or more tables and retrieve related data in a single, unified result set. In essence, joins enable you to query information that is logically connected but physically separated. They achieve this combination by identifying and matching rows based on values found in one or more common columns between the tables. These common columns often serve as the link between a primary key in one table and a foreign key in another, establishing the relationships defined in the database schema. 

Note: A primary key is a unique identifier for each record in a table, ensuring that no two rows have the same value in this column.  A foreign key, on the other hand, is a column in one table that references the primary key in another table, thereby linking the two tables. 

There are multiple 'flavors' of joins (`INNER`, `LEFT`, `RIGHT`, `FULL OUTER`, `NATURAL`), each designed to combine tables in slightly different ways. They provide control over which rows are included in the result set based on the presence or absence of matching values in the joined tables. 

## INNER JOIN

An `INNER JOIN` is one of the most commonly used types of SQL joins. It combines rows from multiple tables based on a condition that specifies matching values in a shared column.

When performing an `INNER JOIN`, only the rows that satisfy the condition from both tables are included in the result set, effectively filtering out any unmatched data. This makes `INNER JOIN` ideal for retrieving related information where connections between tables are explicitly defined, such as customer orders or employee assignments.

```sql
SELECT orders.order_id, customers.customer_name, employees.first_name, employees.last_name 
FROM sales.orders AS orders 
INNER JOIN sales.customers AS customers ON orders.customer_id = customers.customer_id 
INNER JOIN sales.employees AS employees ON orders.employee_id = employees.employee_id;
```

The provided query employs multiple `INNER JOIN` operations to retrieve a unified result set containing details about `orders`, `customers`, and `employees`.  

It matches the `customer_id` in the `orders` table with the corresponding `customer_id` in the `customers` table, and the `employee_id` in the `orders` table with the `employee_id` in the `employees` table. As a result, the query outputs each order's ID alongside the names of the customer and employee involved. 