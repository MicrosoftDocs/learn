Geo-replication and auto-failover groups are both mechanisms used in Azure SQL Database to enhance availability and disaster recovery, but they have some key differences.

## Understand active geo-replication

One method to increase availability for an Azure SQL Database is to use active geo-replication. Active geo-replication is designed as a business continuity solution that allows you to create readable secondary databases of individual databases on a server in the same or different region. It supports up to four secondary replicas and is configured per database.

Behind the scenes, Azure uses [Availability Groups](/sql/database-engine/availability-groups/windows/overview-of-always-on-availability-groups-sql-server) to provide this functionality. With active geo-replication, customers can programmatically or manually failover primary databases to secondary regions during major disaster.

:::image type="content" source="../media/5-active-geo-replication.png" alt-text="Screenshot of active Geo-Replication for Azure SQL Database.":::

To avoid replication overhead from a large write workload that can affect replication performance, it's recommended to configure the geo-secondary with the same service tier and compute size as the primary.

You can manually configure geo-replication for Azure SQL Database by accessing the database page, and selecting **Replicas** in the **Data management** section.

:::image type="content" source="../media/5-geo-replication-creation.png" alt-text="Screenshot of the new database replica for Azure SQL Database.":::

After the secondary replica is created, you can manually initiate a failover. This switches the roles, making the secondary the new primary and the old primary the new secondary.

:::image type="content" source="../media/5-failover.png" alt-text="Screenshot of the forced failover option for an Azure SQL Database on Azure portal." lightbox="../media/5-failover.png":::

Geo-replication is asynchronous, meaning that there might be some data lag between the primary and secondary databases. Also, the application connection string needs to be updated after a failover.

### Configure cross subscription geo-replication

In certain scenarios, you may need to configure a secondary replica on a different subscription than the primary database. This is where cross-subscription geo-replication comes into play. This feature allows you to set up a secondary replica in a different subscription, providing greater flexibility and enhanced disaster recovery options. By using cross-subscription geo-replication, you can ensure that your data is protected and accessible even if one subscription encounters issues. This setup is useful for organizations with multiple subscriptions or those looking to implement a robust business continuity plan.

To learn more about the steps required to configure a cross subscription geo-replication, see [Cross-subscription geo-replication](/azure/azure-sql/database/active-geo-replication-overview?view=azuresql#cross-subscription-geo-replication&preserve-view=true).

## Enable auto-failover groups

An auto-failover group is an availability feature that can be used with both Azure SQL Database and Azure SQL Managed Instance. Auto-failover groups let you manage how databases are replicated to another region, and let you manage how failover could happen. The name assigned to the auto-failover group must be unique within the **.database.windows.net* domain.

Auto-failover groups offer AG-like functionality through a listener, enabling both read-write and read-only activities. This functionality differs slightly from active geo-replication. There are two types of listeners: one for read-write traffic and another for read-only traffic. During a failover, DNS updates allow clients to connect to the listener name without needing additional information. The database server with the read-write copies is the primary, while the server receiving transactions from the primary is the secondary.

:::image type="content" source="../media/5-auto-failover-groups.png" alt-text="Diagram of the auto-failover groups architecture for Azure SQL Database and Azure SQL Managed Instance.":::

Auto-failover groups have two different policies that can be configured.

- **Customer-managed (recommended)** - customers can manually initiate a failover when they detect an unexpected outage affecting one or more databases in the failover group. This manual failover can be performed using command line tools such as PowerShell, the Azure CLI, or the Rest API.
- **Microsoft-managed** - they're automatically initiated by Microsoft during a widespread outage that impacts a primary region. This automatic failover applies to all affected failover groups with their failover policy set to *Microsoft-managed*. 

Unplanned failover could result in data loss if forced and the secondary isn't fully synchronized with the primary. Configuring `GracePeriodWithDataLossHours` controls how long Azure waits before failing over. The default is one hour. If you have a tight RPO and can't afford much data loss, set the value higher. Although Azure waits longer before failing over, this approach can result in less data loss as the secondary has more time to fully synchronize with the primary.

Additionally, an auto-failover group can include one or more databases, with the same size and edition on both the primary and secondary servers. The database on the secondary server is automatically created through a process called *seeding*, which can take some time depending on the database size. It's important to plan accordingly and consider factors such as network speed.

## How to choose

Geo-replication is suitable for scenarios where you need multiple readable replicas and manual failover is acceptable, while auto-failover groups are ideal for scenarios requiring automatic failover and synchronous replication for a group of databases.

The following table compares the features of geo-replication and auto-failover groups, along with other relevant details.

| Feature| Geo-replication| Auto-failover Groups|
|-----|-------|--------|
| **Number of replicas**| Supports up to four secondary replicas.| Supports only one secondary replica|
| **Configuration level**| Configured per database.| Configured for a group of databases|
| **Replication Type**| Asynchronous, meaning there might be some data lag between primary and secondary databases| Synchronous, ensuring the secondary database is always in sync with the primary.|
| **Failover**| Requires manual failover. The application connection string needs to be updated after a failover| Supports automatic and manual failover, with no need to change connection strings after a failover|
| **Readability**| Provides readable secondary databases.| Provides readable secondary databases and serves as hot-standbys for failover|
| **Use Case**| Suitable for scenarios needing multiple readable replicas and manual failover | Ideal for scenarios requiring automatic failover and synchronous replication for a group of databases |
