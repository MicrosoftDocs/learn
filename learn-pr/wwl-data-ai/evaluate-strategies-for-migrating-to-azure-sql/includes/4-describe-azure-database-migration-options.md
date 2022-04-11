Many organizations are migrating their database platform to Azure SQL to reduce licensing costs. Migrating to Azure SQL platform is made easier by the Azure Database Migration Service (DMS). DMS supports both homogenous (for example, MySQL in a Virtual Machine to Azure SQL Database) and heterogenous sources (for example, Oracle in a Virtual Machine to Azure Database for PostgreSQL) migrations.

There are several tools available to help with the migration process. This next section looks at some of the options and methods for migration.

## Azure Migrate tool

This migration tool provides a centralized location to assess and migrate on-premises servers, infrastructure, applications, and data to Azure. It will provide discoverability and proper assessments of your servers regardless of whether they are physical or VMWare/Hyper-V virtual machines.

Azure Migrate will also help to ensure that you select the appropriate size of virtual machine so that workloads will have enough resources available. In addition, the tool will provide a cost estimation so that you can budget accordingly.

In order to utilize the Azure Migrate tool, you must deploy a light-weight appliance, which can be deployed on a virtual or physical machine. Once the on-premises servers are discovered, the appliance will continually send metadata about each server (along with performance metrics) to Azure Migrate, which resides in the cloud.

:::image type="content" source="../media/module-04-plan-implement-final-01.png" alt-text="Azure Migrate portal options":::

As shown above, the Azure Migrate experience can be kicked off from the portal to begin your migration process. The service consists of a unified migration platform, which provides a single portal to track your entire migration to Azure.

There are several other tools you can use to map your server estate and identify compatibility with your target Azure platform:

- MAP Toolkit—The Microsoft Assessment and Planning Toolkit automatically collects and provide a report containing the inventory of all SQL Servers in your network, version, and server information.

- Database Experimentation Assistant—This tool can be used to evaluate version upgrades of SQL Server by checking syntax compatibility and provides a platform to evaluate query performance on the target version.

## Data Migration Assistant

The MAP toolkit and Database Experimentation assistant can help you identify your databases and highlight any incompatibilities or potential performance issues in your database, but the Data Migration Assistant (DMA) is a comprehensive toolkit that assesses, identifies new features you can use to benefit your application, and ultimately performs the migration. This tool can be used to migrate between versions of SQL Server, from on-premises to an Azure Virtual Machine or Azure SQL Database or Azure SQL Managed Instance.

One of the main benefits of the DMA is the ability to assess queries both from Extended Event trace files and SQL queries from an external application, for example T-SQL queries in the C# application code for your application. You can generate a full report using a C# source and upload the migration assessment to the DMA. The DMA mitigates the risk of moving to a newer version of SQL Server or to Azure SQL Database.

## Azure Database Migration Service

The Azure Database Migration Service is designed to support a wide mix of different migration scenarios with different source and target databases, and both offline (one-time) and online (continuous data sync) migration scenarios.

For online migrations, Azure Database Migration Service provides a highly resilient and self-healing migration service with reliable outcomes and near-zero downtime. Below are highlighted the main steps involved:

1. Fully load your on-premises database to Azure Database. 
2. Continuously syncs new database transactions to the Azure target. 
3. Cut over to the target Azure service when prepared. You can stop the replication, and switch the connection strings in your application to the Azure Database.

The offline source and target pairs are shown in Table 2 below:

| **Target**| **Source** |
| - |-|
| **Azure SQL Database**| SQL Server |
| | RDS SQL |
| | Oracle |
| **Azure SQL Database Managed Instance**| SQL Server |
| | RDS SQL |
| | Oracle |
| **Azure SQL Virtual Machine**| SQL Server |
| | Oracle |
| **Azure Cosmos Database**| MongoDB |
| **Azure Database for MySQL**| MySQL |
| | RDS MySQL |
| **Azure Database for PostgreSQL**| PostgreSQL |
| | RDS PostgreSQL |

The source and target pairs for online migration are shown in Table 3 below:

| **Target**| **Source** |
| - | - |
| **Azure SQL Database**| SQL Server |
| | RDS SQL |
| | Oracle |
| **Azure SQL Database Managed Instance**| SQL Server |
| | RDS SQL |
| | Oracle |
| **Azure SQL Virtual Machine**| SQL Server |
| | Oracle |
| **Azure Cosmos Database**| MongoDB |
| **Azure Database for MySQL**| MySQL |
| | RDS MySQL |
| **Azure Database for PostgreSQL**| PostgreSQL |
| | RDS PostgreSQL |
| | Oracle |

The Data Migration Service has a few prerequisites that are common across migration scenarios. You need to create a virtual network in Azure, and if your migration scenarios involve on-premises resources, you will need to create a VPN or ExpressRoute connection from your office to Azure. There are a number of network ports that are required for connectivity. Once the prerequisites are in place, the time to complete migration will depend on the data volume and rate of change in the databases in question.

There are a number of traditional, more manual approaches to migrating databases to Azure including backup and restore, log shipping, replication, and adding an Availability Group replica in Azure. These solutions were not designed primarily for performing migrations, but they can be used for that purpose. The technique you use for physically migrating your data will depend on the amount of downtime you can sustain during the migration process.

Learn more about the [tools used to migrate SQL databases to Azure](/sql/tools/overview-sql-tools?#migration-and-other-tools).
