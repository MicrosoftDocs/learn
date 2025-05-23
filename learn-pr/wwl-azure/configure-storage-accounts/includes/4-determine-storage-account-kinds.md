General purpose Azure storage accounts have two basic [types](/azure/storage/common/storage-account-overview?toc=%2Fazure%2Fstorage%2Fblobs%2Ftoc.json#types-of-storage-accounts): Standard and Premium.

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=52c7296b-212e-4818-a8cb-9f1648d5dd7d]

### Things to know about storage account types

**Standard** storage accounts are backed by magnetic hard disk drives (HDD). A standard storage account provides the lowest cost per GB. You can use Standard storage for applications that require bulk storage or where data is infrequently accessed.

**Premium** storage accounts are backed by solid-state drives (SSD) and offer consistent low-latency performance. You can use Premium storage for Azure virtual machine disks with I/O-intensive applications like databases.

> [!NOTE]
> You can't convert a Standard storage account to a Premium storage account or vice versa. You must create a new storage account with the desired type and copy data, if applicable, to a new storage account. All storage account types are encrypted by using Storage Service Encryption (SSE) for data at rest.


| Storage&nbsp;account| Supported&nbsp;services| Recommended usage |
| --- | --- | ---|
| [**Standard** __general-purpose v2__](/azure/storage/common/storage-account-upgrade)| Blob Storage (including Data Lake Storage), Queue Storage, Table Storage, and Azure Files | Standard storage account for most scenarios, including blobs, file shares, queues, tables, and disks (page blobs). |
| [**Premium** __block blobs__](/azure/storage/blobs/storage-blob-block-blob-premium)| Blob Storage (including Data Lake Storage) | Premium storage account for block blobs and append blobs. Recommended for applications with high transaction rates. Use Premium block blobs if you work with smaller objects or require consistently low storage latency. This storage is designed to scale with your applications. |
| [**Premium** __file shares__](/azure/storage/files/storage-how-to-create-file-share)| Azure Files | Premium storage account for file shares only. Recommended for enterprise or high-performance scale applications. Use Premium file shares if you require support for both Server Message Block (SMB) and NFS file shares. |
| [**Premium** __page blobs__](/azure/storage/blobs/storage-blob-pageblob-overview)| Page blobs only | Premium high-performance storage account for page blobs only. Page blobs are ideal for storing index-based and sparse data structures, such as operating systems, data disks for virtual machines, and databases. |

> [!TIP]
> Before continuing, consider working through the [*Create a storage account*](/training/modules/create-azure-storage-account/) training module. This module has a sandbox where you can create a storage account. 



