Azure Storage is a service that you can use to store unstructured and partially structured data. When implementing Azure Storage, you create a storage account. An Azure Storage account is a logical namespace that, depending on its type, is capable of hosting different types of objects, including blobs, tables, queues, and files:

- **Blobs**: These typically represent unstructured files such as media content, virtual machine disks, backups, or logs. Blobs offer a locking mechanism, which facilitates exclusive file access that IaaS virtual machines require. There are three types of blobs. The first one, known as a block blob, is optimized for sequential access, which is ideal for media content. The second one, referred to as a page blob, offers superior random-access capabilities, which is best suited for virtual machine disks. The third one, referred to as an append blob, supports data append operations, without the need to modify existing content. This works best with logging and auditing activities.
- **Tables**: These hosts non-relational and partially structured content, which consists of multiple rows of data with different sets of properties. In the context of Azure Table storage, these rows are referred to as entities. Developers frequently implement table storage as the backend data store for App Service or Cloud Services.
- **Queues**: These are temporary storage for messages that Azure services commonly use to asynchronously communicate with each other. In distributed applications, a source component sends a message by placing it in a queue. The destination component works through the messages in the queue one at a time.
- **Files**: Similar to blobs, these provide storage for unstructured files, but they offer support for file sharing via the Server Message Block (SMB) protocol in the same manner as traditional on-premises Windows file shares.

## Optional demos

- [Demonstration: Create storage accounts](https://go.microsoft.com/fwlink/?linkid=2261102&clcid=0x409)
- [Demonstration: Explore Azure Blob Storage](https://go.microsoft.com/fwlink/?linkid=2260571&clcid=0x409)
- [Demonstration: Explore AzCopy](https://go.microsoft.com/fwlink/?linkid=2260570&clcid=0x409)
- [Demonstration: Review common Storage Explorer tasks](https://go.microsoft.com/fwlink/?linkid=2260573&clcid=0x409)
