T-SQL provides aggregate functions such as SUM, MAX, and AVG to perform calculations that take multiple values and return a single result.

## Working with aggregate functions

Most of the queries we have looked at operate on a row at a time, using a WHERE clause to filter rows. Each row returned corresponds to one row in the original data set.

Many aggregate functions are provided in SQL Server. In this section, we’ll look at the most common functions such as SUM, MIN, MAX, AVG, and COUNT.

When working with aggregate functions, you need to consider the following points:

 *  Aggregate functions return a single (scalar) value and can be used in SELECT statements almost anywhere a single value can be used. For example, these functions can be used in the SELECT, HAVING, and ORDER BY clauses. However, they cannot be used in the WHERE clause.
 *  Aggregate functions ignore NULLs, except when using COUNT(\*).
 *  Aggregate functions in a SELECT list don't have a column header unless you provide an alias using AS.
 *  Aggregate functions in a SELECT list operate on all rows passed to the SELECT operation. If there is no GROUP BY clause, all rows satisfying any filter in the WHERE clause will be summarized. You will learn more about GROUP BY in the next topic.
 *  Unless you're using GROUP BY, you shouldn't combine aggregate functions with columns not included in functions in the same SELECT list.

To extend beyond the built-in functions, SQL Server provides a mechanism for user-defined aggregate functions via the .NET Common Language Runtime (CLR). That topic is beyond the scope of this module.

## Built-in aggregate functions

As mentioned, Transact-SQL provides many built-in aggregate functions. Commonly used functions include:

:::row:::
  :::column:::
    **Function Name**
  :::column-end:::
  :::column:::
    **Syntax**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    SUM
  :::column-end:::
  :::column:::
    SUM(*expression*)
  :::column-end:::
  :::column:::
    Totals all the non-NULL numeric values in a column.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    AVG
  :::column-end:::
  :::column:::
    AVG(*expression*)
  :::column-end:::
  :::column:::
    Averages all the non-NULL numeric values in a column (sum/count).
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    MIN
  :::column-end:::
  :::column:::
    MIN(*expression*)
  :::column-end:::
  :::column:::
    Returns the smallest number, earliest date/time, or first-occurring string (according to collation sort rules).
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    MAX
  :::column-end:::
  :::column:::
    MAX(*expression*)
  :::column-end:::
  :::column:::
    Returns the largest number, latest date/time, or last-occurring string (according to collation sort rules).
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    COUNT or COUNT\_BIG
  :::column-end:::
  :::column:::
    COUNT(\*) or COUNT(*expression*)
  :::column-end:::
  :::column:::
    With (\*), counts all rows, including rows with NULL values. When a column is specified as *expression*, returns the count of non-NULL rows for that column. COUNT returns an int; COUNT\_BIG returns a big\_int.
  :::column-end:::
:::row-end:::


To use a built-in aggregate in a SELECT clause, consider the following example in the *MyStore* sample database:

```sql
SELECT AVG(ListPrice) AS AveragePrice,
       MIN(ListPrice) AS MinimumPrice,
       MAX(ListPrice) AS MaximumPrice
FROM Production.Product;
```

The results of this query look something like this:

:::row:::
  :::column:::
    AveragePrice
  :::column-end:::
  :::column:::
    MinimumPrice
  :::column-end:::
  :::column:::
    MaximumPrice
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    744.5952
  :::column-end:::
  :::column:::
    2.2900
  :::column-end:::
  :::column:::
    3578.2700
  :::column-end:::
:::row-end:::


Note that the above example summarizes all rows from the **Production.Product** table. We could easily modify the query to return the average, minimum, and maximum prices for products in a specific category by adding a WHERE clause, like this:

```sql
SELECT AVG(ListPrice) AS AveragePrice,
       MIN(ListPrice) AS MinimumPrice,
       MAX(ListPrice) AS MaximumPrice
FROM Production.Product
WHERE ProductCategoryID = 15;
```

When using aggregates in a SELECT clause, all columns referenced in the SELECT list must be used as inputs for an aggregate function, or be referenced in a GROUP BY clause.

Consider the following query, which attempts to include the **ProductCategoryID** field in the aggregated results:

```sql
SELECT ProductCategoryID, AVG(ListPrice) AS AveragePrice,
MIN(ListPrice) AS MinimumPrice,
MAX(ListPrice) AS MaximumPrice
FROM Production.Product;
```

Running this query results in the following error

> Msg 8120, Level 16, State 1, Line 1
> 
> Column 'Production.ProductCategoryID' is invalid in the select list because it isn't contained in either an aggregate function or the GROUP BY clause.

The query treats all rows as a single aggregated group. Therefore, all columns must be used as inputs to aggregate functions.

