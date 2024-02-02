To accommodate a recent increase in toy stores that host their websites in the Tailspin Toys multitenant SaaS application, you decide to migrate the Tailspin Toys Azure Cosmos DB for PostgreSQL single-node database to a multi-node cluster. You can migrate the database quickly and with minimal or no downtime by horizontally scaling the database in the Azure portal. However, to ensure that the database is migrated efficiently and with minimal disruption, you must plan and prepare your database for distribution before you take this step.

Tailspin Toys has provided the following diagram to represent the structure and relationships between tables in the current Tailspin Toys single-node database. Bold fields on a lighter blue background represent primary keys, and italicized items are foreign keys.

:::image type="content" source="../media/table-schema-single-node.png" border="false" alt-text="Diagram of the single-node schemas of and relationships between the stores, products, orders, and line_items tables.":::

You can reference this diagram as you evaluate the best way to distribute Tailspin Toys table data across multiple nodes.

## Plan for horizontal scaling

You can use Azure Cosmos DB for PostgreSQL to run PostgreSQL at any scale, from a single-node database to a multi-node distributed database on a cluster that has up to 20 workers. For multitenant SaaS application providers who start with a single node, planning for future growth when you initially select the size of your cluster can help you avoid downtime when you need to scale.

Horizontally scaling to a multi-node cluster can be accomplished with zero downtime, but having this capability depends on the configuration of the coordinator node. The minimum compute and storage sizes for the coordinator node in a multi-node cluster are four vCores with 16 GiB of RAM and 512 GiB of storage. You can create a single-node database that has compute and storage settings that are smaller than this minimum requirement. Scaling a single-node cluster when the coordinator compute size is less than four vCores with 16 GiB of RAM or the storage size is less than 512 GiB requires the coordinator compute and storage to be scaled. The server would have to be restarted, leading to a short period of downtime.

Horizontally scaling a single-node database and distributing table data across nodes can provide tremendous performance benefits. However, if you fail to properly plan and restructure tables, the result might be misconfigurations that hurt query performance. When you distribute multitenant data, you must consider how table data is distributed, the specified distribution column, table colocation, and common query patterns.

## Understand multitenant architecture

Azure Cosmos DB for PostgreSQL uses a form of hierarchical database modeling to distribute table data across nodes in the cluster. For multitenant SaaS applications, the internal identifier for each tenant, often called the _tenant ID_, is at the top of this hierarchy. This structure is driven by the fact that most queries from the SaaS application request data only for a single tenant by filtering on the tenant ID column. When you review the single-node table structure that Tailspin Toys provides, the `stores` table seems to be the best fit to host tenant data. The column that most logically fits as the tenant ID is `store_id`.

Azure Cosmos DB for PostgreSQL can efficiently process cross-shard queries, but it isn't the typical query pattern in multitenant SaaS applications. In multitenant SaaS apps, practically every query that's sent to the database filters on the tenant ID. Queries are inspected to determine which tenant ID it involves, and the coordinator node routes the query to a single worker node for processing. Specifically, the query is sent to the node that hosts the shard that's associated with the specified tenant ID. Placing all related data on the same node is called _table colocation_. Table colocation can significantly improve query performance when you join related tables.

## Select a distribution column

Tables in a single-node database might have primary and foreign keys, but they don't need to specify a distribution column. Your first step when you plan a migration to a multi-node distributed database is to identify the best distribution column, and then plan table distribution accordingly.

After you examine the most common query patterns that are used in the Tailspin Toys database, you determine that most queries that are executed against the database relate to a single store rather than to joining information across stores. This pattern is typical in databases that are associated with multitenant SaaS applications, including online transaction processing (OLTP) workloads for web clients and online analytical processing (OLAP) workloads that serve per-tenant analytical queries. As a result, multitenant SaaS applications have a natural dimension on which to distribute data across nodes. You can shard by tenant ID. For Tailspin Toys, you specify `store_id` as the distribution column on each distributed table.

## Classify tables

Now that you've identified the `store_id` column as the logical distribution key for the Tailspin Toys database, you need to review the schema and relationships to determine how each table should be handled and whether any modifications to table layouts are required.

When you work with tables in a single-node multitenant SaaS database, the tables generally fall into one of the following categories:

* **Ready for distribution**. These tables already contain the distribution key and are ready to be distributed without changes. Looking at the schema that's provided, the `stores`, `orders`, and `products` tables already contain the `store_id` column and fall into this category.

