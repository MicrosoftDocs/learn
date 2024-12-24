In addition to migrating applications, virtual machines, databases, and other structured data, organizations also need to move unstructured data. This data might be stored in several locations and be liable to frequent changes. As a result, migrating storage that contains unstructured data can be challenging. For your Tailwind Traders migration planning, we examine how to move online on-premises unstructured data with the Azure Storage Mover, and Azure File Sync.

## Azure Storage Mover

[Azure Storage Mover](/azure/storage-mover/) is a relatively new, fully managed migration service that enables you to migrate your files and folders to Azure Storage while minimizing downtime for your workload.

You can use Storage Mover for different migration scenarios such as lift-and-shift, and for migrations that you have to repeat regularly. Azure Storage Mover also helps maintain oversight and manage the migration of all your globally distributed file shares from a single storage mover resource.

### Things to know about Azure Storage Mover

Azure Storage Mover works on both NFS shares and SMB shares. 

:::image type="content" source="../media/storage-mover.png" alt-text="Illustration that shows how the Storage Mover architecture." border="false":::

- Can migrate SMB 2.x protocol source endpoints. File fidelity is maintained. Fidelity includes file and folder timestamps, ACLs, and file attributes.

- Can migrate NFS 3.x and 4.x source endpoints. The metadata of the source folder is persisted in the custom metadata field of the blob, just as they are with files.

### Things to consider when using Azure Storage Mover

A single storage mover resource can manage migrations for your source shares. The storage mover resource itself doesn't process your files and folders. Rather, you deploy a migration agent near your source share to send your data directly to the selected targets in Azure.

Azure Storage Mover is a hybrid cloud service. Hybrid services have both a cloud service component and an infrastructure component. The service administrator runs the infrastructure component in their corporate environment. For Storage Mover, that hybrid component consists of a migration agent. Agents are virtual machines, deployed to and run on a host near the source storage.

For the initial bulk migration, you can use Azure Data Box and combine it with Azure Storage Mover for online catch-up. Using Azure Data Box conserves significant network bandwidth. 

## Azure File Sync

[Azure File Sync](/azure/storage/file-sync/file-sync-introduction) is a feature of Azure Files. Azure Files is an Azure service that provides the functionality of an on-premises file share with the benefits of a platform as a service (PaaS) cloud service. Although not strictly a migration tool, Azure File Sync can be used to centralize file shares management. 

Azure File Sync provides the flexibility, performance, and compatibility of an on-premises file server. You can also use Azure File Sync to cache Azure file shares on Windows Server computers for fast access close to where the data is accessed. You can use any protocol that's available on Windows Server to access your data locally, including SMB, NFS, and FTPS.

### Things to consider when using Azure File Sync

There are several common scenarios for working with Azure File Sync and Azure Files.

| Scenario | Description |
| --- | --- |
| _Replace or supplement on-premises file servers_ | Virtually all companies use file servers. Azure Files can completely replace or supplement traditional on-premises file servers or Network Attached Storage (NAS) devices. With Azure file shares and Microsoft Entra Domain Services authentication, you can migrate data to Azure Files and utilize high availability and scalability while minimizing client changes. |
| _Lift and shift (rehome)_ | Azure Files makes it easy to lift-and-shift applications that expect a file share to store application or user data to the cloud. |
| _Backup and disaster recovery_ | You can use Azure file shares as storage for backups, or for disaster recovery to improve business continuity. You can use Azure file shares to back up your data from existing file servers while preserving configured Windows discretionary access control lists (ACLs). Data stored on Azure file shares is protected from disasters that might affect on-premises locations. |
| _Azure File Sync_ | With Azure File Sync, Azure file shares can replicate to Windows Server, either on-premises or in the cloud, for performance and distributed caching of data where it's being used. Consider using Azure File Sync when you want to migrate shared folder content to Azure. This method is especially useful as a means for replacing the Distributed File System on your Windows Servers in your on-premises datacenters. |

> [!NOTE]
> Other third-party migration tools are available. Review this [migration comparison table](/azure/storage/solution-integration/validated-partners/data-management/migration-tools-comparison#overview-comparison).

