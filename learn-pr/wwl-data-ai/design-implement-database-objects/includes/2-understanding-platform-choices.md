Microsoft's SQL platforms serve different scenarios, and the database objects you design must align with your platform's capabilities and use cases. Understanding the control and management trade-offs between Infrastructure-as-a-Service (IaaS) and Platform-as-a-Service (PaaS) helps determine which platform best supports your database design requirements.

:::image type="content" source="../media/module-22-plan-implement-final-25.png" alt-text="Diagram showing platform management responsibilities for PaaS solutions, with Azure managing infrastructure, OS, and database engine while you manage database objects and data." lightbox="../media/module-22-plan-implement-final-25.png":::

The diagram shows how PaaS platforms divide responsibilities: Azure manages everything below the database layer—physical servers, networking, operating system patches, and engine updates—while you control what matters most to your application: tables, indexes, constraints, and data. This separation lets you invest your time in database design rather than infrastructure maintenance.

## Explore Azure SQL Database

[Azure SQL Database](/azure/azure-sql/database/sql-database-paas-overview?azure-portal=true) is a fully managed PaaS database that provides enterprise-grade performance and availability without infrastructure management. Multiple service tiers support different workload patterns, each influencing how you design database objects.

The [Hyperscale service tier](/azure/azure-sql/database/service-tier-hyperscale?azure-portal=true) eliminates many of the practical limitations traditionally associated with cloud databases. The resources of a single node constrain most databases, but Hyperscale databases have no such restrictions. With its flexible storage architecture, storage expands as needed, and there's no predefined maximum size. You're billed only for the capacity you use. For read-intensive workloads, Hyperscale offers rapid scale-out by provisioning more replicas to handle read operations.

The [serverless compute tier](/azure/azure-sql/database/serverless-tier-overview?azure-portal=true) automatically scales compute based on workload demand and pauses when idle—you pay only for storage during inactive periods. When a connection request is made, the database resumes automatically, though this cold start can add some latency. We recommend you design your application with connection retry logic to handle resume delays, and avoid long-running transactions that prevent autopause.

[Intelligent query processing](/sql/relational-databases/performance/intelligent-query-processing?azure-portal=true) and [automatic tuning](/azure/azure-sql/database/automatic-tuning-overview?azure-portal=true) analyze workload patterns to recommend or automatically create indexes. Automatic plan correction detects and fixes query regressions when proper indexing and statistics are in place.

Built-in [high availability](/azure/azure-sql/database/high-availability-sla-local-zone-redundancy?azure-portal=true) with a 99.99% uptime Service Level Agreement (SLA) means you can focus on performance and data integrity rather than replication topology.

## Build for Azure SQL Managed Instance

[Azure SQL Managed Instance](/azure/azure-sql/managed-instance/sql-managed-instance-paas-overview?azure-portal=true) provides near 100% compatibility with the latest SQL Server Enterprise Edition, always running the most recent database engine version with automatic patching. Native [virtual network integration](/azure/azure-sql/managed-instance/connectivity-architecture-overview?azure-portal=true) provides security isolation, while PaaS capabilities handle backups, high availability, and maintenance. This platform is designed for lift-and-shift migrations where existing database objects migrate with minimal changes.

Instance-level features include SQL Server Agent, Service Broker, linked servers, cross-database queries with three-part naming, and database mail. The [Managed Instance link](/azure/azure-sql/managed-instance/managed-instance-link-feature-overview?azure-portal=true) uses distributed availability groups to synchronize data from SQL Server to Azure in near real-time—enabling hybrid scenarios, read offloading, disaster recovery, and minimal-downtime migrations.

[In-Memory OLTP](/azure/azure-sql/managed-instance/in-memory-oltp-overview?azure-portal=true) in the Business Critical tier enables memory-optimized tables and natively compiled stored procedures for latency-sensitive workloads. Design for In-Memory OLTP by choosing durability options (SCHEMA_AND_DATA vs. SCHEMA_ONLY), index types (hash vs. nonclustered), and accounting for data type limitations.

## Use SQL Server on Azure Virtual Machines

[SQL Server on Azure Virtual Machines](/azure/azure-sql/virtual-machines/windows/sql-server-on-azure-vm-iaas-what-is-overview?azure-portal=true) provides Infrastructure-as-a-Service (IaaS) deployment where you control the SQL Server instance, database engine configuration, and underlying Windows or Linux operating system. This deployment option offers maximum compatibility and customization for applications requiring specific SQL Server versions, OS-level access, or configurations not available in PaaS offerings.

The [SQL IaaS Agent extension](/azure/azure-sql/virtual-machines/windows/sql-server-iaas-agent-extension-automate-management?azure-portal=true) unlocks management capabilities including automated backups, automatic patching during maintenance windows, Azure Key Vault integration, and tempdb configuration through the Azure portal. The [SQL best practices assessment](/azure/azure-sql/virtual-machines/windows/sql-assessment-for-sql-vm?azure-portal=true) validates your configuration against recommended settings, while I/O performance analysis helps identify storage bottlenecks. For high availability, you can configure [Always On availability groups](/azure/azure-sql/virtual-machines/windows/availability-group-overview?azure-portal=true) or [failover cluster instances](/azure/azure-sql/virtual-machines/windows/failover-cluster-instance-overview?azure-portal=true) with full control over replica placement and failover behavior.

## Design for SQL Database in Microsoft Fabric

[SQL database in Microsoft Fabric](/fabric/database/sql/overview?azure-portal=true) is a developer-friendly transactional database built on Azure SQL Database technology that automatically integrates with Fabric's analytics ecosystem. The platform uses the same SQL Database Engine as Azure SQL Database, combining OLTP capabilities with built-in analytics integration and eliminating the traditional separation between operational and analytical data stores.

[Automatic mirroring](/fabric/database/sql/mirroring-overview?azure-portal=true) replicates your operational data into OneLake as Delta Parquet files with no configuration required. All tables automatically become available for analytics through the [SQL analytics endpoint](/fabric/database/sql/sql-analytics-endpoint?azure-portal=true)—a read-only view of mirrored data. You can run [cross-database queries](/fabric/database/sql/query-sql-analytics-endpoint?azure-portal=true) using three-part naming to join data from other SQL databases, warehouses, and lakehouses. Analytical queries run against Delta Parquet files rather than operational tables, preventing analytics workloads from impacting transactional performance.

Intelligent performance features are enabled by default, including [automatic index creation](/azure/azure-sql/database/automatic-tuning-overview?azure-portal=true). The platform also supports AI development with semantic search and retrieval-augmented generation (RAG). Database portability is supported through [SqlPackage](/fabric/database/sql/sqlpackage?azure-portal=true) for .bacpac/.dacpac operations, [Fabric source control](/fabric/cicd/cicd-overview?azure-portal=true) for git integration, and [GraphQL APIs](/fabric/database/sql/graphql-api?azure-portal=true) for modern API interfaces.

[Integration with Power BI](/fabric/database/sql/data-modeling?azure-portal=true), Data Factory, and Data Science notebooks enables end-to-end workflows from operational database through analytics to business intelligence.

Throughout this module, you'll learn techniques applicable across all platforms, with callouts for platform-specific capabilities.
