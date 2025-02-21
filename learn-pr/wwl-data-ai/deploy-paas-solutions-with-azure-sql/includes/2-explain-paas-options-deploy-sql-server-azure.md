Platform as a Service (PaaS) provides a complete development and deployment environment in the cloud, which can be used for simple cloud-based applications and for advanced enterprise applications.

Azure SQL Database and Azure SQL Managed Instance are part of PaaS offering for Azure SQL.

- **Azure SQL Database –** Part of a family of products built upon the SQL Server engine, in the cloud. It gives developers a great deal of flexibility in building new application services, and granular deployment options at scale. SQL Database offers a low maintenance solution that can be a great option for certain workloads.

- **Azure SQL Managed Instance–** It's best for most migration scenarios to the cloud as it provides fully managed services and capabilities.

:::image type="content" source="../media/module-22-plan-implement-final-25.png" alt-text="Platform Management for PaaS Solutions":::

Each offering provides a certain level of administration you have over the infrastructure, by the degree of cost efficiency.

## Deployment models

Azure SQL Database is available in two different deployment models:

- **Single database –** A single database that is billed and managed on a per-database level. You manage each of your databases individually from scale and data size perspectives. Each database deployed in this model has its own dedicated resources, even if deployed to the same logical server.

- **Elastic Pools –** A group of databases that are managed together and share a common set of resources. Elastic pools provide a cost-effective solution for software as a service application model, as resources are shared between all databases. You can configure resources based either on the DTU-based purchasing model or the vCore-based purchasing model.

## Purchasing model

In Azure, all services support physical hardware, and you have the flexibility to choose between two different purchasing models:

### Database Transaction Unit (DTU)

[DTU-based purchasing model](/azure/azure-sql/database/service-tiers-dtu) is calculated based on a formula combining compute, storage, and I/O resources. It's a good choice for customers who want simple, preconfigured resource options.

The DTU purchasing model comes in several different service tiers, such as Basic, Standard, and Premium. Each tier has varying capabilities, providing a wide range of options when choosing this platform.

In terms of performance, the Basic tier is used for less demanding workloads, while the Premium tier is used for intensive workload requirements.

Compute and storage resources are dependent on the DTU level, and they provide a range of performance capabilities at a fixed storage limit, backup retention, and cost.

For more information about DTU purchasing model, see [DTU-based purchasing model overview](/azure/azure-sql/database/service-tiers-dtu).

### vCore

The [vCore-based purchasing model](/azure/azure-sql/database/service-tiers-sql-database-vcore) allows you to purchase a specified number of vCores based on your given workloads. vCore is the default purchasing model when purchasing Azure SQL Database resources. vCore databases have a specific relationship between the number of cores and the amount of memory and storage provided to the database. The vCore purchasing model is supported by both Azure SQL Database and Azure SQL Managed Instance.

You can purchase vCore databases in three different service tiers as well:

| Service Tier       | Best For                     | Storage Type         | Latency          | Compute Tiers       | Resilience Features                                      | Max Database Size |
|--------------------|------------------------------|----------------------|------------------|---------------------|---------------------------------------------------------|-------------------|
| General Purpose    | General-purpose workloads    | Azure premium storage| Higher than BC   | Provisioned, Serverless | N/A                                                     | 4 TB              |
| Business Critical  | High-performing workloads    | Local SSDs           | Lowest           | Provisioned          | Built-in read-only replica, highest resilience to failure | 4 TB              |
| Hyperscale         | Large-scale databases        | Azure premium storage| Varies           | Provisioned          | Unique architecture for scaling                          | 100 TB            |

The General Purpose service tier offers two compute options: **Provisioned** and **Serverless**. Provisioned resources are preallocated and billed hourly based on vCores configured, ideal for consistent workloads. Serverless resources autoscale based on demand and are billed per second, making it cost-efficient for variable workloads.

## Serverless

The term "Serverless" can be misleading because you still deploy your Azure SQL Database to a logical server for connection. [Serverless](/azure/azure-sql/database/serverless-tier-overview) is a compute tier that automatically scales resources up or down based on workload demand. When the workload no longer requires compute resources, the database is paused, and only storage is billed during the inactive period. Upon a connection attempt, the database resumes and becomes available.

:::image type="content" source="../media/module-22-plan-implement-final-24.png" alt-text="Serverless usage example for Azure SQL Database":::

