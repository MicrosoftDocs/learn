Azure Storage always stores multiple copies of your data. This redundancy ensures the data is protected from planned and unplanned events. These events can include transient hardware failures, network or power outages, and massive natural disasters. [Storage redundancy](/azure/storage/common/storage-redundancy) ensures that your storage account meets its availability and durability targets.

When deciding which redundancy option is best for your scenario, consider the tradeoffs between lower costs and higher availability. The factors that help determine which redundancy option you should choose include:

•	How your data is replicated in the primary region.

•	Whether your data is replicated to a second region. The secondary region is geographically distant to the primary region. This helps to protect against regional disasters.

•	Whether your application requires read access to the replicated data in the secondary region if the primary region becomes unavailable for any reason.

#### Redundancy in the primary region

Azure Storage offers two options for how your data is replicated in the primary region.

:::image type="content" source="../media/data-redundancy.png" alt-text="LRS has three copies in the data center. ZRS has three copies in different data centers.":::

**Locally redundant storage (LRS)** is the lowest-cost redundancy option and offers the least durability compared to other options. LRS protects your data against server rack and drive failures. However, if the data center fails, all replicas of a storage account using LRS may be lost or unrecoverable. LRS is a good choice for the following scenarios:

•	If your application stores data that can be easily reconstructed if data loss occurs.

•	If your application is restricted to replicating data only within a country or region due to data governance requirements. 

**Zone-redundant storage (ZRS)** replicates synchronously across three Azure availability zones in the primary region. With ZRS, your data is still accessible for both read and write operations even if a zone becomes unavailable. ZRS provides excellent performance, low latency, and resiliency for your data if it becomes temporarily unavailable. However, ZRS by itself may not protect your data against a regional disaster where multiple zones are permanently affected.

#### Redundancy in a secondary region

For applications requiring high durability, you can choose to copy the data in your storage account to a secondary region. When you create a storage account, you select the primary region for the account. The paired secondary region is determined based on the primary region and can't be changed. Azure Storage offers two options for copying your data to a secondary region: Geo-redundant storage (GRS), and Geo-zone-redundant storage (GZRS).

:::image type="content" source="../media/geo-redundant-storage.png" alt-text="LRS and ZRS replicated to the secondary region.":::

•	The primary difference between GRS and GZRS is how data is replicated in the primary region.  Within the secondary region, data is always replicated synchronously with LRS.

•	If the primary region becomes unavailable, you can choose to fail over to the secondary region. After the failover has completed, the secondary region becomes the primary region, and you can again read and write data.

•	Data is replicated to the secondary region asynchronously A failure that affects the primary region may result in data loss if the primary region cannot be recovered.

•	With GRS or GZRS, the data in the secondary region isn't available for read or write access unless there is a failover to the secondary region. For read access to the secondary region, configure your storage account to use read-access geo-redundant storage (RA-GRS) or read-access geo-zone-redundant storage (RA-GZRS).

> [!TIP]
> If your storage account is configured for read access to the secondary region, then you can design your applications to seamlessly shift to reading data from the secondary region if the primary region becomes unavailable for any reason.