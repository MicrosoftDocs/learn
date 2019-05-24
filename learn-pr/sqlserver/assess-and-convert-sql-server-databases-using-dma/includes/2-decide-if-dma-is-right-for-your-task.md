Suppose you are a database administrator, and you have compiled a list of the various SQL Server databases in your organization. You have then identified those databases that require upgrading to SQL Server 2017. Currently, all databases are hosted on-premise, but the CTO has asked you to move a selection of databases to the cloud in preparation for some up-coming infrastructure changes. Furthermore, she would like a report detailing the changes that will be required, in order to allocate the resource needed to perform the upgrades.

Under time pressure to deliver these results, you realize that it will be impossible to perform the necessary checks and create a report, in time for the CTO’s deadline. You have searched for a suitable solution to this problem and have found the **Microsoft Data Migration Assistant (DMA)** tool. You now need to decide if this is the most appropriate tool for your task.

## Using backup and restore to upgrade/migrate SQL Server

One option for migrating older versions of SQL Server to SQL Server 2017, is to use database backups and restore them on the target instance. However, if you need to migrate a large number of databases, this process is likely to be very lengthy. If you manually migrate databases, you will need to migrate user logins separately.

## What is the Microsoft Data Migration Assistant?

The Microsoft Data Migration Assistant (DMA) is a standalone application that performs a set of key tasks to assist in the process of upgrading your SQL Server databases. It removes the time-consuming process of checking your databases for compatibility issues prior to a migration. DMA connects to the _source_ and _target_ servers, and discovers breaking changes, behavior changes, and deprecated features. If you are migrating to an on-premise SQL Server host, you can also run a **new features** assessment to find features in the target version that can enhance the performance of your database. For migrations to Azure SQL Database, DMA checks feature parity to uncover partially or unsupported features in Azure.

![Data Migration Assistant start page](../media/2-dma-start.png "Data Migration Assistant start page")

The time that DMA needs to assess your database will depend on the size of the source database. For large databases, you can run the compatibility and new feature recommendation assessments individually to reduce the assessment time.

After assessing your database, you can use DMA to migrate to the target server. The migration process can include the following elements:

- Database schema: all objects in the database, including tables, indexes, stored procedures, views, and functions
- Data
- Windows and SQL logins
- Database users
- Server roles

By default, DMA does not move the **sa** login, but will move all other qualified logins. You can select which logins to migrate, but will need to ensure these logins are correctly mapped to the migrated databases.

## Supported source and target versions

The Data Migration Assistant enables you to assess and migrate on-premise and Azure SQL Databases. It supports the following as source databases:

- SQL Server 2005
- SQL Server 2008
- SQL Server 2008 R2
- SQL Server 2012
- SQL Server 2014
- SQL Server 2016
- SQL Server 2017

You can migrate to:

- SQL Server 2012
- SQL Server 2014
- SQL Server 2016
- SQL Server 2017
- Azure SQL Database

When you upgrade a database to an on-premise target, you can choose to assess compatibility issues and new feature recommendations. For SQL Azure Database upgrades, DMA highlights compatibility issues and provides a SQL Server feature parity category, which includes recommendations and alternative approaches for Azure.

## Export report

After running a compatibility or upgrade assessment, you can export the results to CSV or JSON for future reference. You can consolidate assessment reports from multiple servers to create a report in Power BI. To achieve this, you would also need PowerShell, Power BI Desktop, and a report template provided by Microsoft.

## Summary

Performing database upgrades can be a time-consuming task for database administrators who manage a high number of databases. The compatibility and new features assessments, and the upgrade, should always be performed out of hours or when there is the least activity on the server. In practice, there may only be a small window of opportunity to perform these tasks. The Data Migration Assistant ensures each operation is completed consistently, and by default, ensures that no logins or users are overlooked during a migration, which enables a swift transition to the new server.

The rest of this module focuses on installing and using the Data Migration Assistant.