Analytical queries often require calculations that span multiple rows while still returning individual row details. Traditional aggregate functions collapse rows into groups, losing row-level information. Window functions solve this challenge by performing calculations across a set of rows related to the current row, without collapsing the result set.

## Understand window function syntax

Window functions calculate values across a "window" of rows defined by the `OVER` clause. Unlike regular aggregate functions, window functions don't group rows into a single output row. Instead, they compute values across related rows while preserving all original rows in the result.

The general syntax for a window function is:

```
function_name(arguments) OVER (
    [PARTITION BY partition_expression]
    [ORDER BY order_expression [ASC | DESC]]
    [ROWS | RANGE frame_specification]
)
```

The `OVER` clause components control how the window is defined:

- **PARTITION BY**: Divides rows into groups (partitions) for the calculation
- **ORDER BY**: Determines the logical order of rows within each partition
- **ROWS/RANGE**: Defines the frame boundaries relative to the current row

The following query demonstrates a simple window function that calculates a running total of order amounts per customer:

```sql
SELECT 
    CustomerID,
    SalesOrderID,
    OrderDate,
    TotalDue,
    SUM(TotalDue) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS RunningTotal
FROM SalesLT.SalesOrderHeader
ORDER BY CustomerID, OrderDate;
```

> [!NOTE]
> When you specify `ORDER BY` in the `OVER` clause without a frame specification, the default frame is `RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` for aggregate functions. This creates cumulative calculations.

## Use ranking functions

Ranking functions assign sequential numbers to rows based on their position within a partition. SQL Server provides four ranking functions. Each function handles ties differently:

**`ROW_NUMBER()`** assigns a unique sequential number to each row, with no duplicates even for tied values:

```sql
SELECT 
    ProductID,
    Name,
    ListPrice,
    ROW_NUMBER() OVER (ORDER BY ListPrice DESC) AS PriceRank
FROM SalesLT.Product
WHERE ListPrice > 0;
```

The result set looks like this:

```
ProductID   Name                        ListPrice   PriceRank
---------   -------------------------   ---------   ---------
749         Road-150 Red, 62            3578.27     1
750         Road-150 Red, 44            3578.27     2
751         Road-150 Red, 48            3578.27     3
771         Mountain-100 Silver, 38     3399.99     4
```

This query ranks all products by price from highest to lowest. Each product receives a unique number regardless of whether multiple products share the same price.

**`RANK()`** assigns the same rank to tied values, then skips numbers to account for the ties:

```sql
SELECT 
    ProductID,
    Name,
    ListPrice,
    RANK() OVER (ORDER BY ListPrice DESC) AS PriceRank
FROM SalesLT.Product
WHERE ListPrice > 0;
```

The result set looks like this:

```
ProductID   Name                        ListPrice   PriceRank
---------   -------------------------   ---------   ---------
749         Road-150 Red, 62            3578.27     1
750         Road-150 Red, 44            3578.27     1
751         Road-150 Red, 48            3578.27     1
771         Mountain-100 Silver, 38     3399.99     4
```

When two products have identical prices, both receive the same rank. The next product's rank reflects the total number of products ranked higher, creating gaps in the sequence.

**`DENSE_RANK()`** assigns the same rank to tied values but doesn't skip numbers:

```sql
SELECT 
    ProductID,
    Name,
    ListPrice,
    DENSE_RANK() OVER (ORDER BY ListPrice DESC) AS PriceRank
FROM SalesLT.Product
WHERE ListPrice > 0;
```

The result set looks like this:

```
ProductID   Name                        ListPrice   PriceRank
---------   -------------------------   ---------   ---------
749         Road-150 Red, 62            3578.27     1
750         Road-150 Red, 44            3578.27     1
751         Road-150 Red, 48            3578.27     1
771         Mountain-100 Silver, 38     3399.99     2
```

Like `RANK()`, tied values share the same rank. However, `DENSE_RANK()` continues with the next consecutive number, so you can use it to count distinct price levels.

**`NTILE(n)`** distributes rows into a specified number of roughly equal groups:

```sql
SELECT 
    ProductID,
    Name,
    ListPrice,
    NTILE(4) OVER (ORDER BY ListPrice DESC) AS PriceQuartile
FROM SalesLT.Product
WHERE ListPrice > 0;
```

The result set looks like this:

```
ProductID   Name                          ListPrice   PriceQuartile
---------   ---------------------------   ---------   -------------
749         Road-150 Red, 62              3578.27     1
771         Mountain-100 Silver, 38       3399.99     1
722         LL Road Frame - Black, 58     337.22      2
859         Half-Finger Gloves, S         24.49       4
```

