The Azure Storage platform is Microsoft's cloud storage solution for modern data storage scenarios. Azure Storage offers highly available, massively scalable, durable, and secure storage for a variety of data objects in the cloud. Azure Storage data objects are accessible from anywhere in the world over HTTP or HTTPS via a REST API. Azure Storage also offers client libraries for developers building applications or services with .NET, Java, Python, JavaScript, C++, and Go. Developers and IT professionals can use Azure PowerShell and Azure CLI to write scripts for data management or configuration tasks. The Azure portal and Azure Storage Explorer provide user-interface tools for interacting with Azure Storage.

## Benefits of Azure Storage

Azure Storage services offer the following benefits for application developers and IT professionals:

 -  Durable and highly available. Redundancy ensures that your data is safe in the event of transient hardware failures. You can also opt to replicate data across data centers or geographical regions for additional protection from local catastrophe or natural disaster. Data replicated in this way remains highly available in the event of an unexpected outage.<br>
 -  Secure. All data written to an Azure storage account is encrypted by the service. Azure Storage provides you with fine-grained control over who has access to your data.
 -  Scalable. Azure Storage is designed to be massively scalable to meet the data storage and performance needs of today's applications.
 -  Managed. Azure handles hardware maintenance, updates, and critical issues for you.
 -  Accessible. Data in Azure Storage is accessible from anywhere in the world over HTTP or HTTPS. Microsoft provides client libraries for Azure Storage in a variety of languages, including .NET, Java, Node.js, Python, Go, and others, as well as a mature REST API. Azure Storage supports scripting in Azure PowerShell or Azure CLI. And the Azure portal and Azure Storage Explorer offer easy visual solutions for working with your data.

## Azure Storage data services

The Azure Storage platform includes the following data services:

 -  Azure Blobs: A massively scalable object store for text and binary data. Also includes support for big data analytics through Data Lake Storage Gen2.<br>
 -  Azure Files: Managed file shares for cloud or on-premises deployments.
 -  Azure Elastic SAN: A fully integrated solution that simplifies deploying, scaling, managing, and configuring a SAN in Azure.
 -  Azure Queues: A messaging store for reliable messaging between application components.
 -  Azure Tables: A NoSQL store for schemaless storage of structured data.
 -  Azure managed Disks: Block-level storage volumes for Azure VMs.
 -  Azure Container Storage (preview): A volume management, deployment, and orchestration service built natively for containers.

Each service is accessed through a storage account with a unique address. To get started, see Create a storage account.

Additionally, Azure provides the following specialized storage:<br>

 -  Azure NetApp Files: Enterprise files storage, powered by NetApp: makes it easy for enterprise line-of-business (LOB) and storage professionals to migrate and run complex, file-based applications with no code change. Azure NetApp Files is managed via NetApp accounts and can be accessed via NFS, SMB and dual-protocol volumes.<br>

## Sample scenarios for Azure Storage services

The following table compares Azure Storage services and shows example scenarios for each.

