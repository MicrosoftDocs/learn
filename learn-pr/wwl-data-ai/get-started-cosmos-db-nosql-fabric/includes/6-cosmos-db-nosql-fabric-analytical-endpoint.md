Cosmos DB NoSQL in Fabric includes an analytical endpoint that enables users to analyze operational data using Microsoft Fabric’s integrated tools. This capability is made possible through OneLake replication, which creates a read-optimized copy of Cosmos DB data for downstream analytics.

Rather than connecting directly to the operational database, the analytical endpoint provides access to replicated data that is structured for reporting and exploration. This design supports scalable analytics without impacting transactional workloads.

The replicated data is exposed through semantic models, which define the structure and fields available for analysis. These models are surfaced via the SQL analytics endpoint and become discoverable in the OneLake data hub. Once available, they can be used across the Fabric ecosystem, including in Power BI and Spark notebooks.

This approach allows users to build reports, explore data, and generate insights using familiar tools—without needing to manage infrastructure or move data manually. It also ensures consistency across analytics experiences by aligning Cosmos DB NoSQL data with the broader Fabric data model.

The analytical endpoint is designed to work seamlessly with the Cosmos DB NoSQL in Fabric experience. The endpoint provides efficient data access for both operational and analytical workloads, allowing users to focus on building rich data driven applications and insights, without the need for complex data management tasks. This integration simplifies the process of building data-driven applications and insights, enabling users to focus on analysis rather than data management.
