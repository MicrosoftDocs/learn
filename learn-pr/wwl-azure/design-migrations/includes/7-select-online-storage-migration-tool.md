In addition to migrating apps, VMs, and databases, it's often necessary to migrate unstructured data. This data might be stored in several locations and be liable to frequent changes. Therefore, migration of storage containing unstructured data can be challenging.

When considering how to migrate online on-premises unstructured data, consider the following options:

- The Windows Server Storage Migration Service

- Azure File Sync

The Windows Server Storage Migration Service is part of Windows Admin Center.

 

### Overview of the Windows Storage Migration Service

Consider using the Storage Migration Service if you have one or more servers that you want to migrate to newer hardware or VMs. By using the Storage Migration Service, you can:

- Conduct an inventory of your servers and their data.

- Rapidly transfer files, file shares, and security configuration from the source servers.

- Take over the identity of the source servers (known as cutting over). This means that users and apps don't have to change anything to access existing data.

- Manage one or multiple migrations from the Windows Admin Center interface.

### Migrate data with the Storage Migration Service

Migration consists of the following three steps:

1. Inventory servers to gather information about their files and configuration.

2. Transfer data from the source to the destination servers.

3. Optionally, cut over to the new servers.

>[!IMPORTANT]
> The destination servers assume the source servers' former identities so that apps and users don't have to change anything.

After migration, the source servers enter a maintenance state. While in this state, the source servers still contain their original files, but are unavailable to users and apps.

>[!TIP]
> Don't remove files from the source servers until you’re ready to completely decommission the servers at your convenience.

As displayed in the following graphic, you can use the Storage Migration Service to migrate data stored in on-premises file servers via Azure File Sync and Azure Migrate to Azure Files and Azure hosted VMs.

:::image type="content" source="../media/storage-migration-service.png" alt-text="Flowchart of the storage migration service moving on-premises data.":::



### Requirements

To use Storage Migration Service, you require:

- A source server, or failover cluster, containing the data you want to migrate.

- A destination server, or failover cluster, to which you want to migrate the data.

- An Orchestrator server to manage the migration.

- A PC or server running Windows Admin Center to run the Storage Migration Service user interface.

>[!NOTE]
> There are additional requirements in terms of security, the Storage Migration Service proxy service, and required firewall port settings.

 

### Use Azure File Sync

Azure File Sync is a feature of Azure Files. Azure Files is an Azure service that provides the functionality of an on-premises file share with the benefits of a platform as a service (PaaS) cloud service. You can use Azure Files in several common scenarios as described in the following table.

| **Usage**| **Description** |
| - | - |
| Replace or supplement on-premises file servers| Virtually all companies use file servers. Azure Files can completely replace or supplement traditional on-premises file servers or Network Attached Storage (NAS) devices. With Azure file shares and AD DS authentication, you can migrate data to Azure Files and utilize high availability and scalability while minimizing client changes. |
| Lift and shift (rehome)| Azure Files makes it easy to lift-and-shift applications that expect a file share to store application or user data to the cloud. |
| Backup and disaster recovery| You can use Azure file shares as storage for backups, or for disaster recovery to improve business continuity. You can use Azure file shares to back up your data from existing file servers while preserving configured Windows discretionary access control lists (ACLs). Data that's stored on Azure file shares isn't affected by disasters that might affect on-premises locations. |
| Azure File Sync| With Azure File Sync, Azure file shares can replicate to Windows Server, either on-premises or in the cloud, for performance and distributed caching of data where it's being used. |


### What is Azure File Sync?

Azure File Sync enables you to centralize your organization's file shares in Azure Files, while keeping the flexibility, performance, and compatibility of an on-premises file server. You can also use Azure File Sync to cache Azure file shares on Windows Server computers for fast access close to where the data is accessed. You can use any protocol that's available on Windows Server to access your data locally, including SMB, NFS, and FTPS.

In addition to using Azure Disks as back-end storage, you can utilize both Azure Files and a file server that's hosted in Azure VMs by installing Azure File Sync on a file server that's hosted on a cloud VM. If the Azure file share is in the same region as your file server, you can enable cloud tiering and set the volume of free space percentage to maximum (99%). This ensures minimal duplication of data. You also can use any applications you want with your file servers, such as applications that require NFS protocol support.

 

### Azure File Sync terminology

If you want to understand how File Sync works, you must understand the terms that relate to it. The following diagram uses this terminology to depict how Azure File Sync works.

:::image type="content" source="../media/azure-file-synchronization-components.png" alt-text="Azure File Sync using the storage synchronization service.":::



- The server running Windows Server in this diagram has the Azure File Sync agent and is registered with Azure File Sync.

- Next to this server are two sync groups: Accounting and Sales.

- The Accounting sync group has D:\Accounting as the server endpoint and the Sales sync group has D:\Sales as the server endpoint.

- Each sync group has a two-way interaction with the cloud endpoint, which means that the server endpoint syncs its content with the cloud endpoint content (the Azure file share is the cloud endpoint).

- Both cloud endpoints have a two-way interaction with the same Storage Sync Service.

- Azure File Sync uses the Storage Sync Service.

- Storage Sync Service has a two-way interaction with the Azure storage account, which symbolizes that the cloud endpoints (Azure file shares) are created in the Azure storage account.

- The storage account has two-way interaction with Azure Backup, which means the Azure storage account can be backed up by using Backup.

After you've configured Azure File Sync, data on the configured on-premises server endpoints is synchronized to Azure Files.

Consider using Azure File Sync when you want to migrate shared folder content to Azure. This is especially useful as a means for replacing the Distributed File System on your Windows Servers in your on-premises datacenters.