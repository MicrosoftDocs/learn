Azure SQL provides varying levels of database availability options and capabilities according to service tiers. The service tier determines the underlying architecture of the database or managed instance that you deploy.

There are two pricing models for Azure SQL databases and managed instances: DTU and vCore. In this unit, we focus on the vCore service tiers and their architectures for high availability. 

### Things to know about General Purpose availability

SQL databases and managed instances in the General Purpose (or Standard) service tier have the same availability architecture.

:::image type="content" source="../media/general-purpose.png" alt-text="Diagram that shows SQL database high availability in the vCore General Purpose tier." lightbox="../media/general-purpose-large.png" border="false":::

The image illustrates the availability architecture for the vCore General Purpose (or DTU Standard) tier:

- The application connects to the server name, which connects to a gateway **GW** that points the application to the server to connect to. The application is running on a VM.

- The General Purpose tier uses remote storage. The primary replica uses locally attached SSD for the temporary database, **tempdb**. 

- The data and log files are stored in Azure Premium Storage, which is locally redundant storage. Multiple copies are stored in one zone of a region.

- The backup files are stored in Azure Standard Storage, which is RA-GRS by default. It's globally redundant storage with copies in multiple regions.

All of Azure SQL is built on Azure Service Fabric, which serves as the Azure backbone. If Azure Service Fabric determines that a failover needs to occur, the failover is similar to that of a failover cluster instance (FCI). The service fabric locates a node with spare capacity and spins up a new SQL Server instance. The database files are attached, recovery is run, and gateways are updated to point applications to the new node. No virtual network or listener or updates are required. These features are built in.

### Things to know about Business Critical availability

In the Business Critical (or Premium) tier, you can generally achieve the highest performance and availability of all Azure SQL service tiers. This tier is meant for mission-critical applications that need low latency and minimal downtime.

:::image type="content" source="../media/business-critical.png" alt-text="Diagram that shows SQL database high availability in the vCore Business Critical tier." lightbox="../media/business-critical-large.png" border="false":::

The image illustrates the availability architecture for the vCore Business Critical (or DTU Premium) tier:

- Database availability in the Business Critical tier is like deploying an Always On availability group behind the scenes.

- Unlike the General Purpose tier, the data and log files all run on direct-attached SSD, which significantly reduces network latency.

- In this tier, there are three secondary replicas. One secondary replica can be used as a read-only endpoint (at no extra charge). A transaction can complete a commit when at least one secondary replica has implemented the change. 

### Things to know about Hyperscale availability

The Hyperscale service tier is available only in Azure SQL Database. This service tier has a unique architecture because it uses a tiered layer of caches and page servers to expand the ability to quickly access database pages without having to access the data file directly.

:::image type="content" source="../media/hyperscale-architecture.png" alt-text="Diagram that shows SQL database high availability in the vCore Hyperscale tier." lightbox="../media/hyperscale-architecture-large.png" border="false":::

The image illustrates the availability architecture for the vCore Hyperscale tier:

- The Hyperscale tier architecture uses paired page servers. You can scale horizontally to put all the data in caching layers.

- The Hyperscale architecture supports databases as large as 100 TB.

- This tier uses snapshots, which allow for nearly instantaneous database backups, regardless of database size.

- Database restores take minutes rather than hours or days.

- You can scale up or down in constant time to accommodate your workloads.

### Things to consider when choosing database availability

The following table compares support for database availability across the vCore service tiers. For the DTU model, you can equate the Basic and Standard tiers to the vCore General Purpose tier, and the Premium tier to the vCore Business Critical tier. The DTU model doesn't offer a Hyperscale tier. As you compare the support options, think about which service tier meets the database availability requirements for Tailwind Traders.

| SQL Database/SQL Managed Instance vCore tiers | SQL Database DTU tiers | Database availability support |
| --- | --- | --- |
| **General Purpose** | **Standard** or **Basic** | Provides balanced compute and storage options for business workloads |
| **Business Critical** | **Premium** | Meets low latency requirements and enables highest resilience to failures for business applications |
| **Hyperscale** | No applicable tier | Offers highly scalable storage and meets read-scale requirements for business workloads |
