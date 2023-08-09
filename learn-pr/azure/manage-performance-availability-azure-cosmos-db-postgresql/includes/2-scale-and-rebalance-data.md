Woodgrove Bank had a successful trial of their contactless payment app, and they're ready to expand operations to Europe. The number of customers is growing at the same time of the biggest shopping season for their customers. Azure Cosmos DB for PostgreSQL can scale both horizontally and vertically to meet their needs.

Horizontal scaling - used for more resources for distributing data and parallel query processing - is achieved by adding more worker nodes to the cluster. Horizontal scaling can be helpful for scaling the database as the number of Woodgrove Bank app users increases.

:::image type="content" source="../media/horizontal-scaling.svg" alt-text="Diagram of a cluster going from two worker nodes to three worker nodes.":::

Vertical scaling is achieved by managing storage and compute for the coordinator node and the worker nodes. Vertical scaling can assist Woodgrove Bank in adjusting their resources to handle the load anticipated with the shopping season.

:::image type="content" source="../media/vertical-scaling.svg" alt-text="Diagram of a cluster with worker nodes. The cores range from 4 vCores compute and 0.5 TiB of storage to 8 vCores compute and 1 TiB of storage.":::

## Scaling compute and storage for worker nodes

As it's the biggest shopping season for their clients, Woodgrove Bank anticipates more usage of their application during this period. The contactless payment app needs to be able to handle these spikes in traffic. As these spikes are temporary bursts in traffic, there's greater demand for compute throughout this period, and then the traffic goes back to normal load. As there's an increase in traffic, there are more transactions, which means a significant increase in storage. Azure Cosmos DB for PostgreSQL supports scaling compute up and down and scaling up storage. To handle the busy shopping season, scale compute and storage up. At the end of the shopping season, scale compute back down to normal levels.

There are some things to note about adjusting compute and storage for worker nodes:

* The settings for vCores and Storage apply to an individual node.

    :::image type="complex" source="../media/scale-vcores-and-storage.svg" alt-text="Screenshot of the worker node settings juxtaposed with the cluster diagram.":::
        Screenshot of the worker node settings juxtaposed with the cluster diagram. The vCores setting is set for 8 vCores, and the Storage setting is set for 1 TiB. The diagram shows the coordinator node pointing at two worker nodes. Each worker node has 8 vCores of compute and 1 TiB of storage.
    :::image-end:::

* The amount of RAM for a node isn't adjustable. The RAM amount is tied to the selected number of vCores. [Learn more about compute resources.](/azure/postgresql/hyperscale/resources-compute)
* Storage can only be scaled up, not down.
* The maximum IOPS/GiB for the selected configuration is displayed. This value is tied to the total amount of storage.
* Scaling the vCores requires the impacted nodes to be restarted.
* There's a max of 20 worker nodes that can be provisioned in the Azure portal. If more worker nodes are needed, use the **contact us** link to reach out for assistance. This link is located on the screen to scale the worker node, below the number of nodes.

## Add worker nodes

As Woodgrove Bank expands to Europe and the number of users is expected to increase, the database needs to expand to support this growth. The distributed PostgreSQL cluster scales horizontally by adding worker nodes. When worker nodes are added, the data doesn't automatically move. The data needs to be redistributed.

:::image type="complex" source="../media/add-worker-node.svg" alt-text="Diagram of the Coordinator node as a PostgreSQL database with metadata tables, a local table, and two worker nodes.":::
    Diagram of the Coordinator node as a PostgreSQL database with metadata tables and a local table. The diagram also contains two worker nodes, each with distributed shards and reference tables. There are arrows coming from the coordinator and pointed at each of the worker nodes. A plus sign indicates that a third worker node is being added. There are no tables on the extra worker node.
:::image-end:::

If you want to confirm that the data *hasn't* been distributed to the new worker node, try the following SQL query. This query checks shard placement and lists nodes that don't appear in the shard placement list.

```sql
SELECT nodename FROM pg_dist_node WHERE nodename NOT IN(
    SELECT DISTINCT nodename 
    FROM pg_dist_placement AS placement,
       pg_dist_node AS node
    WHERE placement.groupid = node.groupid
   AND node.noderole = 'primary');
```

This query returns the coordinator node and the new worker node.

If you're familiar with Citus, keep in mind that Azure Cosmos DB for PostgreSQL is a hosted platform that restricts access to some of the administrative features. If you try adding nodes using `citus_add_node()`, you get an error message stating "permission denied for function citus_add_node." You're unable to run functions that require superuser access to run. You need to use the Azure portal to add nodes.

## Check shard balance

Once worker nodes are added, the data needs to be redistributed so that the coordinator node can make use of the new worker nodes.

The shard rebalancer for Azure Cosmos DB for PostgreSQL can show you whether data is distributed equally. If data is balanced, the shard rebalancer tells you that rebalancing isn't recommended. However, if you have data loaded and then increase your worker nodes, you get the message that rebalancing is recommended.

## Rebalancing strategies

There are two ways to rebalance shard:

* By shard count (`by_shard_count`)
* By disk size (`by_disk_size`)

By default, it uses the shard count strategy.

You can view the different rebalancing strategies in the Azure portal. You can also confirm the default strategy by querying `pg_dist_rebalance_strategy`.

```sql
SELECT name, default_strategy FROM pg_dist_rebalance_strategy;
```

The `default_strategy` column is set to `t` for `true` for the default rebalancing strategy. `by_shard_count` is the default.

```output
      name      | default_strategy 
----------------+------------------
 by_shard_count | t
 by_disk_size   | f
 ```

While these strategies are the two rebalance strategies included by default, you may want to create your own custom rebalancing strategy. [Learn more about creating a custom rebalancing strategy.](/azure/postgresql/hyperscale/reference-metadata#creating-custom-rebalancer-strategies)

## Rebalancing the shards

The shard rebalancer is run on the **coordinator node** using the `rebalance_table_shards` SQL function on distributed tables.

```sql
SELECT rebalance_table_shards('distributed_table_name',rebalance_strategy:='rebalance_strategy_name');
```

Once the shards are balanced, the shard balancer tells you that rebalancing isn't recommended at this time.

The new shards have the reference and distributed tables as part of rebalancing.

:::image type="complex" source="../media/coordinator-workers-with-arrows-with-tables.svg" alt-text="Diagram of the Coordinator node as a PostgreSQL database with metadata tables, a local table, and three worker nodes.":::
    Diagram of the Coordinator node as a PostgreSQL database with metadata tables and a local table. The diagram also contains three worker nodes, each with distributed shards and reference tables. There are arrows coming from the coordinator and pointed at each of the worker nodes.
:::image-end:::

Let's scale Woodgrove Bank's application for the growth.