| **Feature**                       | **Description**                                                                                                                                                                                                                                                                                                  | **When to use**                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| --------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Azure Files                       | Offers fully managed cloud file shares that you can access from anywhere via the industry standard Server Message Block (SMB) protocol, Network File System (NFS) protocol, and Azure Files REST API.<br><br>You can mount Azure file shares from cloud or on-premises deployments of Windows, Linux, and macOS. | You want to "lift and shift" an application to the cloud that already uses the native file system APIs to share data between it and other applications running in Azure.<br><br>You want to replace or supplement on-premises file servers or NAS devices.<br><br>You want to store development and debugging tools that need to be accessed from many virtual machines.                                                                                                      |
| Azure NetApp Files                | Offers a fully managed, highly available, enterprise-grade NAS service that can handle the most demanding, high-performance, low-latency workloads requiring advanced data management capabilities.                                                                                                              | You have a difficult-to-migrate workload such as Portable Operating System Interface (POSIX)-compliant Linux and Windows applications, SAP HANA, databases, high-performance compute (HPC) infrastructure and apps, and enterprise web applications.<br><br>You require support for multiple file-storage protocols in a single service, including NFSv3, NFSv4.1, and SMB3.1.x, enables a wide range of application lift-and-shift scenarios, with no need for code changes. |
| Azure Blobs                       | Allows unstructured data to be stored and accessed at a massive scale in block blobs.<br><br>Also supports Azure Data Lake Storage Gen2 for enterprise big data analytics solutions.                                                                                                                             | You want your application to support streaming and random access scenarios.<br><br>You want to be able to access application data from anywhere.<br><br>You want to build an enterprise data lake on Azure and perform big data analytics.                                                                                                                                                                                                                                    |
| Azure Elastic SAN                 | Azure Elastic SAN is a fully integrated solution that simplifies deploying, scaling, managing, and configuring a SAN, while also offering built-in cloud capabilities like high availability.                                                                                                                    | You want large scale storage that is interoperable with multiple types of compute resources (such as SQL, MariaDB, Azure virtual machines, and Azure Kubernetes Services) accessed via the internet Small Computer Systems Interface (iSCSI) protocol.                                                                                                                                                                                                                        |
| Azure Disks                       | Allows data to be persistently stored and accessed from an attached virtual hard disk.                                                                                                                                                                                                                           | You want to "lift and shift" applications that use native file system APIs to read and write data to persistent disks.<br><br>You want to store data that isn't required to be accessed from outside the virtual machine to which the disk is attached.                                                                                                                                                                                                                       |
| Azure Container Storage (preview) | Azure Container Storage (preview) is a volume management, deployment, and orchestration service that integrates with Kubernetes and is built natively for containers.                                                                                                                                            | You want to dynamically and automatically provision persistent volumes to store data for stateful applications running on Kubernetes clusters.                                                                                                                                                                                                                                                                                                                                |
| Azure Queues                      | Allows for asynchronous message queueing between application components.                                                                                                                                                                                                                                         | You want to decouple application components and use asynchronous messaging to communicate between them.<br>                                                                                                                                                                                                                                                                                                                                                                   |
| Azure Tables                      | Allows you to store structured NoSQL data in the cloud, providing a key/attribute store with a schemaless design.                                                                                                                                                                                                | You want to store flexible datasets like user data for web applications, address books, device information, or other types of metadata your service requires.<br>                                                                                                                                                                                                                                                                                                             |

## Blob Storage

Azure Blob Storage is Microsoft's object storage solution for the cloud. Blob Storage is optimized for storing massive amounts of unstructured data, such as text or binary data.

Blob Storage is ideal for:

 -  Serving images or documents directly to a browser.
 -  Storing files for distributed access.
 -  Streaming video and audio.
 -  Storing data for backup and restore, disaster recovery, and archiving.
 -  Storing data for analysis by an on-premises or Azure-hosted service.

Objects in Blob Storage can be accessed from anywhere in the world via HTTP or HTTPS. Users or client applications can access blobs via URLs, the Azure Storage REST API, Azure PowerShell, Azure CLI, or an Azure Storage client library. The storage client libraries are available for multiple languages, including .NET, Java, Node.js, and Python.

Clients can also securely connect to Blob Storage by using SSH File Transfer Protocol (SFTP) and mount Blob Storage containers by using the Network File System (NFS) 3.0 protocol.

## Azure Files

Azure Files enables you to set up highly available network file shares that can be accessed by using the industry standard Server Message Block (SMB) protocol, Network File System (NFS) protocol, and Azure Files REST API. That means that multiple VMs can share the same files with both read and write access. You can also read the files using the REST interface or the storage client libraries.

One thing that distinguishes Azure Files from files on a corporate file share is that you can access the files from anywhere in the world using a URL that points to the file and includes a shared access signature (SAS) token. You can generate SAS tokens; they allow specific access to a private asset for a specific amount of time.

File shares can be used for many common scenarios:

 -  Many on-premises applications use file shares. This feature makes it easier to migrate those applications that share data to Azure. If you mount the file share to the same drive letter that the on-premises application uses, the part of your application that accesses the file share should work with minimal, if any, changes.
 -  Configuration files can be stored on a file share and accessed from multiple VMs. Tools and utilities used by multiple developers in a group can be stored on a file share, ensuring that everybody can find them, and that they use the same version.
 -  Resource logs, metrics, and crash dumps are just three examples of data that can be written to a file share and processed or analyzed later.

## Azure Elastic Storage Area Network

Azure Elastic storage area network (SAN) is Microsoft's answer to the problem of workload optimization and integration between your large scale databases and performance-intensive mission-critical applications. Elastic SAN is a fully integrated solution that simplifies deploying, scaling, managing, and configuring a SAN, while also offering built-in cloud capabilities like high availability.

Elastic SAN is designed for large scale **Input/Output**\-intensive workloads and top tier databases such as SQL, MariaDB, and support hosting the workloads on virtual machines, or containers such as Azure Kubernetes Service. Elastic SAN volumes are compatible with a wide variety of compute resources through theInternet Small Computer Systems Interface (iSCSI) protocol. Some other benefits of Elastic SAN include a simplified deployment and management interface. Since you can manage storage for multiple compute resources from a single interface, and cost optimization.

## Azure Container Storage (***preview***)

