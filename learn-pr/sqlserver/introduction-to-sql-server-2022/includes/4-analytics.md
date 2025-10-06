
SQL Server 2025 enhances analytics capabilities for reporting, analysis, and data integration. This unit covers the analytics improvements in areas like mirroring, reporting services, and analysis services.

## Enable Microsoft Fabric mirroring

[Microsoft Fabric](/fabric/get-started/microsoft-fabric-overview) is a unified analytics platform that combines data integration, data engineering, and business intelligence.

Database mirroring is like having a real-time copy of your database running on a separate server. Think of it as creating an exact mirror image that stays synchronized with your main database. In SQL Server 2025's context, this mirroring specifically focuses on creating copies for analytical purposes in Microsoft Fabric, rather than just for backup and failover.

The following diagram illustrates SQL Server 2025's modern mirroring architecture. On the left, you see the source SQL Server database where your operational data resides. The Change Feed technology (shown in the middle) - a new feature in SQL Server 2025 that replaces the traditional [Change Data Capture](/sql/relational-databases/track-changes/about-change-data-capture-sql-server) - continuously monitors for any data changes in your source database. When changes occur, they're captured and streamed directly to Microsoft Fabric's OneLake storage. The Resource Governor, represented by the gears icon, ensures this process runs smoothly by managing system resources. Blue arrows indicate the data flow path, demonstrating how your data moves from the source system to the analytics platform while maintaining near real-time synchronization.

:::image type="content" source="../media/sql-2005-mirroring.png" alt-text="Diagram showing SQL Server 2025's mirroring architecture with data flow from SQL Server through Change Feed to Microsoft Fabric's OneLake." :::

Microsoft Fabric mirroring enables:

- **Near real-time analytics on operational data:** Traditionally, companies had to wait hours or even days to analyze their operational data. Imagine running a retail store and wanting to know how today's sales are affecting your inventory - with real-time analytics, you can see these insights immediately rather than waiting for overnight batch processing.

- **Seamless data synchronization with OneLake:** OneLake, being Microsoft Fabric's storage foundation, acts like a central data hub. When your SQL Server data automatically syncs with OneLake, data scientists and analysts can access fresh data without complex processes. It's like having your database automatically update a shared workspace that everyone in your organization can use for analysis.

- **Resource management through Resource Governor pools:** When you're running both operational databases and analytical queries, you need to ensure one doesn't affect the other. Resource Governor pools help manage this by allocating specific amounts of CPU, memory, and I/O to different workloads. It's similar to having dedicated lanes on a highway - analytical queries get their own lane without slowing down regular business operations.

### Manage resources with resource governor

SQL Server 2025 provides [Resource Governor (RG)](/sql/relational-databases/resource-governor/resource-governor) pool support for mirroring processes:

1. **Workload group assignment**: SQL Server 2025 introduces sophisticated workload management through Resource Governor, allowing different mirroring phases to be assigned to specific workload groups. The system handles ingestion, transformation, and synchronization phases independently, enabling administrators to allocate resources effectively based on the processing requirements of each phase. This granular control ensures optimal performance by preventing resource contention between different mirroring operations and other database workloads.

2. **Flexible pool management**: When mirroring data to Microsoft Fabric, administrators can organize database workloads by either distributing them across separate resource pools or consolidating them into a single pool. This flexibility enables strategic grouping of databases with similar workload patterns and resource needs. For example, you might place all your high-priority OLTP databases in one pool while keeping reporting databases in another, ensuring each gets the appropriate resources. This approach also allows you to isolate mission-critical workloads in dedicated pools, guaranteeing them specific resource allocations without interference from other database operations.

### Compare mirroring technology differences

SQL Server 2025 uses an improved approach to mirroring compared to previous versions:

| Feature | SQL Server 2016-2022 | SQL Server 2025 |
|---------|---------------------|-----------------|
| Capture incremental changes | Change Data Capture (CDC) | *Change Feed* method |
| Arc Agent | Not required | Provides system managed identity for outbound authentication |
| SQL Server Agent | Required for CDC key functions | Not required |
| On-premises Data Gateway (OPDG) | Writes data to OneLake | Used for control and command only, SQL Server writes directly to OneLake |

### Access mirrored data in Microsoft Fabric

Once your data is mirrored to Microsoft Fabric, it becomes instantly available across the entire Fabric ecosystem. 

This means you can:

- Analyze data directly in Power BI using the new Direct Lake mode
- Load it into a Data Warehouse for complex queries
- Use it in Data Engineering pipelines
- Access it through your Lakehouse for big data processing
- Query it using KQL database for log analytics
- Explore it in Notebooks for data science projects
- Use it with Copilot for AI-powered insights

The data is stored in an optimized delta format, ensuring fast access and consistent performance across all these tools and services. This unified access eliminates the need to copy or transform data for different analysis tools, saving time and resources while ensuring everyone works with the same up-to-date information.

## Implement Reporting Services features

With SQL Server 2025, Microsoft is modernizing its reporting platform by making Power BI Report Server the default reporting solution. This change brings several benefits:

The following table outlines key reporting capabilities in Power BI Report Server:

| Feature | Description | Documentation |
|---------|-------------|---------------|
| Unified reporting | Create and manage paginated and interactive reports in one platform | [Report types](/power-bi/report-server/reporting-roadmap) |
| Data modeling | Build reusable semantic models for consistent reporting | [Data modeling guide](/power-bi/transform-model/desktop-modeling-view) |
| Power BI integration | Use Power BI features including visualizations and AI capabilities | [Power BI integration](/power-bi/report-server/connect-data-source) |
| Cloud migration | Migrate to cloud services while preserving existing reports | [Migration guide](/power-bi/report-server/migrate-report-server) |

> [!NOTE]
> SQL Server 2025 licenses include Power BI Report Server at no extra cost.

> [!IMPORTANT]
> [SQL Server Reporting Services (SSRS)](/sql/reporting-services/create-deploy-and-manage-mobile-and-paginated-reports) transitions to [Power BI Report Server](/power-bi/report-server/get-started) as the default reporting solution in SQL Server 2025.

For organizations currently using SQL Server Reporting Services (SSRS), Microsoft continues to provide support for both SQL Server 2025 and all in-market versions. The migration from SSRS to [Power BI Report Server](/power-bi/report-server/get-started) is designed to be straightforward, with most RDL report assets being fully compatible with the new platform.

## Optimize Analysis Services performance

[SQL Server Analysis Services (SSAS)](/sql/analysis-services/analysis-services-overview) provides enterprise-grade semantic data models for business intelligence and data analytics applications. It processes data from multiple data sources into a highly optimized data model, enabling fast analysis of large datasets and complex calculations. Whether you're analyzing financial data, sales metrics, or operational KPIs, SSAS provides the tools to create sophisticated data models that support both traditional reporting and advanced analytics scenarios.

SQL Server 2025 Analysis Services includes these performance and scalability enhancements:

1. **MDX query performance**: Significant improvements for Multidimensional Expressions (MDX) queries on models with:
   - Calculation Groups
   - Format Strings
   - Dynamic Format Strings for Measures
   - Calculated Items with Format Strings

2. **DirectQuery enhancements**:
   - Improved query parallelization for faster response times
   - Implementation of Horizontal Fusion optimization
   - Reduced number of SQL queries generated by DAX
   - Better handling of data source delays and network latencies

These improvements particularly benefit operations in Analyze in Excel and complex query scenarios.

## Explore Integration Services enhancements

SQL Server 2025 Integration Services (SSIS) includes important updates to enhance connectivity and security:

- New support for ADO.NET connectivity with Microsoft SqlClient Data Provider
- Enhanced Microsoft Entra ID authentication capabilities
- More secure and flexible connection scenarios
- Better integration with modern identity solutions
