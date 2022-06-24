Azure Synapse Analytics supports querying both relational (dedicated and serverless SQL endpoints) and non-relational data (Azure Data Lake Storage Gen 2, Cosmos DB and Azure Blob Storage) at petabyte-scale using Transact SQL, supporting ANSI-compliant SQL language. 

The Azure Synapse SQL query language supports different features based on the resource model being used. The table below outlines which Transact-SQL statements work against each resource model.

|T-SQL Statement|Dedicated|Serverless|
|---|---|---|
|SELECT statement|Yes|Yes|
|INSERT statement|Yes|No|
|UPDATE statement|Yes|No|
|DELETE statement|Yes|No|
|MERGE statement|No|No|
|Transactions|Yes|Yes|
|Labels|Yes|No|
|Data load|Yes|No|
|Data export|Yes, using CETAS|Yes, using CETAS|
|Cross database queries|No|Yes|
|Built-in functions (analysis, text, table-value)|Yes|Yes|
|Aggregates|T-SQL built-in aggregates|T-SQL built-in aggregates|
|Operators|Yes|Yes|
|Control flow|Yes|Yes|
|DDL statements|Yes|Yes|

## Query execution plans
In Synapse Analytics you can display the query execution plan for a dedicated sql pool at the control and compute node levels using the database consistency check, **DBCC PDW_SHOWEXECUTIONPLAN**
 > [!Note]
 > This process is not supported by serverless SQL pool in Azure Synapse Analytics.

 In order to see what is running on an Azure Synapse dedicated pool we can use the following query:

 ```sql

SELECT [sql_spid], [pdw_node_id], [request_id], [dms_step_index], [type], [start_time], [end_time], [status], [distribution_id]  
FROM sys.dm_pdw_dms_workers   
WHERE [status] <> 'StepComplete' and [status] <> 'StepError'  
order by request_id, [dms_step_index];  

 ```

 Once you have identified a node that you want to analyze, then you can use the **DBCC PDW_SHOWEXECUTIONPLAN** command to look at the execution plan on a specific distribution and its specific session as shown in the example below:

 ```sql

DBCC PDW_SHOWEXECUTIONPLAN ( 1, 375 );

 ```