To gain deeper insights and better organize data within a database, SQL introduces the powerful `GROUP BY` and `HAVING` clauses.  
These tools allow you to transform raw data into meaningful summaries by categorizing rows and applying aggregate functions, making it easier to analyze trends, identify patterns, or generate reports tailored to specific categories.

## GROUP BY

To analyze data by category or group, SQL provides the `GROUP BY` clause. This clause categorizes rows based on the values in specified columns, effectively partitioning the data into subsets.

The real power of `GROUP BY` is revealed when it's used with aggregate functions. Aggregate functions, such as `COUNT()`, `SUM()`, `AVG()`,`MIN()` and `MAX()` perform calculations on these groups, allowing you to generate summary statistics for each category.

For example, you could use GROUP BY to calculate:
    -total sales `SUM()` for each product category,
    -average price `AVG()` of products from each supplier,
    -number of customers `COUNT()` in each city.

```sql
SELECT category_id, AVG(price)
FROM sales.products
GROUP BY category_id;
```
This query retrieves the average price of products within each category by grouping the rows of the `sales.products` table according to their `category_id`. By applying the `AVG()` function to the `price` column, the query calculates the mean value of prices for all products under every distinct `category_id`.

`GROUP BY` clause doesn't always need to be paired with aggregate functions. While it's commonly used alongside aggregate functions to perform calculations on grouped data, `GROUP BY` can also be used by itself to organize data into groups for other purposes, such as retrieving distinct combinations of columns.

```sql
SELECT category_id
FROM sales.products
GROUP BY category_id;
```
This query groups the rows by `category_id` without performing any aggregation, simply listing each distinct `category_id` present in the `sales.products` table.

## HAVING

In SQL, the `WHERE` clause can't be used to filter the results of aggregate functions.  
To filter groups created by the `GROUP BY` clause based on aggregate function results, you use the `HAVING` clause.  
Think of `HAVING` as a `WHERE` clause for groups: it allows you to apply conditions to the summarized data produced by aggregate functions, enabling you to refine your analysis to focus on relevant groups.

```sql
SELECT category_id, AVG(price)
FROM sales.products
GROUP BY category_id
HAVING AVG(price) > 30;
```
This query calculates the average `price` of products within each category by grouping rows of the `sales.products` table according to their `category_id`. It then filters the results to include only those categories where the average `price` exceeds 30 using the `HAVING` clause.
