Organizations that run Linux can now consider using SQL Server to host databases. Organizations that run SQL Server can now consider moving their servers to the Linux operating system. But why should they choose to make such a change?

As the system administrator for World Wide Importers, you are currently responsible for the Linux servers that host all their front-end web servers, and the back-end Windows database farm. You want to make use of your Linux experience and deploy SQL Server on Linux instead. You must explore the main advantages of using SQL Server on Linux, with the goal of producing a presentation to deliver to your CTO explaining the benefits of SQL Server on Linux and the implications of installing it on Linux.

Here, you will learn why you should consider running SQL Server on Linux.

## Why has SQL Server been released for Linux?

Linux is a collection of operating systems, or distributions, that run on the Linux kernel. It is a popular operating system choice, both for on-premises and cloud-based deployments. SQL Server is a popular Relational Database Management System (RDBMS) that has traditionally only run on the Windows operating system. By releasing SQL Server on Linux, Microsoft has enabled organizations that use Linux to install SQL Server without having to change their choice of operating system or RDBMS. Since Linux is open-source, it can be installed on low-cost commodity hardware, reducing the operating system licensing costs. Linux also has a smaller footprint and lower hardware requirements, which makes it faster to spin up Linux-based VMs over Windows-based servers.

SQL Server on Linux supports Ubuntu, Red Hat Enterprise Linux, and SUSE.

## Why SQL Server?

If you choose SQL Server for World Wide Importers, you can leverage all your existing SQL Server databases and expertise, with a simple backup and restore into the new Linux environment. A lower risk approach is to move a non-business-critical database to Linux and compare its features and performance directly with Windows. If proven, then a detailed migration strategy can be created to migrate the entire data estate. Compare this work to the approach required to move to a different database technology and a different operating system.

SQL Server on Linux also has all the benefits of industry-leading performance as it is first for performance in the TPC-E benchmark, first for performance in the TPC-H 1 TB, 10 TB, and 30-TB benchmarks. NIST has rated it the most secure database over the last seven years. Features for the future include AI built in, and the flexibility to choose what programming languages you use.

## Shared codebase

SQL Server on Linux is not a port of SQL Server for Windows. Both the Linux and Windows database engines run on top of the SQL Platform Abstraction Layer (SQLPAL). This abstraction avoids direct calls to Windows libraries and instead calls the SQLPAL. This abstraction was made possible by building upon the existing platform layer called SQL Server Operating System, which was created to allow SQL Server to run on the various hardware configurations, originally all Windows — combined with the latest work by the Microsoft Research Drawbridge project. Microsoft is getting closer to feature parity with each release of SQL Server on Linux.

## Containers

A disadvantage of using VMs is that each one needs all of the resources of the operating system regardless of whether the services running require them. A containerized virtualization system avoids this disadvantage by sharing the host operating system while still isolating the individual applications and services. A service running on one container is isolated from a service in another. To the services, they appear as if they are running in separate VMs but instead they are sharing the memory and processors of a single operating system.

SQL Server can be run in Docker containers with Kubernetes acting as an orchestration layer for additional resilience.