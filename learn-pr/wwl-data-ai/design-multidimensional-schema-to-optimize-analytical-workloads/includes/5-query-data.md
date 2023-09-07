When the dimension and fact tables in a data warehouse have been loaded with data, you can use SQL to query the tables and analyze the data they contain. The Transact-SQL syntax used to query tables in a Synapse dedicated SQL pool is similar to SQL used in SQL Server or Azure SQL Database.

## Aggregating measures by dimension attributes

Most data analytics with a data warehouse involves aggregating numeric measures in fact tables by attributes in dimension tables. Because of the way a star or snowflake schema is implemented, queries to perform this kind of aggregation rely on `JOIN` clauses to connect fact tables to dimension tables, and a combination of aggregate functions and `GROUP BY` clauses to define the aggregation hierarchies.

For example, the following SQL queries the **FactSales** and **DimDate** tables in a hypothetical data warehouse to aggregate sales amounts by year and quarter:

```sql
SELECT  dates.CalendarYear,
        dates.CalendarQuarter,
        SUM(sales.SalesAmount) AS TotalSales
FROM dbo.FactSales AS sales
JOIN dbo.DimDate AS dates ON sales.OrderDateKey = dates.DateKey
GROUP BY dates.CalendarYear, dates.CalendarQuarter
ORDER BY dates.CalendarYear, dates.CalendarQuarter;
```

The results from this query would look similar to the following table:

| CalendarYear | CalendarQuarter | TotalSales |
|--|--|--|
| 2020 | 1 | 25980.16 |
| 2020 | 2 | 27453.87 |
| 2020 | 3 | 28527.15 |
| 2020 | 4 | 31083.45 |
| 2021 | 1 | 34562.96 |
| 2021 | 2 | 36162.27 |
| ... | ... | ... |

You can join as many dimension tables as needed to calculate the aggregations you need. For example, the following code extends the previous example to break down the quarterly sales totals by city based on the customer's address details in the **DimCustomer** table:

```sql
SELECT  dates.CalendarYear,
        dates.CalendarQuarter,
        custs.City,
        SUM(sales.SalesAmount) AS TotalSales
FROM dbo.FactSales AS sales
JOIN dbo.DimDate AS dates ON sales.OrderDateKey = dates.DateKey
JOIN dbo.DimCustomer AS custs ON sales.CustomerKey = custs.CustomerKey
GROUP BY dates.CalendarYear, dates.CalendarQuarter, custs.City
ORDER BY dates.CalendarYear, dates.CalendarQuarter, custs.City;
```

This time, the results include a quarterly sales total for each city:

| CalendarYear | CalendarQuarter | City | TotalSales |
|--|--|--|--|
| 2020 | 1 | Amsterdam | 5982.53 |
| 2020 | 1 | Berlin | 2826.98 |
| 2020 | 1 | Chicago | 5372.72 |
| ... | ... | ... | .. |
| 2020 | 2 | Amsterdam | 7163.93 |
| 2020 | 2 | Berlin | 8191.12 |
| 2020 | 2 | Chicago | 2428.72 |
| ... | ... | ... | .. |
| 2020 | 3 | Amsterdam | 7261.92 |
| 2020 | 3 | Berlin | 4202.65 |
| 2020 | 3 | Chicago | 2287.87 |
| ... | ... | ... | .. |
| 2020 | 4 | Amsterdam | 8262.73 |
| 2020 | 4 | Berlin | 5373.61 |
| 2020 | 4 | Chicago | 7726.23 |
| ... | ... | ... | .. |
| 2021 | 1 | Amsterdam | 7261.28 |
| 2021 | 1 | Berlin | 3648.28 |
| 2021 | 1 | Chicago | 1027.27 |
| ... | ... | ... | .. |

### Joins in a snowflake schema

When using a snowflake schema, dimensions may be partially normalized; requiring multiple joins to relate fact tables to snowflake dimensions. For example, suppose your data warehouse includes a **DimProduct** dimension table from which the product categories have been normalized into a separate **DimCategory** table. A query to aggregate items sold by product category might look similar to the following example:

```sql
SELECT  cat.ProductCategory,
        SUM(sales.OrderQuantity) AS ItemsSold
FROM dbo.FactSales AS sales
JOIN dbo.DimProduct AS prod ON sales.ProductKey = prod.ProductKey
JOIN dbo.DimCategory AS cat ON prod.CategoryKey = cat.CategoryKey
GROUP BY cat.ProductCategory
ORDER BY cat.ProductCategory;
```

The results from this query include the number of items sold for each product category:

| ProductCategory | ItemsSold |
|--|--|
| Accessories | 28271 |
| Bits and pieces | 5368 |
| ... | ... |

> [!NOTE]
> JOIN clauses for **FactSales** and **DimProduct** and for **DimProduct** and **DimCategory** are both required, even though no fields from **DimProduct** are returned by the query.

## Using ranking functions

Another common kind of analytical query is to partition the results based on a dimension attribute and *rank* the results within each partition. For example, you might want to rank stores each year by their sales revenue. To accomplish this goal, you can use Transact-SQL *ranking* functions such as `ROW_NUMBER`, `RANK`, `DENSE_RANK`, and `NTILE`. These functions enable you to partition the data over categories, each returning a specific value that indicates the relative position of each row within the partition:

