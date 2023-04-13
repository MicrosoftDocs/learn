Now the compute platform is identified, you'll need to decide which Azure service will store the application data.

Azure platform offers several database-as-a-services options, including Azure SQL, Azure Database for MySQL, and Azure Database for PostgreSQL. Your choice of the database technology should be based on the following requirements for the Spring Petclinic application:

 -  The target database service should simplify the migration path from the on-premises MySQL deployment.
 -  The target database service must support automatic backups.
 -  The target database service needs to support automatic patching.

## Azure SQL

Azure SQL is a collective term for a family of Microsoft SQL Server based database services in Azure. Specific Azure SQL services include:

 -  **SQL Server on Azure Virtual Machines (VMs)** \- A virtual machine running in Azure with an installation of SQL Server. The use of a VM makes this option an infrastructure-as-a-service (IaaS) solution that virtualizes hardware infrastructure for compute, storage, and networking in Azure for "lift and shift" migration of existing on-premises SQL Server to the cloud.
 -  **Azure SQL Managed Instance** \- A platform-as-a-service (PaaS) option that provides near-100% compatibility with on-premises SQL Server instances while abstracting the underlying hardware and operating system. The service includes automated software update management, backups, and other maintenance tasks, reducing the administrative burden of supporting a database server instance.
 -  **Azure SQL Database** \- A fully managed, highly scalable PaaS database service that is designed for the cloud. This service includes the core database-level capabilities of on-premises SQL Server, and is a good option when you need to create a new application in the cloud.

## Azure Database for MySQL

Azure Database for MySQL is a PaaS implementation of MySQL in the Azure cloud, based on the MySQL Community Edition.

The Azure Database for MySQL service includes high availability at no extra cost, and scalability as required. You only pay for what you use. Automatic backups are provided, with point-in-time restore.

The server provides connection security to enforce firewall rules and, optionally, require Secure Sockets Layer connections. Many server parameters enable you to configure server settings such as lock modes, maximum number of connections, and timeouts.

Azure Database for MySQL provides a global database system that scales up to large databases without the need to manage hardware, network components, virtual servers, software patches, and other underlying components.

You get the following features with Azure Database for MySQL:

 -  High availability features built-in.
 -  Predictable performance.
 -  Easy scaling that responds quickly to demand.
 -  Secure data, both at rest and in motion.
 -  Automatic backups and point-in-time restore for the last 35 days.
 -  Enterprise-level security and compliance with legislation.

:::image type="content" source="../media/my-sql-database-0dd052f1.png" alt-text="Diagram showing the features of fully managed MySQL database.":::


## Azure Database for PostgreSQL

If you prefer PostgreSQL, you can choose Azure Database for PostgreSQL to run a PaaS implementation of PostgreSQL in the Azure Cloud. This service provides the same availability, performance, scaling, security, and administrative benefits as the MySQL service.

Some features of on-premises PostgreSQL databases aren't available in Azure Database for PostgreSQL. These features are mostly concerned with the extensions that users can add to a database to perform specialized tasks. For example, writing stored procedures in various programming languages (other than pgsql, which is available), and interacting directly with the operating system. A core set of the most frequently used extensions is supported, and the list of available extensions is under continuous review.

Azure Database for PostgreSQL has three deployment options: Single Server, Flexible Server, and Hyperscale.

## Summary

In its default configuration, Pet Clinic uses an in-memory database (HSQLDB) which is populated at startup with data. A similar setup is provided for MySQL if a persistent database configuration is needed. Based on these requirements, you decided to use Azure Database for MySQL Single Server.
