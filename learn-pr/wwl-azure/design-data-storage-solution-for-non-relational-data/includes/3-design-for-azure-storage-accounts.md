Once you’ve determined your data storage requirements, you need to create storage accounts. An [Azure storage account](/azure/storage/common/storage-account-overview) group together all the Azure Storage services you need. The storage account provides a unique namespace that's accessible from anywhere (assuming you have the correct permissions) in the world over HTTPS. Data in your storage account is durable and highly available, secure, and massively scalable.

### Select the appropriate storage account kind

Azure Storage offers several kinds of storage accounts. Each kind supports different features and has its own pricing model. Consider these differences to determine the kind of account that is best for your applications. The [types of storage accounts](/azure/storage/common/storage-account-overview) are:

| Storage Account| Supported Services| Recommended usage |
| - | - | -|
| [Standard general-purpose v2](/azure/storage/common/storage-account-upgrade?tabs=azure-portal)| Blob (including Data Lake Storage), Queue, and Table storage, Azure Files| Supports all the storage services: Blob, Azure Files, Queue, Disk (Page Blob), and Table. |
| [Premium block blobs](https://azure.microsoft.com/blog/azure-premium-block-blob-storage-is-now-generally-available/)| Blob storage (including Data Lake Storage)| Premium block blobs are ideal for applications that require high transaction rates. Also ideal for situations that use smaller objects or require consistently low storage latency. This storage is designed to scale with your applications. |
| [Premium file shares](/azure/storage/files/storage-how-to-create-file-share?tabs=azure-portal)| Azure Files| Recommended for enterprise or high-performance scale applications. Use Premium file shares if you need a storage account that supports both SMB and NFS file shares. |
| [Premium page blobs](/azure/storage/blobs/storage-blob-pageblob-overview?tabs=dotnet)| Page blobs only| Premium high-performance page blob scenarios. Page blobs are ideal for storing index-based and sparse data structures like OS and data disks for virtual machines and databases. |


 

### Determine the number of storage accounts

A storage account represents a collection of settings like location, replication strategy, and subscription owner. Organizations often have multiple storage accounts so they can implement different sets of requirements. The following illustration shows two storage accounts that differ in one setting. That one difference is enough to require separate storage accounts.

:::image type="content" source="../media/storage-considerations.png" alt-text="Storage account considerations like location, compliance, cost, replication, and admin.":::


### Considerations when deciding how many storage accounts to create

- **Location**. Do you have data that is specific to a country or region? For performance reasons, you might want to locate the data close to your users. You may need one storage account for each location.

- **Compliance**. Does your company have regulatory guidelines for keeping data in a specific location? Does your company have internal requirements for auditing or storing data?

- **Cost**. A storage account by itself has no financial cost; however, the settings you choose for the account do influence the cost of services in the account. Geo-redundant storage costs more than locally redundant storage. Premium performance and the hot access tier increase the cost of blobs. Do you need to keep track of expenses or billing by department or project? Are you working with partners where storage costs need to be separated?

- **Replication**. Does your data storage have different replication strategies? For example, you could partition your data into critical and non-critical categories. You could place your critical data into a storage account with geo-redundant storage. You could put your non-critical data in a different storage account with locally redundant storage.

- **Administrative overhead**. Each storage account requires some time and attention from an administrator to create and maintain. It also increases complexity for anyone who adds data to your cloud storage. Everyone in this role needs to understand the purpose of each storage account so they add new data to the correct account.

- **Data sensitivity**. Do you have some data that is proprietary and some for public consumption? If so, you could enable virtual networks for the proprietary data and not for the public data. This may require separate storage accounts.

- **Data isolation**. Regulatory, compliance, or local policies may require data to be segregated. Perhaps data from one application should be separated from data in another application?

> [!TIP]
> Take a few minutes to think about your organization’s storage accounts. Are the storage accounts already in place? Would you make any changes? What type of storage accounts will you need, and why?