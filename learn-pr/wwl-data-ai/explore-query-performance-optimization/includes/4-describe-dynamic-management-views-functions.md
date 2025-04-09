SQL Server provides several hundred dynamic management objects. These objects contain system information that can be used to monitor the health of a server instance, diagnose problems, and tune performance. Dynamic management views and functions return internal data about the state of the database or the instance. Dynamic Management Objects can be either views (DMVs) or functions (DMFs), but most people use the acronym DMV to refer to both types of object. 

There are two levels of DMVs, server scoped and database scoped.

- **Server scoped objects –** require `VIEW SERVER STATE` permission on the server
- **Database scoped objects –** require the `VIEW DATABASE STATE` permission within the database

The names of the DMVs are all prefixed with **sys.dm_** followed by the functional area and then the specific function of the object. SQL Server supports three categories of DMVs:

- Database-related dynamic management objects
- Query execution related dynamic management objects
- Transaction related dynamic management objects

To learn about queries to monitor server and database performance, see [Monitoring Microsoft Azure SQL Database and Azure SQL Managed Instance performance using dynamic management views](/azure/azure-sql/database/monitoring-with-dmvs).

> [!NOTE]
> For older versions of SQL Server where the query store isn't available, you can use the view `sys.dm_exec_cached_plans` with the functions `sys.dm_exec_sql_text` and `sys.dm_exec_query_plan` to return information about execution plans. However, unlike with Query Store, you won't be able to see changes in plans for a given query.

Azure SQL Database has a slightly different set of the DMVs available than SQL Server; some objects are available only in Azure SQL Database, while other objects are only available in SQL Server. Some are scoped at the server level and aren't applicable in the Azure model (the `waits_stats` DMV is an example of a server-scoped DMV), while others are specific to Azure SQL Database, like `sys.dm_db_resource_stats` and provide Azure-specific information that isn't available in (or relevant to) SQL Server.
