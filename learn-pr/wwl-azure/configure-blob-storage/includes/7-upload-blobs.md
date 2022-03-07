A blob can be any type and size file. Azure Storage offers three types of blobs: *block* blobs, *page* blobs, and *append* blobs. You specify the blob type and access tier when you create the blob.

:::image type="content" source="../media/upload-blobs-7ad73d30.png" alt-text="Screenshot of the Upload Blob page. The Advanced section with Authentication type, blob types, and block size.":::


 -  **Block blobs (default)** consist of blocks of data assembled to make a blob. Most scenarios using Blob storage employ block blobs. Block blobs are ideal for storing text and binary data in the cloud, like files, images, and videos.
 -  **Append blobs** are like block blobs in that they are made up of blocks, but they are optimized for append operations, so they are useful for logging scenarios.
 -  **Page blobs** can be up to 8 TB in size and are more efficient for frequent read/write operations. Azure virtual machines use page blobs as OS and data disks.

> [!NOTE]
> Once the blob has been created, its type cannot be changed.

## Blob upload tools

There are multiple methods to upload data to blob storage, including the following methods:

 -  **AzCopy** is an easy-to-use command-line tool for Windows and Linux that copies data to and from Blob storage, across containers, or across storage accounts.
 -  The **Azure Storage Data Movement library** is a .NET library for moving data between Azure Storage services. The AzCopy utility is built with the Data Movement library.
 -  **Azure Data Factory** supports copying data to and from Blob storage by using the account key, shared access signature, service principal, or managed identities for Azure resources authentications.
 -  **Blobfuse** is a virtual file system driver for Azure Blob storage. You can use blobfuse to access your existing block blob data in your Storage account through the Linux file system.
 -  **Azure Data Box Disk** is a service for transferring on-premises data to Blob storage when large datasets or network constraints make uploading data over the wire unrealistic. You can use Azure Data Box Disk to request solid-state disks (SSDs) from Microsoft. You can then copy your data to those disks and ship them back to Microsoft to be uploaded into Blob storage.
 -  The **Azure Import/Export** service provides a way to export large amounts of data from your storage account to hard drives that you provide and that Microsoft then ships back to you with your data.

> [!NOTE]
> And, you can always use Azure Storage Explorer.
