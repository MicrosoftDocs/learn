**SQL Server Management Studio (SSMS)** and **Microsoft Assessment and Planning (MAP)** are two tools that you can use to manage your SQL Server estate. 

Suppose you are a newly hired database administrator for a large company with SQL Server instances across multiple sites and, to learn more about these instances, you have started manually connecting to each SQL Server. It is taking too long to gather all the information you require, but your manager has informed you that there is currently no budget for purchasing any third-party software to help with this task, until the next financial year begins, which is months ahead.

You want a free tool that is easy to learn, but capable of automating the process of auditing your environment. Ideally, it should be something you can share with members of the operations team so they can quickly discover the hardware on the database servers and apply appropriate upgrades.

In this unit, you'll look at the two options you can use to investigate SQL Server instances, and information about the databases running on them. Then you'll be able to make the right decision on which tool to use.

## What tools are available?

With no option to purchase auditing software, you can continue to manually connect to each server and gather the information, or use the free Microsoft Assessment and Planning toolkit.

To manually connect to each server, you need to use a remote desktop connection (RDP) to each server to gather data on the underlying hardware. You would then use SSMS to connect to the SQL Server instances and discover the version and edition, databases, and logins. You can find out some information by executing the Transact-SQL statement:

```sql
SELECT @@VERSION
```

Different SQL Server versions return this information in varying formats, preventing you from gathering consistent metadata about all your SQL Servers. Also, you'll need to run a script against each server to return a list of user databases and logins. There may be other components on the server that would need discovering, such as SQL Server Integration Services (SSIS), SQL Server Reporting Services (SSRS), or SQL Server R Services.

You would need to save this data to a spreadsheet or some other document. If you wanted to create visualizations in Power BI for management reports, you might decide to store this data in a database. The database would prevent multiple versions coming into existence when it's shared with others. Maintaining this list would mean adding tasks to an already tedious process, and with added opportunities for human error.

You could automate the process, by building a system of SQL Agent jobs and SSIS packages, that run scheduled jobs to query each server and store the results in a database, allowing you to generate reports with SSRS. This solution would obviously come at the cost of designing, building, testing, and maintaining it.

## What is the Microsoft Assessment and Planning toolkit?

The MAP toolkit automates the gathering and reporting of all the database instances across your network. You need only supply credentials to each server once as they're stored for later use. Connect MAP to an instance, and it takes an inventory of the database instance and server hardware. You can use this information for managing upgrades, consolidating databases, and ensuring you have the required components installed on an instance.

The reporting tool graphically displays aggregations of instances by edition, enabling you to see quickly how many versions are unsupported, or are about to expire. You can also see how many components, such as **Data Quality Services (DQS)**, or **Master Data Services (MDS)** are installed. The summary of editions makes it easy to see how your servers are licensed. You can potentially improve performance by finding editions with advanced features not being made use of.

The export feature enables you to copy the inventory to Excel. You can then analyze in detail the full instance and hardware configuration on each server. The assessment report enables you to compare these properties across all the audited servers:

- SQL Server version
- Service pack
- Operating system version
- System memory
- Processors
- Cores

You can then dive into the count of databases on each server, the size of data and log files, and counts of tables, views, and stored procedures. The reports also detail users and logins for each database, and the roles each user belongs to.

## Summary

In practice, many DBAs hold informal lists of SQL Server instance configuration settings in Excel files that become neglected and overlooked. This neglect is often because of the time and effort required to manually complete a full audit. The MAP toolkit quickly discovers all the information you need to know about an instance, and helps you plan upgrades, database consolidation operations, licensing checks, and security audits. The reporting prevents the need to maintain files where inventory information is held, as reports can be rapidly regenerated as needed.

The rest of this module focuses on installing and using the Microsoft Assessment and Planning toolkit.