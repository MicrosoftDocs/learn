>[!VIDEO https://learn-video.azurefd.net/vod/player?id=c2324c11-59b0-456d-85e2-4b7e08de422d]

Your organization processes millions of transactions daily from multiple source systems, and stakeholders need reliable analytics that reflect both current operations and historical trends. The data engineering team faces critical decisions: How should data flow from source systems into the **lakehouse**? Which table formats provide the right balance of performance and compatibility? How do you maintain historical accuracy while keeping queries fast?

**Data modeling** in Azure Databricks with **Unity Catalog** addresses these challenges through deliberate design choices that affect every downstream consumer. You select **ingestion patterns** that match your latency requirements. You choose table formats like **Delta Lake** or **Apache Iceberg** based on transaction needs and cross-platform compatibility. You design **partitioning schemes** and **clustering strategies** that align with how analysts query the data.

These decisions compound over time. A table partitioned incorrectly today creates performance problems that grow with data volume. A **dimension table** without proper change tracking loses historical context. Thoughtful upfront design creates a foundation that scales efficiently and answers questions you haven't yet anticipated.

This module guides you through key data modeling decisions for Azure Databricks environments. You'll learn to design ingestion logic, select the right tools for each data source type, and implement storage strategies that optimize query performance. You'll explore **slowly changing dimensions** for historical accuracy and understand when **managed tables** provide advantages over **external tables**.
