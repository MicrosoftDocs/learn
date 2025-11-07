[Microsoft Fabric](/fabric/get-started/microsoft-fabric-overview?azure-portal=true) is a unified analytics platform that brings together data integration, data engineering, data warehousing, data science, real-time analytics, and business intelligence. For SQL Server 2025, [mirroring in Microsoft Fabric](/fabric/database/mirrored-database/overview?azure-portal=true) provides a hybrid capability that enables near real-time replication of your on-premises or cloud SQL Server data directly into Fabric's [OneLake](/fabric/onelake/onelake-overview?azure-portal=true).

Mirroring in Microsoft Fabric represents a modern approach to hybrid analytics, offering integration between your operational databases and analytical workloads without the complexity of traditional ETL processes.

## Understand mirroring in Microsoft Fabric

Mirroring in Microsoft Fabric is a low-latency, low-cost replication solution that continuously replicates data from SQL Server into OneLake, Microsoft Fabric's unified data lake. The technology uses [change data capture](/sql/relational-databases/track-changes/about-change-data-capture-sql-server?azure-portal=true) (CDC) mechanisms integrated into SQL Server 2025's engine to efficiently track and replicate data changes.

Key capabilities include near real-time replication with minimal latency (typically within seconds), zero-copy integration where data is stored in OneLake's open [Delta Lake](/azure/databricks/delta/?azure-portal=true) format accessible by all Fabric workloads, and simplified management with no complex ETL pipelines or integration runtimes to configure. The solution is cost-effective with no additional infrastructure costs and automatically handles schema evolution by synchronizing schema changes.

## Explore the architecture

Mirroring connects your SQL Server 2025 instance to Fabric's unified analytics platform. The Mirroring service monitors your SQL Server for changes using change feed technology integrated into the database engine. Changes are continuously captured and replicated to OneLake, where data is stored in open Delta Lake format.

Once in OneLake, all Fabric capabilities can access the mirrored data including Power BI for reporting and dashboards, Data Engineering with Spark notebooks and pipelines, Data Warehouse through SQL analytics endpoints, Data Science and Machine Learning workloads, and Real-time Analytics using KQL.

## Identify key benefits

By mirroring SQL Server 2025 data into Microsoft Fabric, you gain access to an analytics ecosystem:

- **Power BI integration**: Build real-time dashboards and reports directly on mirrored data
- **Data lakehouse capabilities**: Combine structured SQL Server data with unstructured data from other sources
- **Advanced analytics**: Use [Spark](/fabric/data-engineering/spark-overview?azure-portal=true), Python, R, and SQL for data engineering and data science
- **AI and ML integration**: Leverage [Azure OpenAI](/azure/ai-services/openai/overview?azure-portal=true) and other AI services with your operational data

### Simplify hybrid architecture

Fabric Mirroring eliminates many traditional hybrid data challenges. Replication is automatic with no pipelines to build or maintain, and there's no need for separate infrastructure like integration runtimes or [SQL Server Integration Services](/sql/integration-services/sql-server-integration-services?azure-portal=true) (SSIS) packages. Schema changes are detected and applied automatically, and you can leverage Fabric's security model with Microsoft Entra ID integration.

The solution minimizes impact on your source SQL Server while providing cost-effective storage optimized for analytics workloads. Analytics workloads don't compete with operational database resources, and Delta Lake provides automatic data optimization and compaction.

## Compare Mirroring with other hybrid options

Understanding when to use different SQL Server 2025 hybrid features helps you choose the right solution:

| Feature | Primary Use Case | Latency | Best For |
|---------|-----------------|---------|----------|
| **Fabric Mirroring** | Real-time analytics and reporting | Seconds | Modern analytics, Power BI, data science |
| **Managed Instance Link** | Disaster recovery and migration | Near-synchronous | Business continuity, cloud migration |

> [!TIP]
> Many organizations use multiple hybrid features together. For example, use Fabric Mirroring for analytics, Azure SQL Managed Instance Link for disaster recovery, and Azure Arc for unified management.

## Configure mirroring

