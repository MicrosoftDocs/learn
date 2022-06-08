Azure Storage includes these data services, each of which is accessed through a storage account.

 -  **Azure Containers (Blobs)**: A massively scalable object store for text and binary data.
 -  **Azure Files**: Managed file shares for cloud or on-premises deployments.
 -  **Azure Queues**: A messaging store for reliable messaging between application components.
 -  **Azure Tables**: A NoSQL store for schemaless storage of structured data.

## Container (blob) storage

Azure Blob storage is Microsoft's object storage solution for the cloud. Blob storage is optimized for storing massive amounts of unstructured data, such as text or binary data. Blob storage is ideal for:

 -  Serving images or documents directly to a browser.
 -  Storing files for distributed access.
 -  Streaming video and audio.
 -  Storing data for backup and restore, disaster recovery, and archiving.
 -  Storing data for analysis by an on-premises or Azure-hosted service.

Objects in Blob storage can be accessed from anywhere in the world via HTTP or HTTPS. Users or client applications can access blobs via URLs, the Azure Storage REST API, Azure PowerShell, Azure CLI, or an Azure Storage client library. The storage client libraries are available for multiple languages, including .NET, Java, Node.js, Python, PHP, and Ruby.

> [!NOTE]
> [You can access data from Azure Blob Storage by using the NFS protocol.](/learn/modules/access-data-azure-blob-storage-multiple-protocols/4-access-data-azure-blob-storage-nfs-protocol)



## Azure files

Azure Files enables you to set up highly available network file shares. Shares can be accessed the Server Message Block (SMB) protocol and the Network File System (NFS) protocol. That means that multiple VMs can share the same files with both read and write access. You can also read the files using the REST interface or the storage client libraries.

One thing that distinguishes Azure Files from files on a corporate file share is that you can access the files from anywhere in the world using a URL that points to the file and includes a shared access signature (SAS) token. You can generate SAS tokens; they allow specific access to a private asset for a specific amount of time.

File shares can be used for many common scenarios:

 -  Many on-premises applications use file shares. This feature makes it easier to migrate those applications that share data to Azure. If you mount the file share to the same drive letter that the on-premises application uses, the part of your application that accesses the file share should work with minimal, if any, changes.
 -  Configuration files can be stored on a file share and accessed from multiple VMs. Tools and utilities used by multiple developers in a group can be stored on a file share, ensuring that everybody can find them, and that they use the same version.
 -  Diagnostic logs, metrics, and crash dumps are just three examples of data that can be written to a file share and processed or analyzed later.

The storage account credentials are used to provide authentication for access to the file share. This means anybody with the share mounted will have full read/write access to the share.

## Queue storage

The Azure Queue service is used to store and retrieve messages. Queue messages can be up to 64 KB in size, and a queue can contain millions of messages. Queues are used to store lists of messages to be processed asynchronously.

For example, if you want your customers to be able to upload pictures, and you want to create thumbnails for each picture. You could have your customer wait for you to create the thumbnails while uploading the pictures. An alternative would be to use a queue. When the customer finishes the upload, write a message to the queue. Then have an Azure Function retrieve the message from the queue and create the thumbnails. Each of the processing parts can be scaled separately, giving you more control when tuning it for your usage.

## Table storage

Azure Table storage is now part of Azure Cosmos DB. In addition to the existing Azure Table storage service, there is a new Azure Cosmos DB Table API offering that provides throughput-optimized tables, global distribution, and automatic secondary indexes. Table storage is ideal for storing structured, non-relational data.
