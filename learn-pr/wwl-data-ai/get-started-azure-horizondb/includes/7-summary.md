This module introduced Azure HorizonDB, a cloud-native, fully managed, AI-ready database service built on PostgreSQL.

## Review what you learned

- **What Azure HorizonDB is**: A fully managed, PostgreSQL-compatible database service for mission-critical workloads, with extension-based vector search, SQL AI functions, durable AI pipelines, and Microsoft Foundry integration. Assess compatibility and downtime requirements when you plan a migration into HorizonDB.
- **How it works**: A disaggregated compute-and-storage architecture and a database-as-a-log design deliver predictable performance, elastic scale, and fast failover while maintaining full ACID guarantees.
- **Cluster components**: A cluster combines writer and reader nodes in a read-write pool, read-write and read-only endpoints, purpose-built WAL and data storage fleets, and zone-resilient Azure Blob Storage. Additional read pools aren't currently available.
- **Security and configuration**: Private endpoints control private connectivity, Microsoft Entra provides token-based authentication, CMK provides customer control over encryption keys, and parameter groups manage reusable compute-pool settings.
- **When to use it**: Azure HorizonDB fits transactional, AI, read-scale, and hybrid workloads. Evaluate backup retention, geo-restore, feature-specific restrictions, and regional availability before you commit a workload. CMK and AI Model Management retain their documented preview status.

## Learn more

- [What is Azure HorizonDB?](/azure/horizondb/overview)
- [Azure HorizonDB release notes](/azure/horizondb/release-notes/release-notes)
- [Azure HorizonDB pricing](https://azure.microsoft.com/products/horizondb)
