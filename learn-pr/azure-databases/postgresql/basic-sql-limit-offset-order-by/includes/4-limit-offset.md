When dealing with large datasets, it's often necessary to retrieve only a portion of the results.

The `LIMIT` clause allows you to specify the maximum number of rows to return, preventing overwhelming your application or user.

`OFFSET` is used with `LIMIT` to navigate through these results, enabling you to retrieve 'pages' of data. This is valuable for applications that display data in chunks, such as web pages or reports, and for performance optimization when you only need a sample of the data.

## Limiting the number of rows returned

```sql
SELECT product_name, price FROM sales.products
LIMIT 10;
```

This query retrieves the first 10 products from the table.
The `LIMIT` clause in SQL is a powerful tool for controlling the number of records displayed in query results, enabling efficient data handling and focused analysis.

## Using OFFSET to skip rows

```sql
SELECT * FROM sales.products
LIMIT 10 OFFSET 20;
```

This query retrieves 10 products, starting from the 21st row.
It's important to note that the rows returned might not always be consistent across multiple executions, unless an `ORDER BY` clause is used to ensure a specific sequence, assuming the data in the table remains unchanged.  
The sequence can vary based on factors like how the database engine processes queries or changes in the underlying table data.
