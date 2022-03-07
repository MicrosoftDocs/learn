You can take many different approaches to database migration, such and online or offline migration, backup and restore migration, or migration with custom SQL code or scripts. Each approach is most appropriate for certain business scenarios.

In your start-up company, for example, the supplier communication database is critical and you want to try and migrate without any disruption to the service to users. This department of the company operates on a 24/7 basis and there are few predictable quiet times when you could take the database offline. The Computer Aided Design (CAD) system, by contrast, is only used during the week so you could take it offline over a weekend and migrate it to Azure. 

Here, you'll learn about approaches, techniques, and tools that you can select to execute the migration.

### When to use export and import

Export and import techniques give you control over the data and schema that's moved in the migration. Use export and import tools if you want to select which data is migrated to the new database, and perhaps clean or modify the data during migration.

Consider using export and import techniques:

- When you want to choose a subset of the tables in the on-premises database to migrate to the cloud database.

- When you want to migrate database objects such as constraints, views, functions, procedures, and triggers, and control how these objects are set up in the cloud database.

- When you want to import data from external sources other than MySQL, MariaDB, or PostgreSQL.

For example, you might consider export and import in these scenarios:

- You want to perform a piecemeal migration where the marketing workload is migrated to the cloud and tested before the sales support workload. Both workloads use tables from the *SalesDB* database in your on-premises system. You want to migrate the marketing tables only in the first phase of the project and the sales tables only in the second phase.

- Your on-premises data is old and contains a mix of data that's relevant and irrelevant to the current business. You want to take the opportunity to remove old data and consider a more streamlined database schema.

- You have a large spreadsheet that contains data about products. You want to migrate this data into the cloud database.

### Plan an export and import migration

The advantage of using export and import is the extra level of control you have over the data being migrated. However, a disadvantage is that you must plan more carefully to ensure that all the objects you need are included.

Make sure you understand how the following objects will be migrated:

- The database schema.
- Constraints including primary keys, foreign keys, and indexes.
- Views, functions, procedures, and triggers.
- User accounts and permissions.

### Export and import for MySQL and MariaDB

You can use SQL scripts to perform selective export and import from one database to another. However, if your on-premises database is in MySQL or MariaDB, there are several tools available to help, including:

- **MySQL Workbench**. This is a popular database design tool with a Graphical User Interface (GUI) developed by Oracle Corporation. It includes a **Data Export** tool with flexible data selection options.

- **Toad Edge**. This is a competing toolset developed by Quest. You use it to export and import data from both MySQL and PostgreSQL databases.

- **Navicat**. This database administration GUI tool is also compatible with MariaDB databases.

- **mysqlimport**. This command-line tool can import data from text files.

> [!IMPORTANT]
> Azure Database for MySQL and Azure Database for MariaDB only support the InnoDB storage engine. If you have any tables that use other engines, such as the MyISAM engine, you must convert them to InnoDB before migrating to Azure.

### PostgreSQL export and import

PostgreSQL provides the following tools that you use to export and import data:

- **pgAdmin**. This is a GUI utility for PostgreSQL administrators. It provides an interface for exporting and importing data.

- **pg_dump**. This is a command-line tool you use to export a database in various formats, including test. You can edit the resulting .sql files before you import them using the **psql** utility.

- **Toad Edge**. This is the same utility that you use with MySQL.

## Backup and restore

Backup and restore operations are usually done to protect a database against disasters. An exact copy of the database is taken and saved. If a disaster destroys the working copy, the backed-up copy is restored and normal business can resume.

By restoring to a different location, you use a backup to migrate the complete database to another location, such as a database in the cloud.

### When to use backup and restore

Backup tools make a simple and precise copy of the database. When you restore in the cloud database, you get exactly the same data and schema that you had in the on-premises system. Use backup and restore to migrate a database:

- When you want to migrate an entire database or set of databases in one operation.

- When you don't need to make any modifications to the data, schema, or other database objects during migration.

You could consider using backup and restore to perform a migration in cases like these:

- You have a single database system that you want to lift-and-shift into the cloud with as little modification as possible.

- You want to perform a piecemeal migration on a system that has multiple databases. Each workload is supported by a complete database.

When you restore a database from a backup file to a cloud location, consider the quantity of data that must be sent across the network to the cloud database. To optimize this data transfer, copy the backed-up database to a virtual machine in the same region as the destination database, and restore from there. This restore is quicker than using an on-premises backup file and is less likely to cause contention for network bandwidth.

### Plan a backup and restore on MySQL and MariaDB

To back up a database on an on-premises server, you use the `mysqldump` tool at the command line. That creates a .sql file that you restore to the cloud database by passing it to the `mysql` command as a script. If you prefer a GUI tool, choose the **PHPMyAdmin** application, or **MySQL Workbench**. These GUI tools can both back up and restore the data.

