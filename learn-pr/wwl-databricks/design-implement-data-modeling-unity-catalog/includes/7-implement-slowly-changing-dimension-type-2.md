>[!VIDEO https://learn-video.azurefd.net/vod/player?id=a1da50c9-1de6-41c6-b4bc-cc7ae7dcf02b]

After selecting SCD Type 2 for a dimension, you need to implement the table structure and change capture logic in Azure Databricks. This unit focuses on creating SCD Type 2 tables and implementing the MERGE patterns that maintain version history as source data changes.

## Create the SCD Type 2 table

The following SQL creates a customer dimension table with SCD Type 2 tracking columns:

```sql
CREATE TABLE sales.customer (
    customer_sk BIGINT GENERATED ALWAYS AS IDENTITY,
    customer_id STRING NOT NULL,
    customer_name STRING,
    email STRING,
    city STRING,
    region STRING,
    valid_from TIMESTAMP NOT NULL,
    valid_to TIMESTAMP NOT NULL,
    is_current BOOLEAN
)
USING DELTA
TBLPROPERTIES (
    delta.enableChangeDataFeed = true
);
```

The `GENERATED ALWAYS AS IDENTITY` clause creates an auto-incrementing surrogate key for each new row. Enabling the change data feed allows downstream processes to capture incremental changes efficiently.

## Implement change capture with MERGE

The `MERGE` statement provides an efficient way to implement SCD Type 2 logic when processing updates from source systems. The statement handles inserts, updates, and the versioning logic in a single transaction.

The following pattern closes the current version and inserts the new version when changes occur:

```sql
MERGE INTO sales.customer AS target
USING (
    SELECT 
        source.customer_id,
        source.customer_name,
        source.email,
        source.city,
        source.region,
        current_timestamp() AS valid_from,
        CAST('9999-12-31' AS TIMESTAMP) AS valid_to,
        true AS is_current
    FROM staging.customers AS source
) AS updates
ON target.customer_id = updates.customer_id AND target.is_current = true
WHEN MATCHED AND (
    target.customer_name <> updates.customer_name OR
    target.email <> updates.email OR
    target.city <> updates.city OR
    target.region <> updates.region
) THEN UPDATE SET
    target.valid_to = current_timestamp(),
    target.is_current = false
WHEN NOT MATCHED THEN INSERT (
    customer_id, customer_name, email, city, region,
    valid_from, valid_to, is_current
) VALUES (
    updates.customer_id, updates.customer_name, updates.email, 
    updates.city, updates.region, updates.valid_from, 
    updates.valid_to, updates.is_current
);

-- Insert new versions for updated records
INSERT INTO sales.customer
SELECT 
    s.customer_id,
    s.customer_name,
    s.email,
    s.city,
    s.region,
    current_timestamp() AS valid_from,
    CAST('9999-12-31' AS TIMESTAMP) AS valid_to,
    true AS is_current
FROM staging.customers s
JOIN sales.customer h 
    ON s.customer_id = h.customer_id 
    AND h.valid_to = current_timestamp()
    AND h.is_current = false;
```

> [!TIP]
> Consider using Lakeflow Spark Declarative Pipelines with the `AUTO CDC` API for automated SCD Type 2 processing. This approach handles out-of-order records and simplifies SCD Type 2 table maintenance. See the Azure Databricks documentation for change data capture pipelines.

## Query historical data

Once you've implemented an SCD Type 2 table, you can query data as it existed at any point in time. The query pattern depends on your analytical needs.

### Point-in-time queries

To find the state of data at a specific moment, filter on the validity period:

```sql
SELECT customer_id, customer_name, city
FROM sales.customer
WHERE valid_from <= '2023-06-15 12:00:00'
  AND valid_to > '2023-06-15 12:00:00';
```

This query returns exactly one row per customer—the version that was valid at the specified timestamp.

### Track record history

To view the complete history of changes for a specific entity:

```sql
SELECT customer_name, city, valid_from, valid_to
FROM sales.customer
WHERE customer_id = 'C-555'
ORDER BY valid_from;
```

This query reveals all versions of customer C-555, showing how their attributes changed over time.

### Use Delta Lake time travel

Delta Lake provides built-in time travel capabilities that complement explicit SCD Type 2 table designs. You can query previous table versions using the `TIMESTAMP AS OF` or `VERSION AS OF` syntax:

```sql
-- Query table state from 7 days ago
SELECT * FROM sales.customer 
TIMESTAMP AS OF '2024-01-15';

-- Query a specific table version
SELECT * FROM sales.customer 
VERSION AS OF 42;
```

> [!IMPORTANT]
> Delta Lake time travel has a default retention of 7 days. For longer historical analysis, use explicit SCD columns (ValidFrom, ValidTo) rather than relying solely on time travel. Configure `delta.logRetentionDuration` and `delta.deletedFileRetentionDuration` if you need extended time travel access.
