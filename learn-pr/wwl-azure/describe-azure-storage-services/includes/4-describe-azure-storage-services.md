Azure Storage includes these core data services:

 -  **Azure Blobs**: A massively scalable object store for text and binary data. Also includes support for big data analytics through Data Lake Storage Gen2.
 -  **Azure Files**: Managed file shares for cloud or on-premises deployments.
 -  **Azure Queues**: A messaging store for reliable messaging between application components.
 -  **Azure Disks**: Block-level storage volumes for Azure VMs.
 -  **Azure Tables:** NoSQL table option for structured, non-relational data.

:::image type="content" source="../media/storage-services-overview.png" alt-text="Diagram showing five Azure Storage services: Azure Blobs, Azure Files, Azure Queues, Azure Disks, and Azure Tables with brief descriptions of each.":::

## Benefits of Azure Storage

Azure Storage provides these benefits:

 -  **Durable and highly available**. Redundancy options protect data from hardware failures, outages, and regional incidents.
 -  **Secure**. All data written to an Azure storage account is encrypted by the service. Azure Storage provides you with fine-grained control over who has access to your data.
 -  **Scalable**. Azure Storage is designed to be massively scalable to meet the data storage and performance needs of today's applications.
 -  **Managed**. Azure handles hardware maintenance, updates, and critical issues for you.
 -  **Accessible**. Data can be accessed globally over HTTP or HTTPS by using REST APIs, SDKs, Azure CLI, Azure PowerShell, the Azure portal, or Azure Storage Explorer.

## Azure Blobs

Azure Blob storage is an unstructured object storage service for large volumes of text or binary data. It's designed for scenarios such as large uploads, media content, log files, and analytics datasets. Developers store objects as blobs while Azure handles the underlying storage infrastructure.

Blob storage is ideal for:

 -  Serving images or documents directly to a browser.
 -  Storing files for distributed access.
 -  Streaming video and audio.
 -  Storing data for backup and restore, disaster recovery, and archiving.
 -  Storing data for analysis by an on-premises or Azure-hosted service.

### Accessing blob storage

Objects in blob storage can be accessed from anywhere in the world via HTTP or HTTPS. Users or client applications can access blobs via URLs, the Azure Storage REST API, Azure PowerShell, Azure CLI, or an Azure Storage client library. The storage client libraries are available for multiple languages, including .NET, Java, Node.js, Python, PHP, and Ruby.

### Blob storage tiers

Data access patterns change over time, so Azure Blob storage offers access tiers that balance storage cost against retrieval speed. The available access tiers include:

 -  **Hot access tier**: Optimized for storing data that is accessed frequently (for example, images for your website).
 -  **Cool access tier**: Optimized for data that is infrequently accessed and stored for at least 30 days (for example, invoices for your customers).
 -  **Cold access tier**: Optimized for storing data that is infrequently accessed and stored for at least 90 days.
 -  **Archive access tier**: Appropriate for data that is rarely accessed and stored for at least 180 days, with flexible latency requirements (for example, long-term backups).

Considerations for access tiers:

 -  Hot, cool, and cold access tiers can be set at the account level. The archive access tier isn't available at the account level.
 -  Hot, cool, cold, and archive tiers can be set at the blob level, during or after upload.
 -  Cool and cold tiers have lower storage costs but higher access costs and lower availability SLAs.
 -  Archive tier has the lowest storage cost and highest rehydration latency and access cost.

:::image type="content" source="../media/blob-access-tiers.png" alt-text="Diagram showing four Blob Storage access tiers from Hot to Archive, with increasing minimum retention periods and decreasing storage costs.":::

## Azure Files

Azure Files offers fully managed file shares in the cloud that are accessible via the industry standard Server Message Block (SMB) or Network File System (NFS) protocols. Azure file shares can be mounted concurrently by cloud or on-premises deployments. SMB Azure file shares are accessible from Windows, Linux, and macOS clients. NFS Azure file shares are accessible from Linux or macOS clients. Additionally, SMB Azure file shares can be cached on Windows Servers with Azure File Sync for fast access near where the data is being used.

### Azure Files key benefits

 -  **Shared access**: SMB and NFS protocol support enables compatibility with existing applications.
 -  **Fully managed**: No server hardware or OS patching to manage.
 -  **Scripting and tooling**: Manage shares with Azure CLI, Azure PowerShell, the Azure portal, and Storage Explorer.
 -  **Resiliency**: Built for high availability.
 -  **Familiar programmability**: Applications can use standard file I/O APIs plus Azure SDKs and REST APIs.

## Azure Queues

Azure Queue storage stores large numbers of messages for asynchronous processing. Queues are accessed by authenticated HTTP/HTTPS calls, can hold millions of messages, and support messages up to 64 KB.

Queue storage is commonly paired with Azure Functions so messages trigger background actions.

## Azure Disks

Azure Disk storage (managed disks) provides block-level volumes for Azure VMs. They are virtualized and managed by Azure for improved resiliency and simpler operations.

## Azure Tables

Azure Table storage is a NoSQL store for large amounts of structured, non-relational data, accessible through authenticated calls from cloud and hybrid environments.

