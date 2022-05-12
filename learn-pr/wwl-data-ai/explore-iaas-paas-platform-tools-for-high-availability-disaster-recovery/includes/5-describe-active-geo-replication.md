One method to increase availability for Azure SQL Database is to use active geo-replication. Active geo-replication creates a secondary database replica in another region that is asynchronously kept up to date. 

This replica is readable, similar to an Availability Group in IaaS. Underneath the surface, Azure uses Availability Groups to maintain this functionality, which is why some of the terminologies are similar (primary and secondary logical servers, read-only databases, etc.).

Active geo-replication provides business continuity by allowing customers to programmatically or manually failover primary databases to secondary regions during major disaster.

Azure SQL Managed Instance doesn't support active geo-replication, you must use auto-failover groups instead, which will learn on the next unit.

:::image type="content" source="../media/module-77-high-availability-final-13.png" alt-text="Screenshot of active Geo-Replication for Azure SQL Database.":::

All the databases involved in a geo-replication relationship are required to have the same service tier.

Furthermore, in order to avoid replication overhead due to a large write workload that can affect the replication performance, it's recommended that the geo-secondary is configured with the same compute size as the primary.

As we can see above, you can manually configure geo-replication for Azure SQL Database by accessing the blade for the database, in **Data management** section, selecting **Replicas**, and then **+ Create replica**.

:::image type="content" source="../media/module-77-high-availability-final-05.png" alt-text="Screenshot of replica page for Azure SQL Database.":::

After the secondary replica is created, you can manually fail over your secondary replica. The roles will switch with the secondary becoming the new primary, and the old primary the secondary.

:::image type="content" source="../media/module-77-high-availability-final-06.png" alt-text="Screenshot of Force Failover option on Azure portal.":::

## Cross subscription geo-replica

Some scenarios require you as a DBA to configure a secondary replica on a different subscription than the primary database. Cross subscription geo-replication is a feature that allows you to perform this task.

Cross subscription geo-replication is only available programmatically.

To learn more about the steps required to configure a cross subscription geo-replication, see [Cross-subscription geo-replication](/azure/azure-sql/database/active-geo-replication-overview?view=azuresql#cross-subscription-geo-replication).
