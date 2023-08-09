With the tables in the Tailspin Toys Azure Cosmos DB for PostgreSQL database now prepared for distribution, you're ready to move on to horizontally scale the database and distribute the table data across the worker nodes.

## Horizontally scale the database

You can use Azure Cosmos DB for PostgreSQL to quickly scale your database to handle increased load. For multitenant SaaS applications, guidance for selecting the initial cluster size is based on the number of worker vCores and RAM of your original instance.

:::image type="content" source="../media/cosmos-db-postgresql-scale-nodes.png" alt-text="Screenshot that shows the scale nodes pane for Azure Cosmos DB for PostgreSQL in the Azure portal.":::

On the **Scale** pane, you can configure the number of worker nodes and the compute and storage size for each node. When you migrate from a single-node database, you can typically start with two nodes and expand to more worker nodes over time as application performance and growth requires.

It's essential to remember that this step only adds worker nodes. It doesn't distribute data to the new worker nodes. Depending on the size of the compute and storage that's assigned to the single-node cluster, scaling to multiple nodes might require the downtime of a server restart if the coordinator compute cores and storage sizes need to change. The single-node development database that you created for Tailspin Toys uses a compute size of four vCores with 16 GiB and 512 GiB of storage. This configuration meets the minimum coordinator node size for a multi-node cluster so that you can horizontally scale the database without downtime.

## Distribute and colocate table data

Distributing tables is the process of partitioning or sharding table data and moving those shards to be hosted on worker nodes. The database can't enforce, and actually prohibits, foreign key constraints when the referenced rows don't reside on the same node. So moving from a single-node nondistributed database to a multi-node distributed database requires some planning for the order in which the tables are distributed. In addition, you should ensure that table distribution is done in the least disruptive way possible.

Colocation of related table data should also be configured to allow tenant-specific queries to execute as efficiently as possible. When table data is distributed across nodes in the cluster, you ideally want rows across all tables that relate to the same tenant to reside together on the same nodes in what is called *table colocation*.

:::image type="content" source="../media/multi-tenant-colocation.png" border="false" alt-text="Diagram that shows table colocation represented by data from different tables in separate clouds based on store_id.":::

Colocating Tailspin Toys tables by store has the following advantages:

- It provides SQL coverage for capabilities like foreign keys and joins.
- Transactions for a single store are localized on the single worker node on which the store's data is housed.
- It allows for single-digit millisecond query performance by routing queries for a single store to a single node, optimizing network hops while still scaling compute and memory.
- As the number of stores grows, you can scale the database by adding nodes and rebalancing tenant shards to the new nodes.
- Data for large stores can be isolated to dedicated nodes.

### Determine the order of table distribution

Tables that define or that are referenced by foreign keys present some challenges that must be considered when you distribute the table. The `orders`, `products`, and `line_items` tables in the Tailspin Toys database define foreign key relationships that have one or more tables. The order in which you distribute each table matters because you must account for these foreign key constraints. For example, running the following command to distribute the `orders` table results in an error:

```sql
SELECT create_distributed_table('orders', 'store_id');
```

When a table that's being distributed has foreign key constraints, you must first distribute the table that's referenced by the foreign key. Continuing with the example, you must distribute `stores` before you attempt to distribute `orders`. Trying to distribute the tables in reverse order results in the following error:

```text
ERROR: referenced table "stores" must be a distributed table or a reference table
DETAIL: To enforce foreign keys, the referencing and referenced rows need to be stored on the same node.
HINT: You could use SELECT create_reference_table('stores') to replicate the referenced table to all nodes or consider dropping the foreign key
```

The error message indicates that the foreign key constraint that's related to the `stores` table causes the command to fail because `stores` isn't a distributed table or a reference table.

One approach to resolve this issue is to carefully consider the table relationships and any foreign key constraints. For Tailspin Toys, the tables would need to be distributed in the following order:

1. `stores`
1. `orders` and `products` (the specific order for distributing these tables doesn't matter, as long as they're distributed after `stores` and before `line_items`)
1. `line_items`

### Review methods for distributing tables with minimal disruption

