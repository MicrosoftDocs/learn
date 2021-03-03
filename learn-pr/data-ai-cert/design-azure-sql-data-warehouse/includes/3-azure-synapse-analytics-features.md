As well as the Massively Parallel Processing architecture at limitless scale, there are additional features of SQL Analytics that can be beneficial in Modern Data Warehousing use cases, including:

- Workload management
- Result-set cache
- Materialized views
- Continuous Integration/Continuous Delivery (CI/CD) support through SQL Server Data Tools (SSDT)

## Workload management

Azure Synapse Analytics provides the capability to prioritize the query workloads that take place on the server using Workload Management. Workload Management is managed by three related areas:

- Workload groups
- Workload classification
- Workload importance

### Workload groups

Workload groups enable you to define the resources to isolate and reserve resources for its use. It creates the following benefits:

- Reserves resources for a group of requests.
- Limits the amount of resources a group of requests can consume.
- Accesses shared resources based on importance level.
- Sets query timeout value. Gets DBAs out of the business of terminating runaway queries.

A workload group is defined using T-SQL as follows.

``` SQL 
CREATE WORKLOAD GROUP group_name  
WITH  
(       
    MIN_PERCENTAGE_RESOURCE = value   
  , CAP_PERCENTAGE_RESOURCE = value 
  , REQUEST_MIN_RESOURCE_GRANT_PERCENT = value
  [ [ , ] REQUEST_MAX_RESOURCE_GRANT_PERCENT = value ]  
  [ [ , ] IMPORTANCE = {LOW | BELOW_NORMAL | NORMAL | ABOVE_NORMAL | HIGH} ]
  [ [ , ] QUERY_EXECUTION_TIMEOUT_SEC = value ]  
 )[ ; ]
```

### Workload classification

Using T-SQL, you can create a workload classifier to map queries to a specific classifier. A classifier can define the level of importance of the request, so that it can be mapped to a specific workload group that has an allocation of specific resources during the execution of the query.

``` SQL 
CREATE WORKLOAD CLASSIFIER classifier_name  
WITH  
(
         WORKLOAD_GROUP = 'name'
     ,   MEMBERNAME     = 'security_account' 
 [ [ , ] IMPORTANCE     = {LOW|BELOW_NORMAL|NORMAL|ABOVE_NORMAL|HIGH} ] )
 [ [ , ] WLM_LABEL      = 'label' ]  
 [ [ , ] WLM_CONTEXT    = 'name' ]  
 [ [ , ] START_TIME     = 'start_time' ]  
 [ [ , ] END_TIME       = 'end_time' ]  
)[ ; ]
```
``` TEXT
  WORKLOAD_GROUP: maps to an existing resource class
  IMPORTANCE: specifies relative importance of request
  MEMBERNAME: database user, role, AAD login or AAD group
```

### Workload importance

Workload importance is defined in the CREATE WORKLOAD CLASSIFIER command, and enables higher priority queries to receive resources ahead of lower priority queries that are in the queue. By default, queries are released from the queue on a first-in, first-out basis as resources become available, but workload importance overrides this qualifier.

## Result-set cache

In scenarios where the same results are requested on a regular basis, result-set caching can improve the performance of the queries that retrieve these results. When result-set caching is enabled, the results of the query are cached in the SQL pool storage.

Result-set cache enables interactive response times for repetitive queries against tables with infrequent data changes.
The result-set cache persists even if SQL pool is paused and resumed later, although the query cache is invalidated and refreshed when the underlying table data or query code changes. To ensure that the cache is fresh, the result cache is evicted on a regular basis on a time-aware least recently used algorithm (TLRU). You can set result-set caching on at the database level or at a session level using the following code.

``` SQL 
-- Turn on/off result-set caching for a database
-- Must be run on the MASTER database
ALTER DATABASE {database_name}  
SET RESULT_SET_CACHING { ON | OFF }

-- Turn on/off result-set caching for a client session  
-- Run on target Azure Synapse Analytics
SET RESULT_SET_CACHING {ON | OFF}   
```

## Materialized views

A materialized view can pre-compute, store, and maintain data like a table. These views are automatically updated when data in underlying tables are changed. Updating materialized views is a synchronous operation that occurs as soon as the data is changed. This auto-caching functionality enables Azure Synapse Analytics Query Optimizer to consider using an indexed view, even if the view is not referenced in the query. They also support the following aggregations: **MAX, MIN, AVG, COUNT, COUNT_BIG, SUM, VAR, STDEV**.

## Continuous Integration/Continuous Delivery (CI/CD) support through SQL Server Data Tools (SSDT)

Database project support in SQL Server Data Tools (SSDT) enables teams of developers to collaborate over a version-controlled Azure Synapse Analytics, and track, deploy, and test schema changes.

Other supported features include:

- Ordered ColumnStore
- JSON support
- Dynamic data masking
- Row-level security
