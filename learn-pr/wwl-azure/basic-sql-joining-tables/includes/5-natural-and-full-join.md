# FULL OUTER JOIN

A FULL OUTER JOIN, also referred to as a FULL JOIN, combines the characteristics of both LEFT JOIN and RIGHT JOIN, including all rows from both tables in the result set. 
If there is a matching row between the tables based on the `ON` clause, the columns from both tables are populated. However, if a row in one table does not have a match in the other table, the columns from the unmatched table will display null values.

```sql
SELECT customers.customer_name, orders.order_id
FROM sales.customers AS customers
FULL OUTER JOIN sales.orders AS orders ON customers.customer_id = orders.customer_id;
```

This query combines all rows from both the `sales.customers` and `sales.orders` tables, ensuring no data is excluded from either side. The `ON` clause establishes the relationship between the two tables by matching the `customer_id` column.  
If a row in one table has no corresponding match in the other table, the unmatched columns will return null values.  
You would use this approach for a comprehensive view of all customers and orders, including scenarios where one does not have an associated record in the other. 


# NATURAL JOIN

NATURAL JOIN is a type of SQL join that simplifies the process of combining tables by automatically matching columns with the same name and compatible data types from both tables.
Unlike explicit joins, where the relationship between tables is defined using an `ON` clause, NATURAL JOIN relies on column names to identify shared attributes. It ensures that only rows with identical values in the matched columns are included in the result set, effectively filtering out mismatches.

This approach is particularly useful when the tables being joined have clearly defined relationships and matching column names, as it reduces the need for manual specification of join conditions. 
However, users must exercise caution, as relying purely on column names can lead to unintended results if the tables contain columns with identical names but unrelated data. 

```sql
SELECT c.customer_name, o.order_id
FROM sales.customers AS c
NATURAL JOIN sales.orders AS o;
```

This query combines the `sales.customers` and `sales.orders` tables by automatically matching columns with the same name and compatible data types, such as `customer_id`.  