There are two functions for distributing table data in Azure Cosmos DB for PostgreSQL, `create_distributed_table()` and `create_distributed_table_concurrently()`. Both of these methods have specific strengths and weaknesses when it comes to minimizing application disruption, and there are tradeoffs to using each method.

The primary method for distributing table data in Azure Cosmos DB for PostgreSQL is to use the `created_distributed_table()` function. This method, however, results in table locking and can prevent writes against the table until the distribution process completes. Tailspin Toys asked for any database changes to have a minimal impact on the application, so this approach isn't ideal.

To reduce disruption and prevent table locks, you can use the alternative `create_distributed_table_concurrently()` function. This function does the same thing as `create_distributed_table()`, but it executes the operation without blocking table writes during the distribution operation. Running `create_distributed_table_concurrently()` takes longer to complete, but it's a safer option when you're working with production systems, in which reducing the load on ongoing application operations is essential.

Like running `create_distributed_table()`, distributing tables by using foreign key constraints requires planning. You saw that `created_distributed_table()` checks foreign key constraints and dictates a specific table distribution order. With `create_distributed_table_concurrently()`, it's even more difficult because foreign key constraints prevent tables from being distributed entirely.

For example, consider the following command to distribute the `stores` table concurrently:

```sql
SELECT create_distributed_table_concurrently('stores', 'store_id');
```

With `create_distributed_table()`, you were required to distribute the `stores` table first because other tables have foreign key constraints referencing it. When attempting to distribute the `stores` table first by using `create_distributed_table_concurrently()`, the command raises an error:

```text
ERROR: relation stores is referenced by a foreign key from line_items
DETAIL: foreign keys from a regular table to a distributed table are not supported.
```

When tables are distributed concurrently, all relationships on the table are inspected. Table distribution is prevented for any tables that have relationships to nondistributed tables or to nonreference tables. Your only option to get around this constraint is to drop all foreign key constraints for each table and to re-create them after the distribution process completes.

To use `create_distributed_table_concurrently()` to distribute the `stores` table, you must first drop any foreign key references from all other nondistributed tables:

```sql
BEGIN;

ALTER TABLE orders
      DROP CONSTRAINT orders_store_id_fkey;
ALTER TABLE products
      DROP CONSTRAINT products_store_id_fkey;
ALTER TABLE line_items
      DROP CONSTRAINT line_items_store_id_fkey;

COMMIT;
```

After the foreign key constraints have been removed, you can then distribute the table:

```sql
SELECT create_distributed_table_concurrently('stores', 'store_id');
```

To complete the table distribution for the remaining tables, you must drop each foreign key constraint, distribute the tables, and then re-create the foreign key constraints after all tables are distributed.

The `create_distributed_table_concurrently()` function allows write operations to the database to continue but can take substantially longer to execute than `create_distributed_table()`. The database doesn't enforce referential integrity during the time it takes to distribute the tables because you were forced to drop foreign key constraints.

It's helpful to review the table distribution methods.

The `created_distributed_table()` function:

- Allows the tables that have foreign key constraints to be distributed, but only if the order of table distribution is carefully considered.
- Creates a lock on the distributed table and blocks any write operations until the distribution operation is completed.
- Doesn't honor transactions.
- Has drawbacks that include table writes being blocked during distribution, and the order of table distribution matters.

The `create_distributed_table_concurrently()` function:

- Doesn't block table writes.
- Doesn't work if there are any foreign key constraints in which the data doesn't reside on the same node. The workaround is to drop any foreign key constraints, and then re-create them after the data is distributed.
- Can't be executed inside of a transaction.
- Has drawbacks that include the loss of referential integrity during distribution, and that it takes longer to execute.

### Combine distribution methods to minimize impact and reduce risk

Each distribution method has its advantages but also introduces some impacts on the operation of the production multitenant SaaS application. Using `create_distributed_table()` blocks new transactions from entering the system while it runs but preserves referential integrity throughout the process. The `create_distributed_table_concurrently()` function allows the application to continue writing to the database but introduces the possibility of referential integrity not being enforced while table data is being distributed. To minimize application disruption and reduce risk, you can use a combination of the two methods to distribute the tables in the Tailspin Toys database.