- **ROW_NUMBER** returns the ordinal position of the row within the partition. For example, the first row is numbered 1, the second 2, and so on.
- **RANK** returns the ranked position of each row in the ordered results. For example, in a partition of stores ordered by sales volume, the store with the highest sales volume is ranked 1. If multiple stores have the same sales volumes, they'll be ranked the same, and the rank assigned to subsequent stores reflects the number of stores that have higher sales volumes - including ties.
- **DENSE_RANK** ranks rows in a partition the same way as **RANK**, but when multiple rows have the same rank, subsequent rows are ranking positions ignore ties.
- **NTILE** returns the specified percentile in which the row falls. For example, in a partition of stores ordered by sales volume, `NTILE(4)` returns the quartile in which a store's sales volume places it.

For example, consider the following query:

```sql
SELECT  ProductCategory,
        ProductName,
        ListPrice,
        ROW_NUMBER() OVER
            (PARTITION BY ProductCategory ORDER BY ListPrice DESC) AS RowNumber,
        RANK() OVER
            (PARTITION BY ProductCategory ORDER BY ListPrice DESC) AS Rank,
        DENSE_RANK() OVER
            (PARTITION BY ProductCategory ORDER BY ListPrice DESC) AS DenseRank,
        NTILE(4) OVER
            (PARTITION BY ProductCategory ORDER BY ListPrice DESC) AS Quartile
FROM dbo.DimProduct
ORDER BY ProductCategory;
```

The query partitions products into groupings based on their categories, and within each category partition, the relative position of each product is determined based on its list price. The results from this query might look similar to the following table:

| ProductCategory | ProductName | ListPrice | RowNumber | Rank | DenseRank | Quartile |
|--|--|--|--|--|--|--|
| Accessories | Widget | 8.99 | 1 | 1 | 1 | 1 |
| Accessories | Knicknak | 8.49 | 2 | 2 | 2 | 1 |
| Accessories | Sprocket | 5.99 | 3 | 3 | 3 | 2 |
| Accessories | Doodah | 5.99 | 4 | 3 | 3 | 2 |
| Accessories | Spangle | 2.99 | 5 | 5 | 4 | 3 |
| Accessories | Badabing | 0.25 | 6 | 6 | 5 | 4 |
| Bits and pieces | Flimflam | 7.49 | 1 | 1 | 1 | 1 |
| Bits and pieces | Snickity wotsit | 6.99 | 2 | 2 | 2 | 1 |
| Bits and pieces | Flange | 4.25 | 3 | 3 | 3 | 2 |
|...|...|...|...|...|...|...|

> [!NOTE]
> The sample results demonstrate the difference between `RANK` and `DENSE_RANK`. Note that in the *Accessories* category, the *Sprocket* and *Doodah* products have the same list price; and are both ranked as the 3rd highest priced product. The next highest priced product has a *RANK* of 5 (there are four products more expensive than it) and a *DENSE_RANK* of 4 (there are three higher prices).
>
> To learn more about ranking functions, see [Ranking Functions (Transact-SQL)](/sql/t-sql/functions/ranking-functions-transact-sql?view=azure-sqldw-latest) in the Azure Synapse Analytics documentation.

## Retrieving an approximate count

While the purpose of a data warehouse is primarily to support analytical data models and reports for the enterprise; data analysts and data scientists often need to perform some initial data exploration, just to determine the basic scale and distribution of the data.

For example, the following query uses the `COUNT` function to retrieve the number of sales for each year in a hypothetical data warehouse:

```sql
SELECT dates.CalendarYear AS CalendarYear,
    COUNT(DISTINCT sales.OrderNumber) AS Orders
FROM FactSales AS sales
JOIN DimDate AS dates ON sales.OrderDateKey = dates.DateKey
GROUP BY dates.CalendarYear
ORDER BY CalendarYear;
```

The results of this query might look similar to the following table:

| CalendarYear | Orders |
|--|--|
| 2019 | 239870 |
| 2020 | 284741 |
| 2021 | 309272 |
|...|...|

The volume of data in a data warehouse can mean that even simple queries to count the number of records that meet specified criteria can take a considerable time to run. In many cases, a precise count isn't required - an approximate estimate will suffice. In such cases, you can use the `APPROX_COUNT_DISTINCT` function as shown in the following example:

```sql
SELECT dates.CalendarYear AS CalendarYear,
    APPROX_COUNT_DISTINCT(sales.OrderNumber) AS ApproxOrders
FROM FactSales AS sales
JOIN DimDate AS dates ON sales.OrderDateKey = dates.DateKey
GROUP BY dates.CalendarYear
ORDER BY CalendarYear;
```

The `APPROX_COUNT_DISTINCT` function uses a *HyperLogLog* algorithm to retrieve an approximate count. The result is guaranteed to have a maximum error rate of 2% with 97% probability, so the results of this query with the same hypothetical data as before might look similar to the following table:

| CalendarYear | ApproxOrders |
|--|--|
| 2019 | 235552 |
| 2020 | 290436 |
| 2021 | 304633 |
|...|...|

The counts are less accurate, but still sufficient for an approximate comparison of yearly sales. With a large volume of data, the query using the `APPROX_COUNT_DISTINCT` function completes more quickly, and the reduced accuracy may be an acceptable trade-off during basic data exploration.

> [!NOTE]
> See the [APPROX_COUNT_DISTINCT](/sql/t-sql/functions/approx-count-distinct-transact-sql?view=azure-sqldw-latest) function documentation for more details.
