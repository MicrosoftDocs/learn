::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=862f915f-c789-4c92-a9e6-f33b24f652e5]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Azure HorizonDB is built on two architectural principles: separation of compute and storage, and a database-as-a-log design. Together, they let the service scale elastically and recover quickly while maintaining full ACID guarantees.

:::image type="content" source="../media/service-architecture.png" alt-text="Diagram of Azure HorizonDB architecture: stateless compute of primary and read replicas, separated from WAL and data storage on Azure Blob Storage." lightbox="../media/service-architecture.png":::

## Separate compute and storage

Azure HorizonDB fully separates the compute layer from the storage layer:

- **Compute layer**: Compute is stateless. You scale compute resources (vCores and memory) independently of storage, and you scale reads horizontally by adding replicas to the cluster.
- **Storage layer**: Storage uses two purpose-built fleets—one for the write-ahead log (WAL) and one for data—both backed by Azure Blob Storage and zone-resilient by default. Storage grows automatically as data grows, independent of the compute tier.

This separation lets you scale compute and storage independently, provision read replicas quickly because they share the same storage and need no data copy, and fail over faster because the durable WAL storage is shared.

## Use a database-as-a-log design

In the database-as-a-log architecture, only the WAL is written from compute to the storage layer—data pages aren't. Because the WAL is the authoritative source of truth, this design reduces write amplification and delivers consistent, predictable write latency regardless of database size.

:::image type="content" source="../media/flow.png" alt-text="Flow diagram of Azure HorizonDB write path: client to primary replica to WAL service, then to data storage, standby replicas, and Blob Storage." lightbox="../media/flow.png":::

1. **Client write**: An application submits a write—an `INSERT`, `UPDATE`, or `DELETE`—to the database.
2. **Primary compute replica**: The primary processes the transaction and generates the WAL records that describe the changes.
3. **WAL service**: The durable WAL service receives and persists the WAL records before the transaction is committed.
4. **Acknowledgment**: After the WAL is durably stored, the service acknowledges the commit to the client.
5. **Data storage fleet**: Storage nodes receive only the filtered WAL they own and apply it to the persisted data pages.
6. **Standby replicas**: Standby replicas replay the WAL to refresh their in-memory pages, staying synchronized with the primary for high availability and fast failover.
7. **Azure Blob Storage**: Durable data files and archived WAL are stored in Azure Blob Storage for long-term durability, backup, and recovery.

## Identify the components of a cluster

A provisioned Azure HorizonDB resource is a **cluster**. A cluster includes the following components:

| Component | Role |
|---|---|
| Compute replicas | One writable **primary** and one or more readable **standby** replicas. Standby replicas serve reads and are failover candidates. At least two replicas provide zone resilience. |
| Read-write endpoint | Always points to the primary replica. |
| Read-only endpoint | Load-balances connections across the readable replicas. |
| WAL storage | A purpose-built, low-latency service that accepts and durably stores the WAL. |
| Data storage | A sharded fleet that serves data pages to all replicas and scales automatically. |
| Azure Blob Storage | Provides durability for data and WAL archival. Backups are implemented as blob snapshots. |

Each compute replica runs the PostgreSQL relational engine and includes a local NVMe SSD cache for hot pages, which minimizes reads from the remote storage layer.

::: zone-end
