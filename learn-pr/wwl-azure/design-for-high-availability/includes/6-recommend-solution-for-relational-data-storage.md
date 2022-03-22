Tailwind Traders has numerous apps that access and store data in databases. It's important that these apps, and their respective databases, are highly available and when necessary, recoverable.

To understand the availability options and capabilities in Azure SQL, you need to understand service tiers. The service tier you select will determine the underlying architecture of the database or managed instance that you deploy.

There are two purchasing models to consider: DTU and vCore. Lets focus on the vCore service tiers and their architectures for high availability. You can equate the DTU model's Basic and Standard tiers to General Purpose, and its Premium tiers to Business Critical.

## General purpose

Databases and managed instances in the General Purpose service tier have the same availability architecture. Using the following figure as a guide, first consider the application and control ring. The application connects to the server name, which then connects to a gateway (GW) that points the application to the server to connect to, running on a VM. With General Purpose, the primary replica uses locally attached SSD for the tempdb. The data and log files are stored in Azure Premium Storage, which is locally redundant storage (multiple copies in one region). The backup files are then stored in Azure Standard Storage, which is RA-GRS by default. In other words, it's globally redundant storage (with copies in multiple regions).

All of Azure SQL is built on Azure Service Fabric, which serves as the Azure backbone. If Azure Service Fabric determines that a failover needs to occur, the failover will be similar to that of a failover cluster instance (FCI). The service fabric will identify a node with spare capacity and spin up a new SQL Server instance. The database files will then be attached, recovery will be run, and gateways will be updated to point applications to the new node. No virtual network or listener or updates are required. This capability is built in.

:::image type="content" source="../media/azure-sql-fail-over.png" alt-text="Diagram of the application and control ring.":::

 

## Business critical

The next service tier to consider is Business Critical, which can generally achieve the highest performance and availability of all Azure SQL service tiers (General Purpose, Hyperscale, Business Critical). Business Critical is meant for mission-critical applications that need low latency and minimal downtime.

:::image type="content" source="../media/sql-business-critical-fail-over.png" alt-text="Diagram of SQL business critical failover.":::

 


Using Business Critical is like deploying an Always On availability group (AG) behind the scenes. Unlike in the General Purpose tier, in Business Critical, the data and log files are all running on direct-attached SSD, which significantly reduces network latency. (General Purpose uses remote storage.) In this AG, there are three secondary replicas. One of them can be used as a read-only endpoint (at no additional charge). A transaction can complete a commit when at least one of the secondary replicas has hardened the change for its transaction log.

Read scale-out with one of the secondary replicas supports session-level consistency. So if the read-only session reconnects after a connection error caused by replica unavailability, it might be redirected to a replica that's not 100% up to date with the read-write replica. Likewise, if an application writes data by using a read-write session and immediately reads it by using a read-only session, the latest updates might not immediately be visible on the replica. The latency is caused by an asynchronous transaction log redo operation.

If any type of failure occurs and the service fabric determines a failover needs to occur, failing over to a secondary replica is fast because the replica already exists and has the data attached to it. In a failover, you don't need a listener. The gateway will redirect your connection to the primary even after a failover. This switch happens quickly, and then the service fabric takes care of spinning up another secondary replica.

## Hyperscale

The Hyperscale service tier is currently available for Azure SQL Database, and not Azure SQL Managed Instance. This service tier has a unique architecture because it uses a tiered layer of caches and page servers to expand the ability to quickly access database pages without having to access the data file directly.

:::image type="content" source="../media/sql-hyper-scale-service-tier.png" alt-text="Diagram of SQL hyperscale service tier.":::


Because this architecture uses paired page servers, you can scale horizontally to put all the data in caching layers. This new architecture also allows Hyperscale to support databases as large as 100 TB. Because it uses snapshots, nearly instantaneous database backups can occur regardless of size. Database restores take minutes rather than hours or days. You can also scale up or down in constant time to accommodate your workloads.

It's interesting to note how the log service was pulled out in this architecture. The log service is used to feed the replicas and the page servers. Transactions can commit when the log service hardens to the landing zone. So the consumption of the changes by a secondary compute replica isn't required for a commit. Unlike in other service tiers, you can determine whether you want secondary replicas. You can configure zero to four secondary replicas, which can all be used for read-scale.

As in the other service tiers, an automatic failover will happen if service fabric determines it needs to. But the recovery time will depend on the existence of secondary replicas. For example, if you don't have replicas and a failover occurs, the scenario will be similar to that of the General Purpose service tier: the service fabric first needs to find spare capacity. If you have one or more replicas, recovery is faster and more closely aligns to that of the Business Critical service tier.

