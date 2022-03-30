## Scenario

Let's remember our scenario, in which you are the CTO of a healthcare business that sells medical equipment in different regions around the country. You have different inventory databases in each region and you want to ensure that these databases are all replicating data changes to a central country-wide inventory database which offers you a status on each sale. You might decide to use Change Data Capture (CDC) and enable it on each of your regional inventory database in order to track data changes and send these changes to the national, central database. The data changes would be tracked on CDC tables on your source database and you may decide to use a streaming service such as Azure Data Factory to consume the changes from the CDC tables and stream them to the national database. But before doing that, let's learn more about Change Data Capture (CDC).

## How it works

Change Data Capture (CDC) records insert, update, and delete activity that applies to a table. On SQL Server and Azure SQL Managed instance, the SQL Server Agent runs the CDC scan and cleanup. However, on Azure SQL Databases, a scheduler takes the place of the SQL Server Agent. The scheduler runs capture and cleanup automatically within the database, without any external dependency for reliability or performance. Users still have the option to run capture and cleanup manually on demand.

Therefore, below are the steps highlighting how CDC works on Azure SQL Databases:

1. Enable CDC on the source database and tables that you want to track for Data Modification Language (DML) changes - insert, update, delete.

2. Once you enable CDC on your source tables, associated change tables get created for each source table enabled. Change tables are system tables on your source database.  

3. As you make DML changes on your source table enabled for CDC, those changes are reflected in the database transaction log. The CDC scan process picks up the committed changes from the log and adds them to the change table associated to the CDC-enabled source table. The Commit Log Sequence Number (LSN) identifies changes that were committed in the same transaction and orders those transactions.

4. The cleanup process cleans the change tables on a retention-based policy set by the user. The default retention is 3 days.

5. Query functions are provided to allow systematic access to the change data stored in the change tables.

## Enabling and disabling CDC

### Enabling CDC on your database

In order to enable CDC on your Azure SQL Database, run the following:

*EXEC sys.sp_cdc_enable_db*

### Enabling CDC on your tables

Once you enabled CDC on the database, you should enable it on the tables that you want to be tracked:

*EXEC sys.sp_cdc_enable_table*  
*@source_schema = N'dbo',*  
*@source_name   = N'MyTable',*  
*@role_name     = N'MyRole',*  
*@filegroup_name = N'MyDB_CT',*  
*@supports_net_changes = 1,*
*@captured_column_list = 'column1', 'column2'*

To determine whether a source table has already been enabled for change data capture, examine the is_tracked_by_cdc column in the sys.tables catalog view.

By default, the change table is located in the default filegroup of the database. Database owners who want to control the placement of individual change tables can use the **@filegroup_name** parameter to specify a particular filegroup for the change table associated with the capture instance. The named filegroup must already exist. Generally, it is recommended that change tables be placed in a filegroup separate from source tables.

If the parameter **@supports_net_changes** is set to 1, a net changes function is also generated for the capture instance. This function returns only one change for each distinct row changed in the interval specified in the call. To support net changes queries, the source table must have a primary key or unique index to uniquely identify rows. If a unique index is used, the name of the index must be specified using the @index_name parameter. The columns defined in the primary key or unique index must be included in the list of source columns to be captured.

By default, all of the columns in the source table are identified as captured columns. If only a subset of columns need to be tracked, such as for privacy or performance reasons, use the **@captured_column_list** parameter to specify the subset of columns that you want to track changes for.

### Disabling CDC on your tables

Members of the db_owner fixed database role can remove a capture instance for individual source tables by using the stored procedure sys.sp_cdc_disable_table. To determine whether a source table is currently enabled for change data capture, examine the is_tracked_by_cdc column in the sys.tables catalog view. If there are no tables enabled for the database after the disabling takes place, the change data capture jobs are also removed.

*EXEC sys.sp_cdc_disable_table*  
*@source_schema = N'dbo',*  
*@source_name   = N'MyTable',*  
*@capture_instance = N'dbo_MyTable'*

If a change data capture-enabled table is dropped, change data capture metadata that is associated with the table is automatically removed.

It is not necessary to disable individual tables before you disable the database.

### Disabling CDC on your database

Disabling the database removes all associated change data capture metadata, including the cdc user and schema and the change data capture jobs. However, any gating roles created by change data capture will not be removed automatically and must be explicitly deleted. To determine if a database is enabled, query the is_cdc_enabled column in the sys.databases catalog view.

*EXEC sys.sp_cdc_disable_db*
