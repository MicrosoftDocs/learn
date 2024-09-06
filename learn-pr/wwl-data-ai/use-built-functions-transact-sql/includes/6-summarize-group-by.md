While aggregate functions are useful for analysis, you may wish to arrange your data into subsets before summarizing it. In this section, you will learn how to accomplish this using the GROUP BY clause.

## Using the GROUP BY clause

As you've learned, when your SELECT statement is processed, after the FROM clause and WHERE clause have been evaluated, a virtual table is created. The contents of the virtual table are now available for further processing. You can use the GROUP BY clause to subdivide the contents of this virtual table into groups of rows.

To group rows, specify one or more elements in the GROUP BY clause:

```sql
GROUP BY <value1> [, <value2>, …]
```

GROUP BY creates groups and places rows into each group as determined by the elements specified in the clause.

For example, the following query will result in a set of grouped rows, one row per **CustomerID** in the **Sales.SalesOrderHeader** table. Another way of looking at the GROUP BY process, is that all rows with the same value for **CustomerID** will be grouped together and returned in a single result row.

```sql
SELECT CustomerID
FROM Sales.SalesOrderHeader
GROUP BY CustomerID;
```

The query above is equivalent to the following query:

```sql
SELECT DISTINCT CustomerID
FROM Sales.SalesOrderHeader
```

After the GROUP BY clause has been processed and each row has been associated with a group, later phases of the query must aggregate any elements of the source rows that are in the SELECT list but that don't appear in the GROUP BY list. This requirement will have an impact on how you write your SELECT and HAVING clauses.

So, what’s the difference between writing the query with a GROUP BY or a DISTINCT? If all you want to know is the distinct values for **CustomerID**, there is no difference. But with GROUP BY, we can add other elements to the SELECT list that are then aggregated for each group.

The simplest aggregate function is COUNT(\*). The following query takes the original 830 source rows from **CustomerID** and groups them into 89 groups, based on the **CustomerID** values. Each distinct **CustomerID** value generates one row of output in the GROUP BY query

```sql
SELECT CustomerID, COUNT(*) AS OrderCount
FROM Sales.SalesOrderHeader
GROUP BY CustomerID;
```

For each **CustomerID** value, the query aggregates and counts the rows, so we result shows us how many rows in the **SalesOrderHeader** table belong to each customer.

:::row:::
  :::column:::
    CustomerID
  :::column-end:::
  :::column:::
    OrderCount
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    1234
  :::column-end:::
  :::column:::
    3
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    1005
  :::column-end:::
  :::column:::
    1
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
:::row-end:::

Note that GROUP BY does not guarantee the order of the results. Often, as a result of the way the grouping operation is performed by the query processor, the results are returned in the order of the group values. However, you should not rely on this behavior. If you need the results to be sorted, you must explicitly include an ORDER clause:

```sql
SELECT CustomerID, COUNT(*) AS OrderCount
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
ORDER BY CustomerID;
```

This time, the results are returned in the specified order:

:::row:::
  :::column:::
    CustomerID
  :::column-end:::
  :::column:::
    OrderCount
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    1005
  :::column-end:::
  :::column:::
    1
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    1234
  :::column-end:::
  :::column:::
    3
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
:::row-end:::

The clauses in a SELECT statement are applied in the following order:

1.  FROM
2.  WHERE
3.  GROUP BY
4.  HAVING
5.  SELECT
6.  ORDER BY

Column aliases are assigned in the SELECT clause, which occurs *after* the GROUP BY clause but *before* the ORDER BY clause. You can reference a column alias in the ORDER BY clause, but not in the GROUP BY clause. The following query will result in an *invalid column name* error:

```sql
SELECT CustomerID AS Customer,
       COUNT(*) AS OrderCount
FROM Sales.SalesOrderHeader
GROUP BY Customer
ORDER BY Customer;
```

However, the following query will succeed, grouping and sorting the results by the customer ID.

```sql
SELECT CustomerID AS Customer,
       COUNT(*) AS OrderCount
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
ORDER BY Customer;
```

## Troubleshooting GROUP BY errors

A common obstacle to becoming comfortable with using GROUP BY in SELECT statements is understanding why the following type of error message occurs:

> Msg 8120, Level 16, State 1, Line 2 Column &lt;column\_name&gt; is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.

For example, the following query is permitted because each column in the SELECT list is either a column in the GROUP BY clause or an aggregate function operating on each group:

```sql
SELECT CustomerID, COUNT(*) AS OrderCount
FROM Sales.SalesOrderHeader
GROUP BY CustomerID;
```

The following query will return an error because **PurchaseOrderNumber** isn't part of the GROUP BY, and it isn't used with an aggregate function.

```sql
SELECT CustomerID, PurchaseOrderNumber, COUNT(*) AS OrderCount
FROM Sales.SalesOrderHeader
GROUP BY CustomerID;
```

This query returns the error:

```
Msg 8120, Level 16, State 1, Line 1
Column 'Sales.SalesOrderHeader.PurchaseOrderNumber' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.
```

Here’s another way to think about it. This query returns one row for each **CustomerID** value. But rows for the same **CustomerID** can have different **PurchaseOrderNumber** values, so which of the values is the one that should be returned?

If you want to see orders per customer ID and per purchase order, you can add the **PurchaseOrderNumber** column to the GROUP BY clause, as follows:

```sql
SELECT CustomerID, PurchaseOrderNumber, COUNT(*) AS OrderCount
FROM Sales.SalesOrderHeader
GROUP BY CustomerID, PurchaseOrderNumber;
```

This query will return one row for each customer and each purchase order combination, along with the count of orders for that combination.
