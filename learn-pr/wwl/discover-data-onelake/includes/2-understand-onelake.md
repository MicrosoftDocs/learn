OneLake is the foundation of Microsoft Fabric's analytics platform. It provides a single, unified storage layer where all your data lives. Understanding OneLake is essential because it changes how you think about data storage. Instead of copying data between systems or managing multiple storage accounts, you work with one centralized location shared across all Fabric workloads.

## OneLake is tenant-wide

OneLake is a **tenant-wide data lake** built into every Fabric environment. When your organization enables Fabric, OneLake is automatically available. No separate setup or configuration is required.

With OneLake, you get a **single copy of your data**. All Fabric workloads read from and write to the same storage location. This approach eliminates the traditional problem of data silos where each team or tool maintains its own copy.

Traditional analytics environments often create copies of data for different teams or workloads. With OneLake, all workloads read from the same underlying files. When data changes, everyone sees the updated version immediately. This single source of truth reduces data inconsistencies and storage costs.

## Discover data with the OneLake catalog

The **OneLake catalog** helps you discover and browse data assets across your entire Fabric tenant. Think of it as a searchable inventory of all the data in OneLake.

You can search for assets by name, browse by workspace or domain, and view metadata like descriptions, owners, and lineage. The catalog makes it possible to find relevant data even when you don't know exactly where it's stored.

The catalog also provides governance and security capabilities. OneLake integrates with Microsoft Purview for data governance. You can classify data, apply sensitivity labels, and track data lineage. Access controls determine who can read or modify data, providing enterprise-grade controls to protect your data.

## Types of data in OneLake

OneLake stores data in **open formats**, which means your data isn't locked into a proprietary format. OneLake uses Delta Lake as the default table format, which stores data in open Parquet files. Any tool that understands Delta Lake or Parquet can access it, giving you flexibility in how you work with your data. Files in OneLake can be any format.

Data in OneLake can include:

- **Tables** stored in lakehouses, warehouses, or eventhouses
- **Files** in various formats (Parquet, CSV, JSON, and more)
- **Shortcuts** that reference data without physically copying it
- **Semantic models** for Power BI analytics

**Shortcuts** let you reference data in external locations like Azure Data Lake Storage, Amazon S3, or another OneLake location. The data stays where it is, but you can work with it as if it's part of your lakehouse. Shortcuts are useful when another team manages source data or when governance policies require data to remain in a specific location.

## How data arrives in OneLake

Data can arrive in OneLake through several ingestion methods:

- **Mirroring**: Continuously replicates data from external databases like SQL Server, Azure SQL Database, Azure Cosmos DB, or Snowflake. When source data changes, OneLake reflects those changes automatically.
- **Pipelines**: Orchestrate data movement and transformation using Data Factory capabilities. They copy data from various sources, apply transformations, and load it into OneLake.
- **Dataflows**: Use Power Query to connect to sources, transform data, and load it into OneLake. They're familiar to Excel and Power BI users who worked with Power Query.
- **Streaming**: Handles real-time data through eventstreams. Data flows continuously from sources like IoT devices, application logs, or clickstream events.
- **Direct upload**: Upload files directly to OneLake storage through the Fabric interface.

## How OneLake supports your AI workflow

OneLake plays a foundational role in enabling AI within Fabric. To provide relevant insights, Copilot and Fabric IQ agents need to find and understand your data.

When you ask Copilot a question like _"What were last quarter's sales trends?"_, it searches the OneLake catalog to locate relevant data. The same catalog you use to browse and discover assets powers AI-driven assistance.

When data is scattered or poorly documented, even AI struggles to find it. Copilot can return more accurate results to consumers when your data has clear names, descriptions, and metadata. AI assistants can help you more effectively when data is discoverable and well-cataloged.