The setting to control pausing is called the autopause delay, with a minimum value of 60 minutes and a maximum value of seven days. If the database remains idle for that duration, it pauses.

Once the database is inactive for the specified time, it pauses until a subsequent connection attempt. Configuring a compute autoscaling range and an autopause delay affects database performance and compute costs.

Applications using serverless should be configured to handle connection errors and include retry logic, as connecting to a paused database generates a connection error.

Another difference between serverless and the standard vCore model of Azure SQL Database is that with serverless, you can specify a minimum and maximum number of vCores. Memory and I/O limits are proportional to the specified range.

:::image type="content" source="../media/module-22-plan-implement-final-12.png" alt-text="Screeshot showing the serveless settings in the Azure portal.":::

The image shows the configuration screen for a serverless database in the Azure portal. You have the option to select a minimum as low as half of a vCore and a maximum as high as 16 vCores.

Serverless isn't fully compatible with all the features in Azure SQL Database since some of them require background processes to run constantly, such as:

- Geo-replication
- Long-term backup retention
- A job database in elastic jobs
- The sync database in SQL Data Sync (Data Sync is a service that replicates data between a group of databases)

> [!NOTE]
> Serverless is currently only supported in the General Purpose tier in the vCore purchasing model.

## Backups

One of the most important features of the Platform as a Service offering is backups. In this case, the system automatically performs backups without any intervention from you. Azure blob geo-redundant storage stores these backups, and by default, retains them for between 7 and 35 days, depending on the service tier of the database. Basic and vCore databases default to seven days of retention, and administrators can adjust this value for vCore databases. You can extend the retention time by configuring long-term retention (LTR), allowing you to retain backups for up to 10 years.

In order to provide redundancy, you're also able to use read-accessible geo-redundant blob storage. This storage would replicate your database backups to a secondary region of your preference. It would also allow you to read from that secondary region if needed. Manual backups of databases aren't supported, and the platform will deny any request to do so.

Database Backups are taken on a given schedule:

- **Full –** Once a week
- **Differential –** Every 12 hours
- **Log –** Every 5-10 minutes depending on transaction log activity

This backup schedule should meet the needs of most recovery point/time objectives (RPO/RTO), however, each customer should evaluate whether they meet your business requirements.

There are several options available for restoring a database. Due to the nature of Platform as a Service, you can't manually restore a database using conventional methods, such as issuing the T-SQL command `RESTORE DATABASE`.

Regardless of which restore method is implemented, it isn't possible to restore over an existing database. If a database needs to be restored, the existing database must be dropped or renamed prior to initiating the restore process. Furthermore, keep in mind that depending on the platform service tier, restore times aren't guaranteed and could fluctuate. It's recommended that you test the restore process to obtain a baseline metric on how long a restore could potentially take.

- **Restore using the Azure portal –** Using the Azure portal you have the option of restoring a database to the same logical server for Azure SQL Database, or you can use the restore to create a new database on a new server in any Azure region.

- **Restore using scripting Languages –** Both PowerShell and Azure CLI can be utilized in order to restore a database.

> [!NOTE]
> Copy-only backup to Azure blob storage is available for SQL Managed Instance. SQL Database doesn't support this feature.

For more information about automated backups, see [Automated backups - Azure SQL Database & Azure SQL Managed Instance](/azure/azure-sql/database/automated-backups-overview).

## Active geo-replication

[Geo-replication](/azure/azure-sql/database/active-geo-replication-overview) is a business continuity feature that asynchronously replicates a database to up to four secondary replicas. As transactions are committed to the primary (and its replicas within the same region), the transactions are sent to the secondaries to be replayed. Since this communication is done asynchronously, the calling application doesn't have to wait for the secondary replica to commit the transaction before SQL Server returns control to the caller.

The secondary databases are readable and can be used to offload read-only workloads, thus freeing up resources for transactional workloads on the primary or placing data closer to your end users. Furthermore, the secondary databases can be in the same region as the primary or in another Azure region

You can initiate a failover either manually by the user or programmatically by the application. If a failover occurs, you can update the application connection strings to reflect the new endpoint of what is now the primary database.

## Failover groups

[Failover groups](/azure/azure-sql/database/failover-group-sql-db) are built on top of the technology used in geo-replication but provide a single endpoint for connection. The major reason for using failover groups is that they provide endpoints that can be utilized to route traffic to the appropriate replica. Your application can then connect after a failover without connection string changes.
