As the amount of data stored and queried continues to rise, it becomes increasingly important to have the most price-performant data warehouse. To improve the performance of applications and reports without adding any more cost, result-set caching and materialized views are second to none.

### Result-set caching

Result-set caching helps with predictable and repetitive query patterns and enables instant query response times while reducing time-to-insight for data analysts and reporting users. Result-set caching is an effective solution for interactive dashboard performance improvement.

With result-set caching enabled, Azure Synapse Analytics automatically caches results from repetitive queries, causing subsequent query executions to return results from the persisted cache that omits complete query execution. In addition to saving compute cycles, queries satisfied by result-set cache do not use any concurrency slots and thus do not count against existing concurrency limits. For security reasons, only users with the appropriate security credentials can access the result sets in cache.

### Materialized views to improve performance

Another feature that significantly enhances query performance for a broad set of queries is materialized view support. A materialized view improves complex queries' performance (typically queries with joins and aggregations) while offering simple maintenance operations.

When materialized views are created, the Azure Synapse Analytics dedicated SQL Pool query optimizer transparently and automatically rewrite user queries to leverage deployed materialized views, leading to improved query performance. Best of all, as the data gets loaded into base tables, the query optimizer automatically maintains and refreshes materialized views, providing easier maintenance and management. As the user queries use materialized views, queries run significantly faster and use fewer system resources. A materialized view pre-computes, stores, and maintains its data in a dedicated SQL pool just like a table. There's no recomputation needed each time a materialized view is used. That's why queries that use all or a subset of the data in a materialized view can get faster performance. The more complex and expensive the query within the view is, the more significant potential for execution-time savings.

A properly designed materialized view provides the following benefits:

- Reduce the execution time for complex queries with JOINs and aggregate functions. The more complex the query, the higher the potential for execution-time saving. The most benefit is gained when a query's computation cost is high and the resulting data set is small.  
- The optimizer in the dedicated SQL pool can automatically use deployed materialized views to improve query execution plans. This process is transparent to users providing faster query performance and doesn't require queries to make direct reference to the materialized views.
- Materialized views require low maintenance.  All incremental data changes from the base tables are automatically added to the materialized views in a synchronous manner.  This design allows querying materialized views to return the same data as directly querying the base tables.
- The data in a materialized view can be distributed differently from the base tables.  
- Data in materialized views gets the same high availability and resiliency benefits as data in regular tables.  

The materialized views implemented in a dedicated SQL pool also provide the following additional benefits:

Comparing to other data warehouse providers, the materialized views implemented in Azure Synapse Analytics also provide the following additional benefits:

- Automatic and synchronous data refresh with data changes in base tables. No user action is required.
- Broad aggregate function support. See [CREATE MATERIALIZED VIEW AS SELECT (Transact-SQL)](/sql/t-sql/statements/create-materialized-view-as-select-transact-sql?toc=/azure/synapse-analytics/sql-data-warehouse/toc.json&bc=/azure/synapse-analytics/sql-data-warehouse/breadcrumb/toc.json&view=azure-sqldw-latest&preserve-view=true).
- The support for query-specific materialized view recommendation.  See [EXPLAIN (Transact-SQL)](/sql/t-sql/queries/explain-transact-sql?toc=/azure/synapse-analytics/sql-data-warehouse/toc.json&bc=/azure/synapse-analytics/sql-data-warehouse/breadcrumb/toc.json&view=azure-sqldw-latest&preserve-view=true).