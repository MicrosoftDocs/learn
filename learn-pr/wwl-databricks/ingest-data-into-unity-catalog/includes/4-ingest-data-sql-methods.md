SQL commands provide a declarative approach to data ingestion in Azure Databricks. If you're already comfortable with SQL syntax, these methods let you create and populate tables without writing procedural code. The three primary SQL ingestion techniques—`CREATE TABLE AS SELECT (CTAS)`, `CREATE OR REPLACE TABLE`, and `COPY INTO`—each address different ingestion scenarios while maintaining full compatibility with Unity Catalog.

## Create tables from queries with CTAS

The `CREATE TABLE AS SELECT` statement combines table creation and data population into a single operation. You define a new table based on the results of a `SELECT` query, making it ideal for transforming data during ingestion.

Consider a scenario where you need to ingest customer data from an external source and apply transformations. With CTAS, you write a query that reads from the source, applies your transformations, and saves the results to a new managed table:

```sql
CREATE TABLE catalog.schema.customers AS
SELECT 
    customer_id,
    UPPER(customer_name) AS customer_name,
    email,
    created_date
FROM external_staging.raw_customers
WHERE customer_status = 'active';
```

The table schema is automatically derived from the query results. Azure Databricks creates the table using Delta format by default, which provides ACID transactions, time travel, and optimized performance.

CTAS works well for initial data loads and one-time migrations. When you need to read data from files, combine CTAS with the `read_files` table-valued function:

```sql
CREATE TABLE catalog.schema.sales_data AS
SELECT * FROM read_files(
    '/Volumes/catalog/schema/volume/sales/*.parquet',
    format => 'parquet'
);
```

> [!NOTE]
> CTAS creates a new table each time it runs. If the table already exists, the command fails unless you use the `IF NOT EXISTS` clause—but that clause skips execution entirely rather than updating the table.

## Refresh tables with CREATE OR REPLACE TABLE

When you need to fully refresh a table's contents, `CREATE OR REPLACE TABLE` provides a clean solution. This command either creates a new table or completely replaces an existing one, preserving table history, granted privileges, and any row filters or column masks you've configured.

This approach proves valuable for periodic data refreshes where you want to replace all existing data:

```sql
CREATE OR REPLACE TABLE catalog.schema.daily_metrics AS
SELECT 
    report_date,
    SUM(revenue) AS total_revenue,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM catalog.schema.transactions
WHERE report_date >= CURRENT_DATE - INTERVAL 30 DAYS
GROUP BY report_date;
```

Unlike dropping and recreating a table, `CREATE OR REPLACE` maintains the table's metadata and permissions. Downstream users and applications continue to access the table without reconfiguration.

You can also use this command to define a table with an explicit schema and populate it from files:

```sql
CREATE OR REPLACE TABLE catalog.schema.products (
    product_id INT,
    product_name STRING,
    category STRING,
    price DECIMAL(10, 2)
) AS
SELECT * FROM read_files(
    '/Volumes/catalog/schema/volume/products.csv',
    format => 'csv',
    header => true
);
```

> [!IMPORTANT]
> `CREATE OR REPLACE` performs a full table replacement. For incremental updates where you only want to add new records, use `COPY INTO` instead.

## Load files incrementally with COPY INTO

`COPY INTO` addresses a common ingestion challenge: loading files from cloud storage in a reliable, repeatable manner. Unlike CTAS, which runs once and creates a table, `COPY INTO` is designed for ongoing ingestion workflows where new files arrive regularly.

The command reads files from a specified location and appends them to an existing Delta table. Its key feature is idempotency—files that have already been loaded are automatically skipped, even across multiple executions:

```sql
COPY INTO catalog.schema.events
FROM '/Volumes/catalog/schema/volume/events/'
FILEFORMAT = JSON
FORMAT_OPTIONS ('multiline' = 'true');
```

Before running `COPY INTO`, the target table must already exist. Create it with the appropriate schema:

```sql
CREATE TABLE IF NOT EXISTS catalog.schema.events (
    event_id STRING,
    event_type STRING,
    event_timestamp TIMESTAMP,
    payload STRING
);
```

### Configure file selection

When your source directory contains files with different naming patterns or you need to load specific files, use the `PATTERN` or `FILES` options:

```sql
-- Load only files matching a pattern
COPY INTO catalog.schema.orders
FROM '/Volumes/catalog/schema/volume/orders/'
FILEFORMAT = PARQUET
PATTERN = 'orders_2024*.parquet';

-- Load specific files by name
COPY INTO catalog.schema.orders
FROM '/Volumes/catalog/schema/volume/orders/'
FILEFORMAT = PARQUET
FILES = ('orders_001.parquet', 'orders_002.parquet');
```

### Handle schema and data quality

`COPY INTO` provides options for handling schema changes and validating data before loading:

```sql
COPY INTO catalog.schema.sensor_data
FROM '/Volumes/catalog/schema/volume/sensors/'
FILEFORMAT = CSV
FORMAT_OPTIONS (
    'header' = 'true',
    'inferSchema' = 'true'
)
COPY_OPTIONS ('mergeSchema' = 'true');
```

The `mergeSchema` option allows the table schema to evolve as new columns appear in source files. For validating data without loading it, add the VALIDATE clause:

```sql
COPY INTO catalog.schema.sensor_data
FROM '/Volumes/catalog/schema/volume/sensors/'
FILEFORMAT = CSV
VALIDATE ALL;
```

This validation checks whether data can be parsed, matches the table schema, and satisfies nullability and check constraints.

## Choose the right method

Each SQL ingestion method serves distinct purposes in your data engineering workflows:

| Method | Best for | Behavior |
|--------|----------|----------|
| **CTAS** | Initial data loads, one-time migrations, creating tables from queries | Creates a new table; fails if table exists |
| **CREATE OR REPLACE** | Periodic full refreshes, replacing staging tables | Replaces entire table; preserves permissions |
| **COPY INTO** | Ongoing file ingestion, incremental loads | Appends to existing table; skips loaded files |

For file-based ingestion that requires automatic schema inference, file notifications, or exactly-once guarantees, consider using Auto Loader as a complementary approach. When your ingestion needs are straightforward and you prefer declarative SQL over procedural code, these three methods provide a complete toolkit for managing data flow into Unity Catalog.
