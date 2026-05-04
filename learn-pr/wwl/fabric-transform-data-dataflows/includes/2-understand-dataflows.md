Before you start transforming data, it helps to understand what Dataflows Gen2 are, how they work, and when they're the right tool for the job. Dataflows Gen2 provide a low-code interface for building scalable data transformation processes that run in the cloud using Power Query.

## What are Dataflows Gen2?

Dataflows Gen2 are cloud-based ETL (Extract, Transform, Load) tools that use Power Query to connect to data sources, apply transformations, and load results to a destination. Dataflows Gen2 build transformation logic visually using Power Query Online. Power Query editor is the same interface available in Excel, Power BI Desktop, and other Microsoft products. Every transformation you apply is recorded as an *applied step*, creating an auditable and repeatable recipe for data preparation.

Dataflows run in Microsoft Fabric using managed compute resources. You don't need to build infrastructure, configure gateways for cloud sources, or manage execution environments. When you publish a dataflow, Fabric handles the compute, scheduling, and monitoring.

> [!NOTE]
> After the first reference, this module uses "dataflows" as shorthand for Dataflows Gen2. Earlier versions are identified as "Gen1" or "Power BI dataflows."

## Dataflows Gen2 capabilities

Dataflows Gen2 in Fabric provide several capabilities that support enterprise data preparation:

- **Connect to hundreds of data sources.** Pull data from cloud and on-premises databases, files, web services, SaaS applications, and Fabric items like lakehouses and warehouses.
- **Apply 300+ transformations.** Filter, sort, merge, pivot, aggregate, and reshape data using the Power Query interface. You can also write custom M language expressions for advanced logic.
- **Load to multiple destinations.** Send transformed data to Fabric lakehouses, warehouses, SQL databases, Azure SQL Database, Azure Data Lake Storage Gen2 (ADLS Gen2), Azure Data Explorer, Snowflake, and other supported destinations.
- **AutoSave and background publishing.** Your work is automatically saved as you go. When you publish, validation runs in the background with parallel query validations for faster publishing.
- **Schedule and automate.** Run dataflows manually, on a refresh schedule with parameter support, or as part of a data pipeline for orchestration with other activities. Email alerts notify you when scheduled refreshes fail.
- **AI-powered assistance.** Use natural language prompts to generate transformations, explain steps, and understand your query with Copilot for Dataflow Gen2.
- **Environment portability.** Use Fabric Variable Libraries and relative references to promote dataflows across environments with fewer manual edits for lifecycle management.

## Output destinations

When you configure a dataflow, you choose where to load the transformed data. The dataflow applies your transformations during each refresh and writes the results to your chosen destination. Key destinations include:

| Destination | Description |
|---|---|
| **Lakehouse** | Load data as Delta tables or files (CSV, Parquet, Excel (Preview)) |
| **Warehouse** | Load data to warehouse tables with schema support |
| **Azure Data Lake Storage Gen2** | Write files directly to ADLS Gen2 storage |
| **Azure SQL Database** | Load data to external SQL databases |
| **Fabric SQL database** | Load data to Fabric SQL database tables |
| **SharePoint Files** | Write delimited text or Excel files to SharePoint |
| **Azure Data Explorer (Kusto)** | Load data to Kusto databases and KQL databases |
| **Snowflake** | Load data to Snowflake databases |

When you configure a destination, you also choose an update method that determines how data is loaded during each refresh:

- **Replace**: Drops and recreates the destination with every refresh to provide a full snapshot of the transformed data
- **Append**: Adds new rows to the existing destination without removing previous data for incremental loads where historical data should persist
- **Incremental refresh**: Refreshes only new or changed data using a DateTime column, dividing data into configurable time-range buckets. Supported destinations are Fabric Lakehouse, Fabric Warehouse, and Azure SQL Database. This method significantly reduces refresh time and resource consumption for large or frequently updated datasets.

> [!NOTE]
> Schema-aware destinations (Lakehouses, Warehouses, and SQL databases) support writing into specific schemas, giving you more control over how tables are organized and aligning outputs to enterprise naming conventions. Azure Data Explorer and KQL databases only support the Append update method.

> [!TIP]
> Adding a data destination is optional. If you don't configure one, your dataflow still runs and processes the transformations. You can then use the dataflow as a data source in a pipeline or connect to it from Power BI.

## Dataflow types comparison

Microsoft offers several dataflow types across its platforms. Understanding the differences helps you choose the right one:

| Type | Platform | Best for |
|---|---|---|
| **Dataflows Gen2** | Microsoft Fabric | Lakehouse and warehouse output, best performance, Copilot support |
| **Dataflows Gen1** | Power BI service | Legacy Power BI dataflows, internal storage only |
| **Power Platform dataflows** | Power Apps, Power Automate | Business application data preparation |

If you're starting a new project in Fabric, use Dataflows Gen2 for the best performance and feature set.

## When to use dataflows

Dataflows are a strong choice when any of the following conditions apply:

- **Low-code preference.** Your team is comfortable with Power Query but doesn't write Spark or T-SQL code.
- **Familiar patterns.** Team members already use Power Query in Excel or Power BI Desktop and can apply those skills directly.
- **Simple-to-moderate transformations.** The work involves filtering, merging, reshaping, and cleaning, not heavy computational processing.
- **Reusable logic.** You want to define transformation logic once and apply it across multiple destinations or consumers.
- **Multiple destinations.** You need the same transformed data loaded to both a lakehouse and a warehouse.

## When to consider other approaches

Dataflows aren't the right fit for every scenario. Consider alternatives when:

- **Complex transformations require code.** If the logic involves advanced algorithms, iterative processing, or large-scale joins, Apache Spark notebooks provide more flexibility and performance.
- **Large-scale data processing.** For datasets that require distributed compute across a cluster, notebooks with Spark are more appropriate.
- **Full T-SQL is needed.** When transformations rely on stored procedures, complex joins, or DML operations, T-SQL in a warehouse or SQL analytics endpoint is the better choice.

The decision often comes down to the skill set of your team and the complexity of the transformation work. Dataflows cover the common 80% of transformation needs, while notebooks and T-SQL handle the more complex 20%.

## How dataflows support the intelligent data platform

The tables you produce through dataflows become the data that AI features in Fabric rely on. For example, when a user asks Copilot in Power BI to _summarize sales trends_, Copilot generates a query against the underlying tables. If those tables have clear column names and correct data types, the query returns accurate results. If the data is messy or ambiguous, the response is unreliable.

The same principle applies to Fabric data agents. A data agent that answers natural language questions about your lakehouse can only be as accurate as the data it queries. Dataflows give you a repeatable process to ensure that data is clean, well-typed, and consistently structured before it reaches those downstream AI experiences.
