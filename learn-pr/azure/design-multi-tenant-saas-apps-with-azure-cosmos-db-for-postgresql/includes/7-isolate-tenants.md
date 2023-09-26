Tailspin Toys has indicated that it hosts websites for toy stores of all sizes. Although most of the toy stores are small boutique toy stores that serve from 10,000 customers to hundreds of thousands of customers, a few of the stores are large, with millions of customers worldwide. The largest stores have significantly more traffic than other stores.

When Azure Cosmos DB for PostgreSQL distributes data in a multi-node database, it places table rows in worker shards based on the hashed value of the rows’ distribution column. Every shard contains a range of hashed values, so multiple distribution column values reside within the same shard. For multitenant SaaS applications, a single shard can host data for numerous tenants.

Given the drastically varying sizes of stores that host their websites in the Tailspin Toys SaaS app, you suspect that some of the performance issues Tailspin Toys has experienced are likely due to resource contention between large and small tenants that reside in the same shards. To improve resource allocation and to make guarantees of tenant quality of service, you're interested in isolating the Tailspin Toys largest tenants in dedicated nodes in the cluster.

You must take two steps to isolate a tenant in a specific node:

1. Isolate the tenant’s data to a new dedicated shard.
1. Move the shard to the desired node in the cluster.

## Isolate tenant data in a dedicated shard

You use the `isolate_tenant_to_new_shard()` function to move tenant data into a new dedicated shard. To better understand how the procedure works, you want to use the most active tenant in the Tailspin Toys database (store ID `5`) and the `orders` table as an example:

```sql
SELECT isolate_tenant_to_new_shard('orders', 5);
```

Invoking the function to isolate the tenant that has a `store_id` value of `5` in a new shard occurs in three steps:

1. First, a new shard is created exclusively for `orders` rows that have a distribution column value equal to `5`. The hash range for this shard includes only a single distribution column hash, so it excludes all other rows.
1. Rows in the `orders` table that have a distribution column value that matches the specified tenant ID are moved from their current shard to the new one.
1. The old shard is split into two new fragments that have hash ranges that abut the range of the new shard.

You assigned the same distribution column for each table when you distributed the Tailspin Toys table data. As a result, each tenant's data from all tables are colocated. As shown earlier, the `isolate_tenant_to_new_chard()` function returns an error and advice by using the `CASCADE` option. This option instructs the process to isolate tenant rows of not only the table that is specified in the function call, but of all colocated tables. Continuing the example, you need to rewrite the SQL command:

```sql
SELECT isolate_tenant_to_new_shard('orders', 5, 'CASCADE');
```

The output of the `isolate_tenant_to_new_shard()` function is the `shardid` value of the newly created shard:

```text
 isolate_tenant_to_new_shard 
-----------------------------
                      102339
```

## Move the tenant's new shard to a dedicated node

Executing the `isolate_tenant_to_new_shard()` function to isolate a tenant results in the tenant's data being moved into an isolated shard. However, that shard is created in the same node as the shards from which the tenant was removed. If you want to achieve true hardware isolation for a tenant, you can move them to a separate node in the cluster. The optional step allows you to isolate tenants further and prevent resource contention on the worker node.

By using the `shardid` value that's returned from the `isolate_tenant_to_new_shard()` function, you can query the `citus_shards` view to identify the worker node that currently hosts the newly created shard:

```sql
SELECT nodename, nodeport
FROM citus_shards
WHERE shardid = 102339;
```

The result looks similar to the following example:

```text
                              nodename                           | nodeport 
-----------------------------------------------------------------+----------
 private-c.learn-cosmosdb-postgresql.postgres.database.azure.com |     5432
```

To view the list of worker nodes that are available to hold the shard, query the `citus_get_active_worker_nodes()` function. Before you run the query, you might also want to use the Azure portal to add a new node to your cluster and assign the shard to a dedicated node:

```sql
SELECT * from citus_get_active_worker_nodes();
```

In this example, the database was horizontally scaled by adding a new worker node, `private-w2`. That node is the target for relocation.

```text
                              node_name                           | node_port 
------------------------------------------------------------------+-----------
 private-w0.learn-cosmosdb-postgresql.postgres.database.azure.com |      5432
 private-w1.learn-cosmosdb-postgresql.postgres.database.azure.com |      5432
 private-w2.learn-cosmosdb-postgresql.postgres.database.azure.com |      5432
```

Finally, you select a target worker node and call the `citus_move_shard_placement()` function to relocate the new shard to the worker node of your choice:

```sql
SELECT citus_move_shard_placement(
  102339,
  'private-c.learn-cosmosdb-postgresql.postgres.database.azure.com', 5432,
  'private-w2.learn-cosmosdb-postgresql.postgres.database.azure.com', 5432);
```

To preserve colocation, the `citus_move_shard_placement()` command also moves any colocated shards that have the `CASCADE` option set.

You can confirm the shard movement by querying the `citus_shards` table:

```sql
SELECT nodename, nodeport
FROM citus_shards
WHERE shardid = 102339;
```

The result looks similar to the following example:

```text
                              nodename                            | nodeport 
------------------------------------------------------------------+----------
 private-w2.learn-cosmosdb-postgresql.postgres.database.azure.com |     5432
```
