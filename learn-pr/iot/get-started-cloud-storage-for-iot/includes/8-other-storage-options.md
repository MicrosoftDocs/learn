There are several other Azure storage types that are used with Azure IoT Hub solutions. Some key additional storage types are described as follows:

## Azure Files

Azure Files offers fully managed file shares in the cloud that are accessible via the industry standard Server Message Block (SMB) protocol, Network File System (NFS) protocol, and Azure Files REST API. Azure file shares can be mounted concurrently by cloud or on-premises deployments. SMB Azure file shares are accessible from Windows, Linux, and macOS clients. NFS Azure file shares are accessible from Linux clients. Additionally, SMB Azure file shares can be cached on Windows servers with Azure File Sync for fast access near where the data is being used.

### Why Azure Files is useful

Azure file shares can be used to:

* **Replace or supplement on-premises file servers**: Azure Files can be used to replace or supplement traditional on-premises file servers or network-attached storage (NAS) devices. Popular operating systems such as Windows, macOS, and Linux can directly mount Azure file shares wherever they are in the world. SMB Azure file shares can also be replicated with Azure File Sync to Windows servers, either on-premises or in the cloud, for performance and distributed caching of the data. With Azure Files AD Authentication, SMB Azure file shares can work with Active Directory Domain Services (AD DS) hosted on-premises for access control.

* **"Lift and shift" applications**: Azure Files makes it easy to "lift and shift" applications to the cloud that expect a file share to store file application or user data. Azure Files enables both the "classic" lift and shift scenario, where both the application and its data are moved to Azure, and the "hybrid" lift and shift scenario, where the application data is moved to Azure Files, and the application continues to run on-premises.

* **Simplify cloud development**: Azure Files can also be used to simplify new cloud development projects. For example:

  * **Shared application settings**: A common pattern for distributed applications is to have configuration files in a centralized location where they can be accessed from many application instances. Application instances can load their configuration through the Azure Files REST API, and humans can access them by mounting the share locally.

  * **Diagnostic share**: An Azure file share is a convenient place for cloud applications to write their logs, metrics, and crash dumps. Logs can be written by the application instances via the File REST API, and developers can access them by mounting the file share on their local machine. This enables great flexibility, as developers can embrace cloud development without having to abandon any existing tooling they know and love.

  * **Dev/Test/Debug**: When developers or administrators are working on VMs in the cloud, they often need a set of tools or utilities. Copying such utilities and tools to each VM can be a time consuming exercise. By mounting an Azure file share locally on the VMs, a developer and administrator can quickly access their tools and utilities, no copying required.

* **Containerization**: Azure file shares can be used as persistent volumes for stateful containers. Containers deliver "build once, run anywhere" capabilities that enable developers to accelerate innovation. For the containers that access raw data at every start, a shared file system is required to allow these containers to access the file system no matter which instance they run on.

### Key benefits

* **Easy to use**: When an Azure file share is mounted on your computer, you don't need to do anything special to access the data: just navigate to the path where the file share is mounted and open/modify a file.
* **Shared access**: Azure file shares support the industry standard SMB and NFS protocols, meaning you can seamlessly replace your on-premises file shares with Azure file shares without worrying about application compatibility. Being able to share a file system across multiple machines, applications, and application instances is a significant advantage for applications that need shareability.
* **Fully managed**: Azure file shares can be created without the need to manage hardware or an OS. This means you don't have to deal with patching the server OS with critical security upgrades or replacing faulty hard disks.
* **Scripting and tooling**: PowerShell cmdlets and Azure CLI can be used to create, mount, and manage Azure file shares as part of the administration of Azure applications. You can create and manage Azure file shares using Azure portal and Azure Storage Explorer.
* **Resiliency**: Azure Files has been built from the ground up to be always available. Replacing on-premises file shares with Azure Files means you no longer have to wake up to deal with local power outages or network issues.
* **Familiar programmability**: Applications running in Azure can access data in the share via file system I/O APIs. Developers can therefore leverage their existing code and skills to migrate existing applications. In addition to System IO APIs, you can use Azure Storage Client Libraries or the Azure Files REST API.

## Azure Queue storage

Azure Queue Storage is a service for storing large numbers of messages. You access messages from anywhere in the world via authenticated calls using HTTP or HTTPS. A queue message can be up to 64 KB in size. A queue may contain millions of messages, up to the total capacity limit of a storage account. Queues are commonly used to create a backlog of work to process asynchronously, like in the [Web-Queue-Worker architectural style](/azure/architecture/guide/architecture-styles/web-queue-worker).

For example, say you want your customers to be able to upload pictures, and you want to create thumbnails for each picture. You could have your customer wait for you to create the thumbnails while uploading the pictures. An alternative would be to use a queue. When the customer finishes their upload, write a message to the queue. Then have an Azure function retrieve the message from the queue and create the thumbnails. Each of the parts of this processing can be scaled separately, giving you more control when tuning it for your usage.

## Azure Cosmos DB for Table

Azure Cosmos DB is a fully managed NoSQL and relational database for modern app development.

Azure Cosmos DB for Table provides applications written for Azure Table storage with premium capabilities like:

* Turnkey global distribution.
* Dedicated throughput worldwide (when using provisioned throughput).
* Single-digit millisecond latencies at the 99th percentile.
* Guaranteed high availability.
* Automatic secondary indexing.

Azure Table Storage has SDKs available for .NET, Java, Python, Node.js, and Go. These SDKs can be used to target either Azure Table Storage or the API for Table. Applications written for Azure Table Storage using the Azure Tables SDKs can be migrated to the Azure Cosmos DB with no code changes to take advantage of premium capabilities.

Specifically, the .NET Azure Tables SDK Azure.Data.Tables offers the latest features supported by the API for Table. The Azure Tables client library can seamlessly target either Azure Table storage or API for Table service endpoints with no code changes.

### API for Table benefits

If you currently use Azure Table Storage, you gain the following benefits by moving to the API for Table:

| | Azure Table storage | API for Table |
| --- | --- | --- |
| **Latency** | Fast, but no upper bounds on latency. | Single-digit millisecond latency for reads and writes, backed with <10-ms latency for reads and writes at the 99th percentile, at any scale, anywhere in the world. |
| **Throughput** | Variable throughput model. Tables have a scalability limit of 20,000 operations/s. | Highly scalable with dedicated reserved throughput per table backed by SLAs. Accounts have no upper limit on throughput and support >10 million operations/s per table. |
| **Global distribution** | Single region with one optional readable secondary read region for high availability. | Turnkey global distribution from one to any number of regions. Support for service-managed and manual failovers at any time, anywhere in the world. Multiple write regions to let any region accept write operations. |
| **Indexing** | Only primary index on PartitionKey and RowKey. No secondary indexes. | Automatic and complete indexing on all properties by default, with no index management. |
| **Query** | Query execution uses index for primary key, and scans otherwise. | Queries can take advantage of automatic indexing on properties for fast query times. |
| **Consistency** | Strong within primary region. Eventual within secondary region. | Five well-defined consistency levels to trade off availability, latency, throughput, and consistency based on your application needs. |
| **Pricing** | Consumption-based. | Available in both consumption-based and provisioned capacity modes. |
| **SLAs** | 99.9% to 99.99% availability, depending on the replication strategy. | 99.999% read availability, 99.99% write availability on a single-region account and 99.999% write availability on multi-region accounts. Comprehensive SLAs covering availability, latency, throughput, and consistency. |
