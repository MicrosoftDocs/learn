In this unit, you examine how Azure Database for MySQL can help with building a resilient, performant, and easy to maintain data store for your web-based app. Considering the expected business criticality and high demand, you're interested in its ability to scale both compute and storage resources. You also want to ensure that as a managed service, Azure Database for MySQL minimizes management and maintenance overhead, allowing you to focus on software development instead.

### What are the core characteristics of Azure Database for MySQL?

Azure Database for MySQL - Flexible Server is designed to deliver full compatibility with your existing MySQL applications, supporting widely used MySQL Community Server versions 5.7 and 8.0. This deployment option is particularly effective for scenarios that require:

- Detailed control over compute and storage configurations.
- Consistently high performance.
- Reliable high availability and business continuity.
- Efficient cost management strategies.

Furthermore, Flexible Server enhances security, with its built-in firewall for public endpoints, and supports private connectivity, via Azure Virtual Network (VNet) integration and Azure Private Link, which safeguards your data from unauthorized access.

#### Compute

Azure Database for MySQL - Flexible Server is available in three compute tiers, with each tier geared toward a specific use case:

- **Burstable**: Ideal for development or temporary projects with intermittent performance demands.
- **General Purpose**: Suitable for a broad range of production workloads requiring balanced compute and memory.
- **Business Critical**: Best for applications needing high compute performance and resilience.

The specific tier name is derived from the series name of the Azure VM Stock Keeping Unit (SKU) that's hosting the managed MySQL Server deployment. Within each tier, you can choose from among several different VM sizes, each offering a different number of vCores (ranging from 1 to 96) and amount of memory (ranging from 4 gigabytes (GB) to about 700 GB).

The Burstable compute tier uses B-series VMs, General Purpose relies on Dadsv5-series (AMD) and Ddsv4-series (Intel) VMs, and Business Critical runs on Standard Eadsv5-series (AMD) and Edsv5-series (Intel) VMs.

In the Azure portal, during the server creation process, you can select the tier option on the **Basics** page, under **Server details**, or on the **Flexible server Compute + storage** page, under **Compute**.

:::image type="content" source="../media/what-azure-database-mysql/2-mysql-compute-tier-sizes.png" alt-text="Screenshot of the Compute section of the Compute+storage page displaying the Memory Optimized compute tier's compute sizes options.":::

#### Storage

While provisioning a server or at any point thereafter, you can increase the amount of storage allocated, up to the limit of 16,384 gibibytes (GiB), or 16 tebibytes (TiB) for the Burstable and General Purpose tiers, and 32 TiB for the Business Critical tier. Regardless of the selected compute tier and size, the lower limit (20 GiB) is the same. In addition, storage sizing is independent of the compute tier and size you choose, and you also have the option of enabling storage autogrowth.

> [!NOTE]  
> After increasing the amount of storage, you cannot decrease it.

Regardless of the storage size, you can also scale the desired limit of Input/Output operations per second (IOPS) up and down. The upper limit of available IOPS depends on the compute tier and size, with the upper limit reaching 80,000 IOPS for the largest available size of the Business Critical SKU. You can use this scalable IOPS functionality to accommodate dynamically changing resource requirements at any time, and also enable auto-scale IOPS to automatically adjust based on workload demands.

#### Network connectivity

Azure Database for MySQL - Flexible Server supports the two connectivity methods, public access and private access.

> [!NOTE]  
> In the Azure portal, during the server creation process, you select the connectivity method on the **Networking** tab, under **Network connectivity**.
> You can also access the network connectivity options from the Azure portal's **Flexible server deployment** page, **Networking** tab.

:::image type="content" source="../media/what-azure-database-mysql/2-mysql-network-connectivity.png" alt-text="Screenshot of the Networking tab of the displaying the networking settings for a new Azure Database for MySQL server.":::

##### Public access

With public access, which is provided via an external endpoint, you must explicitly allow by access using firewall rules:

- For external traffic, you must specify an individual IP address or an IP address range from which the traffic is allowed.
- For traffic originating from Azure, you need to allow public access from any Azure service.