Business Critical maintains the highest performance and availability for workloads with small log writes that need low latency. But the Hyperscale service tier allows you to get a higher log throughput in terms of MB/second, provides for the largest database sizes, and provides up to four secondary replicas for higher levels of read scale. So, you'll need to consider your workload when you choose between the two.

## Database service tiers for availability

Azure SQL Database and Azure SQL Managed Instance provide great availability options by default in the various service tiers. There are some additional things you can do to increase or modify the availability of your databases/instances. You'll be able to determine the impact on the service-level agreement (SLA). In this unit, you'll learn how you can go further with various options for availability in Azure SQL.

## Availability Zones

In the Business Critical tier in Azure SQL Database, you can opt in (for no additional fee) for a zone-redundant configuration if your region supports that. At a high level, the Always On Availability Group (AG) that runs behind Business Critical databases and managed instances is deployed across three Availability Zones within a region. An Availability Zone is basically a separate datacenter within a given region. There's always a physical separation between Availability Zones. This capability protects against catastrophic failures that might occur to a datacenter in a region.

:::image type="content" source="../media/sql-zone-redundant-configuration.png" alt-text="Diagram of SQL zone redundant configuration.":::


From performance standpoint, there might be a small increase in network latency because your AG is now spread across datacenters that have some distance between them. For this reason, Availability Zones isn't turned on by default. You can choose to use what's commonly called a "Multi-Az" or a "Single-Az" deployment. Configuring this option is as simple as adding a parameter to a PowerShell/Azure CLI command or selecting a check box in the portal.

Availability Zones are relatively new to Azure SQL, so they're currently available only in certain regions and service tiers. Over time, this capability is likely to be supported in more regions and potentially more service tiers. 

## Azure SQL SLA

Azure SQL maintains a service-level agreement (SLA) that provides financial backing to the commitment to achieve and maintain service levels. If your service level isn't achieved and maintained as described in the SLA, you might be eligible for a credit toward a portion of your monthly service fees.

Currently, you can achieve the highest availability (99.995%) from an Azure SQL Database Business Critical deployment that has Availability Zones configured. The Business Critical tier is the only option in the industry that provides RPO and RTO SLAs of 5 seconds and 30 seconds, respectively. RPO stands for recovery point object. It represents the amount of data you're potentially willing to lose in a worst case scenario. RTO stands for recovery time objective. It represents how long it takes to be back up and running again if a disaster occurs.

For General Purpose or single-zone Business Critical deployments of Azure SQL Database or Azure SQL Managed Instance, the SLA is 99.99%.

The Hyperscale tier's SLA depends on the number of replicas. Remember that you choose how many replicas you have in Hyperscale. If you don't have any, the failover behavior is more like that of General Purpose. If you have replicas, the failover behavior is more like that of Business Critical. Here are the SLAs, based on the number of replicas:

- 0 replicas: 99.5%

- 1 replica: 99.9%

- 2 or more replicas: 99.99%

## What is active geo-replication?

Organizations, like Tailwind Traders, that want a local presence, or a hot backup, can run services in multiple Azure regions. Active geo-replication enables you to create readable secondary databases of individual databases. These databases can be on a server in the same or in a different region.

In the following graphic, an app is hosted in the custom domain Contoso.com. The app uses databases to store data. To manage failover to a secondary region, an administrator has configured a secondary region. Geo-replication has been enabled between the regions.

:::image type="content" source="../media/geo-replication.png" alt-text="Traffic Manager has primary and secondary replication regions.":::


Active geo-replication is available for:

- Azure SQL Database: You can configure active geo-replication for any database in any elastic database pool. You can use active geo-replication to:

	- Create a readable secondary replica in a different region.

	- Fail over to a secondary database if your primary database fails or needs to be taken offline.

>[!TIP]
>You can have up to four readable secondary replicas. Cosmos DB. Cosmos DB supports geo-replication across regions. However, you also can:
>
>	- Designate one region as the writable region and all others as read-only replicas.
>
>	- Fail over by selecting another region to be the write region during an outage.

>[!NOTE]
>Support for Azure SQL Hyperscale is in preview.

The following table describes the capabilities of active geo-replication.

| **Capability**| **Description** |
| - | - |
| Automatic Asynchronous Replication| You can only create a secondary database by adding to an existing database. The secondary database is seeded with data from the primary database. Thereafter, updates to the primary are asynchronously replicated to the secondary database automatically. |
| Readable secondary databases| An application can access a secondary database for read-only operations. |
| Planned failover| Use planned failover to switch the roles of primary and secondary databases. This is an online operation that doesn't result in data loss. Planned failover enables you to: conduct DR drills; relocate the database to a different region; return the database to the primary region. |
| Unplanned failover| Unplanned failover switches the secondary to the primary role immediately, and without any synchronization with the primary. Designed as a recovery method during outages when the primary isn’t accessible, but database availability must be quickly restored. Note that transactions committed to the primary but not replicated to the secondary are lost. |
| Multiple readable secondaries| Configure up to four secondary databases for each primary. |
| Geo-replication of databases in an elastic pool| You can configure each secondary database in an elastic pool, or not, as required. Because each elastic pool is contained within a single region, multiple secondary databases in the same topology can never share an elastic pool. |
| User-controlled failover and failback| You can explicitly switch a secondary database to the primary role at any time. |


