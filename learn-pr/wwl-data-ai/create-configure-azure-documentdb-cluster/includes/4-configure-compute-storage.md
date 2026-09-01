After you deploy a cluster, you can adjust its compute and storage settings to match your workload's needs. Azure DocumentDB lets you scale compute and storage independently, so you can optimize cost and performance separately.

## Choose the right compute tier

The compute tier determines the number of vCores and RAM available on each physical shard in your cluster. Azure DocumentDB offers two categories of compute:

**Burstable tiers** (M10, M20, M25) provide minimal CPU performance during idle periods and scale to full CPU power when demand increases. Use burstable tiers for:

- Development and testing environments
- Low-traffic applications or prototypes
- Learning and experimentation

**Provisioned tiers** (M30 through M200) provide consistent, dedicated performance. Use provisioned tiers for:

- Production workloads with predictable traffic
- Applications that require sustained throughput
- Workloads where latency consistency is critical

To change the compute tier:

1. In the Azure portal, open your cluster.
1. Under **Settings**, select **Scale**.
1. Select the new tier from the **Cluster tier** drop-down menu.
1. Select **Save** to apply the change.

Tier changes happen without interruption to your applications. However, downgrading from a provisioned tier to a burstable tier isn't supported.

> [!NOTE]
> Changes from one provisioned tier to another (for example, M50 to M60) take effect without downtime. Plan tier upgrades before your workload reach capacity limits rather than reacting to performance problems.

## Configure storage

Storage capacity determines how much data your cluster can hold and also affects the IOPS (Input/Output Operations Per Second) available to each shard. Larger storage sizes provide higher IOPS.

Key storage considerations:

- **Storage ranges from 32 GiB to 32 TiB** per shard.
- **IOPS scale with storage size**: Storage up to 512 GiB gets free disk bursting (up to 3,500 IOPS). Storage at 1 TiB provides 5,000 IOPS, and the ceiling is 20,000 IOPS at 32 TiB.
- **Storage can only increase**: You can add more storage at any time, but you can't decrease it after provisioning. Plan your initial allocation with growth in mind.

To increase storage:

1. In the Azure portal, open your cluster's **Scale** page.
1. Select the new storage size from the drop-down menu.
1. Select **Save**.

> [!TIP]
> Estimate your storage needs by calculating current data size, adding index overhead (typically 10 to 30 percent of data size), and multiplying by your expected growth rate. Start with a buffer above your current needs so you don't need to increase storage frequently.

## Scale horizontally with shards

When a single shard can't handle your data volume or throughput requirements, you can add more physical shards to distribute the load. Each shard in a cluster has the same compute and storage configuration.

Azure DocumentDB doesn't require a shard key until your database surpasses terabytes of data. This approach simplifies getting started because you don't need to choose a partition strategy upfront.

To add shards:

1. On the **Scale** page, select the new shard count from the **Physical shard count** list.
1. Select **Save**, then select **Continue** in the confirmation window.

> [!NOTE]
> You can add only one physical shard at a time. If you need to add multiple shards, repeat the process sequentially.

After adding shards, enable the rebalancer feature and then redistribute data across shards:

1. In the Azure portal, open your cluster and select **Features** under **Settings**.
1. Select **Rebalancer for multishard clusters**, then select **Enable**.
1. Connect to the cluster with `mongosh` and run:

```javascript
sh.startBalancer()
```

Check the rebalancing status with `sh.isBalancerRunning()` and stop it when complete with `sh.stopBalancer()`.

> [!TIP]
> If you need more than 10 physical shards, open an Azure support ticket.

> [!NOTE]
> You can't update shard count on a replica or primary cluster with replicas. 


## Match compute to storage

Azure DocumentDB uses Premium SSD v2 disks configured for the highest IOPS and bandwidth the compute tier can support. Because `IOPS` scales with storage size, make sure your compute tier is sufficient to take advantage of larger storage. Use the `IOPS` metric with **Max** aggregation in Azure Monitor to see historical IOPS usage and identify whether your compute tier is the bottleneck.

## Monitor and adjust

After configuring your cluster, monitor its performance to determine if adjustments are needed:

- **CPU percent**: If CPU consistently exceeds 70% with Max aggregation, consider increasing the compute tier.
- **Storage percent**: If storage usage exceeds 70%, plan a storage increase before reaching capacity.
- **IOPS**: Compare used IOPS against the maximum for your storage size to identify I/O bottlenecks.

Azure Monitor provides these metrics directly on the cluster's monitoring page in the Azure portal. Set up alerts on these metrics to get notifications before resource limits are reached.
