## Azure storage redundancy

### What is Azure storage redundancy?

Azure Storage provides several redundancy options that can help ensure your data is available. When choosing a redundancy option for storage, consider the following:

- How your data is replicated in the primary region that hosts your apps

- Whether your data is replicated to a second region that's geographically distant to help protect against regional disasters

- Whether your apps require read access to replicated data if the primary region is unavailable

Redundancy in the primary region can be provided as follows:

- Locally redundant storage (LRS). Helps protect your data against drive or server rack failures in a data center. But if a disaster occurs within the data center, all replicas of your storage account that uses LRS might be lost. This option:

	- Copies your data synchronously three times within a single physical location in the primary region.

	- Is the least expensive replication option.

	- Isn’t recommended for apps that require high availability or durability.

- Zone-redundant storage (ZRS). Helps ensure that your data is still accessible for both read and write operations even if a zone becomes unavailable. This option:

	- Copies your data synchronously across three Azure availability zones in the primary region.

	- For applications requiring high availability, Microsoft recommends using ZRS in the primary region, and also replicating to a secondary region.

>[!NOTE]
> Each availability zone is a separate physical location with independent power, cooling, and networking.

LRS is the lowest-cost redundancy option and offers the least durability compared to other options. LRS protects your data against server rack and drive failures. However, if a disaster such as fire or flooding occurs within the data center, all replicas of a storage account using LRS may be lost or unrecoverable. To mitigate this risk, Microsoft recommends using [zone-redundant storage](/azure/storage/common/storage-redundancy) (ZRS), [geo-redundant storage](/azure/storage/common/storage-redundancy) (GRS), or [geo-zone-redundant storage](/azure/storage/common/storage-redundancy) (GZRS).

LRS is a good choice for the following scenarios:

1) If your application stores data that can be easily reconstructed if data loss occurs, you may opt for LRS.

2) If your application is restricted to replicating data only within a country or region due to data governance requirements, you may opt for LRS. In some cases, the paired regions across which the data is geo-replicated may be in another country or region. For more information on paired regions, visit [Azure regions](https://azure.microsoft.com/regions/).

For your apps that require high durability, you can create copies of your data in a secondary region. Redundancy in the secondary region can be provided as follows:

- Geo-redundant storage (GRS):

	- Copies your data synchronously three times within a single physical location in the primary region using LRS.

	- Copies your data asynchronously to a single physical location in the secondary region.

	- Copies your data synchronously three times within the secondary region using LRS.

- Geo-zone-redundant storage (GZRS):

	- Copies your data synchronously across three Azure availability zones in the primary region using ZRS.

	- Copies your data asynchronously to a single physical location in the secondary region.

	- Copies your data synchronously three times using LRS within the secondary region.

>[!IMPORTANT]
> The primary difference between GRS and GZRS is how data is replicated in the primary region. Within the secondary region, data is always replicated synchronously three times using LRS. LRS in the secondary region protects your data against hardware failures.

With both GRS and GZRS, your data in the secondary region isn't available for read/write access unless there's a failover to the secondary region. To enable read access to the secondary region, configure your storage account to use one of the following:

- Read-access geo-redundant storage (RA-GRS).

- Read-access geo-zone-redundant storage (RA-GZRS)

### Summary of storage redundancy options

The following table summarizes the redundancy options discussed and indicates whether your data is durable and available in each scenario.

| **Outage scenario**| **LRS**| **ZRS**| **GRS/RA-GRS**| **GZRS/RA-GZRS** |
| - | -| - | - | -|
| A node within a data center becomes unavailable| Yes| Yes| Yes| Yes |
| An entire data center (zonal or non-zonal) becomes unavailable| No| Yes| Yes*| Yes |
| A region-wide outage occurs in the primary region| No| No| Yes*| Yes* |
| Read access to the secondary region is available if the primary region becomes unavailable| No| No| Yes (with RA-GRS)| Yes (with RA-GZRS) |


>[!IMPORTANT]
> Account failover is required to restore write availability if the primary region becomes unavailable.

 

 

When deciding which redundancy option is best for your scenario, consider the tradeoffs between lower costs and higher availability. The factors that help determine which redundancy option you should choose include:

- How your data is replicated in the primary region

- Whether your data is replicated to a second region that is geographically distant to the primary region, to protect against regional disasters

- Whether your application requires read access to the replicated data in the secondary region if the primary region becomes unavailable for any reason

## Data Lake Storage redundancy

Azure Storage is scalable by design whether you access via Data Lake Storage Gen2 or Blob storage interfaces. It is able to store and serve many exabytes of data. This amount of storage is available with throughput measured in gigabits per second (Gbps) at high levels of input/output operations per second (IOPS). Processing is executed at near-constant per-request latencies that are measured at the service, account, and file levels.

Because Data Lake Storage Gen2 is built on top of Azure Blob Storage, multiple concepts can describe the same, shared things.

The following are the equivalent entities, as described by different concepts. Unless specified otherwise these entities are directly synonymous:

| **Concept**| **Top Level Organization**| **Lower Level Organization**| **Data Container** |
| - | - | - | - |
| Blobs – General purpose object storage| Container| Virtual directory (SDK only – does not provide atomic manipulation)| Blob |
| Azure Data Lake Storage Gen2 – Analytics Storage| Container| Directory| File |