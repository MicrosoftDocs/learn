Suppose you are a data engineer working at Tailwind Traders, a home improvement retailer with a large manufacturing operation. The organization has to gather and store information from a range of sources, such as real-time data monitoring the status of production line machinery, product quality control data, historical production logs, product volumes in stock, and raw materials inventory data. This information is critical to the operation of the organization. You have been asked to determine how best to store this information, so that it can be stored quickly, and queried easily.

Azure Blob storage is a service that enables you to store massive amounts of unstructured data, or blobs, in the cloud. A blob can hold a PDF document, a JPG image, a JSON file, video content, etc. A blob could contain gigabytes of binary data streamed from a scientific instrument, an encrypted message for another application, or data in a custom format for an app you are developing.

Azure supports three **kinds of blobs**:

| **Block Blobs**| **Page Blobs**| **Append Blobs** |
| - | - | - |
| A block is the smallest amount of data that can be read or written as an individual unit.| A page blob is optimized to support random read and write operations.| An append blob is a block blob optimized to support append operations. |
| A block blob can contain up to 50,000 blocks, giving a maximum size of over 4.7 TB. Each block can vary in size, up to 100 MB.| A page blob is organized as a collection of fixed size 512-byte pages.| Each block can vary in size, up to 4 MB. The maximum size of an append blob is just over 195 GB. |


> [!Note]
> The term blob is an acronym for Binary Large OBject.


Blob storage provides three **access tiers**, which help to balance access latency and storage cost:

| **Hot tier**| **Cool Tier**| **Archive Tier** |
| - | -| - |
| You use this tier for blobs that are accessed frequently. The blob data is stored on high-performance media.| Use the Cool tier for data that is accessed infrequently. This tier has lower performance and lower storage costs| This tier provides the lowest storage cost, but increased latency. The Archive tier is intended for historical data that is required rarely. To retrieve a blob from the Archive tier, you must change the access tier to Hot or Cool. |


**Move data to Blob storage**

A number of solutions exist for migrating existing data to Blob storage when you begin using Blob Storage for your data integration and storage needs.

- **AzCopy** - easy-to-use command-line tool for Windows and Linux that copies data to and from Blob storage, across containers, or across storage accounts. 

- **Azure Storage Data Movement library** - This is a .NET library for moving data between Azure Storage services. The AzCopy utility is built with the Data Movement library. 

- **Azure Data Factory -** supports copying data to and from Blob storage by using the account key, a shared access signature, a service principal, or managed identities for Azure resources. 

- **Blobfuse** – This is a virtual file system driver for Azure Blob storage. You can use blobfuse to access your existing block blob data in your Storage account through the Linux file system. 

- **Azure Data Box – This is** a service that is available to transfer on-premises data to Blob storage when large datasets or network constraints make uploading data over the wire unrealistic. Depending on your data size, you can request [Azure Data Box Disk](/azure/databox/data-box-disk-overview), [Azure Data Box](/azure/databox/data-box-overview), or [Azure Data Box Heavy](/azure/databox/data-box-heavy-overview) devices from Microsoft. You can then copy your data to those devices and ship them back to Microsoft to be uploaded into Blob storage.

- **Azure Import/Export service – This service** provides a way to import or export large amounts of data to and from your storage account using hard drives that you provide. 

 

**Features of** **Azure Blob storage**

Inside an Azure storage account, you create and store blobs inside containers and you can store an unlimited number of containers in a storage account. You can organize blobs in a hierarchy of folders, similar to files in a file system on disk. Some of its other features are

- Versioning – You can maintain and restore earlier versions of a blob

- soft-delete - This feature enables you to recover a blob that has been removed or overwritten, by accident or otherwise.

- Snapshots - A snapshot is a read-only version of a blob at a particular point in time.

- Change feed - The change feed for a blob provides an ordered, read-only, record of the updates made to a blob. You can use the change feed to monitor these changes.

**Why use Azure Storage Blob?**

Some common uses of Azure Blob Storage include:

- Multiple Blob Types – Page blobs, block blobs and append blobs give more flexibility to choose a storage option that fits our needs

- Geo-redundancy - Storing files for distributed access provides maximum availability to enhance local and global access

- Data Integrity - The data accessed is always the latest version as it instantly updates changes made to an object, so its reliable

Cost-optimized - Storing data for analysis and archiving long-term data in a tiered storage helps keep costs down

**When would you choose Azure Blob Storage over Azure Data Lake?**

Let us look at some criteria that will help you decide when to pick one storage solution over the other. In the following table, the two storage solutions are compared against a set of criteria.

| **Criteria**| **Azure Data Lake**| **Azure Blob Storage** |
| - | -| - |
| Data type| Good for storing large volumes of text data| Good for storing unstructured non-text based data such as photos, videos, backup etc. |
| Geographic redundancy| Need to set up replication of data| By default, provides geo redundant storage |
| Namespaces support| Supports hierarchical namespaces| Supports flat namespaces |
| Hadoop compatibility| Hadoop services can use data stored in Data Lake| Is not Hadoop compatible |
| Security| Allows for more granular access| Granular access not supported |