
## How to obtain a query plan in Azure Synapse Analytics dedicated SQL Pool ##

Often Database Engineers and Database Administrators have a need to analyze and investigate query execution in SQL Pools. This analysis is done by using dynamic management views (DMVs).
> [!Note] 
> Permissions to query the DMVs require either **VIEW DATABASE STATE** or **CONTROL** permission, in typical scenarios, granting **VIEW DATABASE STATE** is the preferred method as it is more restrictive
> ``` SQL
> GRANT VIEW DATABASE STATE to TestUser; 
> ```

> [!Warning]
> An attacker can use **sys.dm_pdw_exec_requests** to retrieve information about specific database objects by simply having VIEW SERVER STATE permission and by not having database-specific permission.
>
Azure Synapse queries. which are executed are logged, ** sys.dm_pdw_exec_requests ** contains the last 10,000 queries executed. 
you can use the following query to determine the top 10 longest running queries 
```SQL
SELECT TOP 10 request_id, status, total_elapsed_time
FROM sys.dm_pdw_exec_requests
WHERE status not in ('completed', 'Failed','Cancelled')
ORDER BY total_elapsed_time DESC
```
When looking at the results, those in a **suspended** state can be queued due to a lack of resources from a large number of active running queries. These queries will also appear in the **sys.dm_pdw_waits** in which your focus would be more on waits including **UserConcurrencyResourceType**. There are other reasons that queries may be in a wait queue such as object locks. More information on this topic can be found by [investigating queries waiting for resources.](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-manage-monitor#monitor-waiting-queries)

> [!Note]
> It's a recommended best practice to use [LABEL](/sql/t-sql/queries/option-clause-transact-sql?toc=%2Fazure%2Fsynapse-analytics%2Fsql-data-warehouse%2Ftoc.json&bc=%2Fazure%2Fsynapse-analytics%2Fsql-data-warehouse%2Fbreadcrumb%2Ftoc.json&view=azure-sqldw-latest&preserve-view=true) so users can easily find and troubleshoot poorly performing queries using **sys.dm_pdw_exec_requests**shown below:
>```SQL
> -- you can use an asterisk to show all attributes returned from the DMV
> -- but request_id is what will be used in the next step.
>
> SELECT request_id, status, total_elapsed_time
> FROM sys.dm_pdw_exec_requests
> WHERE [label] = 'MyQuery';
> ```
### How to read the query plan ###

Once the request_id has been obtained, use it with the **sys.dm_pdw_request_steps** to retrieve the distributed SQL (DSQL) plan as shown below:

```SQL
-- be sure to replace QID#### with the request_id you retrieved above

SELECT * FROM sys.dm_pdw_request_steps
WHERE request_id = 'QID####'
ORDER BY step_index;
```
> [!Note]
> If the DSQL plan is taking a lengthy amount of time to return, it could be caused by a complex plan requiring many DSQL steps or just a long running step. If there are several **move** operations within the plan with a lot of steps, then consider optimizing the impacted [table distribution(s)](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-distribute) to reduce data movement.

When looking at the returned DSQL plan, further information about individual steps by looking at the *operation_type* of any long-running step. Take note of the **Step Index** which we'll use to investigate two types of performance impacting operations including 


 **SQL Operations** which include:
- OnOperation
- Remote Operation
- Return Operation

 **Data Movement Operations** including:
- ShuffleMoveOperation
- BroadcastMoveOperation
- TrimMoveOperation
- PartitionMoveOperation
- MoveOperation
- CopyOperation

From the prior step using **sys.dm_pdw_request_steps**, we want to  use the *request_id* and *step_index* to retrieve execution information of the query step on **all** of the distributed database using a query similar to the one below.
```SQL
--Find the distribution run times for a particular SQL Step
--retrieve request_id and step_index with the values from the steps above.

SELECT * FROM sys.dm_pdw_sql_requests
WHERE request_id = 'QID####' AND step_index = 4;
```

When, the query step is still *running* the **DBCC PDW_SHOWEXECUTIONPLAN** can be utilized to retrieve the SQL Server estrimatedplan from the plan cache for the step running on a specific distribution as shown below.
```SQL
 --Retrieve the SQL Server execution plan for a running query on a particular SQL pool or control node
 --Replace distribution_id and spid from the results from the previous query
 --DBCC PDW_SHOWEXECUTIONPLAN( distribution_id, spid)

 DBCC PDW_SHOWEXECUTIONPLAN(7, 31)
```
## Looking for movement on the distributed databases ##

Using the *Request ID* and the *Step Index* as previously retrieved above with **sys.dm_pdw_dms_workers** will allow the retrieval of information about any data movement steps running on each distribution as shown below.
```SQL
 --Find all workers that are completing a Data Movement Step and their details
 --Replace request_id and step_index with the values from the prior steps shown above.

SELECT * FROM sys.dm_pdw_dms_workers
WHERE request_id = 'QID####' AND step_index = 2;

```
> [!Note]
> checking the *total_elapsed_time* will help determine if a particular distribution is taking significantly longer than others for data movement.
> for any long-running distribution, check the *rows_processed* column to derminie if it is materially larger than others. if so, this might indicate skew of your underlying data.

One example of a bad operation that can cause performance problems such as data skew is distributing on a column that contains a lot of NULL values, which will cause those rows to land in the same distribution. If possible, eliminate nulls or filter them out of your query altogether to increase performance.

To help resolve issues, refer to the sections on [Create Statistics to Improve Performance](/learn/modules/optimize-data-warehouse-query-performance-azure-synapse-analytics/7-create-statistics-to-improve), [Understand performance issues related to tables ](/learn/modules/optimize-data-warehouse-query-performance-azure-synapse-analytics/2-understand-performance-issues-related-to-tables), [understand table distribution design](/learn/modules/optimize-data-warehouse-query-performance-azure-synapse-analytics/4-understand-table-distribution-design), and [use indexes to improve performance](/learn/modules/optimize-data-warehouse-query-performance-azure-synapse-analytics/5-use-indexes-to-improve)