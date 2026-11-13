::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=862f915f-c789-4c92-a9e6-f33b24f652e5]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Azure HorizonDB is built on two architectural principles: separation of compute and storage, and a database-as-a-log design. Together, they let the service scale elastically and recover quickly while maintaining full ACID guarantees.

:::image type="content" source="../media/service-architecture.png" alt-text="Diagram of the HorizonDB cluster architecture showing writer and reader nodes, pool endpoints, WAL paths, and shared zone-resilient storage." lightbox="../media/service-architecture.png":::

The diagram illustrates the compute-pool architecture, including additional read pools. Currently, only the read-write pool is available. The additional read pools shown aren't deployable yet.

## Separate compute and storage

Azure HorizonDB fully separates the compute layer from the storage layer:

- **Compute layer**: Compute is stateless. You scale compute resources (vCores and memory) independently of storage, and you scale reads horizontally by adding replicas to the cluster.
- **Storage layer**: Storage uses two purpose-built fleets—one for the write-ahead log (WAL) and one for data—both backed by Azure Blob Storage and zone-resilient by default. Storage grows automatically as data grows, independent of the compute tier.

This separation lets you scale compute and storage independently, provision read replicas quickly because they share the same storage and need no data copy, and fail over faster because the durable WAL storage is shared.

## Use a database-as-a-log design

In the database-as-a-log architecture, only the WAL is written from compute to the storage layer—data pages aren't. Because the WAL is the authoritative source of truth, this design reduces write amplification and delivers consistent, predictable write latency regardless of database size.

:::image type="content" source="../media/flow.png" alt-text="Flow diagram of Azure HorizonDB write path: client to primary replica to WAL service, then to data storage, standby replicas, and Blob Storage." lightbox="../media/flow.png":::

1. **Client write**: An application submits a write—an `INSERT`, `UPDATE`, or `DELETE`—to the database.
2. **Writer node**: The writer processes the transaction and generates the WAL records that describe the changes.
3. **WAL service**: The durable WAL service receives and persists the WAL records before the transaction is committed.
4. **Acknowledgment**: After the WAL is durably stored, the service acknowledges the commit to the client.
5. **Data storage fleet**: Storage nodes receive only the filtered WAL they own and apply it to the persisted data pages.
6. **Reader nodes**: Reader nodes replay the WAL to refresh their in-memory pages. Readers in the read-write pool also provide failover targets for the writer.
7. **Azure Blob Storage**: Durable data files and archived WAL are stored in Azure Blob Storage for long-term durability, backup, and recovery.

## Identify the components of a cluster

A provisioned Azure HorizonDB resource is a **cluster**. A cluster includes the following components:

| Component | Role |
| --- | --- |
| Writer and reader nodes | One writer processes writes. Reader nodes serve reads. Readers in the read-write pool are failover candidates. Zone-redundant high availability requires at least two nodes placed across availability zones. |
| Compute pools | Nodes in a pool share compute configuration and a parameter group. The read-write pool contains the writer and optional readers. Additional read pools aren't available yet. |
| Read-write endpoint | Always points to the writer in the read-write pool, including after failover. |
| Read-only endpoint | Load-balances connections across the reader nodes in its pool. |
| WAL storage | A purpose-built, low-latency service that accepts and durably stores the WAL. |
| Data storage | A sharded fleet that serves data pages to all replicas and scales automatically. |
| Azure Blob Storage | Provides durability for data and WAL archival. Backups are implemented as blob snapshots. |

Each compute node runs the PostgreSQL relational engine and includes a local NVMe SSD cache for hot pages, which minimizes reads from the remote storage layer. When you create a cluster in the Azure portal, its read-write pool is named `defaultpool`.

## Secure and configure your cluster

HorizonDB separates network access, identity, encryption, and database configuration:

| Capability | What to consider |
| --- | --- |
| Private endpoints | Azure Private Link provides a private IP address in your virtual network. Each private endpoint reaches either the read-write endpoint or a pool's read-only endpoint. Create separate private endpoints if you need both. Public access remains enabled unless you disable it separately. |
| Microsoft Entra authentication | Connect with tokens for Microsoft Entra users, groups, or managed identities instead of a local database password. Authentication settings apply across the cluster. Configure a Microsoft Entra administrator to manage Entra-based database roles. |
| Customer-managed keys (CMK, preview) | Service-managed encryption is the default. Choose CMK at cluster creation to control encryption keys through Azure Key Vault or Managed HSM. You must maintain key access. CMK can't be combined with geo-redundant backups. |
| Parameter groups | Reuse PostgreSQL settings across compatible compute pools in the same subscription and region. Default groups are read-only. Assign a custom group after pool creation to change settings. |

When you edit and save a restart-required setting in a custom parameter group, every assigned pool that needs a restart restarts automatically, interrupting connections. Assigning a different group can instead leave changes pending until you explicitly restart the pool. Check the effective settings after a change.

For more information, see the [Azure HorizonDB overview](/azure/horizondb/overview), [Data encryption](/azure/horizondb/security/security-data-encryption), and [Parameter groups](/azure/horizondb/parameters/concepts-parameter-groups).

::: zone-end