* **Needs backfill**. These tables can be logically distributed by the chosen key, but the tables don't contain a column that directly references the key. Tables in this category require modification to add the selected distribution column. The Tailspin Toys `line_items` table can be linked to the `store` table by joining through the `orders` or `products` tables, but it doesn't contain the `store_id` column. For table data to be distributed across worker nodes and colocated for maximum query efficiency, the table needs to be denormalized to include the `store_id` column. Then the new column must be populated with the appropriate `store_id` for each line item.

* **Reference table**. Reference tables are typically small, don't contain the distribution key, are commonly joined by distributed tables, and are shared across tenants. A full copy of each reference table's data is duplicated and maintained on every node in the cluster. The data is available for quick access by queries on any node.

* **Local table**. Local tables are typically not joined to other tables and don't contain the distribution key. They're maintained exclusively on the coordinator node and are often used for administrative purposes, such as for user authentication.

## Backfill tables

By referencing the table schema that Tailspin Toys provided, you observe that the `stores`, `orders`, and `products` tables already contain the `store_id` column. However, the `line_items` table doesn't contain the `store_id` column. To prepare this table for distribution, the `store_id` column needs to be added and populated, or _backfilled_, with values. This operation allows data in the `line_items` table to be colocated with related tenant data in the other tables. Unfortunately, this process denormalizes the table, but it's required to take full advantage of the distributed capabilities of Azure Cosmos DB for PostgreSQL.

You can add the distribution column to the `line_item` table by executing an `ALTER TABLE` command:

```sql
ALTER TABLE line_items ADD COLUMN store_id bigint;
```

After the table is updated to include the distribution column, you need to populate the column with the appropriate `store_id` value for each row in a process called *backfilling*. You can backfill the `store_id` column in the `line_items` table by using a join operation to retrieve the value from another table that contains the `store_id` value. For example, you can join `line_items` with `orders` to get the `store_id` that's associated with the order that's related to each row in `line_items`.

Tailspin Toys asked you to look for methods to use that minimize any operational disruption when you make database changes. The `line_items` table is one of the most active transactional tables in the database. You're concerned that performing a bulk operation to backfill the missing values might result in a heavy load on the database and potentially slow down other queries.

To fulfill the company's request to horizontally scale the database with _minimal disruption_, you decide to take a more conservative approach and update the `line_items` table in small batches. To accomplish this, you use the pg_cron extension, so you can schedule a user-defined function to run on a recurring schedule until the table is completely updated.

You determine that you can safely update 100,000 rows at a time without causing any noticeable database impact. So, you define the update function:

```sql
CREATE OR REPLACE FUNCTION backfill_batch(batch_size bigint)
RETURNS void
LANGUAGE PLPGSQL
AS
$$
BEGIN
    WITH batch AS (
        SELECT line_item_id, order_id
        FROM line_items
        WHERE store_id IS NULL
        LIMIT batch_size
            FOR UPDATE
            SKIP LOCKED
    )
    UPDATE line_items AS li
        SET store_id = orders.store_id
    FROM batch, orders
    WHERE batch.line_item_id = li.line_item_id
        AND batch.order_id = orders.order_id;
END;
$$;
```

By using pg_cron, which comes preinstalled in every Azure Cosmos DB for PostgreSQL database, you decide to schedule the function to run every five minutes:

```sql
SELECT cron.schedule('backfill', '*/5 * * * *', 'SELECT backfill_batch(100000)');
```

You can use this approach to incrementally update the table and still minimize the impact of substantial updates on database performance.

You can migrate to a multi-node cluster with minimal application changes. Still, after the distribution column is added to tables in which it's missing, you also need to update queries from the application to ensure that they're populating the column when they write new records to the database. For Tailspin Toys, this involves updating any queries that write to or read from the `line_items` table to include the `store_id` column.

## Update the table keys

Azure Cosmos DB for PostgreSQL can't enforce uniqueness constraints across nodes unless a table's unique index or primary key contains its distribution column. As part of your steps to prepare tables for a migration to a multi-node database, you must drop and re-create any primary and foreign key constraints on the Tailspin Toys tables. You add the `store_id` distribution column to each.

By default, creating an index on a table locks the table that's being indexed. Write operations to the table are blocked until the index build is finished. To honor the Tailspin Toys request to implement database changes in a way that results in minimal disruption to ongoing operations, you can avoid locking the tables by using the `CONCURRENTLY` option of `CREATE INDEX`.

When the `CONCURRENTLY` option is specified, normal operations against the table can continue while the index is built. But using this option might mean that it takes more time for the task to complete. To update table keys with the least disruption, you can concurrently create a unique index on the table, and then swap out the primary key to use it. For example, on the `line_items` table, you would use the following command to create a new unique index that includes the `store_id` distribution column:

