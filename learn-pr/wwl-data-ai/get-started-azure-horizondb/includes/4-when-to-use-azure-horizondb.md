::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=e506be69-fbc5-484a-9c59-bb371bef7ba5]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Azure HorizonDB is designed for mission-critical workloads that need elastic scale, high availability, and AI capabilities on a PostgreSQL-compatible platform. Use the scenarios and considerations here to decide when it's a good fit.

## Match workloads to Azure HorizonDB

| Workload | Why Azure HorizonDB fits |
| --- | --- |
| Transactional (OLTP) | High-throughput, low-latency transaction processing with predictable performance for line-of-business applications, e-commerce platforms, and SaaS backends. |
| AI and intelligent applications | Native vector search and embedding support for RAG pipelines, recommendation engines, and semantic search in the database layer. |
| Massive read scale-out | Readable replicas that share zone-resilient storage let you scale reads without copying data. |
| Hybrid applications | Integration with the Azure ecosystem, including mirroring transactional data to Microsoft Fabric OneLake for analytics. |

## Evaluate deployment and operational requirements

Match your workload's recovery, security, and operational requirements to the service's current capabilities. General availability doesn't mean that every feature or configuration is available.

| Requirement | Current capability and considerations |
| --- | --- |
| Backup retention | Configure point-in-time restore retention from 1 through 35 days. The default is 7 days. Long-term retention isn't available. |
| Regional disaster recovery | Enable geo-redundant backups when you create the cluster. Backups and WAL records replicate asynchronously to the paired region. Geo-restore uses the latest available backup, with a recovery point objective (RPO) of up to one hour. Point-in-time restore to the paired region isn't supported. |
| Cross-region read replicas | Cross-region reader nodes aren't available. Geo-restore is a backup-based recovery option, not a readable replica or automatic cross-region failover. |
| Encryption key control | CMK is available in preview and must be configured at cluster creation. You can't combine CMK with geo-redundant backups. |
| Maintenance scheduling | Maintenance uses a system-managed window. Custom windows, customer-initiated rescheduling, deferral, and maintenance notifications aren't available. Plan for connection interruptions. |
| Connection pooling | Built-in PgBouncer isn't currently available. Use an external connection pooler if your workload requires pooling. |
| Private connectivity | Private endpoints through Azure Private Link are supported. Virtual network injection isn't available. Configure private DNS and public access separately. |

For recovery planning, see [Backups in Azure HorizonDB](/azure/horizondb/backup-restore/concepts-backup-restore). Check the [service overview and limitations](/azure/horizondb/overview#limitations) and [release notes](/azure/horizondb/release-notes/release-notes) before you commit a workload.

## Check regional availability

Azure HorizonDB is available in a growing set of Azure regions across the Americas, Europe, and Asia Pacific. Confirm current availability in the Azure portal before you plan a deployment.

::: zone-end
