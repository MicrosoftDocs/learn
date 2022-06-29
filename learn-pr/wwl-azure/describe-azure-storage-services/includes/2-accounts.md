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

:::row:::
  :::column:::
    **Type**
  :::column-end:::
  :::column:::
    **Supported services**
  :::column-end:::
  :::column:::
    **Redundancy Options**
  :::column-end:::
  :::column:::
    **Usage**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Standard general-purpose v2
  :::column-end:::
  :::column:::
    Blob Storage (including Data Lake Storage), Queue Storage, Table Storage, and Azure Files
  :::column-end:::
  :::column:::
    LRS, GRS, RA-GRS, ZRS, GZRS, RA-GZRS
  :::column-end:::
  :::column:::
    Standard storage account type for blobs, file shares, queues, and tables. Recommended for most scenarios using Azure Storage. If you want support for network file system (NFS) in Azure Files, use the premium file shares account type.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Premium block blobs
  :::column-end:::
  :::column:::
    Blob Storage (including Data Lake Storage)
  :::column-end:::
  :::column:::
    LRS, ZRS
  :::column-end:::
  :::column:::
    Premium storage account type for block blobs and append blobs. Recommended for scenarios with high transaction rates or that use smaller objects or require consistently low storage latency.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Premium file shares
  :::column-end:::
  :::column:::
    Azure Files
  :::column-end:::
  :::column:::
    LRS, ZRS
  :::column-end:::
  :::column:::
    Premium storage account type for file shares only. Recommended for enterprise or high-performance scale applications. Use this account type if you want a storage account that supports both Server Message Block (SMB) and NFS file shares.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Premium page blobs
  :::column-end:::
  :::column:::
    Page blobs only
  :::column-end:::
  :::column:::
    LRS
  :::column-end:::
  :::column:::
    Premium storage account type for page blobs only.
  :::column-end:::
:::row-end:::


## Storage account endpoints

One of the benefits of using an Azure Storage Account is having a unique namespace in Azure for your data. In order to do this, every storage account in Azure must have a unique-in-Azure account name. The combination of the account name and the Azure Storage service endpoint forms the endpoints for your storage account.

When naming your storage account, keep these rules in mind:

 -  Storage account names must be between 3 and 24 characters in length and may contain numbers and lowercase letters only.
 -  Your storage account name must be unique within Azure. No two storage accounts can have the same name. This supports the ability to have a unique, accessible namespace in Azure.

The following table shows the endpoint format for Azure Storage services.

:::row:::
  :::column:::
    **Storage service**
  :::column-end:::
  :::column:::
    **Endpoint**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Blob Storage
  :::column-end:::
  :::column:::
    https://storage-account-name.blob.core.windows.net
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Data Lake Storage Gen2
  :::column-end:::
  :::column:::
    https://storage-account-name.dfs.core.windows.net
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Files
  :::column-end:::
  :::column:::
    https://storage-account-name.file.core.windows.net
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Queue Storage
  :::column-end:::
  :::column:::
    https://storage-account-name.queue.core.windows.net
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Table Storage
  :::column-end:::
  :::column:::
    https://storage-account-name.table.core.windows.net
  :::column-end:::
:::row-end:::
