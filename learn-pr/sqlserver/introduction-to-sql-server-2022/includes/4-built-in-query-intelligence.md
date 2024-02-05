SQL Server 2022 provides built-in capabilities to reduce time for query tuning, including the Query Store and next generation Intelligent Query Processing (IQP) features, to help you gain faster and more consistent performance with no code changes.

## Challenges for query tuning

Developers and SQL experts agree that while some queries just work, some performance situations can arise for queries that require performance troubleshooting and query tuning exercises. Tuning query performance can be an expensive and often lengthy process.

## Solutions for query tuning using the Query Store

The Query Store is a built-in set of query performance statistics stored in a user database. The Query Store automatically captures a history of queries, plans, and runtime statistics, and retains this information for your review. It separates data by time windows so you can see database usage patterns and understand when query plan changes happened on the server. For more information, see [Monitor performance by using the Query Store](https://aka.ms/querystore).

SQL Server 2022 includes important enhancements to the Query Store to reduce the amount of time for query tuning.

### Query Store on by default

Prior to SQL Server 2022, the Query Store must be enabled using the T-SQL [**ALTER DATABASE**](/sql/t-sql/statements/alter-database-transact-sql) statement. For SQL Server 2022, any new database created will have the Query Store enabled by default. Databases that have been restored from previous versions of SQL Server will retain the Query Store settings captured when the database was backed up. The Query Store has had several enhancements since its inception in SQL Server 2016 that allow users to enable the Query Store without significantly affecting application performance. In addition, several new settings are possible in the Query Store to allow users to more easily control how query performance information is captured and cleaned up. Users can disable the Query Store at any time by using the T-SQL **ALTER DATABASE** statement.

### Query Store hints

Query Store hints provide an easy-to-use method for shaping query plans without changing application code. You can take any query that is stored in the Query Store and use system stored procedures to apply a query hint. The query hint affects the query plan with the intention of improving query performance, without changing application code. For example, you could apply a query store hint to require a query to use a specific `MAXDOP` value without changing the query text.

Query store hints aren't intended to be used as a normal step to tune query performance, but can be a useful tool for query tuning, especially if you can't change the query text in an application. In addition, some new Intelligent Query Processing features use a query store hint. You can view any persisted query store hints in the **sys.query_store_query_hints** catalog view. For more information, see [Query Store hints](https://aka.ms/querystorehints).

### Query Store for read replicas

While the Query Store is beneficial for reducing the amount of time required to tune queries or to easily identify query performance issues, performance information is only available for queries executed against the primary replica in an Always On availability group. In SQL Server 2022, a new option is available using the T-SQL **ALTER DATABASE** statement to enable the Query Store to collect performance information for read-only queries executed on secondary replicas. All performance information for all replicas is persisted on the primary replica. New information is captured in the Query Store to indicate which replica is associated with a query or query plan.

> [!NOTE]
> Trace flag 12606 is required to enable Query Store for secondary replicas.

### Query store for Intelligent Query Processing

While the Query Store collects key performance information for queries, the query processor in SQL Server 2022 will also use the Query Store to persist information to accelerate query performance. These features include optimized plan forcing, memory grant feedback, cardinality estimation (CE) model feedback, and degree of parallelism (DOP) feedback.

## Solutions for faster performance with the next generation of Intelligent Query Processing

Intelligent Query Processing (IQP) is a family of capabilities built into the query processor in the database engine, designed to accelerate performance with no code changes. The next generation of Intelligent Query Processing is built on a foundation of capabilities found in SQL Server 2017 and 2019, as seen in the following diagram:

:::image type="content" source="../media/intelligent-query-processing-feature-family.png" alt-text="Diagram of the Intelligent Query Processing feature family.":::

As you can see, there have been several IQP features that were part of SQL Server 2017 and SQL Server 2019. SQL Server 2022 adds several new capabilities for IQP. You can keep up to date with all the latest on IQP capabilities at [Intelligent query processing in SQL databases](https://aka.ms/iqp). Let's examine each of these new capabilities.

The database engine uses two principles to make decisions for Intelligent Query Processing:

- Avoid causing any query performance regressions by using a new method or automation.
- Provide a method at the database or query level to disable a specific IQP capability. You can pick and choose which IQP feature you want enabled at the database or query level, while using other IQP feature depending on your database compatibility level.

## Capabilities after upgrading to SQL Server 2022

If you upgrade to SQL Server 2022, there are new capabilities to accelerate performance independently of the database compatibility level for your database. The compatibility level allows you to take advantage of new features even if you need to use a database compatibility level from a previous version of SQL Server. For more information, see [Compatibility certification](https://aka.ms/dbcompat).

### Approximate percentile functions

SQL Server includes two Transact-SQL (T-SQL) functions to help analytic workload calculate a percentile of a range of values:

- **PERCENTILE_CONT**
- **PERCENTILE_DISC**

SQL Server 2022 provides *approximate* equivalent to these two functions:

- **APPROX_PERCENTILE_CONT**
- **APPROX_PERCENTILE_DISC**

The approximate percentile functions could be useful for analytic workloads with exceptionally large sets of data. These functions will perform faster, and the implementation guarantees up to a 1.33% error rate within a 99% probability.

### Optimized plan forcing

Optimized plan forcing is a new capability in SQL Server 2022 intended to reduce the time it takes to compile certain queries if the query plan is forced in Query Store.

Some queries by their nature can take a significant amount of time to compile. Optimized plan forcing provides a method to reduce the time it takes to compile a query by storing in the Query Store *compilation steps* for eligible queries that have query plans that are forced in the Query Store. Query plan forcing allows you to lock in a query plan for a specific query. The next time a query needs to be compiled that has optimized plan forcing enabled, compilation steps are used to significantly accelerate the compile phase to execute a query.

For more information, see [Optimized plan forcing with Query Store](/sql/relational-databases/performance/optimized-plan-forcing-query-store).

## SQL Server 2022 IQP capabilities using database compatibility level 140 or greater

You can get more Intelligent Query Processing capabilities to enhance memory grant feedback in SQL Server 2022 if you're using a database compatibility level 140 or greater. Memory grant feedback was introduced in SQL Server 2017 (batch mode) and SQL Server 2019 (row mode). Memory grant feedback is a mechanism where the query processor will *learn* from execution feedback to adjust a memory grant for further executions, thereby avoiding or reducing tempdb spills and RESOURCE_SEMAPHORE waits.

### Memory grant feedback percentiles

Prior to SQL Server 2022, memory grant feedback was based on the most recent execution for a specific query. This could result in some cases of different feedback adjustments, which could lead the query processor to disable memory grant feedback for a specific query. In SQL Server 2022, memory grant feedback uses a percentile method to look at memory grants over several executions before using a memory grant feedback.

### Memory grant feedback persistence

Prior to SQL Server 2022, memory grant feedback was only stored in a cached plan in memory. If the cache plan was evicted, memory grant feedback would have to be recalculated on new query executions. In SQL Server 2022 with the Query Store enabled, memory grant feedback will be persisted in the Query Store. You can view memory grant feedback persistence from the **sys.query_store_plan_feedback** catalog view.

For more information, see [Memory grant feedback](/sql/relational-databases/performance/intelligent-query-processing-feedback#memory-grant-feedback).

## SQL Server 2022 IQP capabilities using database compatibility level 160 or greater

You can get more Intelligent Query Processing capabilities, such as Parameter Sensitive Plan optimization, enhancements to Cardinality Estimation, and degree of parallelism if you use a database compatibility level 160 or greater.

### Parameter Sensitive Plan optimization

When a query is compiled, the execution plan built takes into account values for any parameters used in queries in a stored procedure or parameterized query. This concept is called *parameter sniffing*. Only one query plan can exist in cache for statements in a stored procedure or parameterized query. In most cases, this doesn't result in any performance problems for applications. However, there are situations where the data retrieved for queries based on parameters can be *skewed*, or not evenly distributed. In these cases, the single cache plan may not be optimal for different parameter values. This problem is known as a *parameter sensitive plan*.

In SQL Server 2022, the optimizer can detect parameter sensitive plan scenarios and cache multiple plans for the same stored procedure or parameterized query. The optimizer uses a concept called *query variants* to aggregate sets of parameter values to match a query plan best suited for those parameter values.

For more information, see [Parameter Sensitive Plan optimization](https://aka.ms/pspopt).

### Cardinality Estimation (CE) Feedback

In SQL Server 2014 with database compatibility level 120, Microsoft started using a new *model* within the query processor to make certain assumptions about cardinality estimation for certain query patterns. In some cases, the new model generated a more correct query plan but might result in slower performance than with the *legacy* CE model. The CE model scenarios include correlation, join containment, and row goal. Since SQL Server 2014, several options have been included to use the legacy CE model or control CE behavior at the database level or query level with trace flags or query hints.

In SQL Server 2022 with the Query Store enabled, the optimizer will evaluate highly repetitive queries that match patterns for CE model scenarios where the model may be making an incorrect assumption. The optimizer will then attempt to test and verify whether a query hint could be used to allow the query to perform faster. Upon verification of faster performance, a query hint will be persisted in the Query Store to be used for future query executions. You can see any applied query hints for CE feedback in the **sys.query_store_query_hints** catalog view and CE feedback details in the **sys.query_store_plan_feedback** catalog view. CE feedback will not be used if the legacy CE model has been enabled, if a query plan is forced in the query store, or if a query has existing query store hints.

For more information, see [Cardinality Estimation](https://aka.ms/cefeedback).

### Degree of parallelism (DOP) feedback

The optimizer in SQL Server will in some cases run pieces of the query plan (called *operators*) using parallelism with multiple concurrent threads. The number of threads used for a query plan operator is called degree of parallelism (DOP). SQL Server can control the maximum number of threads per operator using server, database, resource group, or query settings called max degree of parallelism (MAXDOP). Setting the right MAXDOP for a SQL Server deployment can be a complex and sometimes difficult exercise.

In SQL Server 2022, the optimizer can use a technique called DOP feedback to find the *parallel efficiency* for a query. Parallel efficiency is the minimum DOP for a query that can result in the same overall query duration (factoring out common waits). Reducing the DOP for a query can provide more threads and CPU resources for other queries or applications.

DOP feedback requires the Query Store to be enabled, database compatibility level 160, and a database setting called `DOP_FEEDBACK` to be turned on. With these settings, the optimizer will work in coordination with Query Store background tasks to look for repetitive and long-running queries that could benefit from a lower DOP. A feedback cycle will be used to validate an adjusted query duration (factoring out waits) won't regress with a lower DOP value and that lower overall CPU is observed for the query. After a period of validation, a lower DOP is considered stabilized and will be persisted in the Query Store. The optimizer will continue to validate lower DOP values in a stepwise down fashion to find the best parallel efficiency or a minimum DOP, which is 2. DOP feedback will never increase DOP and will honor the MAXDOP setting for a query depending on any server, database, resource governor, or query hint that has been applied.

DOP feedback doesn't require recompilation, but validation will be examined on any new query compilation. You can observe persisted DOP feedback values in the **sys.query_store_plan_feedback** catalog view. You can see what is the most recent DOP used for a query using the `last_dop` column from the Dynamic Management View **sys.dm_exec_query_stats** and the **sys.query_store_runtime_stats** catalog view.

For more information, see [Degree of parallelism (DOP) feedback](https://aka.ms/dopfeedback).
