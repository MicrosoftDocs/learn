Azure SQL managed instance is designed to make it easy to host existing databases in the cloud by providing almost 100 percent compatibility with on-premises versions of SQL Server.

In your sports clothing company, you have a database that stores the product details for your entire catalog. The website uses the database to display product details to customers, by the sales representatives' smartphone apps to keep them informed about the catalog, and by a data analysis solution to populate product dimensions in a data cube. The database is considered business-critical by the board of directors. You've been asked to migrate this database to the cloud so the systems that depend on it need as little modification as possible. You want to evaluate Azure SQL Managed Instance for this project.

## What is Azure SQL Managed Instance?

The Azure SQL platform as a service (PaaS) family includes the Azure SQL Database and Azure SQL Managed Instance. The goal of Azure SQL Managed Instance is to provide SQL Server applications with a fully managed PaaS experience in the Azure cloud.

:::image type="content" source="../media/2-azure-sql.png" alt-text="Diagram showing all Azure SQL offerings available.":::

Azure SQL Managed Instance is designed to enable a *lift and shift* solution for customers. The managed instance looks to bring applications, databases, and supporting technologies to Azure PaaS. Previously, without SQL Managed Instance, migration scenarios where an organization’s application required access to any technology outside of the database (for example SQL Agent jobs, cross database joins, and SQL Server Integration Services) would be prevented from moving to the cloud. The only way a DBA or developer could migrate an on-premises application would be to employ one of the following approaches:

- Move the database and supporting technologies to an infrastructure as a service (IaaS) model. 
- Rewrite the application with a fully PaaS model on Azure SQL Database, with extra development to address migration blockers.

The decision to migrate applications to Azure often hinges on whether an organization has the resources to adapt their application to Azure's PaaS model and manage the application code, as vendor support for modifications is typically limited. So, many opt for SQL Server on IaaS to use the full SQL Server experience without the need to overhaul existing applications. Despite Azure SQL Database's capabilities, the heavy dependence of many applications on technologies outside its scope presents challenges. However, SQL Managed Instance, code-named *"cloud lifter,"* aims to overcome these hurdles, facilitating the migration to a SQL-based PaaS solution in Azure without needing application redesign.

## Review key features

The most important features of SQL Managed Instance include:

| Key Features | Description |
| --- | --- |
| **Backwards compatibility** | Managed instance provides backward compatibility to SQL Server 2008 databases. Direct migration from SQL Server 2005 database servers is also supported, with the compatibility level for migrated SQL Server 2005 databases being updated to SQL Server 2008. |
| **Easy lift and shift** | Managed instance has close to 100 percent compatibility to SQL Server. This compatibility includes core SQL Server components, programmability enhancements, instance-scoped features, such as cross database joins, and management tools that most existing SQL-based applications need to function correctly. |
| **Fully managed PaaS** | PaaS benefits include removing the need for managing hardware and all the overhead that comes from doing physical maintenance on SQL Server servers. You also have the benefits of quickly scaling up and scaling down, and provisioning resources in the cloud. SQL Managed Instance is built on the SQL Server engine, so it's always up to date with the latest SQL features and functionality. |
| **Security features** | You can enable security features at the SQL Managed Instance level just as you do at the database level. These features include the [Vulnerability Assessment](/azure/defender-for-cloud/sql-azure-vulnerability-assessment-overview?azure-portal=true) and the [Advance Threat Protection](/azure/azure-sql/database/threat-detection-configure?azure-portal=true) settings. Finally, at the managed instance level, you can configure [Transparent Data Encryption (TDE)](/azure/azure-sql/database/transparent-data-encryption-tde-overview?azure-portal=true) and whether you want to bring your own key (BYOK) for encryption. |
| **Secure network isolation** | One of the unique aspects of managed instance, network security isolation is where managed instance has complete security isolation from any other tenant in the Azure cloud. In a typical default deployment SQL endpoint, managed instance is solely exposed through a private IP address that only allows connectivity from private Azure networks or hybrid networks. For on-premises applications to connect to managed instance, you'd need an Azure ExpressRoute configuration or a VPN gateway. |
| **Instance failover groups** | An instance failover group is a set of databases managed by a single database server, or within a single managed instance, that can fail over as a unit to another region. You use instance failover groups when all or some of the primary databases have gone offline due to an outage in the primary region. |

## Migration options supported

There are two modes of migration to Azure SQL Managed Instance: **online** and **offline**. The online mode has minimal or no downtime, while the offline mode experiences downtime during the migration process.

- [**Log Replay Service**](/azure/azure-sql/managed-instance/log-replay-service-overview?azure-portal=true). It's an online migration option, and used when you need more control of your database migration project.

- [**Azure SQL Migration extension for Azure Data Studio**](/sql/azure-data-studio/extensions/azure-sql-migration-extension?azure-portal=true). It's a tool that helps you prepare for migrating your SQL Server databases to Azure. It uses the latest version of Data Migration Services to assess your readiness for migration, recommend the best Azure resources for your needs, and execute the migration. It’s ideal for small to medium-sized databases and supports online migration to SQL Managed Instance.

- [**Managed Instance link.**](/azure/azure-sql/managed-instance/managed-instance-link-feature-overview?azure-portal=true). The Managed Instance link, using distributed availability groups, securely extends your data estate by replicating data almost instantly (online) between any hosted SQL Server and Azure SQL Managed Instance, and vice versa.

- [**Native backup and restore**](/azure/azure-sql/managed-instance/restore-sample-database-quickstart?azure-portal=true). Backup and restore are a simple migration method favored by many SQL Server professionals. It's the easiest migration option for customers who can provide full database backups to Azure Storage.

- [**Transactional replication**](/sql/relational-databases/replication/transactional/transactional-replication?azure-portal=true). Transactional replication is a way to move data between continuously connected database servers. It’s best to be used for online or offline migration of large and complex databases.

While most of the tools facilitate [migration to Azure SQL Database](/training/modules/migrate-sql-workloads-azure-sql-databases/?azure-portal=true) as well, there are some that are exclusively supported by SQL Managed Instance. In the next units, we'll learn about a few of them in more detail.

> [!Tip]
> Learn more about how to [design a SQL Server migration strategy](/training/modules/introduction-data-platform-modernization?azure-portal=true).
