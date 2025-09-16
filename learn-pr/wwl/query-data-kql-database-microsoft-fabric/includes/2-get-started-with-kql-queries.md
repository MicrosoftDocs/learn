When you create an Eventhouse, a default KQL database is automatically created with the same name. An Eventhouse contains one or more KQL databases, where you can create tables, stored procedures, materialized views, functions, data streams, and shortcuts to manage your data. You can use the default KQL database or create other KQL databases as needed.

:::image type="content" source="../media/eventhouse.png" alt-text="Screenshot of an Eventhouse in Microsoft Fabric." lightbox="../media/eventhouse.png":::

## Work with data in your Eventhouse

There are several ways to access and work with data in a KQL database within an Eventhouse:

### Data ingestion

You can ingest data directly into your KQL database from various sources:

- Local files, Azure storage, Amazon S3
- Azure Event Hubs, Fabric Eventstream, Real-Time hub
- OneLake, Data Factory copy, Dataflows  
- Connectors to sources such as Apache Kafka, Confluent Cloud Kafka, Apache Flink, MQTT (Message Queuing Telemetry Transport), Amazon Kinesis, Google Cloud Pub/Sub

:::image type="content" source="../media/get-data.png" alt-text="Screenshot of the Get Data menu for an eventhouse in Microsoft Fabric." lightbox="../media/get-data.png":::

### Database shortcuts

You can create **database shortcuts** to existing KQL databases in other eventhouses or Azure Data Explorer databases. These shortcuts let you query data from external KQL databases as if the data were stored locally in your eventhouse, without actually copying the data.

### OneLake availability

You can enable **OneLake availability** for individual KQL databases or tables, making your data accessible throughout the Fabric ecosystem for cross-workload integration with Power BI, Warehouse, Lakehouse, and other Fabric services.

## Query data in a KQL database

To query data in a KQL database, you can use **KQL** or **T-SQL** in *KQL querysets*. When you create a KQL database, an attached KQL queryset is automatically created for running and saving queries.

### Basic KQL syntax

KQL uses a pipeline approach where data flows from one operation to the next using the pipe (`|`) character. Think of it like a funnel - you start with an entire data table, and each operator filters, rearranges, or summarizes the data before passing it to the next step. The order of operators matters because each step works on the results from the previous step.

> [!IMPORTANT]
> KQL is case-sensitive for everything including table names, column names, function names, operators, keywords, and string values. All identifiers must match exactly. For example, `TaxiTrips` is different from `taxitrips` or `TAXITRIPS`.

Here's an example that shows the funnel concept:

```kql
TaxiTrips
| where fare_amount > 20
| project trip_id, pickup_datetime, fare_amount
| take 10
```

This query starts with all data in the `TaxiTrips` table, filters it to show only trips with fares over $20, selects specific columns using the **project** operator, and uses the **take** operator to return the first 10 rows that match the criteria in the **where** clause.

The simplest KQL query consists of a table name:

```kql
TaxiTrips
```

This returns all columns from the `TaxiTrips` table, but the number of rows displayed is limited by your query tool's default settings.

To retrieve a sample of data from potentially large tables, use the **take** operator:

```kql
TaxiTrips
| take 100
```

This returns the first 100 rows from the `TaxiTrips` table, which is useful for exploring data structure without processing the entire table.

You can also aggregate data:

```kql
TaxiTrips
| summarize trip_count = count() by taxi_id
```

This returns a summary table showing the total number of trips (`trip_count`) for each unique `taxi_id`, effectively counting how many trips each taxi has made.

## Analyze data with KQL queryset

KQL queryset provides a workspace for running and managing queries against KQL databases. The KQL queryset allows you to save queries for future use, organize multiple query tabs, and share queries with others for collaboration. The KQL queryset also supports T-SQL queries, allowing you to use T-SQL syntax alongside KQL for data analysis.

You can also create data visualizations while exploring your data, rendering query results as charts, tables, and other visual formats.

:::image type="content" source="../media/queryset-visual.png" alt-text="Screenshot of a visualization in a queryset." lightbox="../media/queryset-visual.png":::

## Use Copilot to assist with queries

For AI-based assistance with KQL querying, you can use Copilot for Real-Time Intelligence

When your administrator enables Copilot, you see the option in the queryset menu bar. Copilot opens as a pane to the side of the main query interface. When you ask a question about your data, Copilot generates the KQL code to answer your question.

:::image type="content" source="../media/kql-copilot.png" alt-text="Screenshot of Copilot for Real-Time Intelligence." lightbox="../media/kql-copilot.png"::: 
