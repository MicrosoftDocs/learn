The following video introduces the different services that should be available with Azure Storage.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4MAbS]

A storage account provides a unique namespace for your Azure Storage data that's accessible from anywhere in the world over HTTP or HTTPS. Data in this account is secure, highly available, durable, and massively scalable.

When you create your storage account, you’ll start by picking the storage account type. The type of account determines the storage services and redundancy options and has an impact on the use cases. Below is a list of redundancy options that will be covered later in this module:

 -  Locally redundant storage (LRS)
 -  Geo-redundant storage (GRS)
 -  Read-access geo-redundant storage (RA-GRS)
 -  Zone-redundant storage (ZRS)
 -  Geo-zone-redundant storage (GZRS)
 -  Read-access geo-zone-redundant storage (RA-GZRS)

| **Type**                    | **Supported services**                                                                    | **Redundancy Options**               | **Usage**                                                                                                                                                                                                                                    |
| --------------------------- | ----------------------------------------------------------------------------------------- | ------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Standard general-purpose v2 | Blob Storage (including Data Lake Storage), Queue Storage, Table Storage, and Azure Files | LRS, GRS, RA-GRS, ZRS, GZRS, RA-GZRS | Standard storage account type for blobs, file shares, queues, and tables. Recommended for most scenarios using Azure Storage. If you want support for network file system (NFS) in Azure Files, use the premium file shares account type.    |
| Premium block blobs         | Blob Storage (including Data Lake Storage)                                                | LRS, ZRS                             | Premium storage account type for block blobs and append blobs. Recommended for scenarios with high transaction rates or that use smaller objects or require consistently low storage latency.                                                |
| Premium file shares         | Azure Files                                                                               | LRS, ZRS                             | Premium storage account type for file shares only. Recommended for enterprise or high-performance scale applications. Use this account type if you want a storage account that supports both Server Message Block (SMB) and NFS file shares. |
| Premium page blobs          | Page blobs only                                                                           | LRS                                  | Premium storage account type for page blobs only.                                                                                                                                                                                            |

## Storage account endpoints

One of the benefits of using an Azure Storage Account is having a unique namespace in Azure for your data. In order to do this, every storage account in Azure must have a unique-in-Azure account name. The combination of the account name and the Azure Storage service endpoint forms the endpoints for your storage account.

When naming your storage account, keep these rules in mind:

 -  Storage account names must be between 3 and 24 characters in length and may contain numbers and lowercase letters only.
 -  Your storage account name must be unique within Azure. No two storage accounts can have the same name. This supports the ability to have a unique, accessible namespace in Azure.

The following table shows the endpoint format for Azure Storage services.

| **Storage service**    | **Endpoint**                                                                   |
| ---------------------- | ------------------------------------------------------------------------------ |
| Blob Storage           | https://&lt;storage-account-name&gt;.blob.core.windows.net  |
| Data Lake Storage Gen2 | https://&lt;storage-account-name&gt;.dfs.core.windows.net   |
| Azure Files            | https://&lt;storage-account-name&gt;.file.core.windows.net  |
| Queue Storage          | https://&lt;storage-account-name&gt;.queue.core.windows.net |
| Table Storage          | https://&lt;storage-account-name&gt;.table.core.windows.net |
