Your company was using zone-redundant storage (ZRS) to replicate its music data across multiple availability zones in a single region. You explored other redundancy options that protect from region-wide outage. You investigated the different replication types for Azure Storage. Also, you learned how to change the replication type from ZRS to geo-zone-redundant storage (GZRS) for increased availability.

ZRS doesn't protect you from region-wide failure. Without GZRS, your company's data wouldn't be accessible if the region failed. Your company's customer satisfaction could be adversely affected. GZRS protects your company's data even if the primary region has failed. GZRS has improved the availability of your company's music data. Your company is now in a better position to maintain consumer satisfaction, and keep its customer base.

[!include[](../../../includes/azure-sandbox-cleanup.md)]

## Learn more

- [Azure Storage redundancy](https://docs.microsoft.com/azure/storage/common/storage-redundancy)
- [Change how a storage account is replicated](https://docs.microsoft.com/azure/storage/common/redundancy-migration?tabs=portal)
- [Choose the right region for you](https://azure.microsoft.com/global-infrastructure/geographies/)