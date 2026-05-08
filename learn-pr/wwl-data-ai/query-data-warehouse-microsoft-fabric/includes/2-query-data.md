Once the dimension and fact tables in a data warehouse are populated with data, you can use T-SQL to query these tables and perform data analysis. The Transact-SQL (T-SQL) syntax used for querying tables in a warehouse in Fabric closely resembles the SQL syntax used in SQL Server and Azure SQL Database. This familiarity allows for an easy transition if you're already used to working with these platforms.

## Aggregate measures by dimension attributes

Most data warehouse analytics involves aggregating numeric measures from fact tables based on attributes in dimension tables. Because of the star or snowflake schema structure, these queries use `JOIN` clauses to link fact and dimension tables, along with aggregate functions and `GROUP BY` clauses to define aggregation hierarchies.

The following SQL query aggregates sales amounts by year and quarter from the **FactSales** and **DimDate** tables in a hypothetical data warehouse:

```sql
SELECT  dates.CalendarYear,
        dates.CalendarQuarter,
        SUM(sales.SalesAmount) AS TotalSales
FROM dbo.FactSales AS sales
JOIN dbo.DimDate AS dates ON sales.OrderDateKey = dates.DateKey
GROUP BY dates.CalendarYear, dates.CalendarQuarter
ORDER BY dates.CalendarYear, dates.CalendarQuarter;
```

The results look similar to the following table:

| CalendarYear | CalendarQuarter | TotalSales |
|--|--|--|
| 2024 | 1 | 25980.16 |
| 2024 | 2 | 27453.87 |
| 2024 | 3 | 28527.15 |
| 2024 | 4 | 31083.45 |
| 2025 | 1 | 34562.96 |
| 2025 | 2 | 36162.27 |
| ... | ... | ... |

You can join as many dimension tables as needed to calculate the aggregations you need. For example, the following code extends the previous example to group the quarterly sales totals by city based on the customer's address details in the **DimCustomer** table.

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

This time, the results include a quarterly sales total for each city.

| CalendarYear | CalendarQuarter | City | TotalSales |
|--|--|--|--|
| 2024 | 1 | Amsterdam | 5982.53 |
| 2024 | 1 | Berlin | 2826.98 |
| 2024 | 1 | Chicago | 5372.72 |
| ... | ... | ... | .. |
| 2024 | 2 | Amsterdam | 7163.93 |
| 2024 | 2 | Berlin | 8191.12 |
| 2024 | 2 | Chicago | 2428.72 |
| ... | ... | ... | .. |
| 2024 | 3 | Amsterdam | 7261.92 |
| 2024 | 3 | Berlin | 4202.65 |
| 2024 | 3 | Chicago | 2287.87 |
| ... | ... | ... | .. |
| 2024 | 4 | Amsterdam | 8262.73 |
| 2024 | 4 | Berlin | 5373.61 |
| 2024 | 4 | Chicago | 7726.23 |
| ... | ... | ... | .. |
| 2025 | 1 | Amsterdam | 7261.28 |
| 2025 | 1 | Berlin | 3648.28 |
| 2025 | 1 | Chicago | 1027.27 |
| ... | ... | ... | .. |

### Joins in a snowflake schema

When using a snowflake schema, dimensions may be partially normalized, requiring multiple joins to relate fact tables to snowflake dimensions. For example, suppose your data warehouse includes a **DimProduct** dimension table from which the product categories have been normalized into a separate **DimCategory** table. A query to aggregate items sold by product category might look similar to the following example:

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
| Apparel | 5368 |
| ... | ... |

> [!NOTE]
> Both `JOIN` clauses are required to traverse the relationship chain from **FactSales** to **DimCategory** through **DimProduct**, even though no fields from **DimProduct** appear in the results.

## Using ranking functions

Another common analytical query partitions results by a dimension attribute and ranks them within each partition. For example, you might want to rank stores each year by their sales revenue. To accomplish this goal, you can use Transact-SQL *ranking* functions such as `ROW_NUMBER`, `RANK`, `DENSE_RANK`, and `NTILE`. These functions enable you to partition data across categories, each returning a value that indicates the relative position of each row within the partition:

