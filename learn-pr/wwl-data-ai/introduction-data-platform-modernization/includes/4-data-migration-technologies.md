The discovery and assessment phase should have given you a clear understanding of your current environment and the workloads that operate within it. You should also understand what you are striving for in your data modernization outcomes. With a clear understanding of these topics, you can select an appropriate data platform technology to support your workloads.

In your global retailer, you've completed the Initiate and Discover and Assessment phases of your data platform modernization project. Now, in the Planning phase, you want to choose the best database technologies to migrate your data estate to. You've decided to host data in the cloud, but you know there are several different technologies in Azure that you can use.

Here, you'll learn about the structured data hosting services that you can use in Azure.

## SQL Server on a Virtual Machine

Using **Infrastructure as a Service (IaaS)**  is very useful for any application solutions that require a quick migration to the cloud with minimal changes. All the versions and editions of SQL Server are available and offer 100% compatibility with SQL Server, allowing you to host as many databases as needed and executing cross-database transactions. There are also other benefits that may get you to consider using IaaS platform including:

- Configure and manage high availability, disaster recovery, and patching for SQL Server easier than on-premises machines
- Customized environment with full administrative rights
- SQL Server instances with up to 64 TB of storage and as many databases as needed
- Fully supports SQL Server transactional replication, AlwaysOn Availability Groups, Integration Services, Log Shipping to replicate data, and traditional SQL Server backups

Because of the simple nature of the migration, migrating to this target platform is often referred to as "lift and shift".

## Azure SQL Database

Azure SQL Database is the collective term for Microsoft's SQL Server Platform-as-a-Service (PaaS) offering. It's fully managed and provides organizations with a highly performing, reliable and secure, general purpose relational database engine in the cloud. There are three products within the Azure SQL Database family, each providing different benefits:

- Single databases
- Elastic Pools
- Managed instances

A Single Database has its own resources and is deployed to a logical SQL Database server where it's managed. There are several tiers of performance, each providing different levels of throughput, performance, storage and cost.  SQL Database Elastic Pools provide organizations with a cost-effective way for deploying and managing multiple databases with different workload characteristics. Elastic Pool databases are deployed onto a single SQL Database server where resources are shared between all of the databases on that server.

Single Databases can be purchased via two different models. Elastic Pool databases can be purchased via the eDTU Purchasing Model and the vCore Purchasing Model.

- **DTU Purchasing Model**

    A Database Throughput Unit (DTU) is a unit of performance calculated by blending CPU, memory, data I/O and transaction log I/O. The higher the DTU, the higher the performance level. The DTU Purchasing Model lets customers control their budgets with per-hourly, fixed price billing.

- **vCore Purchasing Model**

    The vCore Purchasing Model enables customers to select a performance level based on vCores and memory. This model allows compute to be scaled independently of the storage at a more granular level. As an added benefit, the vCore Purchasing Model allows organizations to license Azure SQL Databases with the Azure Hybrid Use Benefit for SQL Server. This means customers with Active Software Assurance (SA) coverage for SQL Server Enterprise and Standard Edition core licenses can  receive savings of up to 30%.

Using a single Azure SQL Database service will suit many business requirements that have databases with predictable performance requirements and it can bring about the following benefits:

- A SQL Server engine compatibility and native virtual network (VNET) support
- Dynamic scalability with no downtime
- Built-in intelligent optimization, global scalability and availability, and advanced security options
- Eliminates hardware costs and reduces administrative costs
- Built-in fault tolerance infrastructure capabilities, Azure SQL Database provides features, such as automated backups, Point-In-Time Restore, geo-restore, and active geo-replication to increase business continuity for applications hosting data in Azure SQL Database
- Databases of up to 4 TB or larger databases that can be horizontally or vertically partitioned using a scale-out pattern

## Azure SQL Database managed instance

For organizations looking to migrate large numbers of SQL Server databases from on-premises, with as low effort as possible, managed instance provides a simple, secure and economical migration destination. Managed instances offers broad SQL Server compatibility and network isolation making it easy to lift-and-shift SQL Server databases to Azure. You can now simply backup an on-premise database and restore it into an Azure SQL Database managed instance. Built on the same fully-managed service offering infrastructure as Azure SQL Database and maintaining all the Azure SQL Database features. It also adds support for database sizes up to 8TB and SQL Server features like SQL Agent, cross-database querying, and replication.

Using Azure SQL Database managed instance brings about the following benefits:

- Isolated environment (single-tenant service with VNET, dedicated compute and storage resources)
- Customer configurable backup retention and recovery
- Database Advisor and Log Analytics for advanced workload analysis
- Automatic database tuning and maintenance for predictable performance
- Monitor, troubleshoot and manage at scale
- Azure portal functionality for manual service provisioning and scaling
- Azure AD authentication, single sign-on support
- Adheres to same compliance standards as Azure SQL Database
- Encryption of the data in transit and rest with customer provided encryption keys
- No patching and version upgrade overhead

Azure SQL Database managed instance is a SQL Server database engine. While it includes SQL Server Agent, it doesn't include other components of SQL Server product including:

- SQL Server Reporting Services (SSRS).
- SQL Server Analysis Services (SSAS).
- SQL Server Integration Services (SSIS).

## Azure SQL Data Warehouse

SQL Data Warehouse is a cloud-based Enterprise Data Warehouse (EDW) that takes advantage of Massively Parallel Processing (MPP) to quickly run complex queries across petabytes of data. It's a distributed system designed to provide analytics on large data. Migrating to SQL Data Warehouse requires some design changes to table schemas and code that aren't difficult to understand but might take some time to implement. If your business requires an enterprise-class data warehouse, the benefits are worth the effort. However, if you don't need the power of SQL Data Warehouse, it will be more cost-effective to use Azure SQL Database or SQL Server on Virtual Machines.

Consider using SQL Data Warehouse when you:

- Have one or more Terabytes of data
- Plan to run analytics on large amounts of data
- Need the ability to scale compute and storage
- Want to save on costs by pausing compute resources when you don't need them.

Don't use SQL Data Warehouse when your workloads have:

- High frequency reads and writes
- Large numbers of singleton select statements
- High volumes of single row inserts
- Row-by-row processing needs
- Incompatible formats (JSON, XML)

> [!NOTE]
> This course will focus on transactional SQL Workloads.
