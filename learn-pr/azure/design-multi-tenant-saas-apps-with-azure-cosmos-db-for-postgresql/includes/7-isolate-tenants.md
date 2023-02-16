Tailspin Toys has indicated that they host websites for toy stores of all sizes, and while most of them are small boutique toy stores serving tens to hundreds of thousands of customers, a few of the stores are very large, with millions of customers worldwide. The largest stores have significantly more traffic than other stores.

When distributing data in a multi-node database, Azure Cosmos DB for PostgreSQL places table rows into worker shards based on the hashed value of the rows’ distribution column. Every shard contains a range of hashed values, meaning multiple distribution column values can reside within the same shard. For multi-tenant SaaS applications, a single shard can host data for numerous tenants.

Given the drastically varying sizes of stores hosting their websites in Tailspin Toys' SaaS app, you suspect some of the performance issues they have experienced are likely due to resource contention between large and small tenants residing in the same shards. To improve resource allocation and make guarantees of tenant quality of service, you are interested in isolating Tailspin Toys' largest tenants to dedicated nodes in the cluster.

There are two steps you must take to isolate a tenant to a specific node:

1. Isolate the tenant’s data to a new dedicated shard.
2. Move the shard to the desired node in the cluster.

## Isolate tenant data to a dedicated shard

The `isolate_tenant_to_new_shard()` function is used to move tenant data into a new dedicated shard. To better understand how the procedure works, you want to use the most active tenant in Tailspin Toys' database, store id `5`, and the `orders` table as an example.

```sql
SELECT isolate_tenant_to_new_shard('orders', 5);
```

Invoking the function to isolate the tenant with `store_id` of `5` into a new shard happens in three steps:

1. First, a new shard will be created exclusively for `orders` rows whose distribution column value equals `5`. The hash range for this shard includes only a single distribution column hash, so it excludes all other rows.
2. Rows in the `orders` table whose distribution column value matches the specified tenant id are moved from their current shard to the new one.
3. The old shard is split into two new fragments with hash ranges that abut the range of the new shard.

You assigned the same distribution column for each table when distributing the Tailspin Toys table data. As a result, each tenant's data from all tables are co-located. As shown above, the `isolate_tenant_to_new_chard()` function will return an error and advise using the `CASCADE` option. This option instructs the process to isolate tenant rows of not just the table specified in the function call but of all co-located tables as well. Continuing the example from above, you need to rewrite the SQL command to be:

```sql
SELECT isolate_tenant_to_new_shard('orders', 5, 'CASCADE');
```

The output of the `isolate_tenant_to_new_shard()` function is the `shardid` of the newly created shard.

```text
 isolate_tenant_to_new_shard 
-----------------------------
                      102339
```

## Move the tenant's new shard to a dedicated node

Executing the `isolate_tenant_to_new_shard()` function to isolate a tenant results in the tenant's data being moved into an isolated shard. However, that shard is created on the same node as the shards from which the tenant was removed. If you wish to achieve true hardware isolation for a tenant, you can move them to a separate node in the cluster. The optional step allows you to isolate tenants further and prevent resource contention on the worker node.

Using the `shardid` value returned from the `isolate_tenant_to_new_shard()` function, you can query the `citus_shards` view to identify the worker node currently hosting the newly created shard:

```sql
SELECT nodename, nodeport
FROM citus_shards
WHERE shardid = 102339;
```

The above query outputs the following:

```text
                              nodename                           | nodeport 
-----------------------------------------------------------------+----------
 private-c.learn-cosmosdb-postgresql.postgres.database.azure.com |     5432
```

To view the list of available worker nodes available to hold the shard, query the `citus_get_active_worker_nodes()` function. Before doing this, you may also want to use the Azure portal to add a new node to your cluster and assign the shard to a dedicated node.

```sql
SELECT * from citus_get_active_worker_nodes();
```

In this example, the database was horizontally scaled by adding a new worker node, `private-w2`. That node will be the target for relocation.

```text
                              node_name                           | node_port 
------------------------------------------------------------------+-----------
 private-w0.learn-cosmosdb-postgresql.postgres.database.azure.com |      5432
 private-w1.learn-cosmosdb-postgresql.postgres.database.azure.com |      5432
 private-w2.learn-cosmosdb-postgresql.postgres.database.azure.com |      5432
```

Finally, you select a target worker node and call the `citus_move_shard_placement()` function to relocate the new shard to the worker node of your choice.

```sql
SELECT citus_move_shard_placement(
  102339,
  'private-c.learn-cosmosdb-postgresql.postgres.database.azure.com', 5432,
  'private-w2.learn-cosmosdb-postgresql.postgres.database.azure.com', 5432);
```

Note that `citus_move_shard_placement()` will also move any co-located shards with the `CASCADE` option to preserve co-location.

You can confirm the shard movement by querying the `citus_shards` table.

```sql
SELECT nodename, nodeport
FROM citus_shards
WHERE shardid = 102339;
```

The above query outputs the following:

```text
                              nodename                            | nodeport 
------------------------------------------------------------------+----------
 private-w2.learn-cosmosdb-postgresql.postgres.database.azure.com |     5432
```
