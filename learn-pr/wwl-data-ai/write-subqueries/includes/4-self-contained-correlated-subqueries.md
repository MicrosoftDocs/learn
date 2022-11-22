Previously, we looked at self-contained subqueries; in which the inner query is independent of the outer query, executes once, and returns its results to the outer query. T-SQL also supports *correlated* subqueries, in which the inner query references column in the outer query and conceptually executes once per row.

## Working with correlated subqueries

Like self-contained subqueries, correlated subqueries are SELECT statements nested within an outer query. Correlated subqueries may also be either scalar or multi-valued subqueries. They're typically used when the inner query needs to reference a value in the outer query.

However, unlike self-contained subqueries, there are some special considerations when using correlated subqueries:

 *  Correlated subqueries cannot be executed separately from the outer query. This restriction complicates testing and debugging.
 *  Unlike self-contained subqueries, which are processed once, correlated subqueries will run multiple times. Logically, the outer query runs first, and for each row returned, the inner query is processed.

The following example uses a correlated subquery to return the most recent order for each customer. The subquery refers to the outer query and references its **CustomerID** value in its WHERE clause. For each row in the outer query, the subquery finds the maximum order ID for the customer referenced in that row, and the outer query checks to see if the row it’s looking at is the row with that order ID.

```sql
SELECT SalesOrderID, CustomerID, OrderDate
FROM SalesLT.SalesOrderHeader AS o1
WHERE SalesOrderID =
    (SELECT MAX(SalesOrderID)
     FROM SalesLT.SalesOrderHeader AS o2
     WHERE o2.CustomerID = o1.CustomerID)
ORDER BY CustomerID, OrderDate;
```

### Writing correlated subqueries

To write correlated subqueries, consider the following guidelines:

 *  Write the outer query to accept the appropriate return result from the inner query. If the inner query is scalar, you can use equality and comparison operators, such as =, &lt;, &gt;, and &lt;&gt;, in the WHERE clause. If the inner query might return multiple values, use an IN predicate. Plan to handle NULL results.
 *  Identify the column from the outer query that will be referenced by the correlated subquery. Declare an alias for the table that is the source of the column in the outer query.
 *  Identify the column from the inner table that will be compared to the column from the outer table. Create an alias for the source table, as you did for the outer query.
 *  Write the inner query to retrieve values from its source, based on the input value from the outer query. For example, use the outer column in the WHERE clause of the inner query.

The correlation between the inner and outer queries occurs when the outer value is referenced by the inner query for comparison. It’s this correlation that gives the subquery its name.

### Working with EXISTS

In addition to retrieving values from a subquery, T-SQL provides a mechanism for checking whether any results would be returned from a query. The EXISTS predicate determines whether any rows meeting a specified condition exist, but rather than return them, it returns TRUE or FALSE. This technique is useful for validating data without incurring the overhead of retrieving and processing the results.

When a subquery is related to the outer query using the EXISTS predicate, SQL Server handles the results of the subquery in a special way. Rather than retrieve a scalar value or a multi-valued list from the subquery, EXISTS simply checks to see if there are any rows in the result.

Conceptually, an EXISTS predicate is equivalent to retrieving the results, counting the rows returned, and comparing the count to zero. Compare the following queries, which will return details about customers who have placed orders:

The first example query uses COUNT in a subquery:

```sql
SELECT CustomerID, CompanyName, EmailAddress 
FROM Sales.Customer AS c 
WHERE
(SELECT COUNT(*) 
  FROM Sales.SalesOrderHeader AS o
  WHERE o.CustomerID = c.CustomerID) > 0;
```

The second query, which returns the same results, uses EXISTS:

```sql
SELECT CustomerID, CompanyName, EmailAddress 
FROM Sales.Customer AS c 
WHERE EXISTS
(SELECT * 
  FROM Sales.SalesOrderHeader AS o
  WHERE o.CustomerID = c.CustomerID);
```

In the first example, the subquery must count every occurrence of each *custid* found in the **Sales.SalesOrderHeader** table, and compare the count results to zero, simply to indicate that the customer has placed orders.

In the second query, EXISTS returns TRUE for a **custid** as soon as a relevant order has been found in the **Sales.SalesOrderHeader** table. A complete accounting of each occurrence is unnecessary. Also note that with the EXISTS form, the subquery is not restricted to returning a single column. Here, we have SELECT \*. The returned columns are irrelevant because we’re only checking if any rows are returned at all, not what values are in those rows.

From the perspective of logical processing, the two query forms are equivalent. From a performance perspective, the database engine may treat the queries differently as it optimizes them for execution. Consider testing each one for your own usage.

> [!NOTE]
> If you're converting a subquery using COUNT(\*) to one using EXISTS, make sure the subquery uses a SELECT \* and not SELECT COUNT(\*). SELECT COUNT(\*) **always** returns a row, so the EXISTS will always return **TRUE.**

Another useful application of EXISTS is negating the subquery with NOT, as in the following example, which will return any customer who has never placed an order:

```sql
SELECT CustomerID, CompanyName, EmailAddress 
FROM SalesLT.Customer AS c 
WHERE NOT EXISTS
  (SELECT * 
   FROM SalesLT.SalesOrderHeader AS o
   WHERE o.CustomerID = c.CustomerID);
```

SQL Server won't have to return data about the related orders for customers who have placed orders. If a **custid** is found in the **Sales.SalesOrderHeader** table, NOT EXISTS evaluates to FALSE and the evaluation quickly completes.

To write queries that use EXISTS with subqueries, consider the following guidelines:

 *  The keyword EXISTS directly follows WHERE. No column name (or other expression) precedes it, unless NOT is also used.
 *  Within the subquery, use SELECT \*. No rows are returned by the subquery, so no columns need to be specified.
