Azure Files offers fully managed file shares in the cloud. A file share is a network storage location that you can surface as local storage to your client operating system. Azure Files supports two industry-standard file-sharing protocols: Server Message Block (SMB) and Network File System (NFS). You can use SMB with Windows, Linux, and macOS clients. You can use NFS with Linux and macOS clients. Azure Files also has a REST API (application programming interface).

You can mount Azure file shares concurrently on cloud or on-premises deployments.

## Key features of Azure Files

- Azure Files makes it easy to move all your on-premises files and applications to the cloud and allows you to effectively manage your files in the cloud.

- Azure Files makes it easy to "lift and shift" applications to the cloud that expect a file share to store application or user data.

- Azure Files offers multiple tiers that you can select based on your budget and performance needs.

- You can use Azure file shares as persistent volumes for stateful containers. For the containers that access raw data at every start, a shared file system is required to allow these containers to access the file system no matter which instance they run on.

## Types of Azure file shares

Azure offers two types of file shares: **standard** and **premium**.

There are key differences between premium and standard file shares:  

- The premium tier stores data on modern solid-state drives (SSDs), while the standard tier uses hard disk drives (HDDs).
- You can use standard file shares with SMB and REST protocols only, while you can use premium file shares with SMB, NFS, and REST protocols.
- You can easily switch between hot, cool, and transaction-optimized tiers of standard file shares, but you can't switch from premium file shares to any of the standard tiers.

The following table helps you to better understand each of the tiers.

| Share type | Tier | Description |
|---|---|---|
| **Premium (SSD)** | Premium | Premium file shares enable highly I/O-intensive workloads with high throughput and low latency. Premium file shares require a FileStorage storage account kind and are only available in a provisioned billing model. |
| **Standard (HDD)** | Transaction optimized | Transaction-optimized file shares enable transaction-heavy workloads that don't need the consistently low latency premium file shares offer. Transaction-optimized file shares are a great fit for applications that require file storage or for backend storage. |
| **Standard (HDD)** | Hot | Hot file shares are optimized for general-purpose file-sharing scenarios such as team shares. |
| **Standard (HDD)** | Cool | Cool file shares offer cost-efficient storage optimized for online archive storage scenarios. This tier is the best for data at rest. |

## Billing

Azure Files offers the following billing models:  

- **Provisioned model**: Using a provisioned model for storage is like buying an on-premises storage solution. When you provision an Azure file share with a certain amount of storage capacity, you pay for that storage capacity regardless of whether you use it or not. Throughput and IOPS (input/output per second) costs are included in the provisioned storage amount, which means you're paying for capacity and performance upfront.

- **Pay-as-you-go model**: In the pay-as-you-go model, you pay for what you use. Throughput and IOPS costs aren't included in the storage amount. You pay for the amount of data stored and pay transaction costs based on your usage of that data. The pay-as-you-go model for Azure Files is only available for standard (HDD) file shares.

## Redundancy

Data in an Azure Storage account is always replicated three times in the primary region. For standard file shares, you can choose from the following redundancy options to specify how and where the copies are geographically stored. Premium file shares are only universally available with LRS (locally redundant storage), with ZRS (zone-redundant storage) available in some regions.

- **Locally redundant storage (LRS)** copies your data synchronously three times within a single physical location in the primary region. LRS is the least expensive replication option, but it isn't recommended for applications requiring high availability or durability.

- **Zone-redundant storage (ZRS)** copies your data synchronously across three Azure availability zones in the primary region. For applications that require high availability, we recommend using ZRS in the primary region while also replicating to a secondary region.

- **Geo-redundant storage (GRS)** copies your data synchronously three times within a single physical location in the primary region using LRS. It then copies your data asynchronously to a single physical location in the secondary region. Within the secondary region, your data is copied synchronously three times using LRS, for a total of six copies of your data.

- **Geo-zone-redundant storage (GZRS)** copies your data synchronously across three Azure availability zones in the primary region using ZRS. It then copies your data asynchronously to a single physical location in the secondary region. Within the secondary region, your data is copied synchronously three times using LRS, for a total of six copies of your data.

The following table illustrates the types of Azure redundancy available for each of the tiers.

| Share type | Tier | Supported Redundancy |
|---|---|---|
| **Premium (SSD)** | Premium | LRS, ZRS |
| **Standard (HDD)** | Transaction optimized | LRS, ZRS, GRS, GZRS |
| **Standard (HDD)** | Hot | LRS, ZRS, GRS, GZRS |
| **Standard (HDD)** | Cool | LRS, ZRS, GRS, GZRS |