Before setting up Fabric Mirroring, ensure you have SQL Server 2025 with the database recovery model set to Full or Bulk-logged, an active [Microsoft Fabric capacity](/fabric/enterprise/licenses?azure-portal=true) (F2 or higher recommended), and appropriate permissions including db_owner on the source database and Admin or Contributor role in the Fabric workspace. If SQL Server is on-premises or in a private network, you'll need a self-hosted integration runtime.

To set up mirroring, navigate to the Microsoft Fabric portal and select or create a workspace with a Fabric capacity. In your workspace, select **+ New** > **Mirrored SQL Database** and choose **SQL Server** as the source type. Configure the connection with your server name, database name, authentication credentials, and gateway if needed for on-premises servers.

Select which tables from your database to replicate based on your analytics needs. Configure the mirroring settings including initial snapshot, continuous replication, and review estimated storage requirements. Finally, review the configuration summary and select **Create and start mirroring** to begin the process.

Once mirroring is configured, you can monitor replication status through the mirroring dashboard, view replicated data through SQL analytics endpoint or Spark, pause and resume mirroring as needed for maintenance, and benefit from automatic schema synchronization with built-in diagnostics and error reporting.

## Access mirrored data in Fabric

After your SQL Server 2025 data is mirrored to OneLake, you can:

### Build Power BI reports

```powerbi
// Connect to the SQL analytics endpoint
let
    Source = Sql.Database("your-workspace.datawarehouse.fabric.microsoft.com", "DatabaseName")
in
    Source
```

### Query with Spark (Python)

```python
# Access mirrored data using Spark
df = spark.read.format("delta").load("Tables/YourTableName")
df.show()
```

### Use SQL analytics endpoint

```sql
-- Query mirrored data using T-SQL
SELECT 
    CustomerID,
    OrderDate,
    TotalAmount
FROM MirroredDatabase.Sales.Orders
WHERE OrderDate >= DATEADD(day, -7, GETDATE())
```

Or use Spark to join SQL Server data with other sources:

```python
# Join SQL Server data with other lakehouse data
sql_data = spark.read.format("delta").load("Tables/Customers")
other_data = spark.read.format("parquet").load("Files/ExternalData")

joined_data = sql_data.join(other_data, "CustomerID")
```

## Apply best practices

Start small by beginning with critical tables and expand based on success. Consider data volume when planning, as large initial snapshots may take time. Ensure adequate network bandwidth for initial load and ongoing changes, and mirror only tables needed for analytics to optimize storage and performance.

For performance optimization, use [partitioning strategies](/sql/relational-databases/partitions/partitioned-tables-and-indexes?azure-portal=true) in SQL Server for better replication performance and ensure proper indexing to improve change tracking efficiency. Monitor replication lag and set up alerts for delays, and schedule intensive operations during off-peak hours.

Security is critical in hybrid scenarios. Use Microsoft Entra ID for centralized identity management, implement [row-level security](/fabric/data-warehouse/row-level-security?azure-portal=true) policies in Fabric to control data access, ensure TLS/SSL for data transmission, and monitor who accesses mirrored data using Fabric's audit logs. Remember that Fabric Mirroring is one-way replication, so have a plan for source recovery, and document which reports and analytics depend on mirrored data.

## Explore common use cases

Organizations use Fabric Mirroring to create real-time operational dashboards showing business metrics for sales performance tracking, inventory monitoring, customer service metrics, and manufacturing operations without impacting production databases.

The hybrid data lakehouse pattern combines operational SQL Server data with other data sources, merging transactional data with IoT sensor data, integrating on-premises data with cloud-based systems, and creating a unified view across multiple SQL Server instances.

Data scientists leverage Fabric Mirroring for advanced analytics and machine learning, building customer churn prediction models using real-time transaction data, predictive maintenance with current equipment telemetry, fraud detection on near real-time transaction streams, and recommendation engines with up-to-date user behavior.

Organizations also use mirroring as part of cloud migration strategy to test analytics workloads in the cloud while keeping production on-premises, validate performance and costs before full migration, train teams on Fabric capabilities with production-like data, and enable phased migration with continuous validation.