This query divides products into four groups based on price. The highest-priced products are in quartile 1, and the lowest-priced are in quartile 4. Use `NTILE()` for percentile analysis or distributing work evenly.

Combining `PARTITION BY` with ranking functions enables per-group rankings:

```sql
SELECT 
    pc.Name AS Category,
    p.Name AS Product,
    p.ListPrice,
    ROW_NUMBER() OVER (
        PARTITION BY p.ProductCategoryID 
        ORDER BY p.ListPrice DESC
    ) AS CategoryPriceRank
FROM SalesLT.Product AS p
INNER JOIN SalesLT.ProductCategory AS pc
    ON p.ProductCategoryID = pc.ProductCategoryID
WHERE p.ListPrice > 0;
```

The result set looks like this:

```
Category          Product                     ListPrice   CategoryPriceRank
---------------   -------------------------   ---------   -----------------
Road Bikes        Road-150 Red, 62            3578.27     1
Road Bikes        Road-150 Red, 44            3578.27     2
Mountain Bikes    Mountain-100 Silver, 38     3399.99     1
Mountain Bikes    Mountain-100 Black, 38      3374.99     2
```

This query ranks products within each category separately. The ranking restarts at 1 for each category, so you can identify the most expensive product in each category by filtering for `CategoryPriceRank = 1`.

> [!TIP]
> Use `ROW_NUMBER()` when you need exactly one row per rank (such as finding the top N per group). Use `RANK()` or `DENSE_RANK()` when you need to preserve tie information for reporting purposes.

## Apply aggregate window functions

Standard aggregate functions like `SUM`, `AVG`, `COUNT`, `MIN`, and `MAX` can be used as window functions by adding the `OVER` clause. This allows you to calculate aggregates while retaining individual row details.

The following query demonstrates how to calculate running totals and cumulative aggregates:

```sql
SELECT 
    SalesOrderID,
    OrderDate,
    TotalDue,
    SUM(TotalDue) OVER (ORDER BY OrderDate, SalesOrderID) AS RunningTotal,
    AVG(TotalDue) OVER (ORDER BY OrderDate, SalesOrderID) AS RunningAverage,
    COUNT(*) OVER (ORDER BY OrderDate, SalesOrderID) AS OrderNumber
FROM SalesLT.SalesOrderHeader
ORDER BY OrderDate, SalesOrderID;
```

The result set looks like this:

```
SalesOrderID   OrderDate    TotalDue    RunningTotal   RunningAverage   OrderNumber
------------   ----------   ---------   ------------   --------------   -----------
71774          2008-06-01   972.785     972.785        972.785          1
71776          2008-06-01   87.083      1059.868       529.934          2
71780          2008-06-01   42452.65    43512.518      14504.172        3
71782          2008-06-01   43962.79    87475.308      21868.827        4
```

> [!IMPORTANT]
> When using aggregate window functions without `ORDER BY` in the `OVER` clause, the function calculates across the entire partition. Adding `ORDER BY` creates a running calculation from the partition start to the current row.

## Define window frames with `ROWS` and `RANGE`

Window frames let you specify exactly which rows relative to the current row should be included in the calculation. The `ROWS` clause counts physical rows, while `RANGE` groups rows with equal values.

Frame boundaries can be specified using:
- `UNBOUNDED PRECEDING`: From the partition start
- `n PRECEDING`: `n` rows before current row
- `CURRENT ROW`: The current row
- `n FOLLOWING`: `n` rows after current row
- `UNBOUNDED FOLLOWING`: To the partition end

The following query calculates a moving average over the last three orders:

```sql
SELECT 
    SalesOrderID,
    OrderDate,
    TotalDue,
    AVG(TotalDue) OVER (
        ORDER BY OrderDate
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS MovingAvg3Orders
FROM SalesLT.SalesOrderHeader
ORDER BY OrderDate;
```

The result set looks like this:

```
SalesOrderID   OrderDate    TotalDue    MovingAvg3Orders
------------   ----------   ---------   ----------------
71774          2008-06-01   972.785     972.785
71776          2008-06-01   87.083      529.934
71780          2008-06-01   42452.65    14504.172
71782          2008-06-01   43962.79    28834.174
```

This query calculates a 3-order moving average by including the current row and the two rows before it. For the first row, only one value is available, so the average equals `TotalDue`. By the third row, the window includes all three rows.

## Use analytical functions

Analytical functions let you access data from other rows without using self-joins or subqueries. These functions are useful for time-series analysis, trend detection, and comparing current values against historical or future values. Unlike aggregate window functions that compute summaries, analytical functions retrieve specific values from specific rows in the window.

