A mirror is a copy, and a copy is only useful while somebody can say how far behind it is. Contoso's analysts build reports on the mirrored tables and stop thinking about where the numbers came from, which is the point. Your job is to know when the answer they're reading is stale, and to be able to tell the difference between a mirror that's broken and one that has nothing new to do. In this unit, you read the replication status, interpret what mirroring does to a schema, and choose the right intervention when something looks wrong.

## The replication status view

Once mirroring is configured, the **Monitor replication** view reports a status for the database and a row for every table under replication.

The database-level status is one of five values:

| Status | Meaning |
| :--- | :--- |
| **Running** | Replication is bringing snapshot and change data into OneLake |
| **Running with warning** | Replication is working, with transient errors |
| **Stopping** or **Stopped** | Replication is stopped |
| **Failed** | A fatal error that replication can't recover from |
| **Paused** | The Fabric capacity was paused and resumed |

Each table carries its own status from the same vocabulary, minus **Paused**, plus two columns that do the real diagnostic work: **Rows replicated**, the cumulative count of every insert, update, and delete applied to the target table, and **Last completed**, the last time that table was refreshed from the source.

**Read those two columns together, because each one lies on its own.** Rows replicated is cumulative rather than a row count, so it climbs past the number of items in the source container as soon as anyone updates anything, and it never goes down after a delete. And **Last completed only advances when the source changes.** A container without writes since Tuesday shows Tuesday, forever, on a mirror that is healthy. Treating a stale timestamp as a fault is the most common misreading of this view, and it's the one that leads people to restart a working mirror.

The initial snapshot is the other case where patience is the correct response. Replication takes a few minutes to begin and longer for a large first copy, so a table with no rows replicated shortly after setup is normal. A table still showing zero after a significant wait is not, and the documented first remedy is narrow: deselect that container and reselect it, which restarts replication for that table alone.

### Stop is not pause

The mirrored database has controls to stop and start replication, and the words undersell what they do.

**Stopping replication disables mirroring completely. Starting it again reseeds every target table from scratch**, which is to say it begins mirroring over as if newly configured. There is no resume-where-you-left-off. On a large database, starting replication again turns what should be a pause into a full re-copy and a window where the analytical tables are being rebuilt underneath whatever is querying them.

So the escalation order matters:

1. **Refresh the view.** Transient errors during setup are expected and clear on their own.
1. **Deselect and reselect the affected container.** Replication restarts for one table rather than the database.
1. **Stop and start replication.** Full reseed. Correct when the whole database is wrong, expensive when one table is.

**Paused** is a different status again, and nothing the mirror did. It appears after the Fabric capacity is paused and resumed, and it doesn't clear itself. The status stays **Paused** and source changes stop reaching OneLake until you open the mirrored database and select **Resume replication**, which continues from where it stopped instead of reseeding.

## What mirroring does to a schema

A document database lets every item have its own shape. A warehouse table doesn't. Mirroring reconciles the two automatically, and knowing the rules tells you what your analysts see.

- **A new property becomes a new column.** Mirroring detects it and adds it.
- **A missing property becomes null.** Items that lack a property that other items have get a null in that column.
- **A renamed property produces two columns.** Fabric keeps the old column and adds the new one. The old shows null for everything replicated after the rename, and the new shows null for everything replicated before it. Neither column is the full history on its own.
- **A changed data type is converted where it can be.** Compatible types are upcast, matching native Delta behavior. Incompatible ones become null, which is what happens if a property that was an array starts arriving as a string.
- **Case-different property names are disambiguated with a suffix.** JSON treats `addressName` and `AddressName` as two properties; a warehouse table can't. Mirroring keeps both by appending `_n`, so the second arrives as `AddressName_1`.

The consequence people meet first is the union table, and it appears whenever a container holds more than one entity type. The CosmicWorks `customer` container is exactly that shape: 282 documents made up of 10 customers and 272 sales orders, discriminated by a `type` property. Nine properties exist only on the customer documents and three only on the sales order documents, so the mirrored table is the union of both shapes, and every row is null in the other type's columns. Nothing is wrong. The table is faithfully representing a container that was never one schema.

That behavior has a limit worth stating plainly: mirroring replicates data without a full-fidelity or well-defined schema. It tracks property changes and data types continuously, a different guarantee from a schema you designed.

:::image type="content" source="../media/schema-union-table.png" alt-text="Diagram showing two document types in one Azure Cosmos DB container becoming a single mirrored table whose columns are the union of both shapes." lightbox="../media/schema-union-table.png":::

## Two replication behaviors that surprise people

**Deletes replicate immediately, but expirations don't replicate at all.** A deleted item disappears from OneLake right away. An item removed by a time-to-live (TTL) value is a different case: mirroring doesn't support soft deletion through TTL, so a container that relies on TTL to age out data has a mirrored copy that keeps rows the source no longer serves.

**Custom partitioning isn't supported**, so the layout of the mirrored data isn't something you tune from the source side.

## Monitoring beyond the portal view

The portal view is good for one mirror and a person looking at it. Two other surfaces exist for everything else.

The **mirroring REST API** exposes replication status for a mirrored database or an individual table, which is what you'd call from a scheduled job that checks freshness before a report refresh.

**Workspace monitoring** is the richer option. Enable it in workspace settings, and mirrored database execution logs flow automatically into a `MirroredDatabaseTableExecution` table in the workspace's monitoring Kusto Query Language (KQL) database, covering data replication, table changes, mirroring status, failures, and replication latency. From there, you query the logs with KQL directly, build a dashboard on them, or set alerts on the values you care about, which is how you find out a mirror stalled without anyone having the pane open.

In this unit, you learn how to monitor mirroring from an Azure Cosmos DB account into Fabric OneLake, understand the replication behaviors that might surprise you, and use the available tools to ensure your mirrored data stays fresh and accurate.
