
Materialized views in the Azure Synapse SQL pool provide a low maintenance method for complex analytical queries to quickly perform without any query change. SQL pool in Azure Synapse supports standard and materialized views. Both are virtual tables created with SELECT expressions and presented to queries as logical tables. Views encapsulate the complexity of common data computation and add an abstraction layer to computation changes, so there's no need to rewrite queries.

| Comparison                     | View                                         | Materialized view
|:-------------------------------|:---------------------------------------------|:--------------------------------------------------------------|
|View definition                 | Stored in SQL pool.              | Stored in SQL pool.
|View content                    | Generated each time when the view is used.   | Pre-processed and stored in SQL pool during view creation. Updated as data is added to the underlying tables.
|Data refresh                    | Always updated                               | Always updated
|Speed to retrieve view data from complex queries     | Slow                                         | Fast  
|Extra storage                   | No                                           | Yes
|Syntax                          | CREATE VIEW                                  | CREATE MATERIALIZED VIEW AS SELECT

A materialized view pre-computes, stores, and maintains its data in SQL pool just like a table. There's no recomputation needed each time when a materialized view is used. That's why queries that use all or a subset of the data in materialized views can get faster performance. Even better, queries can use a materialized view without directly referencing it, so there's no need to change the application code.

An adequately designed materialized view provides the following benefits:

* Reduce the execution time for complex queries with JOINs and aggregate functions. The more complex the query, the higher the potential for execution-time saving. The most benefit is gained when a query's computation cost is high, and the resulting data set is small.
* The optimizer in the SQL pool can automatically use deployed materialized views to improve query execution plans. This process is transparent to users providing faster query performance, and doesn't require queries to make direct reference to the materialized views.
* Requires low maintenance on the views. All incremental data changes from the base tables are automatically added to the materialized views synchronously. This design allows querying materialized views to return the same data as directly querying the base tables.
* The data in a materialized view can be distributed differently from the base tables.
* Data in materialized views gets the same high availability and resiliency benefits as data in regular tables.

Comparing to other data warehouse providers, the materialized views implemented in Azure Synapse Analytics also provide the following additional benefits:

* Automatic and synchronous data refresh with data changes in base tables. No user action is required.
* Broad aggregate function support. See [CREATE MATERIALIZED VIEW AS SELECT (Transact-SQL)](/sql/t-sql/statements/create-materialized-view-as-select-transact-sql?toc=/azure/synapse-analytics/sql-data-warehouse/toc.json&bc=/azure/synapse-analytics/sql-data-warehouse/breadcrumb/toc.json&view=azure-sqldw-latest&preserve-view=true).
* The support for query-specific materialized view recommendation. See [EXPLAIN (Transact-SQL)](/sql/t-sql/queries/explain-transact-sql?toc=/azure/synapse-analytics/sql-data-warehouse/toc.json&bc=/azure/synapse-analytics/sql-data-warehouse/breadcrumb/toc.json&view=azure-sqldw-latest&preserve-view=true).

Before you begin to create materialized views, it's essential to have a deep understanding of your workload in terms of query patterns, importance, frequency, and resulting data size.
Users can run EXPLAIN WITH_RECOMMENDATIONS <SQL_statement> to get the materialized views recommended by the query optimizer. Since these recommendations are query-specific, a materialized view that benefits a single query may not be optimal for other queries in the same workload.
