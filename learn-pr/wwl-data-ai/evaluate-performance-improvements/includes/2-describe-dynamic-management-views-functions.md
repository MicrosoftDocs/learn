SQL Server provides several hundred dynamic management objects. These objects contain system information that can be used to monitor the health of a server instance, diagnose problems, and tune performance. Dynamic management views and functions return internal data about the state of the database or the instance. Dynamic Management Objects can be either views (DMVs) or functions (DMFs), but most people use the acronym DMV to refer to both types of object. There are two levels of DMVs: server scoped and database scoped. Server scoped objects require VIEW SERVER STATE permission on the server, and database scoped objects require the VIEW DATABASE STATE permission within the database. The names of the DMVs are all prefixed with sys.dm_ followed by the functional area and then the specific function of the object. SQL Server supports three categories of DMVs:

- Database-related dynamic management objects
- Query execution related dynamic management objects
- Transaction related dynamic management objects

You can see a large number of queries to monitor server and database performance on the page in the docs called [Monitoring Performance Azure SQL Database Using Dynamic Management Views](https://docs.microsoft.com/azure/azure-sql/database/monitoring-with-dmvs). 

> [!NOTE]
> For older versions of SQL Server (2012 and 2014) where the query store is not available, you can use the view sys.dm_exec_cached_plans in conjunction with the functions sys.dm_exec_sql_text and sys.dm_exec_query_plan to return information about execution plans. However, unlike with Query Store, you will not be able to see changes in plans for a given query.

Azure SQL Database has a slightly different set of the DMVs available than SQL Server; some objects are available only in Azure SQL Database, while other objects are only available in SQL Server. Some are scoped at the server level and are not applicable in the Azure model (the waits_stats DMV below is an example of a server-scoped DMV), while others are specific to Azure SQL Database, like sys.dm_db_resource_stats and provide Azure-specific information that is not available in (or relevant to) SQL Server.
