Data engineers face a common challenge: getting data from diverse sources into analytics platforms efficiently and reliably. Whether your data lives in SQL Server, Salesforce, SharePoint, or cloud storage, you need consistent, governed pipelines that minimize manual effort. **Lakeflow Connect** addresses this challenge by providing managed ingestion connectors that bring data directly into Unity Catalog tables.

## Understand ingestion pipelines

Lakeflow Connect is a collection of managed connectors in Azure Databricks that simplify data ingestion from external sources. Rather than writing custom extraction code, you configure pipelines through either a graphical interface or declarative definitions.

:::image type="content" source="../media/2-understand-lakeflow-connect-pipelines.png" alt-text="Diagram explaining ingestion pipelines in Lakeflow Connect." border="false" lightbox="../media/2-understand-lakeflow-connect-pipelines.png":::

Each pipeline consists of three core components:

- **Connection**: Stores credentials and endpoint information for the source system. You create connections once and reuse them across multiple pipelines.
- **Ingestion definition**: Specifies which tables or objects to extract, along with their destination catalogs and schemas in Unity Catalog.
- **Pipeline schedule**: Controls when and how frequently data flows from source to destination.

When you create an ingestion pipeline for a database connector like SQL Server, Lakeflow Connect also creates an **ingestion gateway**. This gateway continuously extracts change data from the source database and stages it for processing. For SaaS connectors like Salesforce, the connector handles extraction directly without a separate gateway.

## Configure ingestion pipelines

You can create ingestion pipelines through the Databricks UI, Asset Bundles, notebooks, or the CLI. The UI provides the simplest approach for initial setup.

Consider a scenario where you need to ingest customer order data from SQL Server. In the Azure Databricks workspace, you navigate to **Data Ingestion** and select **SQL Server**. The wizard guides you through creating an ingestion gateway, selecting the connection, and choosing the tables to ingest. You specify a destination catalog and schema where the ingested data lands as streaming tables.

```yaml
resources:
  pipelines:
    pipeline_sqlserver:
      name: customer-orders-pipeline
      catalog: sales
      schema: bronze
      ingestion_definition:
        ingestion_gateway_id: ${resources.pipelines.gateway.id}
        objects:
          - table:
              source_schema: dbo
              source_table: orders
              destination_catalog: sales
              destination_schema: bronze
```

With this configuration, the pipeline extracts the `orders` table from the source database and loads it into `sales.bronze.orders` in Unity Catalog.

## Control data extraction behavior

Lakeflow Connect offers several options for controlling how data flows from source to destination. The most important choice is between **snapshot** and **incremental** extraction patterns.

For database connectors, the gateway uses **change data capture (CDC)** to track modifications at the source. When CDC is enabled on the source database, the gateway captures inserts, updates, and deletes incrementally. This means subsequent pipeline runs process only changed records rather than reloading entire tables.

The **SCD type** setting determines how the destination table handles changes:

- **SCD type 1**: Overwrites existing records when updates occur. The destination table always reflects the current state of the source data.
- **SCD type 2**: Preserves historical versions of records. When a row changes, the pipeline marks the previous version as inactive and adds the new version. This approach tracks how data evolves over time.

```yaml
table_configuration:
  scd_type: SCD_TYPE_2
  sequence_by: last_modified
```

When you enable SCD type 2, the destination table includes `__START_AT` and `__END_AT` columns that record each version's active period.

## Optimize column selection and refresh strategies

Not every column in your source tables may be relevant for analytics. Lakeflow Connect lets you specify exactly which columns to include or exclude from ingestion.

```yaml
table_configuration:
  include_columns:
    - customer_id
    - order_date
    - total_amount
```

With explicit column selection, you reduce data transfer volumes and storage costs. If you use `include_columns`, newly added source columns won't automatically appear in the destination. With `exclude_columns`, new columns are included by default.

For situations where incremental processing can't recover from schema changes or data inconsistencies, you can trigger a **full refresh**. This operation clears the destination table and reloads all records from scratch. Lakeflow Connect minimizes downtime during full refresh by maintaining the existing data until the new snapshot completes.

You can also configure a **full refresh window** to schedule when these operations occur, avoiding disruption during peak business hours.

## Scale with multiple destinations

A single ingestion pipeline can write to multiple destination catalogs and schemas. This capability proves useful when different teams need isolated copies of the same source data.

```yaml
objects:
  - table:
      source_table: customers
      destination_catalog: sales
      destination_schema: analytics
  - table:
      source_table: customers
      destination_catalog: marketing
      destination_schema: campaigns
```

You can even ingest the same source table to multiple destinations within the same schema by specifying a custom `destination_table` name.

Once your pipelines are running, you can monitor ingestion progress, set up failure notifications, and adjust schedules through the pipeline details page. Lakeflow Connect automatically creates jobs for each schedule you define, allowing you to add additional processing tasks after ingestion completes.
