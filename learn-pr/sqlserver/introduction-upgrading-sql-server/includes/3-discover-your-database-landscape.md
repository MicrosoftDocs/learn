You're a database administrator for a law company, and your manager wants you to document all its databases to decide which ones to upgrade. You'll gather appropriate information about each database. Then, you'll decide whether you need to upgrade each database and which target version and edition is suitable.

You already know you have a wide variety of databases that run on SQL Server 2000, SQL Server 2005, and later versions. Some of these databases are administered by the main IT department and its DBAs. Others have been created and run by local teams with some database expertise to satisfy a specific need for that team. Some of these databases are well documented, but others have no documentation.

If your goal is to upgrade all databases to SQL Server 2019, you'll still need to decide the best upgrade path. Budget will also affect the version and edition to which you can upgrade. Also, you might have older versions of SQL Server on aging hardware that determine which databases you need to upgrade first. There may be a high security risk or a potential failure of the underlying hardware.

## What needs to be documented?

Administrators often overlook system documentation within a company. You try to begin an audit, but abandon it when other more urgent matters arise. It's also common for documentation to be completed, then disregarded with no plan for ongoing updates. Many companies revisit the process repeatedly. However, without an automated tool or a dedicated application, results are entered into a spreadsheet, then lost on a file system or local administrator's machine. Results are often then deleted when that person moves to another role.

How you document, ideally on a regular basis, depends on the number of SQL Server instances and the number and variety of installed components. A small organization that has a handful of SQL Servers with just the core services might have fewer requirements than a global operation with many more instances.

Get as much information as you need and be consistent across all instances and databases. This type of audit often reveals unused databases or test systems running on an Enterprise license that could be better employed elsewhere. This audit is an essential step to run before upgrading your databases. It ensures no system is forgotten or migrated incorrectly, which could lead to downtime of critical systems.

Here, we'll explore the three main areas to plan an upgrade path and help you prioritize your upgrades.

## SQL Server versions, features, and editions

As you've already learned, an old and unsupported version of SQL Server such as SQL Server 2000 would first require an upgrade to SQL Server 2008. This is because later versions don't support this compatibility level. An interim upgrade then allows a second upgrade.  

Features vary between the target versions you're assessing for your upgrade. You might consider that some databases support applications that won't use any of the advanced features available in the latest version. It may seem plausible to upgrade to SQL Server 2016 rather than SQL Server 2019. While this action is adequate, consider how long it might be before the database requires an upgrade. Upgrading straight to the latest version provides a longer time span before the version is no longer supported.

Also, the edition of SQL Server you select determines the available features.

**SQL Server Developer** edition delivers all the features available in the Enterprise edition, but is licensed at a lower cost to use in a development environment. Whether the production server is SQL Server Standard or Enterprise, always choose the Developer edition for building and testing applications.

**SQL Server Standard** edition offers a basic level of data management and business intelligence. Ideal for smaller operational use, it supports both on-premises and cloud installations.

**SQL Server Enterprise** edition is geared towards larger organizations handling mission-critical workloads, most likely in a top-end datacenter. With super-fast performance and unlimited virtualization, Enterprise edition gives you the best experience for business intelligence and advanced data science technologies.

When you can't decide between Standard or Enterprise, choose the Standard edition. If you need to upgrade later, you can extend your license for the Enterprise edition.

## Count of databases and size

To gauge the time required to upgrade your databases, you need to know how many there are and their size. Larger databases will require more upgrade time so, to limit disruption, upgrade when the database isn't being used or when it has low activity.

For each database, note the data and log file sizes and the number of database objects, such as tables, views, stored procedures, and functions. Gathering statistics on database usage will guide you towards choosing the appropriate edition. Databases running on an Enterprise version might not be taking full advantage of the available features, and could be moved to a Standard edition.

This action might free up space for databases that have become more heavily used over time to be moved to an Enterprise edition, or will benefit from advanced business intelligence features. When you know the size of your databases, you'll determine on which instance they can be hosted, depending on the target resources.

## Current configuration and installed components

There will likely be variation across the instances installed within your environment, depending on the purpose of the server. After connecting to each server, you want to gather data such as the operating system, version number, the architecture (32-bit or 64-bit), and the number of processors.

For documenting your SQL Server instance, you should include the server name, instance name, edition, version number, and which Service Pack (if any) is installed. It's also useful to include the subdirectory where data files, log files, and backups might be stored.

As part of your upgrade planning, consider any components that have been installed on each instance. After application databases are migrated, ensure that any ETL processes, data warehouses, and reporting are all in place and ready to support the business. Check for SSIS, SSRS, and SSAS installations, and for Master Data Services (MDS), Data Quality Service (DQS), and SQL Server R Services.

## What is the Microsoft Assessment and Planning tool?

Even a basic audit of your database landscape requires a repetition of effort, and is potentially time-consuming. For many organizations, manual database auditing is a task that's often started but rarely completed.

The best approach is to use an automated process that removes repetition and human error to return consistent results. The Microsoft Assessment and Planning (MAP) toolkit uses this method, and it includes tools for discovering and documenting your SQL Servers.

![Screenshot of the Microsoft Assessment and Planning Toolkit.](../media/3-map-screenshot.png)

Use MAP to scan your landscape and return the names of the SQL Server instances it finds, along with the version and edition, and installed components. You view this data graphically to easily consume the results. MAP also audits the operating system and hardware, instance settings, and settings for each database.

You can export all this data to Microsoft Excel to filter it and further visualize the results. Using these results, you know the target databases that need an upgrade. Run the toolkit on a regular basis to find any changes. You can then report back to your managers or quickly answer questions from developers.

## How to choose a discovery method

Your law firm has a complex mix of well-documented databases run by professional DBAs and smaller databases, with little or no documentation, run by people who have other jobs.

MAP is ideal in such circumstances. Because MAP discovers databases automatically, you can start to document your landscape without talking to all the people who run the databases.

Auditing the current database landscape and assessing how databases are used will guide you towards an appropriate upgrade solution. The process will help you plan a migration, and it's useful for finding databases that are no longer used and for cleaning up your database environment.

In practice, most organizations discover their landscape only as needed and their documentation doesn't exist or it's out of date. The MAP toolkit is ideal for doing an audit of your landscape, especially when you're thinking about database upgrades. It removes tedious and repetitive tasks that steal valuable administrator time.