**`LAG()`** and **`LEAD()`** access values from previous or subsequent rows, like this:

```sql
SELECT 
    SalesOrderID,
    OrderDate,
    TotalDue,
    LAG(TotalDue, 1, 0) OVER (ORDER BY OrderDate) AS PreviousOrderTotal,
    LEAD(TotalDue, 1, 0) OVER (ORDER BY OrderDate) AS NextOrderTotal,
    TotalDue - LAG(TotalDue, 1, 0) OVER (ORDER BY OrderDate) AS ChangeFromPrevious
FROM SalesLT.SalesOrderHeader
ORDER BY OrderDate;
```

The result set looks like this:

```
SalesOrderID   OrderDate    TotalDue    PreviousOrderTotal   NextOrderTotal   ChangeFromPrevious
------------   ----------   ---------   ------------------   --------------   ------------------
71774          2008-06-01   972.785     0                    87.083           972.785
71776          2008-06-01   87.083      972.785              42452.65         -885.702
71780          2008-06-01   42452.65    87.083               43962.79         42365.567
71782          2008-06-01   43962.79    42452.65             0                1510.14
```

`LAG()` retrieves a value from a previous row, while `LEAD()` retrieves from a following row. The second parameter specifies how many rows to look back or ahead (default is 1), and the third parameter provides a default value when no row exists (such as for the first row with `LAG()`). Use these functions to calculate period-over-period changes, identify trends, or detect anomalies in sequential data.

**`FIRST_VALUE()`** and **`LAST_VALUE()`** return values from the first or last row in the frame:

```sql
SELECT 
    ProductID,
    Name,
    ListPrice,
    ProductCategoryID,
    FIRST_VALUE(Name) OVER (
        PARTITION BY ProductCategoryID 
        ORDER BY ListPrice DESC
    ) AS MostExpensiveInCategory,
    LAST_VALUE(Name) OVER (
        PARTITION BY ProductCategoryID 
        ORDER BY ListPrice DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS LeastExpensiveInCategory
FROM SalesLT.Product
WHERE ListPrice > 0;
```

The result set looks like this:

```
ProductID   Name                        ListPrice   ProductCategoryID   MostExpensiveInCategory    LeastExpensiveInCategory
---------   -------------------------   ---------   -----------------   ------------------------   ------------------------
749         Road-150 Red, 62            3578.27     5                   Road-150 Red, 62           LL Road Frame - Red, 58
750         Road-150 Red, 44            3578.27     5                   Road-150 Red, 62           LL Road Frame - Red, 58
722         LL Road Frame - Red, 58     337.22      5                   Road-150 Red, 62           LL Road Frame - Red, 58
771         Mountain-100 Silver, 38     3399.99     6                   Mountain-100 Silver, 38    Mountain-500 Black, 52
```

`FIRST_VALUE()` returns the value from the first row in the ordered window, which in this case is the most expensive product per category. `LAST_VALUE()` returns the least expensive, but requires an explicit frame to include all rows. These functions help you compare each row against benchmark values like the highest, lowest, or baseline value in a group.

> [!NOTE]
> `LAST_VALUE()` requires an explicit frame specification to include rows after the current row. Without it, the default frame only includes rows up to the current row, making `LAST_VALUE()` return the current row's value.

**PERCENT_RANK()** and **CUME_DIST()** calculate relative position within a partition:

```sql
SELECT 
    Name,
    ListPrice,
    PERCENT_RANK() OVER (ORDER BY ListPrice) AS PercentRank,
    CUME_DIST() OVER (ORDER BY ListPrice) AS CumulativeDistribution
FROM SalesLT.Product
WHERE ListPrice > 0
ORDER BY ListPrice;
```

The result set looks like this:

```
Name                        ListPrice   PercentRank   CumulativeDistribution
-------------------------   ---------   -----------   ----------------------
Patch Kit/8 Patches         2.29        0.0           0.0081
Road Tire Tube              3.99        0.0081        0.0162
Touring Tire Tube           4.99        0.0162        0.0243
Road-150 Red, 62            3578.27     0.9919        1.0
```

`PERCENT_RANK()` returns a value between 0 and 1 indicating what percentage of rows have lower values (0 means lowest, one means highest). `CUME_DIST()` shows the cumulative distribution, indicating what percentage of rows have values less than or equal to the current row. Use these functions for percentile analysis, identifying outliers, or creating distribution reports.

For more information about window functions, see [Window Functions (Transact-SQL)](/sql/t-sql/queries/select-over-clause-transact-sql?azure-portal=true) and [Ranking Functions](/sql/t-sql/functions/ranking-functions-transact-sql?azure-portal=true).