Remember that Azure Database for MySQL and Azure Database for MariaDB only support the InnoDB engine. Make sure you convert all tables to InnoDB before you execute the backup.

To avoid any compatibility problems, check that the version number of MySQL or MariaDB used in the cloud matches the version number of the on-premises database server. Azure Database for MySQL supports versions 5.6, 5.7, and 8.0. Azure Database for MariaDB supports versions 10.2 and 10.3. If your on-premises server uses an earlier version, consider upgrading to one of these versions first and troubleshooting any issues on-premises, before you migrate to the cloud.

### Plan a backup and restore on PostgreSQL

The equivalent command-line backup and restore tools on PostgreSQL are `pg_dump` and `pg_restore`. For a GUI backup and restore tool, use **Toad Edge**.

## Custom application code

If you have extensive data transformation requirements or want to perform an unusual migration, consider writing your own custom code to move data from an on-premises MySQL, PostgreSQL, or MariaDB database into the cloud.

Your custom code could take many forms. The language and framework you choose depends mostly on your development team's expertise:

- SQL Scripts generated from the database and modified or developed from scratch.
- Compiled code from a development framework such as .NET or Java.
- Scripts in PHP or Node.js.
- Shell scripts for Bash or PowerShell.

The custom code approach enables you to be extremely flexible. You customize how data is filtered, aggregated, and transformed, and you can migrate to multiple destinations or merge data from multiple sources. Use this approach if you have requirements that can't be satisfied with an out-of-the-box backup or export tool.

The drawback to this approach is that it requires more investment in development time. For custom code to migrate all the data correctly, it must be extensively tested before it's run on real data. This task requires a team of skilled developers and testers, and often increases the project budget. If you're considering writing custom migration code, don't be tempted to underestimate the time and effort required to create reliable code.

## Azure Database Migration Service

Azure includes a flexible service called **Azure Database Migration Service (DMS)**, which you use to do seamless online migrations from multiple data sources into Azure data platforms. These platforms include **Azure Database for MySQL**, **Azure Database for MariaDB**, and **Azure Database for PostgreSQL**.

Consider using Azure DMS whenever you want to perform an online database migration into Azure.

### Initial migration

To perform a migration with DMS, you complete these tasks:

1. Create a new target database within Azure on the platform of your choice.
1. Create a new DMS data migration project.
1. Generate the schema from the on-premises source databases. If you're using MySQL, you can generate a schema with `sqldump`. If the source database is PostgreSQL, use `pg_dump`.
1. Create an empty database to act as the migration destination.
1. Apply the schema to the destination database.
1. Configure connection details for the source and destination databases in a DMS migration project.
1. Run the DMS migration project. The project transfers the data and generates a report.
1. Review the report and correct any issues that it identifies.

### Online migrations

Azure DMS is a good tool to use for online migrations, in which the original database remains available while the migration executes. Users continue to make changes to data in the source database. Azure DMS uses replication to synchronize these changes with the migrated database. Once migration is complete, you reconfigure the user applications to connect to the migrated database.

## Migrate MySQL or MariaDB to Azure SQL Database

If you want to move a database that's hosted on-premises on a MySQL database server into the Azure cloud—and you don't need the cloud database to run MySQL—consider migrating to Azure SQL Database. Azure SQL Database is a PaaS implementation of Microsoft's industry-leading SQL Server database engine. It includes enterprise-level availability, scalability, and security, and is easy to monitor and manage.

Similarly, if your on-premises database server runs MariaDB, you can consider migrating to Azure SQL Database. The process is very similar because MariaDB is a fork of MySQL.

Azure SQL Database is more fully-featured than Azure Database for MySQL and Azure Database for MariaDB.

> [!NOTE]
> You might need to modify any applications that connect to your migrated database—because Azure SQL Database uses different data types, different database objects, and a different API from MySQL and MariaDB. Consult your developers to determine how much work is required to port a client application from an on-premises MySQL or MariaDB database to a cloud Azure SQL database.

## SQL Server Migration Assistant for MySQL

If you decide to migrate from MySQL to Azure SQL Database, you can use a specialized tool: **SQL Server Migration Assistant for MySQL**. This GUI tool connects to a source MySQL database and a SQL Server database, which can be a database in the Azure SQL Database service.

When it's connected, the assistant copies the complete schema to Azure SQL Database, and converts any data types to their SQL Server equivalents. It also migrates views, procedures, triggers, and other objects. You can then start to migrate the data from MySQL to Azure SQL Database.

> [!NOTE]
> SQL Server Migration Assistant for MySQL is not tested for migrating MariaDB databases to Azure SQL Database.