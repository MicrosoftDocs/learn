
Azure Storage supports several access tiers for blob data, including Hot, Cool, and Archive. Each access tier is optimized to support a particular pattern of data usage.

### Things to know about blob access tiers

Let's examine characteristics of the blob access tiers.

#### Hot tier

The Hot tier is optimized for frequent reads and writes of objects in the Azure storage account. A good usage case is data that is actively being processed. By default, new storage accounts are created in the Hot tier. This tier has the lowest access costs, but higher storage costs than the Cool and Archive tiers. 

#### Cool tier

The Cool tier is optimized for storing large amounts of data that's infrequently accessed. This tier is intended for data that remains in the Cool tier for at least 30 days. A usage case for the Cool tier is short-term backup and disaster recovery datasets and older media content. This content shouldn't be viewed frequently, but it needs to be immediately available. Storing data in the Cool tier is more cost-effective. Accessing data in the Cool tier can be more expensive than accessing data in the Hot tier.

#### Archive tier

The Archive tier is an offline tier that's optimized for data that can tolerate several hours of retrieval latency. Data must remain in the Archive tier for at least 180 days or be subject to an early deletion charge. Data for the Archive tier includes secondary backups, original raw data, and legally required compliance information. This tier is the most cost-effective option for storing data. Accessing data is more expensive in the Archive tier than accessing data in the other tiers. 

### Compare access tiers

The access options for Azure Blob Storage offer a range of features and support levels to help you optimize your storage costs. As you compare the features and support, think about which access options can best support your application needs.

| Compare | Hot tier | Cool tier | Archive tier |
| --- | --- | --- | --- | ---|
| **Availability** | 99.9% | 99% | Offline |
| **Availability (RA-GRS reads)** | 99.99% | 99.9% | Offline |
| **Latency (time to first byte)** | milliseconds | milliseconds | hours |
| **Minimum storage duration** |  N/A | 30 days | 180 days |
| **Usage costs** | Higher storage costs, Lower access & transaction costs | Lower storage costs, Higher access & transaction costs | Lowest storage costs, Highest access & transaction costs |

### Configure the blob access tier

In the Azure portal, you can select the blob access tier for your Azure storage account. You can also change the blob access tier for your account at any time. By selecting the correct access tier for your needs, you can store your blob data in the most cost-effective manner.