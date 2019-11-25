You're a database administrator for a law company and your manager has given you the task of documenting all its databases to decide which ones should be upgraded. You decide to gather appropriate information about each database. Then you'll decide whether each you need to upgrade each database and, if so, which target version and edition is most suitable.

You already know that you have a wide variety of databases that run on SQL Server 2000, SQL Server 2005, and later versions. Some of these databases are administered by the main IT department and its DBAs. Others have been created and run by local teams with some database expertise to satisfy a specific need for that team. Some of these databases are well documented, but others have no documentation at all.

Your goal might be to upgrade all databases to SQL Server 2017, but you'll still need to decide the best upgrade path. Budget will also affect the version and edition to which you can upgrade. Also, you might have older versions of SQL Server on aging hardware that determine which databases you need to upgrade first, because of a high security risk or a potential failure of the underlying hardware.

## What needs to be documented?

Administrators often overlook systems documentation within a company. You make efforts to begin an audit, but abandon it when other more urgent matters arise. It is also not uncommon for documentation to be completed and then disregarded with no plan for ongoing updates. Many companies will revisit the process repeatedly but, without the assistance of an automated tool or a bespoke and dedicated application, the results are entered into a spreadsheet and then lost on a file system or local administrator's machine, only to be deleted when that person moves to another role.

The extent to which you document, ideally on a regular basis, will depend on the number of SQL Server instances in operation and the number and variety of installed components. A small organization with a handful of SQL Servers, with just the core services, may have fewer requirements than a global operation with hundreds or thousands of instances. You should get as much information as you need and be consistent across all instances and databases. Indeed, such an audit often reveals unused databases or test systems running on an Enterprise license that could be better employed elsewhere. This audit is an essential step to run before upgrading your databases, to ensure no system is forgotten or migrated incorrectly, which could lead to downtime of critical systems.

Here, we'll explore the three main areas to plan an upgrade path and help you to prioritize your upgrades.

## SQL Server versions, features, and editions

As you've already learned, an old and unsupported version of SQL Server, such as SQL Server 2000, would first require an upgrade to SQL Server 2008 because later versions don't support this compatibility level. An interim upgrade would then allow a second upgrade.  

Features will vary between the target versions you are assessing for your upgrade. You may consider that some databases support applications that will not use any of the advanced features available in the latest version, so it may seem plausible to upgrade to SQL Server 2014 rather than SQL Server 2017. While this action is adequate, you should consider how long before the database will require a future upgrade. Upgrading straight to the latest version provides a longer time span before the version is no longer supported.

Furthermore, the edition of SQL Server you select determines the available features. **SQL Server Developer** edition delivers all the features available in the Enterprise edition, but is licensed at a lower cost for use within a development environment. Whether the production server is SQL Server Standard or Enterprise, always choose the Developer edition for building and testing applications.

**SQL Server Standard** edition offers a basic level of data management and business intelligence. Ideal for smaller operational use, it supports both on-premise and cloud installations. **SQL Server Enterprise** edition is geared towards larger organizations handling mission-critical workloads, most likely in a top-end datacenter. With super-fast performance and unlimited virtualization, Enterprise edition enables you to take advantage of the best experience for business intelligence and advanced data science technologies.

If you are undecided between Standard or Enterprise, choose the Standard edition; if you later have a need to upgrade, you can then extend your license for the Enterprise edition.

## Count of databases and size

To gauge the time required to upgrade your databases, you need to know how many you have and how large they are. Larger databases will require more upgrade time so, to limit disruption, upgrade when the database is not in use, or when it has the least amount of activity.

For each database, note the data and log file sizes, and the number of database objects, such as tables, views, stored procedures, and functions. Gathering statistics on database usage will guide you towards choosing the appropriate edition. Databases running on an Enterprise version may not be taking full advantage of the available features, and could be moved to a Standard edition. This action might free up space for databases that have become more heavily used over time to be moved to an Enterprise edition, or can benefit from advanced business intelligence features. When you know the size of your databases, you can determine which instance they can be hosted on, depending on the target resources.

## Current configuration and installed components

There will likely be variation across the instances installed within your environment, depending on the purpose of the server. After connecting to each server, you want to gather data such as the operating system, version number, and the architecture (32-bit or 64-bit), as well as the number of processors. For documenting your SQL Server instance, you should include the server name, instance name, edition, version number, and which Service Pack (if any) is installed. It is also useful to include the sub directory where data files, log files, and backups may be stored.

Consider any components that have been installed on each instance as part of your upgrade planning. After application databases have been migrated, you must ensure that any ETL processes, data warehouses, and reporting are all in place and ready to support the business. As well as checking for SSIS, SSRS, and SSAS installations, you must check for Master Data Services (MDS), Data Quality Service (DQS), and SQL Server R Services.

## What is the Microsoft Assessment and Planning tool?

Even a basic audit of your database landscape requires a repetition of effort and is potentially time-consuming. For many organizations, manual database auditing is one of those tasks that is often started but rarely completed. The best approach is to use an automated process that removes repetition and human error and returns consistent results. This method is used in the Microsoft Assessment and Planning (MAP) toolkit, which includes tools for discovering and documenting your SQL Servers.

![Microsoft Assessment and Planning](../media/3-map-screenshot.png)

Use MAP to scan your landscape and return the names of the SQL Server instances it finds, along with the version and edition, and installed components. This data can be viewed graphically so you can easily consume the results. Further to this, MAP audits the operating system and hardware, instance settings, and settings for each database. All this data can be exported to Microsoft Excel to filter it and further visualize the results. Using these results, you know the target databases that are most in need of upgrade. Run the toolkit on a regular basis to find any changes, enabling you to report back to your managers, or quickly answer questions from developers.

## How to choose a discovery method

At your law firm, you've got a complex situation with a mix of well-documented databases run by professional DBAs and smaller databases with little or no documentation run by people with other jobs.

MAP is ideal in such circumstances: because it discovers databases automatically, you can start to document your landscape without talking to all the people that run the databases in question.

## Summary

Auditing the current database landscape and assessing how databases are used will guide you towards an appropriate upgrade solution. As well as helping you plan your migration, the process can be useful for finding databases that are no longer in use and for cleaning up your database environment. In practice, most organizations discover their landscape only as needed and their documentation doesn't exist or it's out of date. The MAP toolkit is ideal for performing an audit of your landscape, especially when you're thinking about database upgrades, as it removes tedious and repetitive tasks, that steal valuable administrator time.