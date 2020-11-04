Platform as a Service (PaaS) provides a complete development and deployment environment in the cloud, which can be used for simple cloud-based applications as well as for advanced enterprise applications.

:::image type="content" source="../media/module-22-plan-implement-final-11.png" alt-text="Platform Management for PaaS Solutions":::

As shown in the image above, PaaS includes cloud provided operating system and management of your solution. For example, in Azure SQL Database and Azure SQL Managed Instance, the high availability, OS and SQL Server features, and backups are all provided by the Azure platform.

We’ll explore Azure SQL database in this section. Azure SQL Database is available in three different deployment options:

- A single database – A single database that is billed and managed on a per database level

- Elastic Pools – A group of databases that are managed together and share a common set of resources

- Hyperscale – a single database offering that allows databases to scale much beyond the 4-TB limit of an Azure SQL Database

Even in the cloud all services are backed by physical hardware. The Azure SQL Database allows you to choose from two different purchasing models:

- Database Transaction Unit (DTU) – DTUs are calculated based on a formula combining compute, storage, and I/O resources.

- vCore – The vCore model allows you to purchase a specified number of vCores based on your given workloads. vCore is the default purchasing model when purchasing Azure SQL Database resources. vCore databases have a specific relationship between the number of cores and the amount of memory and storage provided to the database.

Azure SQL Database also includes:

- Automatic backups

- Automatic patching

- Built-in high availability

- SQL Server feature enhancements without the need to upgrade software

## Service Tier Options

PaaS comes in several different service tiers. Each tier has varying capabilities,  which provide a wide range of options when choosing this platform.

The DTU model is available in three different service tiers:

- Basic

- Standard

- Premium

You can purchase vCore databases in three different service tiers as well:

- General Purpose – This tier is for general purpose workloads. It is backed by Azure premium storage. It will have higher latency than Business Critical

- Business Critical – This tier is for high performing workloads offering the lowest latency of either service tier. This tier is backed by local SSDs instead of Azure blob storage. It also offers the highest resilience to failure as well as providing a built-in read-only database replica that can be used to off-load reporting workloads

- Hyperscale – Hyperscale databases can scale far beyond the 4 TB limit the other Azure SQL Database offerings and have a unique architecture that supports databases of up to 100 TB

## Backups

One of the most important features of the Platform as a Service offering is backups. In this case, backups are performed automatically without any intervention from you. Backups are stored in Azure blob geo-redundant storage and by default are retained for between 7 and 35 days, based on the service tier of the database. Basic and vCore databases default to seven days of retention, and on the vCore databases this value can be adjusted by the administrator. The retention time can be extended by configuring long-term retention (LTR), which would allow you to retain backups for up to 10 years. In order to provide redundancy, you are also able to use read-accessible geo-redundant blob storage. This storage would replicate your database backups to a secondary region. It would also allow you to read from that secondary region if needed. It is worth stating that manual backups of databases are not permitted and the platform will deny any request to do so.

Database Backups are taken on a given schedule:

- Full – Once a week

- Differential – Every 12 hours

- Log – Every 5-10 minutes depending on transaction log activity

This backup schedule should meet the needs of most recovery point/time objectives (RPO/RTO) however each customer should evaluate whether they meet your business requirements.

If the need to restore a database arises, there are several options available. Due to the nature of Platform as a Service, you cannot manually restore a database using conventional methods, such as issuing the T-SQL command RESTORE DATABASE.

Regardless of which restore method is implemented, it is not possible to restore over an existing database. If a database needs to be restored, the existing database must be dropped or renamed prior to initiating the restore. Furthermore, keep in mind that depending on the platform service tier, restore times could fluctuate. It is recommended that you test the restore process to obtain baseline metrics on how long a restore could potentially take.

The available restore options are:

Restore using the Azure portal – Using the Azure portal you have the option of restoring a database to the same Azure SQL Database server, or you can use the restore to create a new database on a new server in any Azure region.

Restore using scripting Languages – Both PowerShell and Azure CLI can be utilized in order to restore a database.

## Active geo-replication

Geo-replication is a business continuity feature that asynchronously replicates a database to up to four secondary replicas. As transactions are committed to the primary (and its replicas within the same region), the transactions are sent to the secondaries to be replayed. Because this communication is done asynchronously, the calling application does not have to wait for the secondary replica to commit the transaction prior to SQL Server returning control to the caller.

The secondary databases are readable and can be used to offload read-only workloads, thus freeing up resources for transactional workloads on the primary or placing data closer to your end users. Furthermore, the secondary databases can be in the same region as the primary or in another Azure region.

With geo-replication you can initiate a failover either manually by the user or from the application. If a failover occurs, you potentially will need to update application connection strings to reflect the new endpoint of what is now the primary database.

## Failover groups

Failover groups are built on top of the technology used in geo-replication, but provide a single endpoint for connection. The major reason for using failover groups is that the technology provides endpoints, which can be utilized to route traffic to the appropriate replica. Your application can then connect after a failover without connection string changes.

## Serverless

The name “Serverless” can be a bit confusing as you still deploy your Azure SQL Database to a logical server, to which you connect. Azure SQL Database serverless is a compute tier that will automatically scale up or down the resources for a given database based on demand. If the workload no longer requires compute resources, the database will become “paused” and you will not be charged during the period when the database is in this state. When a connection attempt is made, the database will “resume” and become available. Resuming the database is not instantaneous.

Another difference between serverless and the normal vCore model of Azure SQL Database is that with serverless you can specify a minimum and maximum number of vCores. Memory and I/O limits are proportional to the range that is specified.

:::image type="content" source="../media/module-22-plan-implement-final-12.png" alt-text="The Azure SQL Database Serverless Settings in the Azure portal":::

The image above shows the configuration screen for a serverless database in the Azure portal. You have the option to select a minimum as low as half of a vCore and a maximum as high as 16 vCores. You should note that databases that are not deployed as serverless are referred to as “provisioned”.

The setting to control pausing is referred to as the autopause delay and has a minimum value of 60 minutes and a maximum value of seven days. If the database has been idle for that period of time, it will then pause. Once the database has been inactive for the specified amount of time, it will be paused until a subsequent connection is attempted. Any applications using serverless should be configured to handle connection errors and include retry logic, as connecting to a paused database will generate a connection error.

Serverless is not fully compatible with all features in Azure SQL Database as some features are running background processes all the time. These features include:

- Geo-replication
- Long-term backup retention
- A job database in elastic jobs
- The sync database in SQL Data Sync (Data Sync is a service that replicates data between a group of databases)

## Hyperscale

Azure SQL Database has been limited to 4 TB of storage per database for many years. This restriction is due to a physical limitation of the Azure infrastructure. Azure SQL Database Hyperscale changes the paradigm and allows for databases to be 100 TB or more. Hyperscale introduces new horizontal scaling techniques to add compute nodes as the data sizes grow. The cost of Hyperscale is the same as the cost of Azure SQL Database; however, there is a per terabyte cost for storage. You should note that once an Azure SQL Database is converted to Hyperscale, you cannot convert it back to a “regular” Azure SQL Database.
