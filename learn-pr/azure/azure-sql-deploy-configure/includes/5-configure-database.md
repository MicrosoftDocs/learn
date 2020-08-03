Now that you've verified your deployment was successful and you know what resources are available, there are some other configurations you may wish to do related to configuring your SQL Managed Instance, SQL Database, or databases within a SQL Managed Instance (these are called *managed databases*).

## Configure Azure SQL Managed Instance

For Azure SQL Managed Instance, since it is essentially a managed SQL Server, many configurations available in SQL Server apply here. For example, you can configure using sp_configure and certain global trace flags, and you have options available around tempdb, model, and master. You also have control over your network connectivity and configuration, which will be discussed shortly.

## Configure databases

For managed databases in Azure SQL Managed Instance and Azure SQL Databases, you have options available with the `ALTER DATABASE` command. There are `SET` options and you can select the dbcompat you want to be at (this can help in migrations). You can also use the `ALTER DATABASE` command to change the Edition or Service tier. In Azure SQL Database, you don't have access to the file configuration underneath, but in Azure SQL Managed instance you can perform file maintenance. Similar to Azure SQL Managed Instance, you have options available for network connectivity, network configuration, and space management.

In Azure SQL Database specifically, "stale" page detection is enabled and the default server collation `SQL_Latin1_General_CP1_CI_AS` is always used. Additionally, the following are default options set to **ON**:  

* SNAPSHOT_ISOLATION_STATE
* READ_COMMITTED_SNAPSHOT
* FULL RECOVERY
* CHECKSUM
* QUERY_STORE
* TDE
* ACCERATED_DATABASE_RECOVERY

## Job management

SQL Server Agent provides a configuring and scheduling system for SQL Server users. You can achieve equivalent functionality in Azure SQL through the following options.

### SQL Agent in Managed Instance

SQL Agent is a fully supported service with Azure SQL Managed Instance. SQL Agent jobs are supported only for T-SQL and SSIS job steps. Command shell steps are not supported. Although alerts are not supported, email notifications are supported through Database mail.

### Elastic Jobs for Azure SQL Database

Azure SQL Database does not support SQL Server Agent. However, you can use the Elastic Job agent Azure service to create and schedule jobs. Jobs are T-SQL scripts that you can run against many database including parallel execution.

### Azure Automation

Azure automation is a service that allows you to orchestrate processes through a concept called a runbook. A runbook can be composed of code like PowerShell or Python and can be directed to any Azure resource.

## Restricted configuration choices

If you're familiar with SQL Server, there are a few configurations that are restricted by the Azure SQL Managed Instance and Azure SQL Database service that may affect how you run various tasks. The restricted choices are:  

* Stopping or restarting servers
* Instant file initialization
* Locked pages in memory
* FILESTREAM and Availability Groups (we use Availability Groups internally)
* Server collation (in MI you can select during deployment but not change)
* Startup parameters
* Error reporting and customer feedback
* `ALTER SERVER CONFIGURATION`
* ERRORLOG configuration
* "Mixed Mode" security is forced
* Logon audit is done through SQL Audit
* Server Proxy account is N/A

Azure SQL Managed Instance and Database are PaaS offerings so restricting these choices should not inhibit your ability to fully use a SQL Server managed service.

## Storage management

For Azure SQL Managed Instance, there is a maximum storage allowed for the instance and the number of vCores is going to affect the maximum storage (for example, the Business critical tier has a lower maximum storage). If you reach the maximum, you may get Message 1105 for a managed database or Message 1133 for the instance.

The size of any new database will be based on the size of the model database, which is a 100 Mb data file and an 8 Mb log file, just like SQL Server. Also like SQL Server, the size of model is configurable. You have the ability to alter the size as well as the number of files, but you do not have control over the physical location of them, as Microsoft has commitments per your deployment choice on I/O performance. Additionally, since remote storage is used in the General Purpose service tier, performance can be affected by the data file and log file size.

For Azure SQL Database, the *Data max size* is the maximum possible size of a single database file, and only one is allowed. The database file *Maxsize* (as defined by the `sys.database_files.max_size` column) can grow to the Data max size. To understand this idea of Data max size versus Maxsize, let's consider an example where a 1 TB (Data max size) General purpose database is deployed. When you do this, however, your database only requires ~500 GB (not 1 TB). As your database grows and approaches the Data max size, the database file Maxsize will also grow up to the 1 TB level.

The transaction log is in addition to the data size, and it is truncated regularly due to automatic backups as Accelerated Database Recovery is on by default. The log's maximum size is always 30% of the Data max size. For example, if the data max size is 1 TB, then the maximum transaction log size is 0.3 TB, and the total of data max size and log size is 1.3 TB.

The Azure SQL Database Hyperscale tier is different from the other service tiers in that it creates a database initially 40 GB and grows automatically in size to the limit of 100 TB. The transaction log has a fixed size restriction of 1 TB.  

## Connectivity architecture and policy

Part of configuring your Azure SQL database logical server or Azure SQL Managed Instance involves determining the route of connection to your database(s).

For Azure SQL Managed Instance, you can choose the connection type or policy during the deployment. In Azure SQL Database, you can choose the connection type after deployment.

You can keep the default of *Proxy for connections from outside and Redirect for connections within Azure* or configure something else.

:::image type="content" source="../media/5-connectivity.png" alt-text="Diagram of the connection policies in Azure SQL." border="false":::

At the highest level, in Proxy mode, all connections are proxied through the gateway. In Redirect mode, after the connection is established leveraging the gateway (redirect-find-db in the figure above) the connection can then connect directly to the database or managed instance.

The direct connection (redirect) allows for reduced latency and improved throughput, but also requires opening up additional ports to allow inbound and outbound communication in the range of 11000 - 11999.  

In the next exercise, you'll be exposed to some commands for configuring Azure SQL with the Azure CLI, and then you'll dive into evaluating the Proxy and Redirect connection policies.
