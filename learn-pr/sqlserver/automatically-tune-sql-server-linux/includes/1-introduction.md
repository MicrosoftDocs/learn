Performance is vital in many database systems and SQL Server 2017 is designed from the ground up to respond quickly and make the best use of the CPU, memory, and storage resources available to it. SQL Server is capable of excellent performance and its number one rating in the TPC-H and TPC-E internationally recognized performance standards shows that the performance of a well-configured SQL Server is second to none. However, some situations can arise in which performance is not optimized. As a database administrator, you must be able to identify and mitigate such situations.

Suppose you are a system architect for a large wine retail company. You have a database of products and sales that is used to manage all stock and dispatch orders to customers. The database is hosted on Microsoft SQL Server 2017 servers, which are deployed on Linux servers that run Red Hat Enterprise Linux.

Performance is good because your administrators have a strict regime of performance monitoring and tuning. However, there is a large upgrade project for another of the company’s major databases about to start. You would like to reduce the amount of time database administrators spend tuning the products and sales database so that you can complete the upgrade project without the need to hire new administrators.

Here, you will see how to monitor the performance of SQL Server 2017 running on Linux servers by using Azure Data Studio. You will also learn how to use Query Store and automatic tuning to ensure that performance degradation does not occur.

## Learning objectives

By the end of this module, you will be able to:

- Use Azure Data Studio to monitor performance in SQL Server on a Linux server.
- Decide whether to enable Query Store.
- Configure Query Store on a Linux server and use the recommendations it provides.
- Enable automatic tuning in SQL Server on a Linux server.

## Prerequisites

Before you begin this module, you should:

- Understand the difference between a query and a query execution plan in SQL Server.
- Be able to install and configure SQL Server 2017 on a Linux server.
- Be able to write Transact-SQL queries.
- Understand Dynamic Management Views (DMVs) in SQL Server.