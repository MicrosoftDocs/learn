You can create Azure Database for MySQL flexible servers based on one of three service tiers: Burstable, General Purpose, and Business Critical. The service tiers provide an increasing level of compute and storage size, as well as the supported number of maximum connections and I/O operations per second (IOPS). One MySQL flexible server can host several databases.
You can monitor your MySQL flexible server's performance metrics like CPU & memory usage, I/O performance, query metrics, and more, to make informed capacity decisions.

## Compute size: RAM and cores

Each of the three service tiers provides different underlying VM SKUs. The Burstable tier uses B-series VMs, the General Purpose tier uses D-series VMs, and the Business Critical tier uses E-series VMs. The VM series used determines the number of vCores and RAM available on the server.

You can change the compute tier, compute size, and storage size after creating a server. Changing the compute tier or compute size requires a restart that typically takes between one to two minutes to complete. Changing the storage size doesn't require a restart.

For non-production (development, staging, testing, etc.) workloads, consider using servers based on the Burstable tier, which provides a cost-effective solution for workloads that don't continuously use the full CPU. During periods of low usage, servers using B-series VMs [accumulate CPU credits](/azure/virtual-machines/b-series-cpu-credit-model/b-series-cpu-credit-model) that can be used in periods of high usage to "burst" performance above the baseline. If your baseline is too high, or there are too many high usage bursts, consider upgrading to the General Purpose or Business Critical tiers to avoid performance degradation.

### Service tier compute sizes

Each of the three service tiers provides different levels of compute power. While the Burstable tier can support up to 20 vCores and the General Purpose tier can support up to 64 vCores, with support for up to 96vCores, the Business Critical tier provides the highest level of compute power. The Business Critical tier also provides the Ev5 series VMs, which [up to 30% more QPS and 50% lower latency](https://techcommunity.microsoft.com/t5/azure-database-for-mysql-blog/boost-azure-mysql-business-critical-flexible-server-performance/ba-p/3603698) than the Ev4 series VMs.

## IOPS: Pre-provisioned vs Autoscale

The number of read and write operations that can be performed per second is referred to as the storage IOPS (I/O operations Per Second). Higher IOPS settings provide better storage performance: more simultaneous read/write operations result in faster data retrieval, data persistence, index updates, and overall database efficiency. If IOPS settings are too low, the database might experience processing delays and degraded performance. If IOPS settings are too high, however, your costs might increase without your realizing any performance improvements.

With Azure Database for MySQL – Flexible Server, you either pre-provision IOPS or use the Autoscale IOPS feature.

- With **pre-provisioned** IOPS, you allocate a specific number of IOPS to provide consistent and predictable performance, which works well if the load doesn't approach the threshold at which I/O operations become throttled. While you can always allocate additional IOPS as your workload demands increase, this requires manual intervention.

- With the **Autoscale** IOPS feature enabled, your IOPS scale on demand based on workload activity and you pay based on consumption. As the workload increases, the server scales I/O performance seamlessly, allowing your instance to handle workload spikes without paying for unused capacity when traffic is low.

In either case, IOPS can't exceed the server's maximum. For information about the maximum IOPS by compute size, see the article [Compute and storage documentation](/azure/mysql/flexible-server/concepts-service-tiers-storage#service-tiers-size-and-server-types).

## Read replicas

As your database's traffic increases, you can scale its capacity horizontally or "out" (number of compute nodes), or vertically or "up" (size of compute nodes). Read replicas provide horizontal scaling.

A read replica is a read-only copy of a database that remains in sync by using MySQL's binary log replication ([binlog](https://dev.mysql.com/doc/refman/8.0/en/binlog-replication-configuration-overview.html)). As applications grow, they need to scale compute and storage resources (like the database). Application component scaling is simplified by provisioning new VMs using Azure Kubernetes Service (AKS), [Virtual Machine Scale Sets](/azure/virtual-machine-scale-sets/overview), and App Service. As these compute resources scale and stored data grows, they increase the burden on the database, which often ends up being a bottleneck in the application's architecture.

Using a read replica allows you to divert read-only operations to secondary databases so that the primary server supports read/write operations. Azure Database for MySQL provides managed read replicas. You can replicate a source server to up to ten replicas. This can help in use cases such as reporting and analytics, which often query large amounts of data.

Using a read replica is particularly helpful when for one reason or another queries can't use indexes. It can be impractical or even disruptive to add indexes for all query patterns, because it places additional load on the server (processing, disk I/O, storage, transaction time, etc.). If a data warehouse isn't available or you need data that is more recent than its refresh cycle, using a read replica is a great way to run "big" queries without disrupting critical read/write operations.

Read replicas are not immediately synchronous in the same way as is a high-availability configuration. Read replicas don't introduce the transactional latency associated with an HA solution, but there can be a slight delay as the data reaches the replica from the primary database.
