## Querying all columns from a table

```sql
SELECT * FROM sales.customers;
```

This query retrieves all rows and columns from the `sales.customers` table. However, querying all columns isn't required and is a costly operation. For best performance, only select the necessary columns.

Selecting specific columns is more efficient because it reduces the amount of data transmitted and processed. When you query all columns from a table, the database retrieves every piece of information regardless of whether it's needed. This increases the load on both the database server and the network, as more data has to be fetched, stored in memory, and transmitted to the client.

## Querying specific columns

```sql
SELECT customer_name, city, country FROM sales.customers;
```

This query retrieves only the `customer_name`, `city`, and `country` columns from the `sales.customers` table.

## Querying distinct values

```sql
SELECT DISTINCT country FROM sales.customers;
```

The `DISTINCT` keyword in SQL is used to ensure that the result of a query contains only unique values for a specified column or combination of columns, eliminating any duplicate entries.  
In this query, the `DISTINCT` keyword retrieves a list of all unique countries from the `sales.customers` table, filtering out any repeated entries for countries that appear multiple times in the table.
