In window operations, you can use aggregate functions such as SUM, MIN, and MAX to operate on a set of rows defined by the OVER clause and its arguments.

Window functions can be categorized as:

- **Aggregate functions**. Such as SUM, AVG, and COUNT which operate on a window and return a scalar value.
- **Ranking functions**. Such as RANK, ROW_NUMBER, and NTILE. Ranking functions require a sort order and return a ranking value for each row in a partition.
- **Analytic functions**. Such as CUME_DIST, PERCENTILE_CONT, or PERCENTILE_DISC. Analytic functions calculate the distribution of values in the partition.
- **Offset functions**. Such as LAG, LEAD, and LAST_VALUE. Offset functions return values from other rows relative to the position of the current row.

## Aggregate functions

Aggregate functions return totals, averages, or counts of things. Aggregate functions perform a calculation and return a single value. With the exception of COUNT(*), aggregate functions do not count NULL values.

Consider the following code, which applies some common aggregate functions to the prices of products in the products table:

```sql
SELECT Name, ProductNumber, Color, SUM(Weight) 
OVER(PARTITION BY Color) AS WeightByColor
FROM SalesLT.Product
ORDER BY ProductNumber;
```

This returns a column called WeightByColor which contains the total weight for all products of the same color as show in the partial result set below.

:::image type="content" source="../media/aggregate-function-results.png" alt-text="A screenshot showing results from the OVER and PARTITION BY Color clause.":::

## Ranking functions

Ranking functions assign a number to each row, depending on its position within an order you have specified. The order is specified using the ORDER BY clause.

Consider the following code, which applies all four ranking functions to products in the products table.

```sql
SELECT productid, name, listprice 
    ,ROW_NUMBER() OVER (ORDER BY productid) AS "Row Number"  
    ,RANK() OVER (ORDER BY listprice) AS PriceRank  
    ,DENSE_RANK() OVER (ORDER BY listprice) AS "Dense Rank"  
    ,NTILE(4) OVER (ORDER BY listprice) AS Quartile  
FROM SalesLT.Product 
```

This returns a column for each of the function, with the appropriate ranking number.

:::image type="content" source="../media/rank-function-results.png" alt-text="A screenshot showing results from ranking functions.":::

## Analytic functions

Analytic functions calculate a value based on a group of rows. Analytic functions are used to calculate moving averages, running totals, and top-N results. These functions include:

- CUME_DIST
- FIRST_VALUE
- RECENT_RANK
- PERCENTILE_CONT
- PERCENTIL_DISC

## OFFSET functions

Offset functions allow you to return a value subsequent or previous rows within a result set.

Offset functions operate on a position that is either relative to the current row, or relative to the starting or ending boundary of the window frame. The offset functions are:

- LAG and LEAD - operate on an offset to the current row and require the ORDER BY clause.
- FIRST_VALUE and LAST_VALUE - operate on an offset from the window frame.
The syntax for the LAG function is shown below. The LEAD function works in the same way.

```sql
LAG (scalar_expression [,offset] [,default])  
    OVER ( [ partition_by_clause ] order_by_clause )
```

In the following code example, the LEAD offset function returns the following year’s budget value:

```sql
SELECT [Year], Budget, LEAD(Budget, 1, 0) OVER (ORDER BY [Year]) AS 'Next'
    FROM dbo.Budget
    ORDER BY [Year];
```

The syntax for LAST_VALUE is shown below. FIRST_VALUE works in the same way.

```sql
LAST_VALUE ( [ scalar_expression ] )  
OVER ( [ partition_by_clause ] order_by_clause rows_range_clause )  
```

The syntax is similar to LAG and LEAD, with the addition of the rows/range clause.
