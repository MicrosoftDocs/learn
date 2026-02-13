>[!VIDEO https://learn-video.azurefd.net/vod/player?id=a3b03ec4-23e8-4ed5-9928-fd65d021e7ca]

Every organization faces the challenge of balancing data availability with compliance requirements and storage costs. When you implement **data retention policies** in Azure Databricks, you ensure that data is kept only as long as necessary while remaining accessible for legitimate business needs. This becomes especially critical when regulations require you to delete personal data upon request.

In this unit, you learn how to configure retention settings, use **`VACUUM`** to remove obsolete data, handle deletion requests for compliance, and automate maintenance with **predictive optimization**.

## Configure Delta Lake retention settings

**Delta Lake** maintains table history through **transaction logs** and **data files**. Two key properties control how long this historical data remains available:

| Property | Default | Purpose |
|----------|---------|---------|
| `delta.logRetentionDuration` | 30 days | Controls how long transaction log history is kept |
| `delta.deletedFileRetentionDuration` | 7 days | Determines when `VACUUM` can remove unreferenced data files |

:::image type="content" source="../media/5-understand-data-retention-settings.png" alt-text="Diagram explaining Delta Lake retention settings." border="false" lightbox="../media/5-understand-data-retention-settings.png":::

These settings work together to define your **time travel** capabilities. For example, if you need 30 days of historical data access, you must configure both properties accordingly:

```sql
ALTER TABLE sales.customers.transactions 
SET TBLPROPERTIES (
    'delta.logRetentionDuration' = 'interval 30 days',
    'delta.deletedFileRetentionDuration' = 'interval 30 days'
);
```

> [!IMPORTANT]
> Increasing retention duration increases storage costs because more data files are preserved. Before adjusting these settings, evaluate your compliance requirements against storage budget constraints.
>
> You must set both of these properties to ensure table history is retained for longer duration for tables with frequent `VACUUM` operations

To view current retention settings for a table, use the following command:

```sql
SHOW TBLPROPERTIES sales.customers.transactions;
```

## Remove obsolete data with VACUUM

The `VACUUM` command removes data files that are no longer referenced by your Delta table and are older than the retention threshold. This operation permanently deletes historical data, so run it carefully.

```sql
-- Remove files older than the default retention period (7 days)
VACUUM sales.customers.transactions;

-- Remove files older than a specific retention period
VACUUM sales.customers.transactions RETAIN 168 HOURS;
```

When you run `VACUUM`, Delta Lake identifies files associated with versions older than the retention threshold and removes them from storage. After this operation, time travel queries to those older versions fail because the underlying data no longer exists.

For tables with **deletion vectors** enabled, you must also run `REORG TABLE ... APPLY (PURGE)` after deleting records to permanently remove the underlying data. `VACUUM` by itself does not remove data that deletion vectors have marked for deletion.

> [!NOTE]
> **Deletion vectors** are a storage optimization feature you can enable on Delta Lake tables. By default, when a single row in a data file is deleted, the entire Parquet file containing the record must be rewritten. With deletion vectors enabled, it marks rows as deleted without rewriting the entire file. 

## Handle compliance deletion requests

Privacy regulations grant individuals the "**right to be forgotten**," requiring you to delete their personal data upon request. Delta Lake's **ACID transactions** make these deletions straightforward.

### Delete individual records

Use the `DELETE` statement to remove specific records:

```sql
DELETE FROM bronze.users 
WHERE user_id = 12345;
```

### Process bulk deletion requests

For multiple deletion requests, use a `MERGE` statement with a control table that tracks pending requests:

```sql
MERGE INTO bronze.users AS target
USING (
    SELECT user_id
    FROM compliance.deletion_requests
    WHERE status = 'pending'
) AS source
ON target.user_id = source.user_id
WHEN MATCHED THEN DELETE;
```

After executing deletions, update your control table to mark requests as completed and run maintenance operations to permanently remove the data.

### Propagate deletions through your data layers

When you delete data in your bronze layer, you must also remove it from silver and gold layers:

- **Materialized views** automatically reflect deletions after a refresh.
- **Streaming tables** require special handling because they expect append-only data. Add the `skipChangeCommits` option to ignore upstream deletions:

```python
spark.readStream.option('skipChangeCommits', 'true').table("bronze.users")
```

After running deletion operations, execute `VACUUM` to permanently remove the data files from storage.

## Automate retention with predictive optimization

Manually scheduling `VACUUM` and `OPTIMIZE` operations across many tables is time-consuming and error-prone. **Predictive optimization** in Unity Catalog automates these maintenance tasks for managed tables.

When enabled, predictive optimization automatically:

- Runs `VACUUM` to remove unreferenced files
- Runs `OPTIMIZE` to improve file layout and query performance
- Runs `ANALYZE` to update table statistics

Enable predictive optimization at the schema level:

```sql
ALTER SCHEMA sales.customers ENABLE PREDICTIVE OPTIMIZATION;
```

> [!TIP]
> Before enabling predictive optimization, set your desired `delta.deletedFileRetentionDuration` on tables that require longer retention periods. The default `VACUUM` retention is 7 days, which might be shorter than your compliance requirements.

To check whether predictive optimization is enabled for a table:

```sql
DESCRIBE TABLE EXTENDED sales.customers.transactions;
```

You can monitor predictive optimization operations through the system table `system.storage.predictive_optimization_operations_history`, which shows when maintenance ran, what operations completed, and associated costs.

> [!NOTE]
> Predictive optimization is enabled by default if your account was created on or after November 11, 2024. 

## Integrate with Azure Storage lifecycle policies

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=8954bdc7-532d-4d10-8a73-826a09dafb32]

