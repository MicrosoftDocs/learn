::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=7ced967c-ca2b-4b79-a165-48406e70881f]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Before you evaluate Azure HorizonDB for a workload, you need a clear picture of what the service is and what makes it different from self-managed PostgreSQL.

## Understand Azure HorizonDB

Azure HorizonDB is a cloud-native, fully managed database service built on PostgreSQL. It combines a disaggregated compute-and-storage architecture with a database-as-a-log design to deliver predictable performance, enterprise-grade security, high availability, and seamless scalability for mission-critical workloads.

Because the service is fully managed, Azure handles provisioning, patching, backups, high availability, and scaling. Your team focuses on the application instead of database infrastructure.

## Keep full PostgreSQL compatibility

Azure HorizonDB works with PostgreSQL applications, drivers, and tools. You keep your PostgreSQL skills and tooling, but assess supported extensions, engine versions, and service limits before you migrate a workload.

For migration into HorizonDB, the documented options include dump and restore and an offline workflow through Azure Database Migration Service (DMS). Offline migration requires a period when source writes stop. DMS support for PostgreSQL-to-HorizonDB migration is in preview. Choose an approach based on workload size, compatibility, and acceptable downtime.

## Build AI-ready applications

Azure HorizonDB supports retrieval-augmented generation (RAG), recommendation engines, and semantic search alongside your operational data. Its AI capabilities include:

- **Vector and hybrid search**: The `pgvector` extension stores and searches vectors. Combine vector similarity with full-text search and semantic reranking to improve retrieval relevance.
- **AI functions in SQL**: The `azure_ai` extension provides functions for embedding generation, text generation, extraction, and reranking by calling AI models.
- **Durable AI pipelines**: Define workflows for chunking, embedding, and other AI tasks in SQL. Pipelines track progress and retry failed steps.
- **AI Model Management (preview)**: Provision managed models for embedding, chat completion, and reranking, or register your own Microsoft Foundry model deployments.

These capabilities let you prepare data and retrieve relevant context inside HorizonDB. Model calls still depend on configured model access and incur model usage charges. See [AI capabilities in Azure HorizonDB](/azure/horizondb/ai/ai-overview).

| Characteristic | What it means |
| --- | --- |
| Cloud-native and fully managed | Azure operates the database platform, including high availability, backups, and scaling. |
| Built on PostgreSQL | Uses PostgreSQL applications, drivers, and tools, subject to supported versions, extensions, and service limits. |
| AI-ready | Extension-based vector search, SQL AI functions, durable AI pipelines, and Microsoft Foundry integration. |
| Built for scale | A disaggregated architecture scales compute and storage independently. |

::: zone-end
