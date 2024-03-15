There are two main points to consider in an implementation plan for [Azure Blob Storage](/azure/storage/blobs/storage-blobs-overview). First, you need to identify which Azure _blob access tier_ satisfies your organization's storage availability, latency, and cost requirements. The second consideration is to decide if you need access to immutable storage.

There are four access options: Hot, Cool, Cold, and Archive access tiers. All four options support availability and latency, but they have differing costs depending on the level of support. All options also support immutable storage, but the storage is implemented differently for the Hot, Cool, and Archive access tiers.

The four access options for Azure Blob Storage offer a range of features and support levels to help you optimize your storage costs. 

| Comparison | Hot access tier | Cool access tier | Cold access tier | Archive access tier |
| --- | --- | --- | --- | ---|
| **Availability** | 99.9% | 99% | 99% | 99% |
| **Availability (RA-GRS reads)** | 99.99%  | 99.9% | 99.9% | 99.9%  |
| **Latency (time to first byte)** | milliseconds | milliseconds | milliseconds | hours |
| **Minimum storage duration** | N/A | 30 days | 90 days | 180 days |

### Things to know about Azure blob access tiers

Think about your data sets, and which access options can satisfy the requirements for Tailwind Traders.

#### Hot tier

The Hot tier is optimized for frequent reads and writes of objects in the Azure storage account. A good usage case is data that is actively being processed. By default, new storage accounts are created in the Hot tier. This tier has the lowest access costs, but higher storage costs than the Cool and Archive tiers. 

#### Cool tier

The Cool tier is optimized for storing large amounts of data that's infrequently accessed. This tier is intended for data that remains in the Cool tier for at least 30 days. A usage case for the Cool tier is short-term backup and disaster recovery datasets and older media content. This content shouldn't be viewed frequently, but it needs to be immediately available. Storing data in the Cool tier is more cost-effective. Accessing data in the Cool tier can be more expensive than accessing data in the Hot tier.

#### Cold tier

The Cold tier is also optimized for storing large amounts of data that's infrequently accessed. This tier is intended for data that can remain in the tier for at least 90 days. 

#### Archive tier

The Archive tier is an offline tier that's optimized for data that can tolerate several hours of retrieval latency. Data must remain in the Archive tier for at least 180 days or be subject to an early deletion charge. Data for the Archive tier includes secondary backups, original raw data, and legally required compliance information. This tier is the most cost-effective option for storing data. Accessing data is more expensive in the Archive tier than accessing data in the other tiers. 

### Things to know about Azure Blob immutable storage

[Immutable storage](/azure/storage/blobs/immutable-storage-overview) for Azure Blob Storage enables users to store business-critical data in a WORM (Write Once, Read Many) state. While in a WORM state, data can't be modified or deleted for a user-specified interval. By configuring immutability policies for blob data, you can protect your data from overwrites and deletes. Policies are applied at the container level and audit logs are available. 

:::image type="content" source="../media/container-policies.png" alt-text="Diagram that shows policies applied at the container level." border="false":::

Azure Blob Storage supports two forms of immutability policies for implementing immutable storage:

- **[Time-based retention policies](/azure/storage/blobs/immutable-time-based-retention-policy-overview)** let users set policies to store data for a specified interval. When a time-based retention policy is in place, objects can be created and read, but not modified or deleted. After the retention period has expired, objects can be deleted, but not overwritten. The Hot, Cool, and Archive access tiers support immutable storage by using time-retention policies.

- **[Legal hold policies](/azure/storage/blobs/immutable-legal-hold-overview)** store immutable data until the legal hold is explicitly cleared. When a legal hold is set, objects can be created and read, but not modified or deleted. Premium Blob Storage uses legal holds to support immutable storage.

The following diagram shows how time-based retention policies and legal holds prevent write and delete operations.

:::image type="content" source="../media/legal-hold.png" alt-text="Diagram shows time-based retention policies versus legal holds." border="false":::

### Things to consider when implementing Azure Blob Storage

You've reviewed the different access options for Azure Blob Storage, and how to use immutable storage. Take a few minutes to determine how you can configure Azure Blob Storage for Tailwind Traders.

- **Consider Blob Storage availability**. Determine the level of availability required for your data. Are there scenarios where offline data is sufficient? The Archive access tier is optimized for data that can remain offline for hours.

- **Consider Blob Storage latency**. Plan for the required time to access the first byte of data in different scenarios. Some work tasks require instant access to data, while others can accommodate some delay. Premium Blob Storage supports single-digit millisecond latency for data, while the Hot and Cool access tiers support latency in milliseconds.

- **Consider Blob Storage costs**. Weigh your options for total cost. Factor in data storage minimum durations, and potential charges for transactions and access. Premium Blob Storage and the Hot access tier have higher overall storage costs, but lower charges for access and transactions. The Cool and Archive access tiers offer lower storage costs, but tend to have higher charges for access and transactions.

- **Consider immutable storage**. Review your business scenarios to identify where you might need immutable storage. Consider the different types immutability policies and which form satisfies your organization's requirements.