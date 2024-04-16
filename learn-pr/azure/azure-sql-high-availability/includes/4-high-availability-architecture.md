To understand the availability options and capabilities in Azure SQL, you need to understand service tiers. The service tier you select will determine the underlying architecture of the database or managed instance that you deploy.

There are two purchasing models to consider: DTU and vCore. This unit will focus on the vCore service tiers and their architectures for high availability. You can equate the DTU model's Basic and Standard tiers to General Purpose, and its Premium tiers to Business Critical.  

## General Purpose

Databases and managed instances in the General Purpose service tier have the same availability architecture. Using the following figure as a guide, first consider the *application* and *control ring*. The application connects to the server name, which then connects to a gateway (GW), which points the application's connection to the correct server, running on a VM. With General Purpose, the primary replica uses locally attached SSD for the `tempdb`. The data and log files are stored in Azure Premium Storage, which is locally redundant storage (multiple copies in one region). The backup files are then stored in Azure Standard Storage, which is RA-GRS by default. RA-GRS is globally redundant storage, with copies in multiple regions.

As we discussed in an earlier module in this learning path, all of Azure SQL is built on Azure Service Fabric, which serves as the Azure backbone. If Azure Service Fabric determines that a failover needs to occur, the failover will be similar to that of a failover cluster instance (FCI). The service fabric will look for a node with spare capacity and spin up a new SQL Server instance. The database files will then be attached, recovery will run, and gateways will be updated to point applications to the new node. No virtual network or listener or updates are required. This capability is built in.

:::image type="content" source="../media/4-general-purpose-architecture.png" alt-text="Screenshot that shows the General Purpose architecture.":::

## Business Critical

The next service tier to consider is Business Critical, which can generally achieve the highest performance and availability of all Azure SQL service tiers (General Purpose, Hyperscale, Business Critical). Business Critical is meant for mission-critical applications that need low latency and minimal downtime.  

:::image type="content" source="../media/4-business-critical-architecture.png" alt-text="Screenshot that shows the Business Critical architecture.":::

Using Business Critical is like deploying an Always On availability group (AG) behind the scenes. Unlike in the General Purpose tier, the data and log files in Business Critical are all running on a direct-attached SSD, which significantly reduces network latency. (General Purpose uses remote storage.) In this AG, there are three secondary replicas. You can use one of them as a read-only endpoint (at no additional charge). A transaction can complete a commit when at least one of the secondary replicas has hardened the change for its transaction log.

Read scale-out with one of the secondary replicas supports session-level consistency, so if the read-only session reconnects after a connection error caused by replica unavailability, it might be redirected to a replica that's not 100% up to date with the read-write replica. Likewise, if an application writes data by using a read-write session and immediately reads it by using a read-only session, the latest updates might not immediately be visible on the replica. The latency is caused by an asynchronous transaction log redo operation.

If any type of failure occurs and the service fabric determines a failover is needed, failing over to a secondary replica is fast because the replica already exists and has the data attached to it. In a failover, you don't need a listener. The gateway redirects your connection to the primary even after a failover. This switch happens quickly, then the service fabric takes care of spinning up another secondary replica.  

## Hyperscale

The Hyperscale service tier is only available in Azure SQL Database. This service tier has a unique architecture because it uses a tiered layer of caches and page servers to expand the ability to quickly access database pages without having to access the data file directly.

:::image type="content" source="../media/4-hyperscale-architecture-2.png" alt-text="Screenshot that shows the Hyperscale architecture.":::

Because this architecture uses paired page servers, you can scale horizontally to put all the data in caching layers. This new architecture also allows Hyperscale to support databases as large as 100 TB. Because it uses snapshots, nearly instantaneous database backups can occur regardless of size. Database restores take minutes rather than hours or days. You can also scale up or down in constant time to accommodate your workloads.

It's interesting to note how the log service was pulled out in this architecture. The log service is used to feed the replicas and the page servers. Transactions can commit when the log service hardens to the landing zone, so the consumption of the changes by a secondary compute replica isn't required for a commit. Unlike in other service tiers, you can determine whether you want secondary replicas. You can configure zero to four secondary replicas, all of which you can use for read-scale.

As in the other service tiers, an automatic failover will happen if service fabric determines it needs to, but the recovery time will depend on the existence of secondary replicas. For example, if you don't have replicas and a failover occurs, the scenario will be similar to that of the General Purpose service tier: the service fabric first needs to find spare capacity. If you have one or more replicas, recovery is faster and more closely aligns to that of the Business Critical service tier.

Business Critical maintains the highest performance and availability for workloads with small log writes that need low latency, but the Hyperscale service tier allows you to get a higher log throughput in terms of MB/second, provides for the largest database sizes, and provides up to four secondary replicas for higher levels of read scale. Therefore, you'll need to consider your workload when you choose between the two.
