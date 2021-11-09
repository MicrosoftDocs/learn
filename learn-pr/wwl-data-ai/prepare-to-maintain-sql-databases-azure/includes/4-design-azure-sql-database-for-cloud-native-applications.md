Azure SQL Database is a Platform as a Service (PaaS) that provides high scalability capabilities, and it can be a great solution for certain workloads, and minimum maintenance efforts. 

The SQL Database service offering is aimed at new application development as it gives developers a great deal of flexibility in building new application services, and granular deployment options.

## Purchasing model

SQL Database comes in two main purchasing models: vCore-based model and DTU-based model. These purchasing models provide the following capabilities:

### vCore-based 

In this purchasing model, compute and storage resources are decoupled. It means you can scale storage and compute resources independently from one another. Each service tier has the following features: 

| Service tier | Capability |
|------------|-------------|
| General Purpose | This service tier is designed for less intensive operations, and offers budget oriented balanced compute and storage options. It provides both provisioned compute tier and serverless compute tier.
|Business Critical | This service tier supports In-Memory OLTP, and built-in read-only replica. It also includes more memory per core, and uses local SSD storage, which is designed for performance-sensitive workloads. |
| Hyperscale | Hyperscale introduces horizontal scaling features that use advanced techniques to add compute nodes as the data sizes grow. It is only supported on single SQL database. Hyperscale allows you to scale storage and compute resources significantly over the limits available for the General Purpose and Business Critical service tiers. |

### DTU-based

In the DTU model, there are three service tiers available: Basic, Standard, and Premium. Compute and storage resources are dependent on the service tier, and they provide a range of performance capabilities at a fixed storage limit, backup retention, and cost. Also, it provides simplicity due to preconfigured resource options.

> [!NOTE] 
> Azure SQL Managed Instance doesn't support DTU-based purchasing model.

There are two main changes that incur in a brief database disconnection at the end of the scaling operation:

- Once you initiate a scaling operation that requires a failover.
- When adding or removing databases to the elastic pool.

You can use a proper [retry logic](/azure/azure-sql/database/troubleshoot-common-connectivity-issues) in your application to handle connection errors. 

## Serverless compute tier

Despite its name, the serverless compute tier does require you to have a server with your database. The serverless option can best be thought of as an autoscaling and auto-pause solution for SQL Database. It is effective for lowering the costs in development and testing environments. For example, you can set up a minimum and a maximum vCores configuration for your database, where it will scale dynamically based on your workload. 

The auto-pause delay feature allows you to define the period of time the database will be inactive before it is automatically paused. The auto-pause delay feature can be set up from 1 hour to seven days. Alternatively, auto-pause delay feature can be disabled. The resume operation is triggered when the next access attempt occurs in the database. Serverless pricing model charges only storage if the database is paused.

:::image type="content" source="../media/prepare_to_maintain_sql_databases_azure_02.png" alt-text="Serverless SQL Database properties from Azure portal":::

The image above illustrates where you can change the autoscaling and auto-pause  properties for serverless compute tier.

## Deployment model

There are two main deployment models when deploying SQL Database on Azure: **single database** and **elastic pool**. Elastic pools share resources with other databases part of the same pool, while single databases resources are managed independently.

SQL Database, like virtual machines, can be deployed using Azure Resource Manager (ARM) templates, PowerShell, Azure CLI, or the Azure portal. 

### Single database

Single database is simplest deployment model of Azure SQL Database. Once your logical server is deployed, you add a database to it, and then connect your application to that database. You manage each of your databases individually from scale and data size perspective. Each database deployed in this model has its own dedicated resources, even if deployed to the same logical server.

You can monitor database resources utilization through Azure portal. This feature allows you to easily identify how the database is performing, as shown in the image below: 

:::image type="content" source="../media/prepare_to_maintain_sql_databases_azure_01.png" alt-text="SQL Database properties from Azure portal":::
 
### Elastic pool

Elastic pools allow you to allocate storage and compute resources to a group of databases, rather than having to manage resources for each database individually. Additionally, elastic pools are easier to scale than single databases, where scaling individual databases is no longer needed due to changes made at the elastic pool level. 

Elastic pools provide a cost-effective solution for software as a service application model, since resources are shared between all databases. You can configure resources based either on the DTU-based purchasing model or the vCore-based purchasing model.

Due to the nature of this model, it is recommended to monitor your resources continually to identify concurrent performance spikes that could affect other databases part of the same elastic pool. Often, you may need to revisit your allocation strategy to make sure there's enough resource available for all databases sharing the same elastic pool.

Elastic pool is a good fit for multi-tenant databases with low average utilization, where each tenant has its own copy of the database. 

## Network options

Azure SQL Database by default has a public internet endpoint. Access to this endpoint can be controlled via firewall rules, or limited to specific Azure networks, using features like Virtual Network endpoints or Private Link. 

## Backup and restore

