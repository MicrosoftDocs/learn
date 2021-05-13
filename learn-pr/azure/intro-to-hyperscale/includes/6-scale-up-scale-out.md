Hyperscale provides self-service scaling to deal with increased workloads. The Azure portal makes it easy to add new worker nodes, and to increase the vCores and storage of existing nodes. Scaling causes no downtime, and doesn't interrupt queries.

However, before any scaling starts, you need to choose the initial capacity for your database.

## SaaS applications

Different database solutions have different compute requirements. We've seen 2-3x performance improvements when moving to Hyperscale from a single-node PostgreSQL database, because sharding improves resource utilization. In these cases, we recommend choosing equal resources–for RAM and compute–as the original instance. Analytics are available through the Azure portal to then review if you should change scale.

RAM allocation is determined by vCore count, so the vCore count is essentially the real decision.

The number of vCores required for the coordinator node depends on your existing workload (write/read throughput).

Our payment app has a high throughput, due to the large number of transactions. As we're migrating from an on-premises server, we'll initially set the server group to have equal compute and RAM. We'll look at analytics, including the coordinator node's workload, to see if we need to change the number of vCores.

## Real-time applications

Moving from a single-node database to Hyperscale, you can expect a linear performance with the number of worker cores. If you want to halve your current latency, double the number of worker cores.

The type of queries your application uses affect memory requirements. You can easily determine how much memory a query requires by running `EXPLAIN ANALYZE` on a query. As vCores and RAM are scaled together, aim to increase the number of vCores until the majority of your workloads fit in memory.

### Increasing worker nodes

To add nodes, in the Azure portal go to the Compute + storage tab in your Hyperscale resource group. Dragging the slider for Worker node count changes the value.

:::image type="content" source="../media/configure-sliding.gif" alt-text="Configure nodes and vCores.":::

### Increase or decrease vCores on nodes

In addition to adding new nodes, you can increase the capabilities of existing nodes. Adjusting compute capacity up and down can be useful for performance experiments, as well as short or long-term changes to traffic demands.

### Rebalance shards

To take advantage of newly added nodes, you must rebalance shards - Where some shards are moved to the new nodes from existing nodes. When new worker nodes are available, you can start the shard rebalancer, by simply running:

```sql
SELECT rebalance_table_shards('distributed_table_name');
```

## Partition by time

When data is sharded properly, it’s distributed effectively. Over time, these shards will hold increasing amounts of data, which can decrease performance. You can partition data by time in order to increase performance. Partitioning tables breaks large tables of time-ordered data into multiple inherited tables, with each containing different time ranges.

Time partitioning makes most sense when you:

* Most frequently query a very small subset of your most recent data
* You actively delete/drop older data

For example, with our payment app, we can partition the transactional data by time. A common query is when a customer wants to see their transactions for a particular month. We can dramatically increase the performance if we have partitioned the data by time - allowing us to query transactional data for a single month, rather than querying the customer's data for every month.

It’s important to not shard by time, as data will be distributed seemingly at random. However, partitioning by time is a best-practice, and very recommended.

PostgreSQL can natively partition by time. It’s recommended to use the PostgreSQL partman extension, pg_partman. The extension is highly effective and has great user experience.
