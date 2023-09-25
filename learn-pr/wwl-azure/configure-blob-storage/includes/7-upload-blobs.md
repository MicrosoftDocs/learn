
A blob can be any type of data and any size file. Azure Storage offers three types of blobs: *block blob*, *page blob*, and *append blob*. 

### Things to know about blob types

Let's take a closer look at the characteristics of blob types. 

- **Block blobs**. A block blob consists of blocks of data that are assembled to make a blob. Most Blob Storage scenarios use block blobs. Block blobs are ideal for storing text and binary data in the cloud, like files, images, and videos.

- **Append blobs**. An append blob is similar to a block blob because the append blob also consists of blocks of data. The blocks of data in an append blob are optimized for _append_ operations. Append blobs are useful for logging scenarios, where the amount of data can increase as the logging operation continues.

- **Page blobs**. A page blob can be up to 8 TB in size. Page blobs are more efficient for frequent read/write operations. Azure Virtual Machines uses page blobs for operating system disks and data disks.

- The block blob type is the default type for a new blob. When you're creating a new blob, if you don't choose a specific type, the new blob is created as a block blob.

- After you create a blob, you can't change its type.

### Things to consider when using blob upload tools

A common approach for uploading blobs to your Azure storage account is to use Azure Storage Explorer. Many other tools are also available. Review the following options and consider which tools would suit your configuration needs.

| Upload tool | Description |
| --- | --- |
| **AzCopy** | An easy-to-use command-line tool for Windows and Linux. You can copy data to and from Blob Storage, across containers, and across storage accounts. |
| **Azure Data Box Disk** | A service for transferring on-premises data to Blob Storage when large datasets or network constraints make uploading data over the wire unrealistic. You can use Azure Data Box Disk to request solid-state disks (SSDs) from Microsoft. You can copy your data to those disks and ship them back to Microsoft to be uploaded into Blob Storage. |
| **Azure Import/Export** | A service that helps you export large amounts of data from your storage account to hard drives that you provide and that Microsoft then ships back to you with your data. |

#### Business scenario

The following example shows how to upload blob data in Azure Storage Explorer. After you identify the files to upload, you choose the blob type and block size, and the container folder. You also set the authentication method and encryption scope.

:::image type="content" source="../media/upload-blobs-7ad73d30.png" alt-text="Screenshot of the Upload Blob page that shows the Authentication type, blob types, and block size.":::