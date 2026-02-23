>[!VIDEO https://learn-video.azurefd.net/vod/player?id=feaee633-42d4-4b4c-9c9a-6fd1a3d451b1]

Data pipelines often require tracking not just current values, but every change that occurs over time. Temporal tables provide a mechanism for recording row-level changes automatically, enabling point-in-time queries and complete audit trails. Unlike slowly changing dimensions that focus on business data history, temporal tables capture technical history for operational traceability and debugging.

## Understand temporal tables versus SCD Type 2

Temporal tables and SCD Type 2 dimensions serve different purposes, though both track historical changes. Understanding when to use each approach helps you design appropriate solutions.

**SCD Type 2** tracks changes to business entities over time for analytical reporting. When a customer moves from Seattle to Portland, you want to attribute historical sales to the customer's location at the time of each transaction. SCD Type 2 maintains business-meaningful versions with explicit start and end dates.

**Temporal (history) tables** capture technical changes for operational needs. When troubleshooting why data loaded incorrectly, you need to see exactly what values existed at each point in time, which files were processed, and when changes occurred. Temporal tables provide this forensic capability automatically.

:::image type="content" source="../media/8-understand-temporal-tables-versus-slowly-changing-dimension-type-2.png" alt-text="Diagram explaining temporal tables versus SCD Type 2." border="false" lightbox="../media/8-understand-temporal-tables-versus-slowly-changing-dimension-type-2.png":::

Consider using temporal tables when you need to:

- Debug data ingestion issues by examining table state at specific timestamps
- Audit all changes for compliance or regulatory requirements
- Reproduce analyses or reports from a specific point in time
- Track operational metadata like load times and source file information

## Enable change data feed for row-level tracking

Delta Lake's change data feed captures every row-level change automatically. When enabled, the runtime records change events with metadata indicating whether each row was inserted, deleted, or updated. Change data feed is disabled by default, so you must explicitly enable it on tables where you need this capability.

To enable change data feed on a new table:

```sql
CREATE TABLE bronze.sales_transactions (
    transaction_id STRING,
    customer_id STRING,
    amount DECIMAL(10,2),
    transaction_date TIMESTAMP,
    source_file STRING,
    load_timestamp TIMESTAMP
)
USING DELTA
TBLPROPERTIES (delta.enableChangeDataFeed = true);
```

For existing tables, enable change data feed with an `ALTER TABLE` statement:

```sql
ALTER TABLE bronze.sales_transactions 
SET TBLPROPERTIES (delta.enableChangeDataFeed = true);
```

> [!IMPORTANT]
> Change data feed only records changes that occur after you enable it. Past changes to a table aren't captured. Enable this feature before loading production data.

## Query table history

Once change data feed is enabled, you can query the change history to see exactly what modifications occurred. The change data feed adds three metadata columns to your data:

| Column              | Description                                                                      |
| ------------------- | -------------------------------------------------------------------------------- |
| `_change_type`      | The type of change: `insert`, `update_preimage`, `update_postimage`, or `delete` |
| `_commit_version`   | The Delta log version containing the change                                      |
| `_commit_timestamp` | The timestamp when the change was committed                                      |

Query changes within a specific time range:

```sql
SELECT 
    transaction_id,
    amount,
    _change_type,
    _commit_version,
    _commit_timestamp
FROM table_changes('bronze.sales_transactions', '2026-01-01', '2026-01-31')
WHERE _change_type IN ('insert', 'update_postimage')
ORDER BY _commit_timestamp;
```

This query helps identify when specific records were modified, which is valuable for debugging data quality issues.

## Use time travel for point-in-time queries

Delta Lake maintains a transaction log that enables querying data as it existed at any point in history. This capability supports debugging scenarios where you need to compare current data with a previous state.

Query data at a specific timestamp:

```sql
SELECT * FROM bronze.sales_transactions
TIMESTAMP AS OF '2026-01-15 14:30:00';
```

Query data at a specific version:

```sql
SELECT * FROM bronze.sales_transactions
VERSION AS OF 42;
```

To view the complete history of operations performed on a table:

```sql
DESCRIBE HISTORY bronze.sales_transactions;
```

The history output includes the operation type, timestamp, user, and detailed metrics for each change.

> [!NOTE]
> Time travel availability depends on retention settings. By default, Delta Lake retains data files for 7 days and log files for 30 days. Configure `delta.deletedFileRetentionDuration` and `delta.logRetentionDuration` for longer retention periods.

## Persist change history for long-term auditing

Because Delta Lake's built-in time travel has retention limits, you should persist change data to a separate history table for long-term audit requirements. This approach creates a permanent record of all changes.

Use Structured Streaming to continuously capture changes:

```python
(spark.readStream
    .option("readChangeFeed", "true")
    .option("ignoreDeletes", "false")
    .table("bronze.sales_transactions")
    .writeStream
    .option("checkpointLocation", "/checkpoints/sales_history")
    .trigger(availableNow=True)
    .toTable("audit.sales_transactions_history")
)
```

The `readChangeFeed` option instructs Spark to read the change data feed, which returns row-level change events including inserts, updates, and deletes. The `ignoreDeletes` option controls whether delete operations are included in the stream. Setting it to `false` ensures that delete records are captured in the history table, providing a complete audit trail of all data changes.

The history table contains every change event with full metadata, enabling queries across the entire lifetime of your data—not just the retention window.

> [!TIP]
> Schedule the history capture process to run after each data load. Using `trigger(availableNow=True)` processes all available changes as a batch, which works well with scheduled workflows.

## Configure retention for compliance requirements

For temporal tables supporting compliance or regulatory needs, configure retention settings to match your requirements:

```sql
ALTER TABLE bronze.sales_transactions 
SET TBLPROPERTIES (
    delta.logRetentionDuration = 'interval 90 days',
    delta.deletedFileRetentionDuration = 'interval 90 days'
);
```

Both properties must be set together. The `logRetentionDuration` controls how long history metadata is retained, while `deletedFileRetentionDuration` controls how long deleted data files are preserved before `VACUUM` removes them.

Longer retention periods increase storage costs but provide extended time travel access and change data feed availability for auditing.

With temporal tables configured properly, you can trace every change to your data from ingestion through transformation, supporting both operational debugging and regulatory compliance requirements.
