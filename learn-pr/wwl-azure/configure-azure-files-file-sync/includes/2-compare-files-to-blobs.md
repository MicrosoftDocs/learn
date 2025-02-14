[Azure Files](/azure/storage/files/storage-files-introduction) offers fully managed file shares in the cloud. You can access Azure file shares by using the Server Message Block (SMB), Network File System (NFS), and HTTP protocols. Clients can connect to Azure file shares from Windows, Linux, and macOS devices.

### Things to know about Azure Files

Here are some characteristics of Azure files: 

- **Serverless deployment**. An Azure file share is a PaaS offering of a fully managed file share that doesn't require any infrastructure. You don't need to take care of any VMs, operating systems, or updates.

- **Almost unlimited storage**. A single Azure file share can store up to 100 tebibytes (TiB) of files, and a file can be up to 4 TiB in size. The files are organized in a hierarchical folder structure in the same way as on on-premises file servers.

- **Data encryption**. The data on an Azure file share is encrypted at rest in an Azure datacenter and in transit on a network.

- **Access from anywhere**. By default, clients can access Azure file shares from anywhere if they have internet connectivity.

- **Integration into an existing environment**. You can control access to Azure file shares by using Microsoft Entra identities or AD DS identities that are synced to Microsoft Entra ID. This helps ensure that users can have the same experience accessing an Azure file share as when they access an on-premises file server.

- **Previous versions and backups**. You can create Azure file share snapshots that integrate with the Previous Versions feature in File Explorer. You can also use Azure Backup to back up Azure file shares.

- **Data redundancy**. Azure file share data replicates to multiple locations in the same Azure datacenter or across many Azure datacenters. The replication setting of the Azure storage account that includes the file share controls the data redundancy.

### Things to consider when using Azure Files

There are many common scenarios for using Azure Files. As you review the following suggestions, think about how Azure Files can provide solutions for your organization.

- **Consider replacement and supplement options**. Replace or supplement traditional on-premises file servers or NAS devices by using Azure Files.

- **Consider global access**. Directly access Azure file shares by using most operating systems, such as Windows, macOS, and Linux, from anywhere in the world.

- **Consider lift and shift support**. _Lift and shift_ applications to the cloud with Azure Files for apps that expect a file share to store file application or user data.

- **Consider using Azure File Sync**. Replicate Azure file shares to Windows Servers by using Azure File Sync. You can replicate on-premises or in the cloud for performance and distributed caching of the data where it's being used. We take a closer look at Azure File Sync in a later unit.

- **Consider shared applications**. Store shared application settings such as configuration files in Azure Files.

- **Consider diagnostic data**. Use Azure Files to store diagnostic data such as logs, metrics, and crash dumps in a shared location.

- **Consider tools and utilities**. Azure Files is a good option for storing tools and utilities that are needed for developing or administering Azure VMs or cloud services.

## Compare Azure Files to Azure Blob Storage

It's important to understand when to use Azure Files to store data in file shares rather than using Azure Blob Storage to store data as blobs. The following table compares different features of these services and common implementation scenarios.

| Azure Files (file shares) | Azure Blob Storage (blobs) |
| --- | --- |
| Azure Files provides the SMB and NFS protocols, client libraries, and a REST interface that allows access from anywhere to stored files. | Azure Blob Storage provides client libraries and a REST interface that allows unstructured data to be stored and accessed at a massive scale in block blobs. |
| - Files in an Azure Files share are true directory objects. <br> - Data in Azure Files is accessed through file shares across multiple virtual machines. | - Blobs in Azure Blob Storage are a flat namespace. <br> - Blob data in Azure Blob Storage is accessed through a container. |
| _**Azure Files** is ideal to lift and shift an application to the cloud that already uses the native file system APIs. Share data between the app and other applications running in Azure._ <br><br> _Azure Files is a good option when you want to store development and debugging tools that need to be accessed from many virtual machines._ | _**Azure Blob Storage** is ideal for applications that need to support streaming and random-access scenarios._ <br><br> _Azure Blob Storage is a good option when you want to be able to access application data from anywhere._ |

