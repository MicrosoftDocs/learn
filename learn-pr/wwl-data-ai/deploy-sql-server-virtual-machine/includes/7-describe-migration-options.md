Azure Infrastructure as a Service (IaaS) solutions are frequently used when migrating your on-premises environment to the cloud. There are several tools available to help with the migration process. This next section looks at some of the tools and methods for migration.

## Azure Migrate tool

This migration tool provides a centralized location to assess and migrate on-premises servers, infrastructure, applications and data to Azure. It will provide discoverability and proper assessments of your servers regardless of whether they are physical or VMWare/Hyper-V virtual machines.

Azure Migrate will also help to ensure that you select the appropriate size of virtual machine so that workloads will have enough resources available. In addition, the tool will provide a cost estimation so that you can budget accordingly.

In order to utilize the Azure Migrate tool, you must deploy a light-weight appliance which can be deployed on a virtual or physical machine. Once the on-premises servers are discovered, the appliance will continually send metadata about each server (along with performance metrics) to Azure Migrate, which resides in the cloud.

:::image type="content" source="../media/module-22-plan-implement-final-10.png" alt-text="Azure Migrate portal options":::

As shown above, the Azure Migrate experience can be kicked off from the portal to begin your migration process. The service consists of a unified migration platform which provides a single portal to track your entire migration to Azure.

There are several additional tools you can use to map your server estate and identify compatibility with your target Azure platform:

- MAP Toolkit—The Microsoft Assessment and Planning Toolkit automatically gathers an inventory of all of the SQL Servers in your network, gathering version and server information and providing reports on the information gathered.

- Database Experimentation Assistant—This tool can be used to evaluate version upgrades of SQL Server by checking syntax compatibility and provides a platform to evaluate query performance on the target version.

## Data Migration Assistant

The MAP toolkit and Database Experimentation assistant can help you identify your databases and highlight any incompatibilities or potential performance issues in your database, but the Data Migration Assistant (DMA) is a comprehensive toolkit that assesses, identifies new features you can use to benefit your application, and ultimately performs the migration. This tool can be used to migrate between versions of SQL Server, from on-premises to an Azure VM or Azure SQL Database or Azure SQL Managed Instance.

One of the main benefits of the DMA is the ability to assess queries both from Extended Event trace files and SQL queries from an external application, for example T-SQL queries in the C# application code for your application. You can generate a full report using a C# source and upload the migration assessment to the DMA. The DMA mitigates the risk of moving to a newer version of SQL Server or to Azure SQL Database.

## Azure Database Migration Service

The Azure Database Migration Service (DMS) is designed to support a wide mix of different migration scenarios with different source and target databases, and both offline (one-time) and online (continuous data sync) migration scenarios. The DMS supports migrating to and from SQL Server to Azure SQL Database and Azure SQL Managed Instance. The offline source and target pairs are shown in Table 2 below:

| **Target**| **Source** |
| - |-|
| **Azure SQL DB**| SQL Server |
| | RDS SQL |
| | Oracle |
| **Azure SQL DB MI**| SQL Server |
| | RDS SQL |
| | Oracle |
| **Azure SQL VM**| SQL Server |
| | Oracle |
| **Azure Cosmos DB**| MongoDB |
| **Azure DB for MySQL**| MySQL |
| | RDS MySQL |
| **Azure DB for PostgreSQL**| PostgreSQL |
| | RDS PostgreSQL |

The source and target pairs for online migration are shown in Table 3 below:

| **Target**| **Source** |
| - | - |
| **Azure SQL DB**| SQL Server |
| | RDS SQL |
| | Oracle |
| **Azure SQL DB MI**| SQL Server |
| | RDS SQL |
| | Oracle |
| **Azure SQL VM**| SQL Server |
| | Oracle |
| **Azure Cosmos DB**| MongoDB |
| **Azure DB for MySQL**| MySQL |
| | RDS MySQL |
| **Azure DB for PostgreSQL**| PostgreSQL |
| | RDS PostgreSQL |
| | Oracle |

The Data Migration Service has a few prerequisites that are common across migration scenarios. You need to create a virtual network in Azure, and if your migration scenarios involve on-premises resources, you will need to create a VPN or ExpressRoute connection from your office to Azure. There are a number of network ports that are required for connectivity. Once the prerequisites are in place, the time to complete migration will depend on the data volume and rate of change in the databases in question.

There are a number of traditional, more manual approaches to migrating databases to Azure including backup and restore, log shipping, replication, and adding an Availability Group replica in Azure. These solutions were not designed primarily for performing migrations, but they can be used for that purpose. The technique you use for physically migrating your data will depend on the amount of downtime you can sustain during the migration process.
