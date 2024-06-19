Query hints are options or strategies that can be applied to enforce the query processor to use a particular operator in the execution plan for `SELECT`, `INSERT`, `UPDATE`, or `DELETE` statements. Query hints override any execution plan the query processor might select for a given query with the `OPTION` clause.

In most cases, the query optimizer selects an efficient execution plan based on the indexes, statistics, and data distribution. Database administrators rarely need to intervene manually.

You can change the execution plan of the query by adding query hints to the end of the query. For example, if you add `OPTION (MAXDOP <integer_value>)` to the end of a query that uses a single CPU, the query may use multiple CPUs (parallelism) depending on the value you choose. Or, you can use `OPTION (RECOMPILE)` to ensure that the query generates a new, temporary plan each time it's executed.

```sql
--With maxdop hint
SELECT ProductID, OrderQty, SUM(LineTotal) AS Total  
FROM Sales.SalesOrderDetail  
WHERE UnitPrice < $5.00  
GROUP BY ProductID, OrderQty  
ORDER BY ProductID, OrderQty  
OPTION (MAXDOP 2)
GO

--With recompile hint
SELECT City
FROM Person.Address
WHERE StateProvinceID=15 OPTION (RECOMPILE)
GO
```

Although query hints may provide a localized solution to various performance-related issues, you should avoid using them in production environment for the following reasons.

- Having a permanent query hint on your query can result in structural database changes that would be beneficial to that query not being applicable.
- You can't benefit from new and improved features in subsequent versions of SQL Server if you bind a query to a specific execution plan.

However, there are several query hints available on SQL Server, which are used for different purposes. Let's discuss a few of them below:

- **`FAST <integer_value>`**—retrieves the first <integer_value> number of rows while continuing query execution. It works better with small data sets and low value for fast query hint. As row count is increased, query cost becomes higher.

- **`OPTIMIZE FOR`**—provides instructions to the query optimizer that a particular value for a local variable should be used when a query is compiled and optimized.

- **`USE PLAN`**—the query optimizer will use a query plan specified by the *xml_plan* attribute.

- **`RECOMPILE`**—creates a new, temporary plan for the query and discards it immediately after the query is executed.

- **`{ LOOP | MERGE | HASH } JOIN`**—specifies all join operations are performed by `LOOP JOIN`, `MERGE JOIN`, or `HASH JOIN` in the whole query. The optimizer chooses the least expensive join strategy from among the options if you specify more than one join hint.

- **`MAXDOP <integer_value>`**—overrides the max degree of parallelism value of `sp_configure`. The query specifying this option also overrides the Resource Governor.

You can also apply multiple query hints in the same query. The following example uses the `HASH GROUP` and `FAST <integer_value>` query hints in the same query.

```sql
SELECT ProductID, OrderQty, SUM(LineTotal) AS Total  
FROM Sales.SalesOrderDetail  
WHERE UnitPrice < $5.00  
GROUP BY ProductID, OrderQty  
ORDER BY ProductID, OrderQty  
OPTION (HASH GROUP, FAST 10);  
GO    
```

To learn more about query hints, see [Hints (Transact-SQL)](/sql/t-sql/queries/hints-transact-sql-query).

## Query Store hints (in preview)

The Query Store hints feature in Azure SQL Database provides a simple method for shaping query plans without modifying application code.

Query Store hints are useful when the query optimizer doesn't generate an efficient execution plan, and when the developer or DBA can't modify the original query text. In some applications, the query text may be hardcoded or automatically generated.

:::image type="content" source="../media/module-55-optimize-queries-final-19.png" alt-text="Screenshot of how Query Store hints work.":::

To use Query Store hints, you need to identify the Query Store *query_id* of the query statement you wish to modify through Query Store catalog views, built-in Query Store reports, or Query Performance Insight for Azure SQL Database. Then, execute `sp_query_store_set_hints` with the *query_id* and query hint string you wish to apply to the query.

The example below shows how to obtain the *query_id* for a specific query, and then use it to apply the `RECOMPILE` and `MAXDOP` hints to the query.

```sql
SELECT q.query_id, qt.query_sql_text
FROM sys.query_store_query_text qt 
    INNER JOIN sys.query_store_query q 
        ON qt.query_text_id = q.query_text_id 
WHERE query_sql_text like N'%ORDER BY CustomerName DESC%'  
  AND query_sql_text not like N'%query_store%'
GO

--Assuming the query_id returned by the previous query is 42
EXEC sys.sp_query_store_set_hints @query_id= 42, @query_hints = N'OPTION(RECOMPILE, MAXDOP 1)'
GO
```

There are a few scenarios where Query Store hints can help with query-level performance issues.

- Recompile a query on each execution.
- Limit the maximum degree of parallelism for a statistic update operation.
- Use a Hash join instead of a Nested Loops join.
- Use compatibility level 110 for a specific query while keeping the database at the current compatibility.

> [!NOTE]
> Query Store hints are also supported by SQL Managed Instance.

For more information about Query Store hints, see [Query Store hints](/sql/relational-databases/performance/query-store-hints).
