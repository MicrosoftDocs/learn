Suppose you are a database administrator for a law company and you have performed a database audit. Having performed this operation, you gave your results and recommendations to management for assessment. They have taken note of your advice to upgrade the unsupported versions of SQL Server as soon as possible and asked you how you will go about migrating the databases. As yet, the budget has not been set and you have been advised that you may not be able to buy new licenses for SQL Server 2017.

You have active database servers that run SQL Server 2000, SQL Server 2008 and SQL Server 2012.

Some databases may have to be migrated to existing instances of SQL Server 2012 or SQL Server 2016. Because of the urgent need to upgrade unsupported versions, you will explore all available options so that you are ready as soon as you are given the go-ahead.  

Here, we will explore the main upgrade paths available for different versions of SQL Server.

## Available upgrade paths for different versions

The older the database you want to migrate, the fewer the options are available. As previously discussed, if you want to upgrade SQL Server 2000 databases, you need to perform an interim upgrade to SQL Server 2008, before upgrading to any later version.

## Backup and restore

You can use the **backup and restore** option on any version of SQL Server from 2005 through 2016. Be aware that you cannot backup and restore any of the systems databases - master, model, msdb, or temp. Take a backup of the database from the source server and restore it on the target server. You can then change the compatibility of the database. For example, to change the compatibility of a database named **Customer Services** to SQL Server 2016, you would run the following command:

```sql
ALTER DATABASE [CustomerServices] SET COMPATIBILITY_LEVEL = 130
```

You must first ensure that all objects within the database are supported by the target environment, otherwise you will not be able to change the compatibility level. You will need to remove any deprecated features, such as queries to management views that have been renamed or replaced, updated system stored procedures, or deprecated data types.

## Bulk load

Versions as far back as SQL Server 2005 can use the **bulk load** operation to copy data into a target database. By creating the new database on the target server, you can the use the **Bulk Copy Program (BCP)** to run a script to copy the data. BCP is an efficient solution for copying large volumes of data, but if you are not familiar with writing BCP scripts, you will need to factor in time to learn how to do this.

## Transactional replication

Replication enables you to upgrade your SQL Server databases, but does require you to have working knowledge of how transactional replication works. Replication allows you to have a mix of versions within the topology, so is already geared to enabling upgrades. The **Distributor** must be the same version of SQL Server as the **Publisher**, or later, and the **Subscriber** can be up to two versions newer or earlier than the Publisher. Replication offers two upgrade paths:

- **Side-by-side**. With side-by-side replication, you create a new parallel environment with the target version of SQL Server, and then move the databases, logins, scheduled jobs, and any other objects, to your new environment.
- **In-place**. An in-place replication upgrade replaces the existing installation, and upgrades both system and user databases.

If you already have replication in place, you should consider one of these options to complete your migration.

## Availability groups

If you have taken advantage of using the **Always On** availability group introduced in SQL Server 2012, you can failover to a SQL Server 2014 or higher secondary. Your **primary** must be running SQL Server 2012 SP2 or later and the failover can be manual or automatic. Note that once you have failed over to a later version, and the older version of SQL Server becomes the **secondary** server, it cannot receive changes from the primary.

## Database mirroring

You can use database mirroring to upgrade **principals** running SQL Server 2008 SP3, SQL Server 2008 R2 SP2 or higher, to a **mirror** that is SQL Server 2014 or later. As is the case with availability groups, once you have failed over to the newer version of SQL Server and the older version becomes the mirror, it will not receive changes from the principal.

## Log shipping

Log shipping can be used to upgrade if the **principal** is running SQL Server 2008 SP3, SQL Server 2008 R2 SP2 or higher, to a **secondary** running SQL Server 2014 or higher. Once again, be aware that after failover to the newer version of SQL Server, the older version now running as the secondary will not receive changes from the primary.

## Data Migration Assistant

The **Data Migration Assistant (DMA)** supports versions of SQL Server from 2005 upwards. Using the assistant, you connect to the instance and select the database you plan to upgrade. You tell the assistant the target version of SQL Server and it will analyze the size and schema of the database, and make recommendations for your upgrade. After the analysis, DMA provides a compatibility report, which highlights breaking changes, behavioral changes, and deprecated features so these can be fixed.

![Data Migration Assistant](../media/4-dma-screenshot.png)

DMA also makes recommendations for how the database can use performance, storage, and security features in the target version. These results can be exported to a CSV or JSON file for future reference, which is ideal when you have a large number of databases for upgrade and need a concise list of tasks to prevent application failure once upgraded. You can then use DMA to upgrade your database and logins to the target server.

## Choosing an upgrade method

In your law firm, for databases that run SQL Server 2000, you must start by upgrading to SQL Server 2008 using the backup and restore method. Make sure that you set the database compatibility level to 100 after the migration, so that the database can be further upgraded after that. 

Once you have completed the initial upgrade from SQL Server 2000, all your databases are at SQL Server 2008 and higher but you still have a complex situation. 

The simplest consistent method for upgrading all these databases is to use the DMA, which can upgrade any database hosted on SQL Server 2005 and later. This tool will help you by providing a complete list of compatibility issues that you must fix before you execute the upgrade on a given database. Your team can work through that list to resolve all problems before you use DMA to execute the upgrade itself.

## Summary

There are various methods available for upgrading your SQL Servers. The path that you choose depends on the version you are upgrading from and whether there is a failover mechanism in place that you must use for the upgrade. DMA supports database upgrades from SQL Server 2005 onwards, so if you have a variety of versions across your database landscape, this tool is ideal for upgrading from one central point. Most usefully, DMA highlights deprecated features in older databases so you can see the code that will break, before you even begin the upgrade process. Furthermore, DMA suggests features that will boost security and performance and the results can be exported.