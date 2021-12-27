Organizations that run Linux can consider using SQL Server to host databases. Equally, organizations that run SQL Server can think about moving their servers to the Linux operating system. But why should they make such a change?

As the system administrator for Wide World Importers, you're  responsible for the Linux servers that host all their front-end web servers, and the back-end Windows database farm. You want to use your Linux experience to deploy SQL Server on Linux instead. So you'll explore the main advantages of using SQL Server on Linux. Your target is to produce a presentation to deliver to your CTO. You'll explain the benefits of SQL Server on Linux and the implications of installing it on Linux.

Here, you'll learn why you should consider running SQL Server on Linux.

## Why use SQL Server on Linux?

Linux is a collection of operating systems, or distributions, that run on the Linux kernel. It's a popular operating system choice, both for on-premises and cloud-based deployments. SQL Server is a popular Relational Database Management System (RDBMS) that has traditionally only run on the Windows operating system. From SQL Server 2017 onwards, Microsoft has supported SQL Server installations on Linux operating systems.

If you want to run SQL Server, remember that you're not limited to the Windows platform. Because Linux is open-source, it can be installed on low-cost commodity hardware, reducing the operating system licensing expense. Linux also has a smaller footprint and lower hardware requirements, which make it faster to spin up Linux-based VMs over Windows-based servers.

SQL Server on Linux supports Ubuntu, Red Hat Enterprise Linux, and SUSE.

## Why SQL Server?

If you choose SQL Server on Linux as the data platform of choice for Wide World Importers, you can deploy all of your existing SQL Server databases, which currently run on the Windows platform, onto Linux. You will also be able to run your existing applications using the Linux version of SQL Server, and your organization will be able to reuse their existing DBA and application development skills

There will be a straightforward backup and restore into the new Linux environment. A lower risk approach is to move a non-business-critical database to Linux and compare its features and performance directly with Windows. If proven, you could then create a detailed migration strategy to migrate the entire data estate. Compare this work to the approach required to move to a different database technology and a different operating system.

SQL Server on Linux also has all the benefits of industry-leading performance. It's first for performance in the TPC-E benchmark, and first for performance in the TPC-H 1 TB, 10 TB, and 30-TB benchmarks. The National Institute of Standards and Technology (NIST) has rated SQL Server on Linux the most secure database.

Another good reason to consider using SQL Server is the PolyBase feature. With PolyBase, you can set up external sources of data that provide data to external tables. When you submit queries, you can return data from these external tables in the same way as if it was stored in regular tables within your SQL Server database. The external sources of data can include Hadoop, Azure Blob Storage accounts, Oracle, PostgreSQL, MongoDB, and many others. Once you have set up external tables, you can also use them to export or import data from or to SQL Server without having to use an Export, Transform, Load (ETL) package or a separate import or export tool. You can also use PolyBase to integrate external sources of data with the SQL Server business intelligence tools.

Wide World Importers have databases in Oracle and SAP HANA in addition to SQL Server. You were considering using ETL tools to populate a data warehouse with data from all these sources so that you could write reports against it. If you deploy SQL Server with PolyBase, you could instead consider adding Oracle and SAP HANA as external data sources in SQL Server to integrate the three systems. That way, your reports can submit all their queries to SQL Server but still include data that's stored in Oracle and SAP HANA. In this configuration, SQL Server acts as a data virtualization hub.

## Shared codebase

SQL Server on both Linux and Windows use the SQL Platform Abstraction Layer (SQLPAL) which allows SQL Server to run on all the supported operating systems. Therefore, developers can write applications using their favorite language (such as .NET, PHP, node.JS, Java, or Python) and expect the application to run the same way anywhere, whether they are using SQL Server running on Windows, Linux, Linux containers, Azure SQL Edge, or Azure SQL Database.

## Containers

A disadvantage of using VMs is that each one needs all of the resources of the operating system, whether or not the services running require them. A containerized virtualization system avoids this disadvantage by sharing the host operating system while still isolating the individual applications and services. A service running on one container is isolated from a service in another. To the services, they appear as if they're running in separate VMs but instead they're sharing the memory and processors of a single operating system.

SQL Server can be run in Linux containers. If you have to manage large numbers of these containers, you can use an orchestration tool such as Kubernetes or Docker Swarm. You might do this for high availability, or to enable DevOps teams to implement continuous integration or continuous delivery by deploying new code in containers.
