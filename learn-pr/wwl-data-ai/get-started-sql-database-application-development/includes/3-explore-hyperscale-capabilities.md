The [Hyperscale service tier](/azure/azure-sql/database/service-tier-hyperscale) in Azure SQL Database is a service tier in the [vCore-based purchasing model](/azure/azure-sql/database/service-tiers-sql-database-vcore) ideal for business workloads. It's a highly scalable storage and compute performance tier that uses Azure to scale out the storage and compute resources for an Azure SQL Database substantially beyond the limits available for the [General Purpose](/azure/azure-sql/database/service-tiers-sql-database-vcore#general-purpose) and [Business Critical](/azure/azure-sql/database/service-tiers-sql-database-vcore#business-critical) service tiers. It decouples the query processing engine from long-term storage components, allowing for seamless scaling of compute and storage resources.

Hyperscale simplifies infrastructure and application design, allowing developers to focus on business needs rather than managing database resources.

Azure SQL Database used to be limited to 4 TB of storage per database. However, the Hyperscale service tier now allows databases to exceed 100 TB. Hyperscale uses horizontal scaling to add compute nodes as data grows. While the cost is similar to regular Azure SQL Database, there's an extra per terabyte storage cost. 

## Understand the benefits

The Hyperscale service tier eliminates many of the practical limitations typically found in cloud databases. Unlike most other databases that are constrained by the resources of a single node, Hyperscale databases have no such restrictions. With its flexible storage architecture, storage expands as needed, and there's no predefined maximum size. You only pay for the capacity you use. For read-intensive workloads, Hyperscale offers rapid scale-out by provisioning extra replicas to offload read operations.

:::image type="content" source="../media/3-hyperscale.png" alt-text="Diagram showing the Hyperscale Architecture.":::

Additionally, the time needed to create database backups or to scale up or down is no longer dependent on the volume of data in the database. Hyperscale databases can be backed up instantly. You can also scale a database of tens of terabytes up or down within minutes. This capability frees you from concerns about being constrained by your initial configuration choices. Hyperscale also provides fast database restores, completing in minutes rather than hours or days.

Hyperscale provides rapid scalability based on your workload demand.

| Feature| Description| Benefit| Use Case|
|---|---|---|---|
| **Scale Up/Down**| You can scale up the primary compute size in terms of resources like CPU and memory, and then scale down, in constant time. Because the storage is shared, scaling up and scaling down isn't linked to the volume of data in the database. | Ensures flexibility and efficiency in resource management. | Ideal for applications with varying workloads that require different levels of compute power. |
| **Scale In/Out** | You can also provision one or more compute replicas to handle your read requests. These extra compute replicas act as read-only replicas, offloading the read workload from the primary compute. Additionally, these replicas serve as hot-standbys, ready to take over if there's a primary compute failure. | Enhances performance and reliability by offloading read workloads and providing failover capabilities. | Suitable for read-intensive applications that need high availability and quick failover. |

## Maximize performance

The Hyperscale service tier is designed for customers with large on-premises SQL Server databases who want to modernize their applications by moving to the cloud. It's also ideal for customers already using Azure SQL Database who want to significantly expand their database growth potential. Additionally, Hyperscale is perfect for those seeking both high performance and high scalability

In addition to rapid scaling features, Hyperscale provides the following performance capabilities.

- Database backups are nearly instantaneous, regardless of size, with no effect on compute resources.
- Database restores are completed in minutes, rather than hours or days.
- Overall performance is enhanced due to higher transaction log throughput and faster transaction commit times, regardless of data volumes.

> [!NOTE]
> To deploy a Hyperscale database in Azure SQL Database, see 

## Deploy an Azure SQL Database Hyperscale

To deploy Azure SQL Database with the Hyperscale tier:

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true). 
1. Navigate to the **Azure SQL** page, and then select **+ Create**.
1. Select **SQL Database**, *Single database* and the **Create** button.
1. From the **Basics** tab of the **Create SQL Database** page, select the desired subscription, resource group, and database name.
1. Select the **Create new** link for the **Server**, and fill out the new server information, such as server name, server admin login and password, and location.
1. Under **Compute + storage**, select the **Configure database** link.
1. Select **Hyperscale** for **Service tier**, and **Provisioned** for **Compute tier**.

    :::image type="content" source="../media/3-hyperscale-azure-sql.png" alt-text="Screenshot showing the Hyperscale configuration for Azure SQL Database.":::

1. Under **Hardware Configuration**, select the **Change configuration** link. Review the available hardware configurations and select the most appropriate configuration for your database. For this example, we leave to **Standard-series (Gen5)** default option.
1. Optionally, adjust the **vCores** slider if you would like to increase the number of vCores for your database.
1. Adjust the **High-Availability Secondary Replicas** slider to create one replica. Select **Apply**.
1. Select **Next: Networking** at the bottom of the page.
1. On the **Networking** tab, set **Add current client IP address** to **Yes**. 
1. Select the **Review + create** button, and then select **Create**.

    :::image type="content" source="../media/3-create-button.png" alt-text="Screenshot of the review and create page when provisioning an Azure SQL Database Hyperscale.":::

> [!NOTE]
> After converting a database to Hyperscale, it isn't possible to revert it back to a regular Azure SQL Database. To learn more about Hyperscale limitations see, [known limitations for Hyperscale service tier](/azure/azure-sql/database/service-tier-hyperscale#known-limitations).

## Connect to a read-only replica

You can connect to a read-only replica by setting the *ApplicationIntent* argument on your connection string to **ReadOnly**. Any connections with the **ReadOnly** application intent are automatically routed to one of the read-only compute replicas.

```
Server=tcp:<your_server_name>.database.windows.net,1433;Database=<your_database_name>;User ID=<your_username>@<your_server_name>;Password=<your_password>;Encrypt=true;Connection Timeout=30;ApplicationIntent=ReadOnly;
```