## What are auto-failover groups?

Because active geo-replication isn’t supported by Azure SQL Managed Instance, for geographic failover of instances of SQL Managed Instance, you must use Auto-failover groups. Auto-failover groups enable you to manage the replication (and failover) of a group of databases (on a server or all databases in a managed instance) to another region. As with geo-replication, you can choose to initiate failover manually, or you can delegate it to the Azure service based on a policy that you define.

 

>[!TIP]
>A failover group can include one or multiple databases, typically used by the same app. 

You must configure the auto-failover group on the primary server. The configuration connects the primary to the secondary server in a different Azure region. The groups can include all or some databases in these servers. The following graphic depicts a typical configuration of a geo-redundant cloud application using multiple databases and auto-failover group.

:::image type="content" source="../media/automatic-fail-over-group.png" alt-text="Traffic Manager uses automatic failover groups.":::



The following table describes some of the capabilities of auto-failover groups.

| **Capability**| **Description** |
| - | - |
| Automatic failover policy| A failover group is configured with an automatic failover policy by default. Azure triggers failover when a failure is detected, and the grace period has expired. |
| Planned failover| Performs full synchronization between primary and secondary databases. Then the secondary switches to the primary role. |
| Unplanned failover| Immediately switches the secondary to the primary role without any synchronization with the primary. |
| Manual failover| Enables you to initiate failover manually, regardless of the automatic failover configuration. If you haven’t configured an automatic failover policy, manual failover is required to recover databases in the failover group to the secondary. |


Since auto-failover groups are a similar function to active geo-replication, it’s worth considering when to use each.

Use active geo-replication when:

- You’re implementing the Hyperscale service tier. Auto-failover groups aren’t currently supported in the Hyperscale service tier.

- You want multiple Azure SQL Database secondaries in the same or different regions.

Use auto-failover groups when:

- You’re implementing Azure SQL DB managed instance.

>[!IMPORTANT]
> Auto-failover groups support both Azure SQL DB and Azure SQL Database. However, Active geo-replication supports only Azure SQL Database.

 

## Geo-replication and auto-failover groups

After you choose a service tier (and consider Availability Zones as applicable), you can consider some other options for getting read-scale or the ability to fail over to another region: geo-replication and auto-failover groups. In SQL Server on-premises, configuring either of these options is something that would take a lot of planning, coordination, and time.

The cloud, and Azure SQL specifically, have made this process easier. For both geo-replication and auto-failover groups, you can get configured with a few clicks in the Azure portal or a few commands in the PowerShell/Azure CLI.

Here are some considerations to help you decide if geo-replication or auto-failover groups are best for your scenario:

| ‎| **Geo-replication**| **Failover groups** |
| - | - | - |
| Automatic failover| No| Yes |
| Fail over multiple databases simultaneously| No| Yes |
| User must update connection string after failover| Yes| No |
| SQL Managed Instance support| No| Yes |
| Can be in same region as primary| Yes| No |
| Multiple replicas| Yes| No |
| Supports read-scale| Yes| Yes |


 

Global distribution enables you to replicate data from one region into multiple Azure regions. You can add or remove regions in which your database is replicated at any time, and Azure Cosmos DB ensures that when you add an additional region, your data is available for operations within 30 minutes, assuming your data is 100 TBs or less.

There are two common scenarios for replicating data in two or more regions:

1. Delivering low-latency data access to end users no matter where they are located around the globe

2. Adding regional resiliency for business continuity and disaster recovery (BCDR)

To deliver low-latency data access to customers, it is recommended that you replicate the data to regions closest to where your users are. For your online clothing company, you have customers in Los Angeles, New York, and Tokyo. Take a look at the [Azure regions](https://azure.microsoft.com/global-infrastructure/regions/) page, and determine the closest regions to those sets of customers, as those are the locations you'll replicate users to.

To provide a BCDR solution, it is recommended to add regions based on the region pairs described in the [Business continuity and disaster recovery (BCDR): Azure Paired Regions](/azure/best-practices-availability-paired-regions) article.

What high availability strategy would you recommend for Tailwind Traders relational databases? How would you design their production workloads compared to dev and test environments? 