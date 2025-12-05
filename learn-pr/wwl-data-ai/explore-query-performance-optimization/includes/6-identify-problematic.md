The typical approach DBAs take to troubleshoot query performance involves first identifying the problematic query, usually the one consuming the most system resources, and then retrieving its execution plan. There are two main scenarios. One scenario is that the query consistently performs poorly. This can be due to various issues, such as hardware resource constraints (though this usually doesn't affect a single query running in isolation), suboptimal query structure, database compatibility settings, missing indexes, or poor plan choices by the query optimizer. The second scenario is that the query performs well in some executions but poorly in others. This inconsistency can be caused by factors like data skew in a parameterized query, which has an efficient plan for some executions and a poor one for others. Other common factors include blocking, where a query waits for another query to complete to gain access to a table, or hardware contention.

Let's explore each of these scenarios in more detail.

## Hardware constraints

Hardware constraints typically don't manifest during single query executions but become evident under production load when CPU threads and memory are limited. CPU contention can be detected by observing the performance monitor counter '% Processor Time', which measures server CPU usage. In SQL Server, *SOS_SCHEDULER_YIELD* and *CXPACKET* wait types can indicate CPU pressure. Poor storage system performance can slow down even optimized single query executions. Storage performance is best tracked at the operating system level using performance monitor counters `Disk Seconds/Read` and `Disk Seconds/Write`, which measure I/O operation completion times. SQL Server logs poor storage performance if an I/O takes longer than 15 seconds. High *PAGEIOLATCH_SH* waits in SQL Server can indicate storage performance issues. Hardware performance is typically evaluated early in the troubleshooting process due to its ease of assessment.

Most database performance issues stem from suboptimal query patterns, which can put undue pressure on hardware. For example, missing indexes can lead to CPU, storage, and memory pressure by retrieving more data than necessary. It's recommended to address and tune suboptimal queries before tackling hardware issues. Next, we look at query tuning.

## Suboptimal query constructs

Relational databases perform best when executing set-based operations, which manipulate data (`INSERT`, `UPDATE`, `DELETE`, and `SELECT`) in sets, producing either a single value or a result set. The alternative is row-based processing, using cursors or while loops, which increase cost linearly with the number of rows impacted—a problematic scale as data volumes grow.

Detecting suboptimal use of row-based operations with cursors or WHILE loops is important, but there are other SQL Server anti-patterns to recognize. Table-valued functions (TVFs), particularly multi-statement TVFs, caused problematic execution plan patterns before SQL Server 2017. Developers often use multi-statement TVFs to execute multiple queries within a single function and aggregate results into a single table. However, using TVFs can lead to performance penalties.

SQL Server has two types of TVFs: inline and multi-statement. Inline TVFs are treated like views, while multi-statement TVFs are treated like tables during query processing. Because TVFs are dynamic and lack statistics, SQL Server uses a fixed row count for estimating query plan cost. This can be fine for small row counts, but inefficient for thousands or millions of rows.

Another anti-pattern is the use of scalar functions, which have similar estimation and execution problems. Microsoft has made significant performance improvements with Intelligent Query Processing, under compatibility levels 140 and 150.

## SARGability

The term SARGable in relational databases refers to a predicate (`WHERE` clause) formatted to use an index to speed up query execution. Predicates in the correct format are called 'Search Arguments' or SARGs. In SQL Server, using a SARG means the optimizer evaluates using a nonclustered index on the column referenced in the SARG for a *SEEK* operation, instead of scanning the entire index or table to retrieve a value.

The presence of a SARG doesn't guarantee the use of an index for a *SEEK*. The optimizer’s costing algorithms could still determine that the index is too expensive, especially if a SARG refers to a large percentage of rows in a table. The absence of a SARG means the optimizer won't evaluate a SEEK on a nonclustered index.

Examples of non-SARGable expressions include those with a `LIKE` clause using a wildcard at the beginning of the string, such as `WHERE lastName LIKE '%SMITH%'`. Other non-SARGable predicates occur when using functions on a column, like `WHERE CONVERT(CHAR(10), CreateDate,121) = '2020-03-22'`. These queries are typically identified by examining execution plans for index or table scans where seeks should otherwise occur.

:::image type="content" source="../media/module-55-optimize-queries-final-07.png" alt-text="Screenshot of query and execution plan using a non-SARGable function.":::

There's an index on the *City* column that is being used in the `WHERE` clause of the query and while it's being used in this execution plan above, you can see the index is being scanned, which means the entire index is being read. The `LEFT` function in the predicate makes this expression non-SARGable. The optimizer won't evaluate using an index seek on the index on the *City* column.

This query could be written to use a predicate that is SARGable. The optimizer would then evaluate a *SEEK* on the index on the *City* column. An index seek operator, in this case, would read a smaller set of rows.

:::image type="content" source="../media/module-55-optimize-queries-final-08.png" alt-text="Screenshot of a query and execution plan with a SARGable Predicate.":::

Changing `LEFT` function into a `LIKE` results in an index seek.

>[!NOTE]
>The `LIKE` keyword, in this example, doesn't have a wildcard on the left, so it's looking for cities that begin with M. If it was “two-sided” or started with a wildcard ('%M%' or '%M') it would be non-SARGable. The seek operation is estimated to return 1,267 rows, or approximately 15% of the estimate for the query with the non-SARGable predicate.

Some other database development anti-patterns are treating the database as a service rather than a data store. Using a database to convert data to JSON, manipulate strings, or perform complex calculations can lead to excessive CPU use and increased latency. Queries that try to retrieve all records and then perform computations in the database can lead to excessive IO and CPU usage. Ideally, you should use the database for data access operations and optimized database constructs like aggregation.

## Missing indexes

The most common performance problems for database administrators stem from a lack of useful indexes, causing the engine to read more pages than necessary to return query results. While indexes consume resources (affecting write performance and consuming space), their performance gains often outweigh the extra resource costs. Execution plans with these issues can be identified by the query operator *Clustered Index Scan* or the combination of *Nonclustered Index Seek* and *Key Lookup*, indicating missing columns in an existing index.

The database engine helps by reporting missing indexes in execution plans. The names and details of recommended indexes are available through the dynamic management view `sys.dm_db_missing_index_details`. Other DMVs like `sys.dm_db_index_usage_stats` and `sys.dm_db_index_operational_stats` highlight the utilization of existing indexes.

Dropping an unused index can be sensible. Missing index DMVs and plan warnings should be starting points for tuning queries. It's crucial to understand key queries and build indexes to support them. Creating all missing indexes without evaluating them in context isn't recommended.

## Missing and out-of-date statistics

Understanding the importance of column and index statistics to the query optimizer is crucial. It's also essential to recognize conditions that can lead to out-of-date statistics and how this issue can manifest in SQL Server. Azure SQL offerings default to having autoupdate statistics set to ON. Before SQL Server 2016, the default behavior of autoupdate statistics was to not update statistics until the number of modifications to columns in the index equaled about 20% of the number of rows in a table. This behavior could result in significant data modifications that change query performance without updating the statistics, leading to suboptimal plans based on outdated statistics.

Before SQL Server 2016, trace flag 2371 could be used to change the required number of modifications to a dynamic value, so as your table grew, the percentage of row modifications needed to trigger a statistics update decreased. Newer versions of SQL Server, Azure SQL Database, and Azure SQL Managed Instance support this behavior by default. The dynamic management function `sys.dm_db_stats_properties` shows the last time statistics were updated and the number of modifications since the last update, allowing you to quickly identify statistics that might need manual updates.

## Poor optimizer choices

While the query optimizer does a good job of optimizing most queries, there are some edge cases where the cost-based optimizer can make impactful decisions that aren't fully understood. There are many ways to address this including using query hints, trace flags, execution plan forcing, and other adjustments in order to reach a stable and optimal query plan. Microsoft has a support team that can help troubleshoot these scenarios.

In the below example from the *AdventureWorks2017* database, a query hint is being use to tell the database optimizer to always use a city name of Seattle. This hint won't guarantee the best execution plan for all city values, but it's predictable. The value of ‘Seattle’ for `@city_name` will only be used during optimization. During execution, the actual supplied value `(‘Ascheim’)` is used.

```sql
DECLARE @city_name nvarchar(30) = 'Ascheim',
        @postal_code nvarchar(15) = 86171;

SELECT * 
FROM Person.Address
WHERE City = @city_name 
      AND PostalCode = @postal_code
OPTION (OPTIMIZE FOR (@city_name = 'Seattle');
```

As seen in the example, the query uses a hint (the `OPTION` clause) to tell the optimizer to use a specific variable value to build its execution plan.

## Parameter sniffing

SQL Server caches query execution plans for future use. Since the execution plan retrieval process is based on the hash value of a query, the query text has to be identical for every execution of the query for the cached plan to be used. In order to support multiple values in the same query, many developers use parameters, passed in through stored procedures, as seen in the following example:

```sql
CREATE PROC GetAccountID (@Param INT)
AS

<other statements in procedure>

SELECT accountid FROM CustomerSales WHERE sales > @Param;

<other statements in procedure>

RETURN;

-- Call the procedure:

EXEC GetAccountID 42;
```

Queries can also be explicitly parameterized using the procedure `sp_executesql`. However, explicit parameterization of individual queries is done through the application with some form (depending on the API) of *PREPARE* and *EXECUTE*. When the database engine executes that query for the first time, it optimizes the query based on the initial value of the parameter, in this case, 42. This behavior, called parameter sniffing, allows for the overall workload of compiling queries to be reduced on the server. However, if there's data skew, query performance could vary widely. 

For example, a table that had 10 million records, and 99% of those records have an ID of 1, and the other 1% are unique numbers, performance is based on which ID was initially used to optimize the query. This wildly fluctuating performance is indicative of data skew and isn't an inherent problem with parameter sniffing. This behavior is a fairly common performance problem that you should be aware of. You should understand the options for alleviating the issue. There a few ways to address this problem, but they each come with tradeoffs:

- Use the `RECOMPILE` hint in your query, or the `WITH RECOMPILE` execution option in your stored procedures. This hint causes the query or procedure to be recompiled every time it's executed, which will increase CPU utilization on the server but will always use the current parameter value.
- You can use the `OPTIMIZE FOR UNKNOWN` query hint. This hint causes the optimizer to choose to not sniff parameters and compare the value with column data histogram. This option won't get you the best possible plan but will allow for a consistent execution plan.
- Rewrite your procedure or queries by adding logic around parameter values to only RECOMPILE for known troublesome parameters. In the example below, if the SalesPersonID parameter is NULL, the query is executed with the `OPTION (RECOMPILE)`.

```sql
CREATE OR ALTER PROCEDURE GetSalesInfo (@SalesPersonID INT = NULL)
AS
DECLARE  @Recompile BIT = 0
         , @SQLString NVARCHAR(500)

SELECT @SQLString = N'SELECT SalesOrderId, OrderDate FROM Sales.SalesOrderHeader WHERE SalesPersonID = @SalesPersonID'

IF @SalesPersonID IS NULL
BEGIN
     SET @Recompile = 1
END

IF @Recompile = 1
BEGIN
    SET @SQLString = @SQLString + N' OPTION(RECOMPILE)'
END

EXEC sp_executesql @SQLString
    ,N'@SalesPersonID INT'
    ,@SalesPersonID = @SalesPersonID
GO
```

This example is a good solution but it does require a fairly large development effort, and a firm understanding of your data distribution. It requires maintenance as the data changes.
