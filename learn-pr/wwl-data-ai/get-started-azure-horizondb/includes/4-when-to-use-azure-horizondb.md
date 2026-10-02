::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=e506be69-fbc5-484a-9c59-bb371bef7ba5]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Azure HorizonDB is designed for mission-critical workloads that need elastic scale, high availability, and AI capabilities on a PostgreSQL-compatible platform. Use the scenarios and considerations here to decide when it's a good fit.

## Match workloads to Azure HorizonDB

| Workload | Why Azure HorizonDB fits |
|---|---|
| Transactional (OLTP) | High-throughput, low-latency transaction processing with predictable performance for line-of-business applications, e-commerce platforms, and SaaS backends. |
| AI and intelligent applications | Native vector search and embedding support for RAG pipelines, recommendation engines, and semantic search in the database layer. |
| Massive read scale-out | Readable replicas that share zone-resilient storage let you scale reads without copying data. |
| Hybrid applications | Integration with the Azure ecosystem, including mirroring transactional data to Microsoft Fabric OneLake for analytics. |

## Consider preview limitations

Because Azure HorizonDB is in preview, some capabilities aren't yet available. Review the current limitations before you commit a workload. Examples include:

- Configurable backup retention (retention is currently fixed at seven days) and long-term retention.
- Cross-region read replicas for disaster recovery.
- Customer-managed keys (CMK) for encryption at rest.
- Configurable maintenance windows.
- Built-in connection pooling (PgBouncer) and virtual network injection.

Always check the [Azure HorizonDB release notes](/azure/horizondb/release-notes/release-notes) for the latest status, because preview capabilities change over time.

## Check regional availability

Azure HorizonDB is available in a growing set of Azure regions across the Americas, Europe, and Asia Pacific. Confirm current availability in the Azure portal before you plan a deployment.

::: zone-end
