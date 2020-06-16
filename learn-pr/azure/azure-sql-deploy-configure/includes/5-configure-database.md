Now that you've verified your deployment was successful and you know what resources are available, there are some other configurations you may wish to do related to configuring your SQL Managed Instance, SQL Database, or databases within a SQL Managed Instance (these are called *managed databases*).

## Configure Azure SQL Managed Instance

For Azure SQL Managed Instance, since it is essentially a managed SQL Server, many configurations available in SQL Server apply here. For example, you can configure using sp_configure and certain global trace flags, and you have options available around tempdb, model and master, and the ERRORLOG. You also have control over your network connectivity and configuration, which will be discussed shortly.

## Configure databases

For managed databases in Azure SQL Managed Instance and Azure SQL Databases, you have options available with the `ALTER DATABASE` command. There are `SET` options and you can select the dbcompat you want to be at (this can help in migrations). You can also use the `ALTER DATABASE` command to change the Edition or Service tier. In Azure SQL Database you don't have access to the file configuration underneath, but in Azure SQL Managed instance you can perform file maintenance. Similar to Azure SQL Managed Instance, you have options available for network connectivity, network configuration, and space management.

In Azure SQL Database specifically, "stale" page detection is enabled and the default server collation `SQL_Latin1_General_CP1_CI_AS` is always used. Additionally, the following are default options set to **ON**:  

* SNAPSHOT_ISOLATION_STATE
* READ_COMMITTED_SNAPSHOT
* FULL RECOVERY
* CHECKSUM
* QUERY_STORE
* TDE
* ACCERATED_DATABASE_RECOVERY

## Restricted configuration choices

If you're familiar with SQL Server, there are a few configurations that are restricted by the Azure SQL Managed Instance and Azure SQL Database service that may affect how you run various tasks. The restricted choices are:  

* Stopping or restarting servers
* Instant file initialization
* Locked pages in memory
* FILESTREAM and Availability Groups
* Server collation (in MI you can select during deployment but not change)
* Startup parameters
* Error reporting and customer feedback
* `ALTER SERVER CONFIGURATION`
* "Mixed Mode" security is forced
* Logon audit is done through SQL Audit
* Server Proxy account is N/A

## Space management

For Azure SQL Managed Instance, there is a maximum storage allowed for the instance and the number of vCores is going to affect the maximum storage (for example, the Business critical tier has a lower maximum storage). If you reach the maximum, you may get Message 1105 for a managed database or Message 1133 for the instance. Upon creation of a database, they are created as the model default size which is 100Mb/8Mb and is configurable. You have the ability to alter the size as well as the number of files, but you do not have control over the physical location of them. Additionally, since in the General Purpose service tier remote storage is used, performance can be afected by the data/log file size.

For Azure SQL Database, the "Data max size" or "Maxsize" is the maximum possible size of a single database file (one one is allowed). The database file "Maxsize" can grow to the "Data max size". The transaction log maximum size is always 30% above the "Data max size". The log is also truncated regularly due to automatic backups (Accelerated Database Recovery is on by default).

To understand this idea of Data max size versus Maxsize, let's consider an example where a 1TB (Data max size) General purpose database is deployed. When you do this, however, your database is only ~500GB (not 1 TB). As your database grows and approaches the Data max size, the database file Maxsize will also grow up to the 1TB level.

The Azure SQL Database Hyperscale tier is different from the other service tiers in that it creates a database of 40GB and grows automatically in size.  

## Connectivity architecture and policy

Part of configuring your Azure SQL database logical server or Azure SQL Managed Instance involves determining the route of connection to your database(s).

During deployment, in Azure SQL Managed Instance you're able to choose the connection type or policy. In Azure SQL Database, you can choose the connection type, but only via PowerShell, Azure CLI, or the portal after deployment.

You can keep the default (Proxy for connections from outside and Redirect for connections within Azure) or configure something else.

![Connection policies in Azure SQL](../media/connectivity.png)

At the highest level, in Proxy mode, all connections are proxied through the a gateway, but in Redirect mode, after the connection is established leveraging the gateway (redirect-find-db in the figure above), the connection can then connect directly to the database or managed instance.

The direct connection (redirect) allows for reduced latency and improved throughput, but also requires opening up additional ports (allowing inbound and outbound communication in the range of 11000 - 11999).  

In the next exercise, you'll be exposed to some commands for configuring Azure SQL with the Azure CLI, and then you'll dive into evaluating the Proxy and Redirect connection policies.
