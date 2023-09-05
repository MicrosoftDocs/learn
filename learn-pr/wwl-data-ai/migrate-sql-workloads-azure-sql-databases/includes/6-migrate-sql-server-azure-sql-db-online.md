If you need a database to remain online to users throughout the migration process, you can use transactional replication to move the data. Transactional replication is the only online method available for migrating to Azure SQL Database.

In our bicycle manufacturer scenario, warehouses run on a 24 hour, 7 days a week basis, and there are no periods of inactivity. Your board of directors wants to be sure that the inventory database is constantly available, even during the migration to Azure SQL Database.

:::image type="content" source="../media/6-replication-architecture.png" alt-text="Diagram showing the replication topology involving SQL Server and Azure SQL Database.":::

## What is transactional replication?

[Transactional replication](/sql/relational-databases/replication/transactional/transactional-replication) is a way to move data between continuously connected database servers. 

The process begins with a snapshot of the publication database objects and data. Once the initial snapshot is taken, any subsequent changes to the data or schema at the Publisher are typically delivered to Azure SQL Database in near real-time as they occur.

:::image type="content" source="../media/6-replication-to-sql-database.png" alt-text="Diagram showing the key components in a transactional replication.":::

Azure SQL Database supports both transactional and snapshot replication as a push subscriber. That means Azure SQL Database can receive and apply changes from a publisher using either a transactional or snapshot replication.

The publisher and/or distributor can be an instance of SQL Server that is either running on-premises, on an Azure virtual machine in the cloud, or as an Azure SQL Managed Instance.

You can configure transactional replication through SQL Server Management Studio, or by executing Transact-SQL statements on the publisher. Transactional replication can't be configured from the Azure portal.

Transactional replication requires the following components:

| Role | Definition |
| --- | --- |
| **Publisher** | A database instance that hosts the data to be replicated (source). |
| **Subscriber** | Receives the data being replicated by the *Publisher* (target). |
| **Distributor** | Collects changes in the articles from a *Publisher* and distributes them to the *Subscribers*. |
| **Article** | A database object; for example, a table that's included in the *Publication*. |
| **Publication** | A collection of one or more articles from the database being replicated. |
| **Subscription** | A request from a *Subscriber* for a *Publication*. |

## Set up a transactional replication

Follow the steps below to migrate the table `[Person].[Person]` from *AdventureWorks* database to Azure SQL Database with no downtime. Transactional replication can only use SQL Server authentication logins to connect to Azure SQL Database.

| Parameter | Definition |
| --- | --- |
| `@distributor` | Source instance name. |
| `@publisher` | Source instance name. |
| `@subscriber` | Azure SQL Database in the format: `<server>.database.windows.net`. The Azure SQL Database must exist before running the script. |
| `@dbname` | Database name at the source. |
| `@publisher_login` | SQL user with required permissions at the source. |
| `@publisher_password` | Password for the SQL user. |
| `@destination_db` | Database name at the destination. |
| `@subscriber_login` | SQL user with required permissions at the destination. |
| `@subscriber_password` | Password for the SQL user. |
| `@working_directory` | Replication working directory, change this location as appropriate. |

Adjust the parameters above according to your own environment when running the script. The script assumes the publisher and the subscriber are the same, which is a requirement when replicating to Azure SQL Database.

### Create the distributor

The following script creates the distributor database, distributor publishers, and the agents.

```sql
USE [master]
GO

EXEC sp_adddistributor @distributor = N'CONTOSO-SRV', @password = N''
GO

EXEC sp_adddistributiondb 
		@database = N'distribution', 
		@data_folder = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Data', 
		@data_file = N'distribution.MDF', 
		@data_file_size = 13, 
		@log_folder = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Data', 
		@log_file = N'distribution.LDF', 
		@log_file_size = 9, 
		@min_distretention = 0, 
		@max_distretention = 72, 
		@history_retention = 48, 
		@deletebatchsize_xact = 5000, 
		@deletebatchsize_cmd = 2000, 
		@security_mode = 1
GO

-- Adding the distribution publishers
exec sp_adddistpublisher 
	@publisher = N'CONTOSO-SRV', 
	@distribution_db = N'distribution',
	@security_mode = 1, 
	@working_directory = N'C:\REPL', 
	@trusted = N'false', 
	@thirdparty_flag = 0, 
	@publisher_type = N'MSSQLSERVER'
GO

exec sp_addsubscriber 
	@subscriber = N'contoso.database.windows.net', 
	@type = 0, 
	@description = N'Azure SQL Database (target)'
GO

-- Enabling the replication database
use master
exec sp_replicationdboption 
	@dbname = N'AdventureWorks', 
	@optname = N'publish', 
	@value = N'true'
GO

--Adds a Log Reader agent for the AdventureWorks database. 
exec [AdventureWorks].sys.sp_addlogreader_agent 
	@publisher_security_mode = 1
GO

--Adds a Queue Reader agent for the distributor.
exec [AdventureWorks].sys.sp_addqreader_agent 
	@frompublisher = 1
GO
```

### Create the transactional publication

The following script creates the transactional publication of the `AdventureWorks` database from the publisher.

