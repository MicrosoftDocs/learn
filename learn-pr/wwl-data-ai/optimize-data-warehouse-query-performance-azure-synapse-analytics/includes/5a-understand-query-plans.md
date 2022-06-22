
## How to obtain a query plan in Azure Synapse Analytics dedicated SQL Pool ##

Often Database Engineers and Database Administrators have a need to analysi and investigate query execution in SQL Pools. This is done through the use of dynamic management views (DMVs).
> [!Note] 
> Permissions to query the DMVs require either **VIEW DATABASE STATE** or **CONTROL** permission, in typical scenarios, granting **VIEW DATABASE STATE** is the preferred method as it is more restrictive
> ``` SQL
> GRANT VIEW DATABASE STATE to TestUser; 
> ```

> [!Warning]
> An attacker can use **sys.dm_pdw_exec_requests** to retrieve information about specific database objects by simply having VIEW SERVER STATE permission and by not having database-specific permission.
>
Azure Snyapse queries which are executed are logged, ** sys.dm_pdw_exec_requests ** contains the last 10,000 queries executed. 
you can use the following query to determine the top 10 longest running queries 
```SQL
SELECT TOP 10 request_id, status, total_elapsed_time
FROM sys.dm_pdw_exec_requests
WHERE status not in ('completed', 'Failed','Cancelled')
ORDER BY total_elapsed_time DESC
```
When looking at the results, note that those in a **suspended** state can be queued due to a lack of resources from a large number of active running queries. These queries will also appear in the **sys.dm_pdw_waits** in which your focus would be more on waits including **UserConcurrencyResourceType**. There are other reasons that queries may be in a wait queue such as object locks. More information on this topic can be found by [investating queries waiting for resources.](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-manage-monitor#monitor-waiting-queries)

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

When looking at the returned DSQL plan, further information about individual steps by looking at the *operation_type* of any long-running step. Take note of the **Step Index** which we'll use to investigate two types of perfomrnace impacting operations including 

1 **SQL Operations** which include:
- OnOperation
- Remote Operation
- Return Operation

2 **Data Movement Operations** including:
-ShuffleMoveOperation
-BroadcastMoveOperation
-TrimMoveOperation
-PartitionMoveOperation
-MoveOperation
-CopyOperation


- Example of a bad operation (like a huge broadcast)
- how to fix issues with query plans (stats, query design, table design, etc)