For data stored in Azure Blob Storage, you can complement Delta Lake retention with **Azure Storage lifecycle management policies**. These policies automatically transition data to cooler storage tiers or delete blobs based on access patterns and age.

Consider using Azure lifecycle policies to:

- Move infrequently accessed historical data to **cool** or **archive** tiers
- **Delete** temporary files or staging data after a defined period
- Reduce storage costs for data that remains accessible but rarely queried

Lifecycle policies operate at the storage layer, while Delta Lake retention operates at the table layer. Use both together for a comprehensive data retention strategy.

### Challenges with archiving Delta tables

When implementing storage lifecycle policies with Delta Lake, you must account for how Delta Lake manages files:

- **File creation time vs. modification time**: Azure Databricks typically relies on file creation time for lifecycle management. Operations like `UPDATE`, `MERGE`, `DELETE`, and `OPTIMIZE` rewrite Parquet files, which resets their creation time and can delay archival.

- **Querying archived data**:
  - **Offline tiers (Archive)**: Querying files in offline tiers fails unless they're restored
  - **Online tiers (Cool, Cold)**: Queries succeed but may incur higher access costs if data is frequently accessed.

- **Preventing frequent access**: It can be challenging to ensure users don't accidentally query archived data, which would trigger costly retrieval or failures.

### Strategies for effective archiving

To overcome these challenges and implement a cost-effective archival strategy:

- **Partition data by date**: Partitioning tables by ingestion date or transaction date makes it easier to identify and manage older data files.

- **Define storage lifecycle policies**: Configure Azure Storage lifecycle management rules to move older files to cool or archive tiers based on their age (for example, move to Cool after 30 days, Archive after 365 days).

- **Set the `delta.timeUntilArchived` property**: Configure this table property to match your storage lifecycle policy. This informs Azure Databricks that files older than the specified period are archived, preventing the query optimizer from assuming they're immediately available.
  
    ```sql
    ALTER TABLE sales_data 
    SET TBLPROPERTIES (delta.timeUntilArchived = '365 days');
    ```

- **Use views to restrict access**: Create views that filter out archived data to prevent users from accidentally querying it.

    ```sql
    CREATE VIEW active_sales_data AS 
    SELECT * FROM sales_data
    WHERE ingestion_date > CURRENT_DATE() - INTERVAL 365 DAYS;
    ```

- **Optimize and Vacuum with predicates**: When running maintenance commands, use predicates to avoid touching archived partitions, which would trigger retrieval.

    ```sql
    OPTIMIZE sales_data 
    WHERE ingestion_date >= current_timestamp() - INTERVAL 30 days;
    ```

Implementing data retention policies requires ongoing attention as business requirements and regulations evolve. Establish clear processes for reviewing and updating your retention settings, and document your compliance procedures so your team can respond quickly to deletion requests.