```sql
CREATE UNIQUE INDEX CONCURRENTLY line_items_tmp_idx ON line_items (store_id, line_item_id);
```

While the unique indexes are creating, you can view any impact the operation is having on database health and identify any resulting locks by querying the `citus_stat_activity` table:

```sql
SELECT wait_event_type, count(*)
  FROM citus_stat_activity
 WHERE state != 'idle'
 GROUP BY 1
 ORDER BY 2 DESC;
```

If locks exist, they appear in the output, like in this example:

```text
 wait_event_type | count 
-----------------+-------
                 |     2
 lock            |     1
```

If you do see locks in the output, you can get more information about specific blocked queries by using the `citus_lock_waits` table:

```sql
SELECT * FROM citus_lock_waits;
```

The `citus_lock_waits` table provides details about which process is blocked and which process is blocking it. The output, displayed in the following extended view (enabled by running `\x` at the command prompt), looks similar to the following example:

```text
-[ RECORD 1 ]-------------------------+--------------------------------------
waiting_gpid                          | 10000024055
blocking_gpid                         | 10000019266
blocked_statement                     | CREATE UNIQUE INDEX CONCURRENTLY line_items_tmp_idx ON orders (store_id, order_id);
current_statement_in_blocking_process | SELECT create_orders(20000);
waiting_nodeid                        | 1
blocking_nodeid                       | 1
```

The output shows that using the `CONCURRENTLY` option allows write operations against the table to continue. The scheduled job that sends batches of new orders to the database has temporarily blocked the creation of the unique index on the `line_items` table. New orders can continue to be written to the database throughout the `CREATE UNIQUE INDEX` process.

After the new unique index creation completes, you must drop and re-create the primary and foreign key constraints on the `line_items` table. For the primary key, switch out the primary key for the unique index that you created earlier. This step is ideally done within a transaction to ensure that there's no time when the constraints aren't enforced. You would execute the following `ALTER TABLE` statements to complete this work:

```sql
BEGIN;
    
-- Swap out the primary key for the unique index
ALTER TABLE line_items
  DROP CONSTRAINT line_items_pkey,
  ADD CONSTRAINT line_items_pkey PRIMARY KEY USING INDEX line_items_tmp_idx;

-- Create a foreign key to the stores table (this did not exist previously)
ALTER TABLE line_items
  ADD CONSTRAINT line_items_store_id_fkey FOREIGN KEY (store_id) REFERENCES stores (store_id);

-- Re-create the foreign keys to the orders and products tables
ALTER TABLE line_items
  ADD CONSTRAINT line_items_order_fkey FOREIGN KEY (store_id, order_id) REFERENCES orders (store_id, order_id),
  ADD CONSTRAINT line_items_product_fkey FOREIGN KEY (store_id, product_id) REFERENCES products (store_id, product_id);

-- Drop the original foreign key references
ALTER TABLE line_items
    DROP CONSTRAINT line_items_order_id_fkey,
    DROP CONSTRAINT line_items_product_id_fkey;

COMMIT;
```

You must consider the relationships between tables when you drop and re-create primary and foreign keys. To ensure that existing constraint checks don't block operations when you drop keys, you should begin at the bottom of the relationship hierarchy and work your way up. Likewise, when you re-create keys, start at the top and work your way down to be sure that any referenced objects exist. For example, in the Tailspin Toys database, the `orders` and `products` tables are above `line_items` in the hierarchy. The `line_items` table has foreign key references to each of those tables. Attempting to drop and re-create the primary keys on either `orders` or `products` before the foreign key constraints are removed from `line_items` results in an error. The order of operations matters. To avoid these errors, start by removing the foreign key references for tables that are lower in the hierarchy, like `line_items`, and then work your way up the hierarchy.

Another technique to avoid breaking foreign key relationships that are defined in other tables is to include the `CASCADE` option when you drop the primary key constraints from your tables. The `CASCADE` option ensures that any related foreign key constraints are removed from other tables further down in the hierarchy.

When you modify each of the Tailspin Toys tables this way, the schema for the multi-node distributed database should now resemble the following diagram. The diagram highlights the new `store_id` column in the `line_items` table and the newly defined foreign key relationship with `stores` in green. Bold fields on a lighter blue background represent primary keys, and italicized items are foreign keys.

:::image type="content" source="../media/table-schema-multi-node.png" border="false" alt-text="Diagram that shows the multi-node schemas of and relationships between the stores, products, orders, and line_items tables. The new store_id column on the line_items table and the relationship between stores and line_items are highlighted in green.":::
