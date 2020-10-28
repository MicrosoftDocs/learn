It is helpful to have a basic understanding of how database optimizers work before taking a deeper dive into execution plan details. SQL Server uses what is known as cost-based query optimizer. The query optimizer calculates a cost for multiple possible plans based on the statistics it has on the columns being utilized, and the possible indexes that can be used for each operation in each query plan. Based on this information, it comes up with a total cost for each plan. Some complex queries can have thousands of possible execution plans. The optimizer does not evaluate every possible plan, but uses heuristics to determine plans that are likely to have good performance. The optimizer will then choose the lowest cost plan of all the plans evaluated for a given query.

Because the query optimizer is cost-based, it is important that it has good inputs for decision making. The statistics SQL Server uses to track the distribution of data in columns and indexes need be kept up to date, or it can cause suboptimal execution plans to be generated. SQL Server automatically updates its statistics as data changes in a table; however, more frequent updates may be needed for rapidly changing data. The engine uses a number of factors when building a plan including compatibility level of the database, row estimates based on statistics and available indexes. 

When a user submits a query to the database engine, the following process happens:

1. The query is parsed for proper syntax and a parse tree of database objects is generated if the syntax is correct.
2. The parse tree from Step 1 is taken as input to a database engine component called the Algebrizer for binding. This step validates that columns and objects in the query exist and identifies the data types that are being processed for a given query. This step outputs a query processor tree which is in the input for step 3.
3. Because query optimization is a relatively expensive process in terms of CPU consumption, the database engine caches execution plans in a special area of memory called the plan cache. If a plan for a given query already exists, that plan is retrieved from the cache. The queries whose plans are stored in cache will each have a hash value generated based on the T-SQL in the query. This value is referred to as the query_hash. When looking for a plan in cache, the engine will generate a query_hash for the current query and then look to see if it matches any existing queries in the plan case.
4. If the plan does not exist, the Query Optimizer then uses its cost-based optimizer to generate several execution plan options based on the statistics about the columns, tables, and indexes that are used in the query, as described above. The output of this step is a query execution plan.
5. The query is then executed using an execution plan that is pulled from the plan cache, or a new plan generated in step 4. The output of this step is the results of your query.

Let’s look at an example. Consider the following query:

```tsql
SELECT orderdate

 ,avg(salesAmount)

FROM FactResellerSales

WHERE ShipDate = '2013-07-07'

GROUP BY orderdate;
```

In this example SQL Server will check for the existence of the OrderDate, ShipDate, and SalesAmount columns in the table FactResellerSales. If those columns exist, it will then generate a hash value for the query and examine the plan cache for a matching hash value. If there is plan for a query with a matching hash the engine will try to reuse that plan. If there is no plan with a matching hash, it will examine the statistics it has available on the OrderDate and ShipDate columns. The WHERE clause referencing the ShipDate column is what is known as the predicate in this query. If there is a nonclustered index that includes the ShipDate column SQL Server will most likely include that in the plan, if the costs are lower than retrieving data from the clustered index. The optimizer will then choose the lowest cost plan of the available plans and execute the query.

Query plans combine a series of relational operators to retrieve the data, and also capture information about the data such as estimated row counts. Another element of the execution plan is the memory required to perform operations such as joining or sorting data. The memory needed by the query is called the memory grant. The memory grant is a good example of the importance of statistics. If SQL Server thinks an operator is going to return 10,000,000 rows, when it is only returning 100, a much larger amount of memory is granted to the query. A memory grant that is larger than necessary can cause a twofold problem. First, the query may encounter a RESOURCE_SEMAPHORE wait, which indicates that query is waiting for SQL Server to allocate it a large amount of memory. SQL Server defaults to waiting for 25 times the cost of the query (in seconds) before executing, up to 24 hours. Second, when the query is executed, if there is not enough memory available, the query will spill to tempdb, which is much slower than operating in memory.

The execution plan also stores other metadata about the query, including, but not limited to, the database compatibility level, the degree of parallelism of the query, and the parameters that are supplied if the query is parameterized.

Query plans can be viewed either in a graphical representation or in a text-based format. The text-based options are invoked with SET commands and apply only to the current connection. Text-based plans can be viewed anywhere you can run TSQL queries.

Most DBAs prefer to look at plans graphically, because a graphical plan allows you to see the plan as a whole, including what’s called the ‘shape’ of the plan, much more easily. There are several ways you can view and save graphical query plans. The most common tool used for this purpose is SQL Server Management Studio, but estimated plans can also be viewed in Azure Data Studio. There are also third-party tools that support viewing graphical execution plans.

There are three different types of execution plans that can be viewed.

**Estimated Execution Plan:** - This type is the execution plan as generated by the query optimizer. The metadata and size of query memory grant are based on estimates from the statistics as they exist in the database at the time of query compilation. To see a text-based estimated plan run the command SET SHOWPLAN_ALL ON before running the query. When you run the query, you will see the steps of the execution plan, but the query will NOT be executed, and you will not see any results. The SET option will stay in effect until you set it OFF.

**Actual Execution Plan:** - This type is same plan as the estimated plan; however this plan also contains the execution context for the query, which includes the estimated and actual row counts, any execution warnings, the actual degree of parallelism (number of processors used) and elapsed and CPU times used during the execution. To see a text-based actual plan run the command SET STATISTICS PROFILE ON before running the query. The query will execute, and you get the plan and the results.

**Live Query Statistics:** -  This plan viewing option combines the estimated and actual plans into an animated plan that displays execution progress through the operators in the plan. It refreshes every second and shows the actual number of rows flowing through the operators. The other benefit to Live Query Statistics is that it shows the handoff from operator to operator, which may be helpful in troubleshooting some performance issues. Because the type of plan is animated, it is only available as a graphical plan.
