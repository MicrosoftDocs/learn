SQL Server 2022 offers similar deployment, edition, and licensing options as with previous releases of SQL Server. There are some differences which you will learn about in this module.

## Deployment options for SQL Server 2022

Just like in SQL Server 2017 and SQL Server 2019, SQL Server 2022 can be deployed on Windows and Linux operating systems on computers, virtual machines, and in cloud virtual machine platforms. SQL Server 2022 can also be deployed using containers and on Kubernetes platforms.

SQL Server 2022 is supported on supported version of Windows 10, Windows 11, and Windows Server. SQL Server 2022 for Linux is supported on Red Hat Enterprise Linux 8.0 - 8.5 Server, SUSE Enterprise Linux Server v15, and Ubuntu 20.04 LTS.

You can deploy SQL Server using the same methods as in previous version such as the Windows Graphical setup wizard, command line options, Linux package managers, and container runtime engines such as Docker. SQL Server 2022 is also available through Azure Virtual Machine marketplace images.

## Editions for SQL Server 2022

As with previous versions of SQL Server, SQL Server 2022 can be deployed using the following editions:

- SQL Server Evaluation Edition

Use this edition to evaluate all features of SQL Server 2022 but there is a time limit of 180 days after you run setup. This edition does not require a paid license but cannot be used for production.

- SQL Server Developer Edition

Use this edition to test all features for your SQL Server 2022 application. There is no time limit for this edition and no paid license is required but it cannot be used for production.

- SQL Server Express Edition

This edition does not require a paid license and can be used in production. This edition contains many of the core capabilities of SQL Server 2022 but has limits on specific features and resource such as CPU, memory, and database size.

- SQL Server Web Edition

SQL Server Web edition is a low total-cost-of-ownership option for Web hosters and Web VAPs to provide scalability, affordability, and manageability capabilities for small to large-scale Web properties.

- SQL Server Standard Edition

SQL Server Standard Edition includes most of the core capabilities of SQL Server along with a common surface area of features so that developers can access most SQL Server features from an application. SQL Server Standard edition does not include all SQL Server features and has some limitations for resource such as CPU and memory.

- SQL Server Enterprise Edition

SQL Server Enterprise Edition includes all features and capabilities of SQL Server with unlimited access to resources such as CPU and memory.

See a list of all the capabilities for each edition in our documentation at https://aka.ms/sql2022editions.

## Licensing for SQL Server 2022

SQL Server 2022 paid editions are licensed on individual instances using models like per core or with contract agreements such as Software Assurance (SA). SQL Server 2022 offers a new licensing model called Pay-as-you-go (PAYG). Learn more about all the licensing options for SQL Server 2022 at https://aka.ms/sqlserver2022licensing.

## Feature differences for SQL Server 2022 from previous releases

In this module you will learn about all the new features and capabilities in SQL Server 2022 compared to previous releases in the areas of cloud connected, built-in query intelligence, core engine, data virtualization, and T-SQL. 

You may also want to learn more about differences for features that have been removed, deprecated, or enhanced from SQL Server in SQL Server 2022 from a perspective of deployment.

> [!TIP]
> Stay up to date with all the latest release notes for SQL Server 2022 at https://aka.ms/sqlserver2022releasenotes.

### Features removed or deprecated in SQL Server 2022

The following features have been removed from SQL Server 2022 that were available in previous releases:

- R, Python, and Java runtimes

R, Python, and Java runtimes are no longer includes as part of setup for SQL Server 2022. The Machine Learning Services feature is still supported but you will need to add your own packages that include runtimes you need.

- Polybase Hadoop Connectivity with Java

The Polybase feature wit Hadoop connectivity is removed from SQL Server 2022. You can still use Polybase services with ODBC drivers or new REST API based connectors for Azure Blob Storage (abs), Azure Data Lake Storage (ADLS), or S3 compatible object storage (s3).
 
- Polybase scale out groups

The Polybase scale out group feature has been removed from SQL Server 2022. Queries using external tables or OPENROWSET for data virtualization can take advantage of scale-up processing built into SQL Server.
 
- Machine Learning Server

Machine Learning Server was retired in July of 2022. Therefore, the Machine Learning Server feature has been removed from SQL Server setup.
 
- Distributed Replay

Distributed Reply is no longer available to configure with setup for SQL Server 2022 on Windows but will be available in a different deployment method in the future.

This feature has been deprecated starting in SQL Server 2022

- Stretch Database

Stretch Database is deprecated in SQL Server 2022. This feature will be removed in a future version of Microsoft SQL Server. Avoid using this feature in new development work, and plan to modify applications that currently use this feature.

### New deployment experiences in SQL Server 2022

In SQL Server 2022, the Azure extension for SQL Server configuration is part of the SQL Server 2022 setup experience. The Azure extension for SQL Server can be used to configure SQL Server 2022 as an Azure Arc-enabled SQL Server. There is no subscription charge to setup an Azure Arc-enabled SQL Server. You only incur subscription charges when you use specific Azure services such as Azure Active Directory (AAD) Authentication, Microsoft Purview, or Microsoft Defender for SQL.