`Stores` is a small table that isn't updated often. Distributing this table by using `create_distributed_table()` blocks write operations. However, because writes to this table occur infrequently and the table distribution occurs quickly, distributing the table might fall within the acceptable level of possible application disruption. As described earlier, you know that `stores` can be distributed by using `create_distributed_table()` without needing to drop any foreign keys on the other tables. Given these conditions, a possible tradeoff would be to distribute the `stores` table by using `create_distributed_table()`:

```sql
SELECT create_distributed_table('stores', 'store_id');
```

With `stores` now distributed, you need to consider how to approach the other tables. If you use `create_distributed_table_concurrently()`, you must drop and then re-create foreign keys on each table, so distributing the `stores` table hasn't eliminated that requirement.

The `products` table is larger than the `stores` table, but the `products` table might also be a candidate to distribute by using the `create_distributed_table()` function. Like `stores`, the impact of blocking writes to this table is slight. You can distribute the `products` table data by running the following code:

```sql
SELECT create_distributed_table('products', 'store_id', colocate_with => 'stores');
```

The `stores` and `products` tables share the same distribution column, so colocation happens implicitly. You also can explicitly specify colocation by using the `colocate_with` option of the `create_distributed_table()` function, as in the preceding example.

The `orders` and `line_items` tables are the largest tables in the database, and they're the targets of most of the write operations in the database. Blocking writes to these tables would be detrimental to the use of the SaaS application, so you should take a more conservative approach to distribute these tables. By using `create_distributed_table_concurrently()`, you have to drop the foreign key constraint between the `line_items`, `orders`, and `stores` tables, but it does limit the number of keys that you need to drop, and it slightly decreases the risk of not enforcing referential integrity between tables. For example, to distribute the `orders` table, you would drop the foreign key constraints, distribute the table concurrently, and then re-create the foreign key reference to `stores`:

```sql
-- Drop the foreign key to the stores table
ALTER TABLE orders
    DROP CONSTRAINT orders_store_id_fkey;

-- Drop the foreign key reference in the line_items table
ALTER TABLE line_items
    DROP CONSTRAINT line_items_orders_fkey;

SELECT create_distributed_table_concurrently('orders', 'store_id', colocate_with => 'stores');

-- Re-create the foreign key to the stores table
ALTER TABLE orders
    ADD CONSTRAINT orders_store_id_fkey FOREIGN KEY (store_id) REFERENCES stores (store_id);
```

Usually, you would want to run these statements in a transaction to reduce further the risk of not enforcing referential integrity when the table data is being distributed. However, `create_distributed_table_concurrently()` can't be run inside a transaction, so this option isn't possible at this time.

You can't re-create the foreign key to the `line_items` table until after that table is also distributed. The table distribution follows the same pattern: drop any foreign key constraints, distribute the table, and then re-create the foreign keys.

A best practice to use after all of your tables are distributed is to truncate the local rows of tables that still reside on the coordinator node. You can truncate the rows by running `truncate_local_data_after_distributing_table()`. You can't run this statement until after the related tables are all distributed because foreign key constraints cause an error.

```sql
SELECT truncate_local_data_after_distributing_table('stores');
```

You need to run this statement only on `stores` because the statement automatically cascades to other related local tables. It truncates the `orders`, `products`, and `line_items` local tables. Truncating local coordinator node table data is safe for distributed tables because their rows, if any, are copied to worker nodes during distribution.

## Understand what happens when only some tables are distributed

Neither of the distribution functions that are available in Azure Cosmos DB for PostgreSQL work in transactions, so some time elapses between when the first and the last tables are distributed. As you go about migrating the Tailspin Toys database to a multi-node cluster, you would like to understand whether queries that involve multiple tables break or become unacceptably inefficient during the interval when one or more tables are distributed, but others aren't.

Queries that involve joins across distributed tables or which are cross-partition can be planned efficiently because related data typically is colocated. However, when data isn't colocated, or if one of the joined tables is still a local table on the coordinator node, the Citus engine can't optimize the query. As a result, performance might be degraded due to the need to shuffle large amounts of data. You should thoroughly test common queries against the Tailspin Toys development database that you created before you migrate their production database to a multi-node cluster so that you can assess the impact.
