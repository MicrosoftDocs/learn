A scalar subquery is an inner SELECT statement within an outer query, written to return a single value. Scalar subqueries might be used anywhere in an outer T-SQL statement where a single-valued expression is permitted—such as in a SELECT clause, a WHERE clause, a HAVING clause, or even a FROM clause. They can also be used in data modification statements, such as UPDATE or DELETE.

Multi-valued subqueries, as the name suggests, can return more than one row. However they still return a single column.

## Scalar subqueries

Suppose you want to retrieve the details of the last order that was placed, on the assumption that it is the one with the highest **SalesOrderID** value.

To find the highest **SalesOrderID** value, you might use the following query:

```sql
SELECT MAX(SalesOrderID)
FROM Sales.SalesOrderHeader
```

This query returns a single value that indicates the highest value for an **OrderID** in the **SalesOrderHeader** table.

To get the details for this order, you might need to filter the **SalesOrderDetails** table based on whatever value is returned by the query above. You can accomplish this task by nesting the query to retrieve the maximum **SalesOrderID** within the WHERE clause of a query that retrieves the order details.

```sql
SELECT SalesOrderID, ProductID, OrderQty
FROM Sales.SalesOrderDetail
WHERE SalesOrderID = 
   (SELECT MAX(SalesOrderID)
    FROM Sales.SalesOrderHeader);
```

To write a scalar subquery, consider the following guidelines:

 *  To denote a query as a subquery, enclose it in parentheses.
 *  Multiple levels of subqueries are supported in Transact-SQL. In this module, we'll only consider two-level queries (one inner query within one outer query), but up to 32 levels are supported.
 *  If the subquery returns no rows (an empty set), the result of the subquery is a NULL. If it is possible in your scenario for no rows to be returned, you should ensure your outer query can gracefully handle a NULL, in addition to other expected results.
 *  The inner query should generally return a single column. Selecting multiple columns in a subquery is almost always an error. The only exception is if the subquery is introduced with the EXISTS keyword.

A scalar subquery can be used anywhere in a query where a value is expected, including the SELECT list. For example, we could extend the query that retrieved details for the most recent order to include the average quantity of items that is ordered, so we can compare the quantity ordered in the most recent order with the average for all orders.

```sql
SELECT SalesOrderID, ProductID, OrderQty,
    (SELECT AVG(OrderQty)
     FROM SalesLT.SalesOrderDetail) AS AvgQty
FROM SalesLT.SalesOrderDetail
WHERE SalesOrderID = 
    (SELECT MAX(SalesOrderID)
     FROM SalesLT.SalesOrderHeader);
```

## Multi-valued subqueries

A multi-valued subquery is well suited to return results using the IN operator. The following hypothetical example returns the **CustomerID**, **SalesOrderID** values for all orders placed by customers in Canada.

```sql
SELECT CustomerID, SalesOrderID
FROM Sales.SalesOrderHeader
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Sales.Customer
    WHERE CountryRegion = 'Canada');
```

In this example, if you were to execute only the inner query, a column of **CustomerID** values would be returned, with a row for each customer in Canada.

In many cases, multi-valued subqueries can easily be written using joins. For example, here's a query that uses a join to return the same results as the previous example:

```sql
SELECT c.CustomerID, o.SalesOrderID
FROM Sales.Customer AS c
JOIN Sales.SalesOrderHeader AS o
    ON c.CustomerID = o.CustomerID
WHERE c.CountryRegion = 'Canada';
```

So how do you decide whether to write a query involving multiple tables as a JOIN or with a subquery? Sometimes, it just depends on what you’re more comfortable with. Most nested queries that are easily converted to JOINs will actually BE converted to a JOIN internally. For such queries, there is then no real difference in writing the query one way vs another.

One restriction you should keep in mind is that when using a nested query, the results returned to the client can only include columns from the outer query. So if you need to return columns from both tables, you should write the query using a JOIN.

Finally, there are situations where the inner query needs to perform much more complicated operations than the simple retrievals in our examples. Rewriting complex subqueries using a JOIN can be difficult. Many SQL developers find subqueries work best for complicated processing because it allows you to break down the processing into smaller steps.
