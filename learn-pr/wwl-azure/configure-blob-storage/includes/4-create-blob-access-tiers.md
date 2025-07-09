Azure Storage supports several [access tiers](/azure/storage/blobs/access-tiers-overview) for blob data. These tiers include Hot, Cool, Cold, and Archive. Each access tier is optimized to support a particular pattern of data usage.

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=eb34696d-bdbd-4892-a2e9-6f0e1c46904b]

### Things to know about blob access tiers

Let's examine characteristics of the blob access tiers.

#### Hot tier

The Hot tier is optimized for frequent reads and writes of objects in the Azure storage account. A good usage case is data that is actively being processed. An online tier optimized for storing data that is accessed or modified frequently. The hot tier has the highest storage costs, but the lowest access costs.

#### Cool tier

The Cool tier is optimized for storing large amounts of infrequently accessed data. This tier is intended for data that remains in the Cool tier for at least 30 days. A usage case for the Cool tier is short-term backup and disaster recovery datasets and older media content. This content shouldn't be viewed frequently, but it needs to be immediately available. Storing data in the Cool tier is more cost-effective. The cool tier has lower storage costs and higher access costs compared to the hot tier.

#### Cold tier

The Cold tier is also optimized for storing large amounts of infrequently accessed data. This tier is intended for data that can remain in the tier for at least 90 days. The cold tier has lower storage costs and higher access costs compared to the cool tier.

#### Archive tier

The Archive tier is an offline tier that's optimized for data that can tolerate several hours of retrieval latency. Data must remain in the Archive tier for at least 180 days or be subject to an early deletion charge. Data for the Archive tier includes secondary backups, original raw data, and legally required compliance information. This tier is the most cost-effective option for storing data. Accessing data is more expensive in the Archive tier than accessing data in the other tiers. 

An archive tier doesn't allow you to read or modify the content of a blob directly. However, you do have access to its metadata, including index tags. To access the blob's content, you can assign it to the hot, cool, or cold tier to trigger the process referred to as rehydration.

### Compare access tiers

The access options for Azure Blob Storage offer a range of features and support levels to help you optimize your storage costs. As you compare the features and support, think about which access options can best support your application needs.

| Comparison | Hot access tier | Cool access tier | Cold access tier | Archive access tier |
| --- | --- | --- | --- | ---|
| **Availability** | 99.9% | 99% | 99% | 99% |
| **Availability (RA-GRS reads)** | 99.99%  | 99.9% | 99.9% | 99.9%  |
| **Latency (time to first byte)** | milliseconds | milliseconds | milliseconds | hours |
| **Minimum storage duration** | N/A | 30 days | 90 days | 180 days |