In the previous examples, we aggregated numeric data such as the price and quantities in the previous example,. Some of the aggregate functions can also be used to summarize date, time, and character data. The following examples show the use of aggregates with dates and characters:

This query returns first and last company by name, using MIN and MAX:

```sql
SELECT MIN(CompanyName) AS MinCustomer, 
       MAX(CompanyName) AS MaxCustomer
FROM SalesLT.Customer;
```

This query will return the first and last values for **CompanyName** in the database's collation sequence, which in this case is alphabetical order:

:::row:::
  :::column:::
    MinCustomer
  :::column-end:::
  :::column:::
    MaxCustomer
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    A Bike Store
  :::column-end:::
  :::column:::
    Yellow Bicycle Company
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
:::row-end:::

Other functions may be nested with aggregate functions.

For example, the YEAR scalar function is used in the following example to return only the year portion of the order date, before MIN and MAX are evaluated:

```sql
SELECT MIN(YEAR(OrderDate)) AS Earliest,
       MAX(YEAR(OrderDate)) AS Latest
FROM Sales.SalesOrderHeader;
```

:::row:::
  :::column:::
    Earliest
  :::column-end:::
  :::column:::
    Latest
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    2008
  :::column-end:::
  :::column:::
    2021
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
:::row-end:::

The MIN and MAX functions can also be used with date data, to return the earliest and latest chronological values. However, AVG and SUM can only be used for numeric data, which includes integers, money, float and decimal datatypes.

## Using DISTINCT with aggregate functions

You should be aware of the use of DISTINCT in a SELECT clause to remove duplicate rows. When used with an aggregate function, DISTINCT removes duplicate values from the input column before computing the summary value. DISTINCT is useful when summarizing unique occurrences of values, such as customers in the orders table.

The following example returns the number of customers who have placed orders, no matter how many orders they placed:

```sql
SELECT COUNT(DISTINCT CustomerID) AS UniqueCustomers
FROM Sales.SalesOrderHeader;
```

COUNT(&lt;some\_column&gt;) merely counts how many rows have some value in the column. If there are no NULL values, COUNT(&lt;some\_column&gt;) will be the same as COUNT(\*). COUNT (DISTINCT &lt;some\_column&gt;) counts how many different values there are in the column.

## Using aggregate functions with NULL

It is important to be aware of the possible presence of NULLs in your data, and of how NULL interacts with T-SQL query components, including aggregate function. There are a few considerations to be aware of:

 *  With the exception of COUNT used with the (\*) option, T-SQL aggregate functions ignore NULLs. For example, a SUM function will add only non-NULL values. NULLs don't evaluate to zero. COUNT(\*) counts all rows, regardless of value or non-value in any column.
 *  The presence of NULLs in a column may lead to inaccurate computations for AVG, which will sum only populated rows and divide that sum by the number of non-NULL rows. There may be a difference in results between AVG(&lt;column&gt;) and (SUM(&lt;column&gt;)/COUNT(\*)).

For example, consider the following table named t1:

:::row:::
  :::column:::
    **C1**
  :::column-end:::
  :::column:::
    **C2**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    1
  :::column-end:::
  :::column:::
    NULL
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    2
  :::column-end:::
  :::column:::
    10
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    3
  :::column-end:::
  :::column:::
    20
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    4
  :::column-end:::
  :::column:::
    30
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    5
  :::column-end:::
  :::column:::
    40
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    6
  :::column-end:::
  :::column:::
    50
  :::column-end:::
:::row-end:::

This query illustrates the difference between how AVG handles NULL and how you might calculate an average with a SUM/COUNT(\*) computed column:

```sql
SELECT SUM(c2) AS sum_nonnulls, 
    COUNT(*) AS count_all_rows, 
    COUNT(c2) AS count_nonnulls, 
    AVG(c2) AS average, 
    (SUM(c2)/COUNT(*)) AS arith_average
FROM t1;
```

The result would be:

:::row:::
  :::column:::
    sum\_nonnulls
  :::column-end:::
  :::column:::
    count\_all\_rows
  :::column-end:::
  :::column:::
    count\_nonnulls
  :::column-end:::
  :::column:::
    average
  :::column-end:::
  :::column:::
    arith\_average
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    150
  :::column-end:::
  :::column:::
    6
  :::column-end:::
  :::column:::
    5
  :::column-end:::
  :::column:::
    30
  :::column-end:::
  :::column:::
    25
  :::column-end:::
:::row-end:::

In this resultset, the column named **average** is the aggregate that internally gets the sum of 150 and divides by the count of non-null values in column **c2**. The calculation would be 150/5, or 30. The column called **arith\_average** explicitly divides the sum by the count of all rows, so the calculation is 150/6, or 25.

If you need to summarize all rows, whether NULL or not, consider replacing the NULLs with another value that will not be ignored by your aggregate function. You can use the COALESCE function for this purpose.
