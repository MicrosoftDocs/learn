After migration, consider these optimizations to get the most from Azure Storage:

## Discovery

Turn on Azure Storage Discovery. Storage Discovery collects valuable metrics to optimize your storage workload based on data. This data can't be generated retrospectively, so turn it on as early as possible to generate insights to right-size storage and assign proper actions at the object level.

Learn more: [What is Azure Storage Discovery?](/azure/storage-discovery/overview)

## High availability

Plan and prepare to protect your data from disastrous events. These can be natural disasters, man-made disasters, or fraudulent attacks like malware. Understand your requirements and choose a solution that meets your objectives.

Understand what you're protecting against: high availability ensures that data is available to your workloads with minimum interruption in case of an isolated system failure. However, it also replicates accidental or malicious changes, so it doesn't protect against those attacks.

Learn more: [Data redundancy in Azure Storage](/azure/storage/common/storage-redundancy)

## Disaster, replication, and malware protection

Disaster recovery is usually meant to protect from disasters like the loss of an entire data center or region, or a major error such as accidental deletion of files. In the past, the primary protection was storing data in an offsite backup. Today, recovering from an offsite backup is considered too slow, given the impact that major attacks across multiple systems can have.

Azure offers multiple mechanisms to help you protect from these events. These range from operational and vaulted backups to object versioning, immutability, and replication.

Learn more:
- [About Azure Files backup](/azure/backup/azure-file-share-backup-overview)
- [Overview of Azure Blobs backup](/azure/backup/blob-backup-overview)
- [Immutable storage for blob data](/azure/storage/blobs/immutable-storage-overview)
- [Blob versioning](/azure/storage/blobs/versioning-overview)

## Modernization

After moving storage to Azure, modernize to get the most from the cloud. Modernization can cover many aspects. While it's hard to modernize access patterns for manually stored files on Azure Files, it can have a big impact on managing automatically generated files. For example, if an application stores its files using NFS on Blob initially, switching to the Blob API and automatically cooling objects after a couple of weeks can reduce costs, because the likelihood of access decreases significantly. You can base this on metadata stored in an application's tracking database, or automate it using Storage Actions.

## Tiering (data cooling)

As described above, the likelihood of data being accessed drops rapidly after just a few days. Automatically cooling data can significantly reduce costs. However, you should analyze the use case over a reasonable time period. Some data can be cooled after just a few days and will hardly be accessed anymore (for example, an automated purchase order in a business-to-business integration scenario). In other cases, data should stay hot for a longer period and then be archived (for example, training data for neural networks is accessed often until the workload is successfully implemented, but then is rarely accessed for years, though it may be legally required to be archived).

Learn more: [Set Blob Tier REST API](/rest/api/storageservices/set-blob-tier?tabs=microsoft-entra-id)

> [!NOTE]
> Azure Files doesn't support cooling individual files.

## Housekeeping

A major contributor to storage costs is keeping stale data. Implement jobs to automatically purge data that's no longer needed. The best practice is to have the application that generated or tracks the data perform cleanup (for example, a legal archive system). You can also automate this using Storage Actions.
Learn more:
- [Delete Blob](/rest/api/storageservices/delete-blob)
- [Delete File REST API](/rest/api/storageservices/delete-file2)

## Storage actions

Storage Actions automates these actions on Azure Blob Storage based on policies.
Learn more: [What is Azure Storage Actions](/azure/storage-actions/overview)
