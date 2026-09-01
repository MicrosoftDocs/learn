Before you can discover data, you need to understand where it lives. In Microsoft Fabric, all data lives in OneLake, the single storage layer built into every Fabric tenant. OneLake eliminates the need for separate storage accounts because all Fabric workloads read from and write to the same location.

:::image type="content" source="../media/onelake-architecture.png" alt-text="Diagram of OneLake architecture showing a tenant with workspaces containing items over open Delta and Parquet formats.":::

## One storage layer, one copy of data

Every workspace stores its data in OneLake. Lakehouses, warehouses, eventhouses, and other items all write to the same underlying storage. When data changes, everyone with access sees the updated version. This removes the traditional problem of each team maintaining its own copy.

OneLake stores data in open formats. Tables use Delta Lake (Parquet files), and any tool that reads Delta or Parquet can access them directly. Files in OneLake can be any format: CSV, JSON, images, and more.

## How data arrives in OneLake

Data enters OneLake through several paths depending on the source and timing:

- **Mirroring** continuously replicates changes from external databases like Azure SQL, Cosmos DB, or Snowflake.
- **Pipelines** orchestrate batch data movement and transformation using Data Factory.
- **Dataflows** use Power Query to connect, transform, and load data.
- **Eventstreams** handle real-time data from IoT devices, applications, or change feeds.
- **Shortcuts** reference data in external locations like Azure Data Lake Storage, Amazon S3, Google Cloud Storage, or Dataverse without copying it.
- **Direct upload** adds files through the Fabric interface.

## What this means for discovery

Because all Fabric data lives in OneLake, you don't need to search across separate storage accounts or request access to disconnected systems. OneLake provides a single place to discover what your organization stores. Fabric provides tools to browse, evaluate, and connect to that data.

> [!TIP]
> Which data source paths are most valuable in your organization to limit or eliminate data duplication?
