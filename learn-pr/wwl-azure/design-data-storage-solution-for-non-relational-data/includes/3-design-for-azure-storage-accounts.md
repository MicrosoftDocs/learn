

After you determine the data storage requirements for your organization, you need to create storage accounts for Tailwind Traders.

An [Azure storage account](/azure/storage/common/storage-account-overview?azure-portal=true) groups together all of your Azure Storage services. The storage account provides a unique namespace that's accessible from anywhere (assuming you have the correct permissions) in the world over HTTPS. Data in your storage account is durable and highly available, secure, and massively scalable.

A storage account represents a collection of settings like location, replication strategy, and subscription owner. Organizations often have multiple storage accounts so they can implement different sets of requirements. The following illustration shows two storage accounts in the Tailwind Traders organization that differ only in the data location (region). But, this one difference is enough to require separate storage accounts in the infrastructure.

:::image type="content" source="../media/storage-considerations.png" alt-text="Diagram showing storage account considerations like location, compliance, cost, replication, and administration." border="false":::

### Things to know about storage account types

Azure Storage offers several storage account options. Each [storage account](/azure/storage/common/storage-account-overview?azure-portal=true) supports different features and has its own pricing model. Review the following options and think about what storage accounts are required to support Tailwind Traders applications.

| Storage&nbsp;account| Supported&nbsp;services| Recommended usage |
| --- | --- | ---|
| [**Standard** __general-purpose v2__](/azure/storage/common/storage-account-upgrade?azure-portal=true)| Blob Storage (including Data Lake Storage), Queue Storage, Table Storage, and Azure Files | Standard storage account for most scenarios, including blobs, file shares, queues, tables, and disks (page blobs). |
| [**Premium** __block blobs__](/azure/storage/blobs/storage-blob-block-blob-premium/?azure-portal=true)| Blob Storage (including Data Lake Storage) | Premium storage account for block blobs and append blobs. Recommended for applications with high transaction rates. Use Premium block blobs if you work with smaller objects or require consistently low storage latency. This storage is designed to scale with your applications. |
| [**Premium** __file shares__](/azure/storage/files/storage-how-to-create-file-share?azure-portal=true)| Azure Files | Premium storage account for file shares only. Recommended for enterprise or high-performance scale applications. Use Premium file shares if you require support for both Server Message Block (SMB) and NFS file shares. |
| [**Premium** __page blobs__](/azure/storage/blobs/storage-blob-pageblob-overview?azure-portal=true)| Page blobs only | Premium high-performance storage account for page blobs only. Page blobs are ideal for storing index-based and sparse data structures, such as operating systems, data disks for virtual machines, and databases. |

### Things to consider when choosing storage accounts

You've reviewed Azure storage account options and some scenarios for when to use different types of storage accounts. Take a few minutes to think about the storage accounts in the Tailwind Traders organization. If you're already using storage accounts, explore how well the configuration meets the business scenarios.

- **Consider your storage locations**. Locate data storage close to where it's most frequently used to increase performance. Does Tailwind Traders have data that's specific to a country or region? You might need a storage account to best support each location.

- **Consider compliance requirements**. Examine regulatory guidelines for Tailwind Traders business scenarios. Are there guidelines for keeping data in a specific location? Does your company have internal requirements for auditing or storing data? You might require different storage accounts to meet the different requirements.

- **Consider data storage costs**. Factor in data storage costs into your plan for Tailwind Traders. A storage account by itself has no financial cost. But, the settings you choose for the account do influence the cost of services in the account. Geo-redundant storage costs more than locally redundant storage. Premium performance and the hot access tier increase the cost of blobs. Do you need to keep track of expenses or billing by department or project? Are you working with partners where storage costs need to be separated? By creating multiple storage accounts, you can better control the overall costs.

- **Consider replication scenarios**. Configure data storage to support different replication strategies. You could partition your data into critical and non-critical categories. You could place Tailwind Traders critical data into a storage account with geo-redundant storage. You could put Tailwind Traders non-critical data in a different storage account with locally redundant storage.

- **Consider administrative overhead**. Plan for administrative overhead in your Tailwind Traders storage design. Each storage account requires some time and attention from an administrator to create and maintain. Using multiple storage accounts increases the complexity for users who add data to your cloud storage. Users in this role need to understand the purpose of each storage account to ensure they add new data to the correct account.

- **Consider data sensitivity**. Protect sensitive and proprietary Tailwind Traders data in your data storage. You can enable virtual networks for proprietary data and not for public data. This scenario might require separate storage accounts.

- **Consider data isolation**. Segregate regulatory and compliance data, or local policies by using multiple storage accounts for Tailwind Traders. You can separate data in one application from data in another application to ensure data isolation.