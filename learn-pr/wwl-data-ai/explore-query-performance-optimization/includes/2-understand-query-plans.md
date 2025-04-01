Understanding how database optimizers work is essential before diving into execution plan details. SQL Server uses a cost-based query optimizer, which calculates the cost for multiple possible plans based on statistics it has on the columns being used and the potential indexes for each operation in the query plan. This information helps the optimizer determine the total cost for each plan. Complex queries can have thousands of possible execution plans, but the optimizer doesn't evaluate every single one. Instead, it uses heuristics to identify plans that are likely to perform well and then selects the lowest cost plan from those evaluated.

Since the query optimizer is cost-based, it's crucial to provide it with accurate inputs for decision-making. SQL Server relies on statistics to track the distribution of data in columns and indexes, and these statistics must be kept up to date to avoid generating suboptimal execution plans. Although SQL Server automatically updates its statistics as data changes in a table, more frequent updates may be necessary for rapidly changing data. The optimizer considers many factors when building a plan, including the database's compatibility level, row estimates based on statistics, and available indexes.

When a user submits a query to the database engine, the following process happens:

1. The query is parsed for proper syntax, and if correct, a parse tree of database objects is generated.
2. The parse tree is then input to a database engine component called the *Algebrizer* for binding. This step validates that columns and objects in the query exist and identifies the data types being processed. The output is a query processor tree, which serves as input for the next step.
3. Query optimization is CPU-intensive, so the database engine caches execution plans in a special memory area called the plan cache. If a plan for the query already exists, it's retrieved from the cache. Each query in the cache has a hash value generated based on the T-SQL in the query, known as the *query_hash*. The engine generates a *query_hash* for the current query and checks for matches in the plan cache.
4. If no plan exists, the Query Optimizer uses its cost-based optimizer to generate several execution plan options based on statistics about the columns, tables, and indexes used in the query. The output is a query execution plan.
5. The query is executed using an execution plan from the plan cache or a new plan generated in the previous step. The output is the results of your query.

>[!NOTE]
> To learn more about how the query processor works, see [Query Processing Architecture Guide](/sql/relational-databases/query-processing-architecture-guide)

Let’s look at an example. Consider the following query:

```sql
SELECT orderdate,
        AVG(salesAmount)
FROM FactResellerSales
WHERE ShipDate = '2013-07-07'
GROUP BY orderdate;
```

In this example, SQL Server checks for the existence of the *OrderDate*, *ShipDate*, and *SalesAmount* columns in the *FactResellerSales* table. If these columns exist, SQL Server generates a hash value for the query and examines the plan cache for a matching hash value. If a matching hash value is found, the engine attempts to reuse the plan. If no matching hash value is found, SQL Server examines the available statistics on the *OrderDate* and *ShipDate* columns.

The `WHERE` clause referencing the *ShipDate* column is known as the predicate in this query. If there's a nonclustered index that includes the *ShipDate* column, SQL Server will likely include it in the plan, provided the costs are lower than retrieving data from the clustered index. The optimizer then chooses the lowest cost plan from the available options and executes the query.

Query plans combine a series of relational operators to retrieve data and capture information such as estimated row counts. Another element of the execution plan is the memory required for operations like joining or sorting data, known as the memory grant. The memory grant highlights the importance of statistics. If SQL Server estimates an operator returns 10,000,000 rows when it actually returns 100, a larger memory grant is allocated to the query. An excessively large memory grant can cause two issues. First, the query may encounter a `RESOURCE_SEMAPHORE` wait, indicating it's waiting for SQL Server to allocate a large amount of memory. SQL Server defaults to waiting for 25 times the cost of the query (in seconds) before executing, up to 24 hours. Second, if there isn't enough memory available when the query is executed, it spills to tempdb, which is slower than operating in memory.

The execution plan also stores other metadata about the query, such as the database compatibility level, the degree of parallelism, and the parameters supplied if the query is parameterized.

Query plans can be viewed in either a graphical representation or a text-based format. Text-based options are invoked with SET commands and apply only to the current connection. These plans can be viewed anywhere you can run T-SQL queries.

Most DBAs prefer graphical plans because they allow you to see the plan as a whole, including the *shape* of the plan. There are several ways to view and save graphical query plans. The most common tool for this purpose is SQL Server Management Studio, but estimated plans can also be viewed in Azure Data Studio. Additionally, there are third-party tools that support viewing graphical execution plans.

There are three different types of execution plans.

### Estimated Execution Plan

This type of execution plan is generated by the query optimizer. The metadata and size of the query memory grant are based on estimates from the statistics present in the database at the time of query compilation. To see a text-based estimated plan, run the command `SET SHOWPLAN_ALL ON` before executing the query. When you run the query, you see the steps of the execution plan, but the query won't be executed, and you won't see any results. The SET option remains in effect until you set it OFF.

### Actual Execution Plan

This type of plan is the same as the estimated plan; however, it also includes the execution context for the query. This context contains the estimated and actual row counts, any execution warnings, the actual degree of parallelism (number of processors used), and the elapsed and CPU times used during execution. To see a text-based actual plan, run the command `SET STATISTICS PROFILE ON` before executing the query. The query executes, and you get both the plan and the results.

### Live Query Statistics

This plan viewing option combines the estimated and actual plans into an animated plan that displays execution progress through the operators. It refreshes every second and shows the actual number of rows flowing through the operators. Another benefit of Live Query Statistics is that it shows the handoff from operator to operator, which can be helpful in troubleshooting performance issues. Because this type of plan is animated, it's only available as a graphical plan.
