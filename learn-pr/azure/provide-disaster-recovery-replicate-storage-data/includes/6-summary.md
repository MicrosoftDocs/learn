Your company was using zone-redundant storage (ZRS) to replicate its music data across multiple availability zones in a single region. You explored other redundancy options that protect from region-wide outage. You investigated the different replication types for Azure Storage. Also, you learned how to change the replication type from ZRS to geo-zone-redundant storage (GZRS) for increased availability.

ZRS doesn't protect you from region-wide failure. Without GZRS, your company's data wouldn't be accessible if the region failed. Your company's customer satisfaction could be adversely affected. GZRS protects your company's data even if the primary region has failed. GZRS has improved the availability of your company's music data. Your company is now in a better position to maintain consumer satisfaction, and keep its customer base.

[!include[](../../../includes/azure-sandbox-cleanup.md)]

## Learn more

- [What is Azure Blob storage?](https://docs.microsoft.com/azure/storage/blobs/storage-blobs-overview)
- [Create a storage account](https://docs.microsoft.com/azure/storage/common/storage-quickstart-create-account?tabs=azure-portal)
- [Azure Storage redundancy](https://docs.microsoft.com/azure/storage/common/storage-redundancy)