```sql
USE [AdventureWorks]
GO

EXEC sp_addpublication 
	@publication = N'REPL-AdventureWorks', 
	@description = N'Transactional publication of database ''AdventureWorks'' from Publisher ''CONTOSO-SRV''.', 
	@sync_method = N'concurrent', 
	@retention = 0, 
	@allow_push = N'true', 
	@allow_pull = N'true', 
	@allow_anonymous = N'true', 
	@enabled_for_internet = N'false', 
	@snapshot_in_defaultfolder = N'false', 
	@alt_snapshot_folder = N'C:\REPL', 
	@compress_snapshot = N'true', 
	@ftp_port = 21,
	@ftp_login = N'anonymous', 
	@allow_subscription_copy = N'false', 
	@add_to_active_directory = N'false', 
	@repl_freq = N'continuous', 
	@status = N'active', 
	@independent_agent = N'true', 
	@immediate_sync = N'true', 
	@allow_sync_tran = N'false',
	@autogen_sync_procs = N'false', 
	@allow_queued_tran = N'false', 
	@allow_dts = N'false', 
	@replicate_ddl = 1, 
	@allow_initialize_from_backup = N'false', 
	@enabled_for_p2p = N'false',
	@enabled_for_het_sub = N'false'
GO

exec sp_addpublication_snapshot 
	@publication = N'REPL-AdventureWorks', 
	@frequency_type = 1, 
	@frequency_interval = 0, 
	@frequency_relative_interval = 0, 
	@frequency_recurrence_factor = 0, 
	@frequency_subday = 0, 
	@frequency_subday_interval = 0,
	@active_start_time_of_day = 0, 
	@active_end_time_of_day = 235959, 
	@active_start_date = 0,
	@active_end_date = 0, 
	@publisher_security_mode = 0,
	@publisher_login = N'sqladmin', 
	@publisher_password = N'<pwd>'
```

### Create the article for the publication

The following script creates the article for the `[Person].[Person]` table. 

```sql
USE [AdventureWorks]
GO

EXEC sp_addarticle 
	@publication = N'REPL-AdventureWorks', 
	@article = N'Person', 
	@source_owner = N'Person', 
	@source_object = N'Person',
	@type = N'logbased', 
	@description = N'', 
	@creation_script = N'',
	@pre_creation_cmd = N'drop', 
	@schema_option = 0x000000000803509F, 
	@identityrangemanagementoption = N'none', 
	@destination_table = N'Person',
	@destination_owner = N'Person',
	@status = 24, 
	@vertical_partition = N'false', 
	@ins_cmd = N'CALL [sp_MSins_PersonPerson]', 
	@del_cmd = N'CALL [sp_MSdel_PersonPerson]', 
	@upd_cmd = N'SCALL [sp_MSupd_PersonPerson]'
GO
```

### Create the subscription and the subscription agent

The following script creates the push subscription to the Azure SQL Database subscriber.

```sql
USE [AdventureWorks]
GO

EXEC sp_addsubscription 
	@publication = N'REPL-AdventureWorks', 
	@subscriber = N'contoso.database.windows.net', 
	@destination_db = N'my-db',
	@subscription_type = N'Push',
	@sync_type = N'automatic',
	@article = N'all',
	@update_mode = N'read only', 
	@subscriber_type = 0

exec sp_addpushsubscription_agent 
	@publication = N'REPL-AdventureWorks', 
	@subscriber = N'contoso.database.windows.net', 
	@subscriber_db = N'my-db',
	@job_login = null, 
	@job_password = null, 
	@subscriber_security_mode = 0, 
	@subscriber_login = N'sqladmin',
	@subscriber_password = '<pwd>', 
	@frequency_type = 64, 
	@frequency_interval = 1, 
	@frequency_relative_interval = 1, 
	@frequency_recurrence_factor = 0,
	@frequency_subday = 4, 
	@frequency_subday_interval = 5,
	@active_start_time_of_day = 0, 
	@active_end_time_of_day = 235959, 
	@active_start_date = 0, 
	@active_end_date = 0, 
	@dts_package_location = N'Distributor'
GO
```

### Initiate and monitor replication

Replication management and monitoring are not supported from Azure SQL Database. Instead, perform these activities from SQL Server. To initiate replication, start the snapshot job, log reader job, and distributor job. 

You can monitor the **Snapshot Agent** and **Log Reader Agent** by right-clicking on the publication and selecting the appropriate option. If the agents are not running, start them.

:::image type="content" source="../media/6-replication-view-snapshot.png" alt-text="Screenshot showing how to launch the snapshot agent.":::

To view the synchronization status, right-click on the subscription, select **View Synchronization Status**, and then start the agent. If you encounter any error messages, check the agent jobs history on the SQL Server Agent. If the agents are running as expected, you should see the following results.

**Snapshot Agent:**

:::image type="content" source="../media/6-replication-snapshot.png" alt-text="Screenshot showing the snapshot agent status in a transactional replication.":::

**Log Reader Agent:**

:::image type="content" source="../media/6-replication-log-reader.png" alt-text="Screenshot showing the log reader status in a transactional replication.":::

**Synchronization Status:**

:::image type="content" source="../media/6-replication-sync-status.png" alt-text="Diagram showing the synchronization status in a transactional replication.":::

After the data is fully replicated to Azure SQL Database, you can direct the connections to the subscriber database, and then stop and remove the replication.

To learn more about supported configurations, see [https://learn.microsoft.com/en-us/azure/azure-sql/database/replication-to-sql-database?view=azuresql](/azure/azure-sql/database/replication-to-sql-database).