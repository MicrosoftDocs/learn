Instead of retrieving individual rows, you frequently need to summarize data to understand trends or patterns. Aggregate functions are designed for this purpose, allowing you to perform calculations on a group of rows and return a single result. Common examples include determining the total sales, the average price of products, or the number of orders placed. These functions are fundamental tools for data analysis in SQL.
Examples of aggregate functions include `COUNT` to count rows, `SUM` to calculate totals, `AVG` for averages, `MIN` to find the smallest value, and `MAX` to find the largest value in a dataset.

## COUNT

`COUNT` is commonly used to quickly get an overview of the volume of data in a table, such as the total number of orders placed in a `sales` dataset.

```sql
SELECT COUNT(*) FROM sales.orders;
```
The result of this query is a single numeric value representing the total number of orders (or rows) present in the `sales.orders` table.

```sql
SELECT COUNT(DISTINCT country) FROM sales.customers;
```
This SQL query uses the `COUNT` function along with the `DISTINCT` keyword to determine the number of unique countries present in the `country` column of the `sales.customers` table. Essentially, it counts each distinct `country` only once, providing a numerical result that represents the total number of different countries in the dataset.

## SUM

`SUM` is a versatile aggregate function widely used for calculating the total sum of values in a numeric column. Whether you're analyzing financial data or evaluating inventory quantities, `SUM` provides a straightforward way to aggregate numbers across multiple rows in a table.

```sql
SELECT SUM(price) FROM sales.products;
```
This query calculates the total sum of all values in the `price` column of the `sales.products` table. It aggregates the prices of multiple rows into a single numeric result, representing the total cost of all products.

## AVG

The `AVG` function is an essential SQL aggregate function designed to calculate the arithmetic mean of numeric values within a column. Whether you're dealing with product prices, employee salaries, or exam scores, `AVG` enables you to summarize data efficiently by returning a single value that represents the average of all rows in the specified dataset.

```sql
SELECT AVG(price) FROM sales.products;
```
This query is designed to calculate the average `price` of all products listed in the `sales.products` table. By using the `AVG` function, it computes the arithmetic mean of the values in the `price` column, effectively summarizing the dataset into a single representative value.

## MAX and MIN

The `MAX` and `MIN` functions are aggregate functions used to identify the highest and lowest numeric values within a column.

```sql
SELECT MAX(price), MIN(price) FROM sales.products;
```
This query retrieves two values: the highest `price` and the lowest `price` among all products listed in the `sales.products` table.
