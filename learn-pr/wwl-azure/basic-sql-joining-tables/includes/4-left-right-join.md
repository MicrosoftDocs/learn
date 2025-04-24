
## LEFT JOIN

A LEFT JOIN, also known as a LEFT OUTER JOIN, is a type of SQL operation that preserves all the rows from the left-hand (or first) table in the query, regardless of whether there is a matching row in the right-hand (or second) table.
When a match is found, the columns from the right table are populated with the corresponding values. However, if no match exists, the result will include nulls in the columns originating from the right table. 
This is particularly useful when you need to create a comprehensive list from one table while appending related data from another, even when such relationships are incomplete or absent. 

```sql
SELECT customers.customer_name, orders.order_id
FROM sales.customers AS customers
LEFT JOIN sales.orders AS orders ON customers.customer_id = orders.customer_id;
```

The SQL query using a LEFT JOIN retrieves all customers from the `sales.customers` table, including those without any matching orders in the `sales.orders` table. The `ON` clause specifies that the `customer_id` field links the two tables.  
For customers who have placed orders, the `order_id` from the `orders` table is displayed. However, if a customer does not have any orders, the result still includes the customer, with the `order_id` column displaying null values.  


## RIGHT JOIN

A RIGHT JOIN, also known as a RIGHT OUTER JOIN, is an SQL operation that ensures all rows from the right-hand (or second) table are included in the result, regardless of whether there is a matching row in the left-hand (or first) table. 
In cases where no match is found, the columns from the left table display null values.
This type of join is commonly used to focus on the data in the right table while also appending information from the left table wherever relationships exist.


```sql
SELECT customers.customer_name, orders.order_id
FROM sales.customers AS customers
RIGHT JOIN sales.orders AS orders ON customers.customer_id = orders.customer_id;
```

This query retrieves all rows from the `sales.orders` table, ensuring that every order is included in the result, even if there is no associated entry in the `sales.customers` table.  
The `ON` clause specifies the relationship between the two tables via the `customer_id` column. If an order has a corresponding customer, the `customer_name` column is populated with the customer’s name; otherwise, null values are displayed for unmatched records.  