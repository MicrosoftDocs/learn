

Azure Storage offers several storage account options. Each [storage account](/azure/storage/common/storage-account-overview) supports different features and has its own pricing model.

### Things to know about storage account types

Review the following options and think about what storage accounts are required to support your applications.

| Storage&nbsp;account| Supported&nbsp;services| Recommended usage |
| --- | --- | ---|
| [**Standard** __general-purpose v2__](/azure/storage/common/storage-account-upgrade)| Blob Storage (including Data Lake Storage), Queue Storage, Table Storage, and Azure Files | Standard storage account for most scenarios, including blobs, file shares, queues, tables, and disks (page blobs). |
| [**Premium** __block blobs__](/azure/storage/blobs/storage-blob-block-blob-premium)| Blob Storage (including Data Lake Storage) | Premium storage account for block blobs and append blobs. Recommended for applications with high transaction rates. Use Premium block blobs if you work with smaller objects or require consistently low storage latency. This storage is designed to scale with your applications. |
| [**Premium** __file shares__](/azure/storage/files/storage-how-to-create-file-share)| Azure Files | Premium storage account for file shares only. Recommended for enterprise or high-performance scale applications. Use Premium file shares if you require support for both Server Message Block (SMB) and NFS file shares. |
| [**Premium** __page blobs__](/azure/storage/blobs/storage-blob-pageblob-overview)| Page blobs only | Premium high-performance storage account for page blobs only. Page blobs are ideal for storing index-based and sparse data structures, such as operating systems, data disks for virtual machines, and databases. |

> [!NOTE]
> All storage account types are encrypted by using Storage Service Encryption (SSE) for data at rest.