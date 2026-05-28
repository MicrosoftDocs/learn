When you plan a storage migration, it's easy to underestimate the complexity, duration, and impact on your application workloads.

## Choosing a strategy

The right approach depends on several factors. Use the following table as a starting point:

| Factor | Online | Offline (Data Box) | Hybrid (seed + sync) |
|---|---|---|---|
| Data volume | Small to large (if bandwidth allows) | Large to very large (tens of TB to PB) | Very large with ongoing changes |
| Available bandwidth | Sufficient for data volume and timeline | Limited or costly | Limited for bulk, sufficient for deltas |
| Downtime tolerance | Low (supports incremental sync) | Higher (import lead time of days to weeks) | Low (final delta sync minimizes cutover) |
| Data change rate | Handles ongoing changes natively | Snapshot at time of export only | Bulk seed offline, then sync changes online |
| Cost profile | Bandwidth costs (ingress free) | Per-device fee, shipping costs | Device fee + bandwidth for delta syncs |

Most large-scale migrations use a combination of strategies across different workloads. Evaluate each data set individually rather than applying a single approach to your entire estate.

## Online

If your network can support the data volume and timeline, online migration is the most straightforward approach. Online migrations offer higher fidelity than offline migrations because replication runs can follow in short sequence, or change can be captured in an event-driven manner. However, bandwidth isn't always available in the quantities required to migrate the size of your data estate.

Even if bandwidth could be made available, contract terms may hinder feasibility. Offline migration can be cost effective, even when bandwidth is available.

Consider the following when evaluating your options:
- Your data must remain available throughout the migration, and any changes during migration need to be captured and replicated.
- Online migration tools can systematically capture and replicate changes, which shortens the required downtime for the actual cutover.
- Use Data Box as an offline migration tool with Azure Storage Mover or Azure File Sync to synchronize your data estate just before cutover.

## Offline

If you can't migrate data online, use Azure Data Box for an offline migration. The Data Box family offers several options based on data volume and performance needs:

- **Data Box Next Gen 525**: Up to 525 TB usable capacity per device. NVMe-based with up to 7 GB/s throughput using SMB Direct on RDMA (100-GbE). Designed for large-scale migrations.
- **Data Box Next Gen 120**: Up to 120 TB usable capacity per device. Same NVMe-based, high-performance platform as the 525 at a lower capacity point.
- **Data Box Disk**: Up to 35 TB usable capacity per order, consisting of five 7 TB SSDs. Suitable for smaller offline transfers.

For all Data Box options, plan for the order-to-delivery lead time and the time required for data copy to the device, shipping, and hydration into your Azure storage account.

Learn more: [Data Box overview](/azure/databox/data-box-overview)

## Hybrid: seed and sync

For very large data estates with ongoing changes, a hybrid approach combines the strengths of offline and online migration. This approach involves three phases:

1. **Seed**: Use Azure Data Box to transfer the bulk of your data to Azure. This avoids saturating your network for weeks or months.
2. **Sync**: Once the Data Box data is hydrated into your storage account, use Azure Storage Mover or Azure File Sync to perform incremental delta synchronizations over the network.
3. **Cutover**: After successive delta passes reduce the remaining changes to a manageable size, perform the final sync and cutover with minimal downtime.

This approach is especially effective when the initial data volume would take weeks to transfer online, but the daily change rate is small enough to synchronize over available bandwidth.

## Tape libraries

Tape libraries often prevent a full data center exit, making them a poor long-term option. However, data on tapes is often required for legal reasons. It may also be valuable data that needs to be preserved but can't be stored cheaply on-premises. This data may also be valuable for AI training or analytics workloads.

To learn more about migrating tape libraries to Azure, see [TapeArk](https://www.tapeark.com/partners/microsoft-azure/).

## Data lakes

Data lake migrations have their own complexities due to data gravity and require specialized solutions like [Cirata Data Migrator](https://aka.ms/cirataoffer).

Key considerations for data lake migrations:
- **ACL and permissions migration**: Data lakes often rely on fine-grained POSIX ACLs. Verify that your migration tool preserves these permissions when moving to ADLS Gen2.
- **Metadata and partition structure**: Hive-style partitioning, folder hierarchies, and custom metadata must be preserved to avoid breaking downstream analytics pipelines.
- **Cirata Data Migrator**: Provides live migration of data lakes with full fidelity, including ACLs, metadata, and partition structures, without requiring application downtime or changes to existing pipelines.

Learn more: [Cirata Data Migrator for Azure](https://aka.ms/cirataoffer)

## Application-aware vs. storage-level migration

Not all data should be migrated at the storage level. For some workloads, an application-level migration is more appropriate:

- **Storage-level migration** (file and blob copy): Best for file shares, unstructured data, and blob storage where the data can be copied independently of the application. Tools like Azure Storage Mover, Azure File Sync, and AzCopy operate at this level.
- **Application-level migration**: Required when data is managed by an application that maintains its own consistency guarantees. Examples include database backup and restore, SQL replication, and application-specific export/import tools.

> [!TIP]
> If an application writes to a file share or blob container but manages internal consistency (for example, transaction logs, write-ahead logs), coordinate the migration with the application owner. A raw file copy during active writes can result in inconsistent data on the target.

Identify which workloads in your estate need application-aware migration early in the planning process to avoid data integrity issues later.

With your migration strategy selected, the next step is to assess the tools and network bandwidth available to support it.