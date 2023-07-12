
Azure Blob Storage is a service that stores unstructured data in the cloud as objects or blobs. Blob stands for Binary Large Object. Blob Storage is also referred to as _object storage_ or _container storage_.

### Things to know about Azure Blob Storage

Let's examine some configuration characteristics of Blob Storage.

- Blob Storage can store any type of text or binary data. Some examples are text documents, images, video files, and application installers.

- Blob Storage uses three resources to store and manage your data:
   - An Azure storage account
   - Containers in an Azure storage account
   - Blobs in a container

- To implement Blob Storage, you configure several settings:
   - Blob container options
   - Blob types and upload options
   - Blob Storage access tiers
   - Blob lifecycle rules
   - Blob object replication options

The following diagram shows the relationship between the Blob Storage resources.

:::image type="content" source="../media/blob-storage-94fb52b8.png" alt-text="Diagram that shows the Azure Blob Storage architecture." border="false":::

### Things to consider when implementing Azure Blob Storage

There are many common uses for Blob Storage. Consider the following scenarios and think about your own data needs:

- **Consider browser uploads**. Use Blob Storage to serve images or documents directly to a browser.

- **Consider distributed access**. Blob Storage can store files for distributed access, such as during an installation process.

- **Consider streaming data**. Stream video and audio by using Blob Storage.

- **Consider archiving and recovery**. Blob Storage is a great solution for storing data for backup and restore, disaster recovery, and archiving.

- **Consider application access**. You can store data in Blob Storage for analysis by an on-premises or Azure-hosted service.