- **ROW_NUMBER** returns the ordinal position of the row within the partition. For example, the first row is numbered 1, the second 2, and so on.
- **RANK** returns the ranked position of each row in the ordered results. For example, in a partition of stores ordered by sales volume, the store with the highest sales volume is ranked 1. If multiple stores have the same sales volumes, they'll be ranked the same, and the rank assigned to subsequent stores reflects the number of stores that have higher sales volumes - including ties.
- **DENSE_RANK** ranks rows in a partition the same way as **RANK**, but when multiple rows have the same rank, subsequent rows are ranked without gaps — ties don't consume extra positions.
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

The query partitions products by category, ranking each product within its partition by list price. The results look similar to the following table:

| ProductCategory | ProductName | ListPrice | RowNumber | Rank | DenseRank | Quartile |
|--|--|--|--|--|--|--|
| Accessories | Water Bottle | 8.99 | 1 | 1 | 1 | 1 |
| Accessories | Headband | 8.49 | 2 | 2 | 2 | 1 |
| Accessories | Arm Warmers | 5.99 | 3 | 3 | 3 | 2 |
| Accessories | Ankle Strap | 5.99 | 4 | 3 | 3 | 2 |
| Accessories | Insole | 2.99 | 5 | 5 | 4 | 3 |
| Accessories | Shoelace | 0.25 | 6 | 6 | 5 | 4 |
| Apparel | Running Cap | 7.49 | 1 | 1 | 1 | 1 |
| Apparel | Compression Sleeve | 6.99 | 2 | 2 | 2 | 1 |
| Apparel | Gym Bag | 4.25 | 3 | 3 | 3 | 2 |
|...|...|...|...|...|...|...|

> [!NOTE]
> The sample results demonstrate the difference between `RANK` and `DENSE_RANK`. Note that in the *Accessories* category, the *Arm Warmers* and *Ankle Strap* products have the same list price, and are both ranked as the 3rd highest priced product. The next highest priced product has a *RANK* of 5 (there are four products more expensive than it) and a *DENSE_RANK* of 4 (there are three higher prices).
>
> To learn more about ranking functions, see the [Use built-in functions and GROUP BY in Transact-SQL](/sql/t-sql/functions/ranking-functions-transact-sql) module.

## Retrieving an approximate count

While the purpose of a data warehouse is primarily to support analytical data models and reports for the enterprise, data analysts and data scientists often need to perform some initial data exploration to determine the basic scale and distribution of the data.

For example, the following query uses the `COUNT` function to retrieve the number of sales for each year:

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
| 2023 | 239870 |
| 2024 | 284741 |
| 2025 | 309272 |
|...|...|

The volume of data in a data warehouse may mean that even simple queries to count the number of records that meet specified criteria take considerable time to run. In many cases, a precise count isn't required — an approximate estimate will suffice. In such cases, you can use the `APPROX_COUNT_DISTINCT` function as shown in the following example:

```sql
SELECT dates.CalendarYear AS CalendarYear,
    APPROX_COUNT_DISTINCT(sales.OrderNumber) AS ApproxOrders
FROM FactSales AS sales
JOIN DimDate AS dates ON sales.OrderDateKey = dates.DateKey
GROUP BY dates.CalendarYear
ORDER BY CalendarYear;
```

The `APPROX_COUNT_DISTINCT` function uses a *HyperLogLog* algorithm to retrieve an approximate count. The result is guaranteed to have a maximum error rate of 2% with 97% probability, so the results of this query might look similar to the following table:

| CalendarYear | ApproxOrders |
|--|--|
| 2023 | 235552 |
| 2024 | 290436 |
| 2025 | 304633 |
|...|...|

The counts are less accurate, but still sufficient for an approximate comparison of yearly sales. With a large volume of data, the query using the `APPROX_COUNT_DISTINCT` function completes more quickly, and the reduced accuracy may be an acceptable trade-off during basic data exploration.

> [!NOTE]
> See the [APPROX_COUNT_DISTINCT](/sql/t-sql/functions/approx-count-distinct-transact-sql) function documentation for more details.
