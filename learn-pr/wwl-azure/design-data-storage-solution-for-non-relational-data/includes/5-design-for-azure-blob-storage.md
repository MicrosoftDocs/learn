When designing [blob storage](/azure/storage/blobs/storage-blobs-overview), there are two main areas we’ll highlight. The first is determining the blob access tier. Blob storage type affects storage availability, latency, and cost. The second area is deciding if immutable storage is needed. 

| **Availability, Latency, and Cost**| **Immutable Storage** |
| - | - |
| Premium blob storage | Legal hold policies |
| Hot, cool, and archive access tiers | Time-based retention policies |
### Determine the Azure blob access tier

Optimize storage costs by placing your data in the appropriate access tier. 

| **Feature**| **Premium**| **Hot tier**| **Cool tier**| **Archive tier** |
| - | - | - | - | -|
| Availability| 99.9%| 99.9%| 99%| Offline |
| Availability (RA-GRS reads)| N/A| 99.99%| 99.9%| Offline |
| Usage charges| Higher storage costs, lower access, and transaction cost| Higher storage costs, lower access, and transaction costs| Lower storage costs, higher access, and transaction costs| Lowest storage costs, highest access, and transaction costs |
| Minimum storage duration| N/A| N/A| 30 days| 180 days |
| Latency (time to first byte)| Single-digit milliseconds| milliseconds| milliseconds| hours |


 

- **Premium blob storage.** The [premium blob storage account types](/azure/storage/blobs/storage-blob-performance-tiers) are best suited for I/O intensive workloads that require low and consistent storage latency. Premium blob storage uses solid-state drives (SSDs) for fast and consistent response times. This storage is best for workloads that perform many small transactions. An example would be a mapping app that requires frequent and fast updates. 

- **Hot access tier**. By default, new storage accounts are created in the hot access tier. The hot tier is optimized for frequent reads and writes of objects in the storage account. The hot tier has higher storage costs than cool and archive tiers, but the lowest access costs. A good usage case is data that is actively being processed. 

- **Cool access tier**. The cool access tier is optimized for storing large amounts of data that is infrequently accessed. This tier is intended for data that will remain in the cool tier for at least 30 days. The cool access tier has lower storage costs and higher access costs compared to hot storage. A usage case for the cool access tier is short-term backup and disaster recovery datasets and older media content. This content wouldn’t be viewed frequently but must be available immediately.

- **Archive access tier**. The [archive access tier](/azure/storage/blobs/access-tiers-overview#archive-access-tier) is optimized for data that can tolerate several hours of retrieval latency. Data must remain in the archive tier for at least 180 days or be subject to an early deletion charge. The archive tier is the most cost-effective option for storing data. But, accessing that data is more expensive than accessing data in the other tiers. Data for the archive tier includes secondary backups, original raw data, and legally required compliance information.

 

> [!TIP]
> Take a few minutes to determine the data sets and access tiers your organization will need. How did you decide on the access tier? How will you manage the data sets?

 

### Determine requirements for Azure blob immutable storage

 

[Immutable storage](/azure/storage/blobs/immutable-storage-overview) for Azure Blob Storage enables users to store business-critical data in a WORM (Write Once, Read Many) state. While in a WORM state, data can’t be modified or deleted for a user-specified interval. By configuring immutability policies for blob data, you can protect your data from overwrites and deletes. Policies are applied at the container level and audit logs are available. 

:::image type="content" source="../media/container-policies.png" alt-text="Policies are applied at the container level.":::


The next diagram shows how time-based retention policies and legal holds prevent write and delete operations.

:::image type="content" source="../media/legal-hold.png" alt-text="Locked time-based retention policy vs legal hold.":::


Immutable storage for Azure Blob storage supports two types of immutability policies.

- **Time-based retention policies**: With a [time-based retention policy](/azure/storage/blobs/immutable-time-based-retention-policy-overview), users can set policies to store data for a specified interval. When a time-based retention policy is in place, objects can be created and read, but not modified or deleted. After the retention period has expired, objects can be deleted but not overwritten.

- **Legal hold policies**: A [legal hold](/azure/storage/blobs/immutable-legal-hold-overview) stores immutable data until the legal hold is explicitly cleared. When a legal hold is set, objects can be created and read, but not modified or deleted. 

> [!TIP]
> Take a few minutes to determine if your organization will need immutable blob storage policies. Which data sets and policies would be most helpful?
