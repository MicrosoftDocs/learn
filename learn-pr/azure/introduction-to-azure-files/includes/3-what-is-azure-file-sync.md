Azure File Sync enables centralizing your organization's file shares in Azure Files, while keeping the flexibility, performance, and compatibility of a Windows file server. While some users might opt to keep a full copy of their data locally, Azure File Sync can turn Windows Server into a quick cache of your Azure file shares. You can use any protocol available on Windows Server to access your data locally, including SMB, NFS, and FTPS. You can have as many caches as you need across the world.

Common reasons customers use Azure File Sync: 

- Centralize file share backups in Azure to optimize cost and manageability.
- Free up on-premises storage capacity to avoid buying more storage.
- Maintain on-premises file share performance for frequently used files.
- Migrate on-premises file shares to Azure Files.
- Provide low latency, multi-site access for file shares.

## Types of Azure file shares

Azure offers two types of file shares: **standard** and **premium**.

There are key differences between premium and standard file shares:  

- The premium tier stores data on modern solid-state drives (SSDs), while the standard tier uses hard disk drives (HDDs).
- Standard file shares can be used with SMB and REST protocols only, while premium file shares can be used with SMB, NFS, and REST protocols.
- You can easily switch between hot, cool, and transaction optimized tiers of standard file shares, but you can't switch from premium file shares to any of the standard tiers.

The following table helps you to better understand each of the tiers.

| Share type | Tier | Description |
|---|---|---|
| **Premium (SSD)** | Premium | Premium file shares enable highly I/O-intensive workloads, with high throughput and low latency. Premium file shares require a FileStorage storage account kind and are only available in a provisioned billing model. |
| **Standard (HDD)** | Transaction optimized | Transaction optimized file shares enable transaction-heavy workloads that don't need the consistently low latency offered by premium file shares. Transaction optimized file shares are a great fit for applications that require file storage or for backend storage. |
| **Standard (HDD)** | Hot | Hot file shares are optimized for general purpose file sharing scenarios such as team shares. |
| **Standard (HDD)** | Cool | Cool file shares offer cost-efficient storage optimized for online archive storage scenarios. This tier is the best for data at rest. |

## Billing

Azure Files offers two billing models:  

- **Provisioned model**: Using a provisioned model for storage is like buying an on-premises storage solution. When you provision an Azure file share with a certain amount of storage capacity, you pay for that storage capacity regardless of whether you use it or not. Throughput and IOPS (input/output per second) costs are included in the provisioned storage amount, which means you're paying for capacity and performance upfront.

- **Pay-as-you-go model**: In the pay-as-you-go model, you pay for what you use. Throughput and IOPS costs aren't included in the storage amount. You pay for the amount of data stored, and pay transaction costs based on your usage of that data.

## Redundancy

Data in an Azure Storage account is always replicated three times in the primary region. For standard file shares, you can choose from the following redundancy options to specify how and where the copies are geographically stored. Premium file shares are only universally available with LRS (locally redundant storage), with ZRS (zone-redundant storage) available in some regions.

- **Locally redundant storage (LRS)** copies your data synchronously three times within a single physical location in the primary region. LRS is the least expensive replication option, but it isn't recommended for applications requiring high availability or durability.

- **Zone-redundant storage (ZRS)** copies your data synchronously across three Azure availability zones in the primary region. For applications requiring high availability, we recommend using ZRS in the primary region while also replicating to a secondary region.

- **Geo-redundant storage (GRS)** copies your data synchronously three times within a single physical location in the primary region using LRS. It then copies your data asynchronously to a single physical location in the secondary region. Within the secondary region, your data is copied synchronously three times using LRS, for a total of six copies of your data.

- **Geo-zone-redundant storage (GZRS)** copies your data synchronously across three Azure availability zones in the primary region using ZRS. It then copies your data asynchronously to a single physical location in the secondary region. Within the secondary region, your data is copied synchronously three times using LRS, for a total of six copies of your data.

The following table illustrates the types of Azure redundancy available for each of the tiers.

| Share type | Tier | Supported Redundancy |
|---|---|---|
| **Premium (SSD)** | Premium | LRS, ZRS |
| **Standard (HDD)** | Transaction optimized | LRS, ZRS, GRS, GZRS |
| **Standard (HDD)** | Hot | LRS, ZRS, GRS, GZRS |
| **Standard (HDD)** | Cool | LRS, ZRS, GRS, GZRS |