> [!IMPORTANT]  
> Because public access allows connections from IP addresses allocated to any Azure resource, including connections from other customers' subscriptions, it is only recommended for use in development and testing scenarios.

##### Private access

For private access via designated Azure virtual networks, use VNet integration support. If you enable this option, the server automatically blocks connections that originate from the internet.

> [!NOTE]  
> Before you can enable private access, you must implement custom Domain Name Service (DNS) name resolution. For additional information, see [Private Network Access using virtual network integration for Azure Database for MySQL - Flexible Server](/azure/mysql/flexible-server/concepts-networking-vnet).

By default, the server enforces Transport Layer Security (TLS 1.2) to help protect incoming network communication.

> [!IMPORTANT]  
> While you can allow unencrypted connections after server provisioning, it is not recommended.

#### High availability

Azure Database for MySQL - Flexible Server supports high availability with automatic failover to help ensure that you never lose committed data because of localized failures. When you enable this functionality, the platform automatically provisions and manages a standby replica.

There are two high-availability architectural models, depending on the replica's placement.

##### Zone-Redundant High Availability

For enhanced resiliency, the zone-redundant high availability model positions the primary database in one availability zone and its standby replica in a separate zone. This configuration is designed to safeguard against data center-level failures, offering a higher level of data protection by ensuring that both the primary and backup databases are not subject to the same localized risks. This model is recommended for critical applications where continuity and data integrity are paramount, as it allows the service to remain available even if one entire data center goes offline.

##### Same-Zone High Availability

The same-zone high availability model situates both the primary database and its standby replica within the same availability zone. Opting for a same-zone deployment is particularly beneficial in scenarios where minimal latency is crucial for application performance. By maintaining both the primary instance and its replica in close physical proximity, you ensure that the failover process does not significantly impact response times. This setup is ideal for applications where even minimal latency differences can affect functionality or user experience.

#### Business continuity

Azure Database for MySQL - Flexible Server automatically creates point-in-time backups of its databases and retains them in the locally redundant storage for up to 35 days, or up to 10 years when using long-term retention. When configuring backup, you can choose either locally redundant, zone-redundant, or geo-redundant backups, which allows you to recover from an outage affecting an entire Azure region. Additionally, you can perform on-demand backups at any time to create a backup snapshot outside the regular backup schedule.

Azure Database for MySQL also supports managed maintenance windows, intended for automated server patching, which facilitates business continuity. By specifying a custom patching schedule, you can minimize the effect of a temporary downtime resulting from the server restart.

#### Cost optimization

Azure Database for MySQL - Flexible Server offers numerous options for optimizing costs.

- **Granular control over compute and storage configuration**. You can adjust most server configuration options independently of each other, which allows you to optimize your deployment costs based on your objectives and its intended use case. For example, you can separately adjust options for:

  - Compute SKU
  - The amount of storage
  - IOPS
  - The backup retention period

- **The ability to stop and start the server on-demand**. The compute tier billing is stopped as soon as you stop the server. This ability can help you to minimize costs during development, testing, and for production workloads with a reliably predictable schedule.
- **The Burstable compute tier**. Take advantage of the Burstable compute tier for competitive pricing for your workloads that require low CPU utilization, with occasional CPU usage spikes.
- **The reserved instance discount**. You can commit to either a 1-year or 3-year purchase plan to get the reserved instance discount, which saves you more than 60 percent of the original, nondiscounted cost. Consider this option for production workloads with predictable, long-term compute capacity requirements.
- **An Azure free account**. You can use an Azure free account to evaluate Flexible Server at no cost for 12 months, with monthly limits of up to:

  - 750 hours of Burstable B1MS instance, enough hours to run a database instance continuously each month.
  - 32-GB storage and 32-GB backup storage.

> [!NOTE]  
> If you create an Azure Database for MySQL flexible server using your Azure free account, an estimated cost per month still appears on the **Compute + Storage : Cost Summary** blade and on the **Review + Create** tab. However, as long as you're using your Azure free account and your service usage remains within the associated monthly limits, you will not be charged for the service.
