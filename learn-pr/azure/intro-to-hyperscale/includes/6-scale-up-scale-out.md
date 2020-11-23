Hyperscale provides self-service scaling to deal with increased load. The Azure portal makes it easy to add new worker nodes, and to increase the vCores and storage of existing nodes. Scaling causes no downtime, and without interrupting queries.

However, before any scaling starts, you need to choose the initial capacity for your database.

## Multi-Tenant SaaS applications

Different database solutions have different compute requirements. We have seen 2-3x performance improvements when moving to Hyperscale from an existing single-node PostgreSQL database, because sharding improves resource utilization. In these cases we recommend choosing equal resources, for RAM and compute, as the original instance. Analytics are available through the Azure portal to then make a decision if you wish to scale down.

RAM allocation is determined by vCore count, so the vCore count is essentially the real decision.
The number of vCores required for the coordinator node depends on your existing workload (write/read throughput).

## Real-Time Analytics applications

Moving from a single-node database to Hyperscale, you can expect a linear performance with the number of worker cores. If you want to halve your current latency, double the number of worker cores.

The type of queries your application uses affect memory requirements. You can run EXPLAIN ANALYZE on a query to determine how much memory it requires. As vCores and RAM are scaled together, aim to increase the number of vCores until the majority of your workloads fit in memory.

### Increasing worker nodes

To add nodes, in the Azure portal go to the Compute + storage tab in your Hyperscale resource group. Dragging the slider for Worker node count changes the value.

*Picture goes here*

Increase or decrease vCores on nodes

In addition to adding new nodes, you can increase the capabilities of existing nodes. Adjusting compute capacity up and down can be useful for performance experiments, as well as short—or long-term—changes to traffic demands.

### Rebalance shards

To take advantage of newly added nodes you must rebalance shards - Moving some shards from existing nodes to the new ones. We will do this in the next exercise, with one pgsql command.

After new workers have successfully finished provisioning, you can start the shard rebalancer, by running:

*command goes here*
