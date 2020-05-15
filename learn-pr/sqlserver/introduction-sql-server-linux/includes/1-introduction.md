Microsoft SQL Server has many unique features, compared to other database management systems:

- **Intelligence over any data**. SQL Server is the only commercial Relational Database Management System (RDBMS) with Artificial Intelligence (AI) built-in. It supports R, Python, and Java running next to the data in-memory and at massive scale with support for Spark.
- **Choice of platform, language, and container**. SQL Server developers and administrators can choose their platform and language, with support for Windows, Linux, containers, Transact-SQL, Java, C/C++, C#/VB.NET, PHP, Node.js, Python, and Ruby.
- **Industry-leading performance and scalability**. SQL Server is currently first in the TPC-E benchmark for performance, and first for performance in the TPC-H 1 TB, 10 TB, and 30-TB benchmarks.
- **Industry-leading security**. According to the National Institute of Standards and Technology (NIST), SQL Server has been the most secure RDBMS for more than the last nine years. Security features include the following and you'll see others later in this module:
    - Transparent Data Encryption (TDE). You can use this technology to encrypt data-at-rest in SQL Server data files.
    - SQL Data Discovery and Classification. You can use this tool in SQL Server Management Studio (SSMS) to find the most sensitive data in your databases, including Personally Identifiable Information, so that you can take action to secure it.
    - Dynamic Data Masking (DDM). You can use this feature to protect sensitive values, such as credit card numbers, by masking parts of them from non-privileged users. 
- **Insights in minutes on any device**. SQL Server provides an end-to-end solution for reporting, and scales from mobile to desktop at a fraction of the cost of other systems. You can turn data into answers using the enterprise reporting capabilities of SQL Server Reporting Services along with the included Power BI Report Server, which gives users access to rich, interactive Power BI reports on any device.

> [!NOTE]
> Power BI Report Server only runs on Windows, but you can use it to query data hosted on SQL Servers running on Linux operating systems.

SQL Server also supports PolyBase, which is a data virtualization solution in SQL Server. It allows you to create external tables in your database that point to external data sources like Hadoop clusters, Oracle, Teradata, NoSQL databases, and SAP HANA. You will be able to query all your data sources with one single query.

For these reasons, Wide World Importers are interested in running SQL Server 2019 on Linux. Their system administrators have more experience with Linux servers than with Windows and they're intrigued by the performance, security, and functionality of SQL Server.

You're a database administrator who wants to learn the functionality and benefits of installing SQL Server on Linux, and running SQL Server on containers.

## Learning objectives

In this module, you'll:

- Describe the key benefits of running SQL Server on Linux
- Describe both Windows and cross-platform tools that can be used to administer SQL Server on Linux
- Describe the benefits of running SQL Server on Linux virtual machines
- Describe the benefits of running SQL Server on container runtime environments, such as Docker

## Prerequisites

- Basic Linux administration