Azure Container Storage integrates with Kubernetes and utilizes existing Azure Storage offerings for actual data storage, offering a volume orchestration and management solution purposely built for containers. You can choose any of the supported backing storage options to create a storage pool for your persistent volumes.

Azure Container Storage offers substantial benefits:<br>

 -  Rapid scale out of stateful pods<br>
 -  Improved performance for stateful workloads<br>
 -  Kubernetes-native volume orchestration<br>

## Queue Storage

The Azure Queue service is used to store and retrieve messages. Queue messages can be up to 64 KB in size, and a queue can contain millions of messages. Queues are generally used to store lists of messages to be processed asynchronously.

For example, say you want your customers to be able to upload pictures, and you want to create thumbnails for each picture. You could have your customer wait for you to create the thumbnails while uploading the pictures. An alternative would be to use a queue. When the customer finishes their upload, write a message to the queue. Then have an Azure Function retrieve the message from the queue and create the thumbnails. Each of the parts of this processing can be scaled separately, giving you more control when tuning it for your usage.

## Table Storage

Azure Table Storage is now part of Azure Cosmos DB. In addition to the existing Azure Table Storage service, there's a new Azure Cosmos DB for Table offering that provides throughput-optimized tables, global distribution, and automatic secondary indexes.

## Disk Storage

An Azure managed disk is a virtual hard disk (VHD). You can think of it like a physical disk in an on-premises server but, virtualized. Azure-managed disks are stored as page blobs, which are a random **Input/Output** storage object in Azure. We call a managed disk 'managed' because it's an abstraction over page blobs, blob containers, and Azure storage accounts. With managed disks, all you have to do is provision the disk, and Azure takes care of the rest.

## Azure NetApp Files

Azure NetApp Files is an enterprise-class, high-performance, metered file storage service. Azure NetApp Files supports any workload type and is highly available by default. You can select service and performance levels, create NetApp accounts, capacity pools, volumes, and manage data protection.

## Secure access to storage accounts

Every request to Azure Storage must be authorized. Azure Storage supports the following authorization methods:

 -  Microsoft Entra integration for blob, file, queue, and table data. Azure Storage supports authentication and authorization with Microsoft Entra ID for the Blob, File, Table, and Queue services via Azure role-based access control (Azure RBAC). Authorizing requests with Microsoft Entra ID is recommended for superior security and ease of use.<br>
 -  Identity-based authentication over SMB for Azure Files. Azure Files supports identity-based authorization over SMB (Server Message Block) through either on-premises Microsoft Entra Domain Services, or Microsoft Entra Kerberos (hybrid user accounts only).
 -  Authorization with Shared Key. The Azure Storage Blob, Files, Queue, and Table services support authorization with Shared Key. A client using Shared Key authorization passes a header with every request that is signed using the storage account access key. pended to the URI for a storage resource. The security token encapsulates constraints such as permissions and the interval of access.
 -  Microsoft Entra Domain Services with Azure NetApp Files. Azure NetApp Files features such as SMB volumes, dual-protocol volumes, and NFSv4.1 Kerberos volumes are designed to be used with Microsoft Entra Domain Services.

## Encryption

There are two basic kinds of encryption available for Azure Storage: **encryption at rest** and **client-side encryption**.

### 1. Encryption at rest<br>

Azure Storage encryption protects and safeguards your data to meet your organizational security and compliance commitments. Azure Storage automatically encrypts all data prior to persisting to the storage account and decrypts it prior to retrieval. The encryption, decryption, and key management processes are transparent to users. Customers can also choose to manage their own keys using Azure Key Vault.

### 2. Client-side encryption

The Azure Storage client libraries provide methods for encrypting data from the client library before sending it across the wire and decrypting the response. Data encrypted via client-side encryption is also encrypted at rest by Azure Storage.

Azure NetApp Files data traffic is inherently secure by design, as it doesn't provide a public endpoint and data traffic stays within customer-owned VNet. Data-in-flight isn't encrypted by default. However, data traffic from an Azure VM (running an **Network File System** or **Server Message Block** client) to Azure NetApp Files is as secure as any other Azure-VM-to-VM traffic. NFSv4.1 and SMB3 data-in-flight encryption can optionally be enabled.

## Redundancy<br>

To ensure that your data is durable, Azure Storage stores multiple copies of your data. When you set up your storage account, you select a redundancy option.

Azure NetApp Files provides locally redundant storage with **99.99% availability**.

## Transfer data to and from Azure Storage

You have several options for moving data into or out of Azure Storage. Which option you choose depends on the size of your dataset and your network bandwidth.

Azure NetApp Files provides NFS and SMB volumes. You can use any file-based copy tool to migrate data to the service.<br>
