Azure SQL Database is a Platform as a Service (PaaS) database engine that provides a complete development and deployment environment in the cloud, which can be used for simple cloud-based applications and for advanced enterprise applications.

Migrating to SQL Database allows you to modernize your application by taking advantage of its PaaS capabilities. This enables you to eliminate dependencies on technical components that are scoped at the instance level, such as SQL Agent jobs. Azure SQL Database offers a low-maintenance solution that can be an excellent choice for certain workloads.

You may have specific requirements that are better suited for Azure SQL Database rather than Azure SQL Managed Instance in the following scenarios:

- You need to simplify deployment for databases with intermittent, unpredictable usage.
- New databases without usage history where compute sizing is difficult or not possible to estimate prior to deployment.
- The complexity of deployment and development is a concern.
- Your storage requirements are higher than what Azure SQL Managed Instance offers, and database consolidation isn't an option.

The process of migrating a SQL Server database running on an Azure virtual machine to Azure SQL Database is similar to the steps we'll learn in this module.

> [!NOTE]
> Before proceeding, it is important to ensure that you have reviewed the [Assess SQL Server databases for migration to Azure SQL](/training/modules/assess-sql-server-databases-for-migration-to-azure-sql/). This module will introduce you to the assessment tools and help you discover new features in the target SQL Server platform that your database can benefit from after an upgrade.

### Use case scenario

Throughout this module, we're using an example scenario to explain key data migration concepts.

Suppose you work for a company that builds bikes and bicycle parts. You have several legacy database servers that you want to upgrade, including and product database, a parts stock database, and a human resources database. You also want to move from a capital expenditure model to an operational expenditure model, and benefit from the scalability and availability of Azure services. You plan to migrate your SQL Server databases to Azure SQL Database. Your board of directors has asked you to plan the migration project and has made you responsible for the execution of the migration tasks.

You'll learn how to migrate SQL Server databases to Azure SQL Database. You'll begin by exploring the pre-migration considerations you need to take into account before a migration, and how to create an Azure SQL database. You'll then explore the different methods for offline and online migrations, and look at ways to move data to Azure SQL Database.
