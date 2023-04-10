The discovery and assessment phase should have given you a clear understanding of your current environment and the workloads that operate within it. You should also understand what you are striving for in your data modernization outcomes. With a clear understanding of these topics, you can select an appropriate data platform technology to support your workloads.

In our global retailer scenario, you've completed the discover and assessment phases of your data platform modernization project. Now, in the planning phase, you want to choose the best database technologies to migrate your data estate to. You've decided to host data in the cloud, but you know there are several different technologies in Azure that you can use.

Here, you'll learn about  the Azure SQL hosting services available, and also Azure Synapse Analytics.

:::image type="content" border="false" source="../media/2-azure-sql-overview.png" alt-text="A diagram showing the main Azure SQL solutions and scenarios for data modernization.":::

## SQL Server on a Virtual Machine

Using **Infrastructure as a Service (IaaS)**  is useful for any application solutions that require a quick migration to the cloud with minimal changes. All the versions and editions of SQL Server are available and offer 100% compatibility with SQL Server, allowing you to host as many databases as needed and executing cross-database transactions. There are also other benefits that may get you to consider using IaaS platform including:

- Configure and manage high availability, disaster recovery, and patching for SQL Server easier than on-premises machines
- Customized environment with full administrative rights
- SQL Server instances with up to 64 TB of storage and as many databases as needed
- Fully supports SQL Server transactional replication, AlwaysOn Availability Groups, Integration Services, Log Shipping to replicate data, and traditional SQL Server backups

Because of the simple nature of the migration, migrating to this target platform is often referred to as "lift and shift".

## Azure SQL Managed Instance

SQL Managed Instance is an ideal migration destination for organizations seeking a low-effort solution to transfer large numbers of on-premises SQL Server databases to Azure. With broad SQL Server compatibility and network isolation, it simplifies the lift-and-shift process while providing a secure and cost-effective solution. You can backup and restore on-premises databases to SQL Managed Instance, which offers the same features as SQL Database, along with support for larger database sizes (up to 8 TB) and SQL Server features such as SQL Agent, cross-database querying, and replication.

Using Azure SQL Managed Instance brings about the following benefits:

- Isolated environment (single-tenant service with VNET, dedicated compute and storage resources)
- Customer configurable backup retention and recovery
- Database Advisor and Log Analytics for advanced workload analysis
- Automatic database tuning and maintenance for predictable performance
- Monitor, troubleshoot, and manage at scale
- Azure portal functionality for manual service provisioning and scaling
- Azure AD authentication, single sign-on support
- Adheres to same compliance standards as Azure SQL Database
- Encryption of the data in transit and rest with customer provided encryption keys
- No patching and version upgrade overhead

## Azure SQL Database

Azure SQL Database is fully managed and provides organizations with a highly performing, reliable, and secure, general purpose relational database engine in the cloud. There are deployment models within Azure SQL Database, each providing different benefits:

- **Single database**

    A single database has its own resources and is deployed to a logical SQL Database server where it's managed. There are several tiers of performance, each providing different levels of throughput, performance, storage, and cost.

- **Elastic Pools**

    Elastic pools provide organizations with a cost-effective way for deploying and managing multiple databases with different workload characteristics. Databases that belong to an elastic pool are deployed onto a single SQL Database server, allowing for shared resource utilization among all databases within the pool.

Both single databases and elastic pools can be purchased using either the DTU-based purchasing model or the vCore-based purchasing model.

- **DTU-based purchasing model**

    A Database Throughput Unit (DTU) is a unit of performance calculated by blending CPU, memory, data I/O and transaction log I/O. The higher the DTU, the higher the performance level. The DTU Purchasing Model lets customers control their budgets with per-hourly, fixed price billing.

- **vCore-based purchasing model**

    The vCore purchasing model enables customers to select a performance level based on vCores and memory. This model allows compute to be scaled independently of the storage at a more granular level. As an added benefit, the vCore purchasing model allows organizations to license Azure SQL Databases with the Azure Hybrid Use Benefit for SQL Server. This means customers with Active Software Assurance (SA) coverage for SQL Server Enterprise and Standard Edition core licenses can  receive savings of up to 30%.

Using a single Azure SQL Database service will suit many business requirements that have databases with predictable performance requirements and it can bring about the following benefits:

- A SQL Server engine compatibility and native virtual network (VNET) support
- Dynamic scalability with no downtime
- Built-in intelligent optimization, global scalability and availability, and advanced security options
- Eliminates hardware costs and reduces administrative costs
- Built-in fault tolerance infrastructure capabilities, Azure SQL Database provides features, such as automated backups, Point-In-Time Restore, geo-restore, and active geo-replication to increase business continuity for applications hosting data in Azure SQL Database
- Databases of up to 4 TB or larger databases that can be horizontally or vertically partitioned using a scale-out pattern

## Azure Synapse Analytics

Azure Synapse Analytics is a cloud-based Enterprise Data Warehouse (EDW) that takes advantage of Massively Parallel Processing (MPP) to quickly run complex queries across large amount of data. It's a distributed system designed to provide analytics on large data. Migrating to Azure Synapse Analytics requires some design changes to table schemas and code that aren't difficult to understand but might take some time to implement. If your business requires an enterprise-class data warehouse, the benefits are worth the effort. However, if you don't need the power of Azure Synapse Analytics, it will be more cost-effective to use Azure SQL Database or SQL Server on Virtual Machine.

Consider using Azure Synapse Analytics when you:

- Have one or more terabytes of data
- Plan to run analytics on large amounts of data
- Need the ability to scale compute and storage
- Want to save on costs by pausing compute resources when you don't need them.

Don't use Azure Synapse Analytics when your workloads have:

- High frequency reads and writes
- Large numbers of singleton select statements
- High volumes of single row inserts
- Row-by-row processing needs
- Incompatible formats (JSON, XML)
