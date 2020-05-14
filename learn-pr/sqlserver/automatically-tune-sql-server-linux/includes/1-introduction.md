Suppose you're a system architect for a large wine retail company. You have a database of products and sales that's used to manage all stock and dispatch orders to customers. The database is hosted on Microsoft SQL Server 2019 servers, which are deployed on Linux servers that run Red Hat Enterprise Linux (RHEL).

Performance is good because your administrators have a strict regime of performance monitoring and tuning. However, a large upgrade project for another of the company's major databases is about to start. You'd like to reduce the amount of time that database administrators spend tuning the products and sales database. You could then complete the upgrade project without needing to hire new administrators.

Performance is vital in many database systems. SQL Server 2019 is designed from the ground up to respond quickly and make the best use of the CPU, memory, and storage resources available. SQL Server is capable of excellent performance and uses Intelligent Query Processing (IQP) to dynamically accelerate responses. Its number one rating in the TPC-H and TPC-E internationally recognized performance standards shows that the performance of a well-configured SQL Server is second to none. However, some situations can arise in which performance isn't optimized. As a database administrator, you must know how to identify and mitigate such situations.

Here, you'll see how to monitor the performance of SQL Server 2019 running on Linux servers by using Azure Data Studio. You'll also learn how to use Query Store and automatic tuning to ensure that performance degradation doesn't occur.

## Learning objectives

By the end of this module, you'll see how to:

- Use Azure Data Studio to monitor performance in SQL Server on a Linux server
- Decide whether to enable Query Store
- Configure Query Store on a Linux server and use the recommendations it provides
- Enable automatic tuning in SQL Server on a Linux server

## Prerequisites

Before you begin this module, you should:

- Understand the difference between a query and a query execution plan in SQL Server
- Know how to install and configure SQL Server 2019 on a Linux server
- Know how to write Transact-SQL queries
- Understand dynamic management views (DMVs) in SQL Server