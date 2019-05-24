Suppose you are a newly-hired database administrator for a large company with SQL Server instances across multiple sites and, to learn more about these instances, you have started manually connecting to each SQL Server. It is taking too long to gather all the information you require, but your manager has informed you that there is currently no budget for purchasing any third party software to help with this task, until the next financial year begins, which is months ahead.

You want a free tool that is easy to learn, but capable of automating the process of auditing your environment. Ideally, it should be something you can share with members of the operations team so they can quickly discover the hardware on the database servers and apply appropriate upgrades.

## What tools are available?

With no option to purchase auditing software, you can continue to manually connect to each server and gather the information, or use the free **Microsoft Assessment and Planning (MAP)** toolkit.

To manually connect to each server, you need to have a remote desktop connection (RDP) to each server to gather data on the underlying hardware. You would then need to use **SQL Server Management Studio (SSMS)** to connect to the SQL Server instances and discover the version and edition, databases and logins. You can find out some information by executing the Transact-SQL statement:

```sql
SELECT @@VERSION
```

However, different SQL Server versions return this information in varying formats, preventing you from gathering consistent metadata about all your SQL Servers. Furthermore, you would need to run a script against each server to return a list of user databases and logins. There may be other components on the server that would need discovering, such as SQL Server Integration Services (SSIS), or SQL Server R Services.

You would need to save this data to a spreadsheet or some other document. If you wanted to create visualizations in Power BI for management reports, you might decide to store this data in a database in order to prevent multiple versions coming into existence if shared with others. Maintaining this list would mean adding tasks to an already tedious process, and with added opportunities for human error.

## What is the Microsoft Assessment and Planning toolkit?

The Microsoft Assessment and Planning (MAP) toolkit automates the gathering and reporting of all the database instances across your network. You need only supply credentials to each server once and these will be stored for later use. Connect MAP to an instance, and it takes an inventory of the database instance and server hardware. You can use this information for managing upgrades, consolidating databases, and ensuring you have the required components installed on an instance.

The reporting tool graphically displays aggregations for numbers of instance by edition, enabling you to quickly see how many versions are unsupported or due to soon expire. You can also see how many components, such as **Data Quality Services (DQS)**, or **Master Data Services (MDS)** are installed. The summary of editions makes it easy to see how your servers are licensed, and find editions with advanced features not being made use of to potentially improve performance.

The export feature enables you to copy the inventory to Excel. You can then analyze in detail the full instance and hardware configuration on each server. The assessment report enables you to compare the SQL Server version, service pack, operating system version, system memory, processors, and cores across all audited servers. You can then dive into the count of databases on each server, the size of data and log files, and counts of tables, views, and stored procedures. The reports also detail users and logins for each database, and the roles each user belongs to.

## Summary

In practice, many DBAs hold informal lists of SQL Server instance configuration settings in Excel files that become neglected and overlooked. This neglect is often due to the time and effort required to manually complete a full audit. The Microsoft Assessment and Planning toolkit quickly discovers all the information you need to know about an instance, and helps you plan upgrades, database consolidation operations, licensing checks, and security audits. The reporting prevents the need to maintain files where inventory information is held, as this can be rapidly regenerated as needed.

The rest of this module focuses on installing and using the Microsoft Assessment and Planning toolkit.