Azure provides a seemless backup and restore capabilities for SQL Database and SQL Managed Instance, with the following features:

### Continuous backup

Increase your administration efficiency knowing that SQL Databases are backed up regularly, and copied to a read-access geo-redundant storage (RA-GRS) continuously. 

Full backups are performed every week, differential backups every 12 to 24 hours, and transaction log backups every 5 to 10 minutes.

### Geo-restore

As backups are geo-redundant by design for SQL Database and SQL Managed Instance, you can easily restore databases to a different geographical region, which is especially useful for less strict disaster recovery scenarios.

Backup storage is billed apart from regular database files storage. However, when provisioning a SQL Database, the backup storage is created with the maximum size of the data tier selected for your database at no extra cost.

**Note:** Geo-restore is only available if the backup storage redundancy property is set to ***geo-redundant backup storage***

### Point-in-time restore (PITR)

You can configure a specific point in time retention policy for each database running on a SQL Database offering. SQL Database retention period can be set from 1 up to 35 days. In fact, if not specified, Azure will assign it automatically once you create your database, where the default configuration is seven days.

You can restore your databases to a specific point in time according to the retention defined, but PITR is only supported if restoring a database in the same server the backup was originated. You can use either Azure portal, Azure PowerShell, Azure CLI, or REST API to restore a SQL Database.

- **Long-term retention (LTR)**

 Long-term retention is useful for scenarios that require you to set the retention policy beyond what is offered by Azure. You can set a retention policy for up to 10 years, and this option is disabled by default.

 :::image type="content" source="../media/prepare_to_maintain_sql_databases_azure_03.png" alt-text="Long-term retention properties from Azure portal":::

 In the image above, you can configure long-term retention policies through Azure portal. Once the database is selected, a new panel will open on the right side the screen, where you can override the default properties.

 For more information about automated backups, see [Automated backups - Azure SQL Database & Azure SQL Managed Instance](/azure/azure-sql/database/automated-backups-overview?tabs=single-database).

## Automatic Tuning

Running in a PaaS service allows for you to take advantage of additional compute resources on Azure to allow value added services to run. One of the best of these features, is automatic database tuning. Automatic tuning currently includes the following features:

- Identify Expensive Queries
- Forcing Last Good Execution Plan
- Adding Indexes
- Removing Indexes

The Azure services uses a combination of built-in intelligence and advanced heuristics to determine the best indexes for your query patterns. These indexes are tested on a shadow copy of your database and then ultimately implemented into your database. All the aforementioned tuning features have the ability to be turned off in the event you would like to have more control over your environment.

## Elastic query (preview)

The elastic queries feature provides cross-database queries in SQL Database. Queries can either be initiated by the user or application.

This feature is especially useful for applications that cannot be changed, as it allows portability while still taking advantage of the Azure infrastructure.

Elastic queries support the following partitioning strategies:

* Vertical partitioning - Also called cross-database queries. The data is partitioned vertically between many databases. Schemas are different for each database. For example, you may have a database used for customer data, and a different one used for payment information. With the help of vertical partitioning, you can now run a cross-database query between both databases.

* Horizontal Partitioning - Also called sharding. The data is partitioned horizontally to distribute rows across several scaled-out databases. In this topology, the schema remains the same among all sharding databases. It supports either single-tenant model or multiple tenant models.

**Note:** Azure SQL Managed Instance doesn't support elastic jobs.

## Elastic job (preview)

The elastic job feature is the SQL Server Agent replacement for Azure SQL Database. To some extent, it is equivalent to the Multi Server Administration feature available on an on-premises SQL Server instance.

You can execute T-SQL commands across several target deployments like SQL Databases, SQL Database elastic pools, and SQL Databases in shard maps. Database resources can run on different Azure subscriptions, and/or regions. The execution runs in parallel, and it is especially useful for performing database maintenance tasks.

**Note:** Azure SQL Managed Instance doesn't support elastic jobs.

## SQL Data Sync

Data Sync feature allows you to incrementally synchronize data across multiple databases running on SQL Database or on-premises SQL Server. Similarly, Data Sync is a good option if you need to offload intensive workloads in production with a separate database that can be used for analytics and/or adhoc operations. 

Data Sync is based on a hub topology, where you define one of the databases in the sync group to work as a hub database. The sync group can have multiple members, and you can only synchronize changes between the hub database and individual databases. Data Sync tracks changes using insert, update, and delete triggers through a historical table created on the user database.

When you create a sync group, it will ask you to provide a database responsible to store the sync group metadata. The metadata location can be either a new database or an existing database as long it is located in the same region your sync group resides.

 :::image type="content" source="../media/prepare_to_maintain_sql_databases_azure_04.png" alt-text="New sync group page from Azure portal":::

In the image above, you can specify sync group properties like the schedule synchronization, the conflict resolution option, and the use of a private link if needed.

**Note:** Azure SQL Managed Instance doesn't support Data Sync feature.
