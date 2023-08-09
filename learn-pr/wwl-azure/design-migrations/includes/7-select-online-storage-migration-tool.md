In addition to migrating applications, virtual machines, databases, and other structured data, organizations also need to move unstructured data. This data might be stored in several locations and be liable to frequent changes. As a result, migrating storage that contains unstructured data can be challenging. For your Tailwind Traders migration planning, we'll examine how to move online on-premises unstructured data with the Azure Storage Migration Service and Azure File Sync.

## Azure Storage Migration Service

The Azure Storage Migration Service in the Windows Admin Center is helpful when you need to move servers to newer hardware or virtual machines. You can use the Migration Service to assist with migrating your unstructured data in several ways, including:

- Conduct an inventory of your servers and their data
- Rapidly transfer files, file shares, and security configuration from the source servers
- Take over the identity of the source servers (or _cut over_) 
- Manage one or multiple migrations from the Windows Admin Center interface

### Things to know about the Migration Service

The Azure Storage Migration Service can help you migrate unstructured data stored in on-premises file servers to Azure Files and Azure-hosted virtual machines. The migration process is accomplished through capabilities provided by the Migration Service, Azure File Sync, and Azure Migrate.

:::image type="content" source="../media/storage-migration-service.png" alt-text="Illustration that shows how the Azure Storage Migration Service moves on-premises data." border="false":::

#### Migrating online on-premises unstructured data

The Azure Storage Migration Service implements three steps to move your online on-premises unstructured data:

1. **Inventory servers**: The Migration Service inventories your servers to gather information about their files and configuration.

1. **Transfer data**: The Migration Service transfers your data from the source to the destination servers.

1. **Cut over (option)**: As an option, the Migration Service cuts over to the new servers.

### Things to consider when using the Migration Service

To migrate your unstructured data with the Azure Storage Migration Service, you need to prepare the following configuration:

- Select the source server or failover cluster containing the data to migrate
- Select a destination server or failover cluster to receive the migrated data
- Identify an orchestrator server to manage the migration
- Prepare your PC or server with Windows Admin Center to run the Migration Service user interface
- Satisfy requirements for security, the Migration Service proxy service, and firewall port settings

> [!IMPORTANT]
> 
> **During migration**
> 
> When you use the **cut over** option, the destination servers assume the former identities of the source servers.
> This option enables users and apps to access your existing data without making any changes.
> 
> **After migration**
> 
> When migration is complete, your source servers enter a maintenance state.
> While the servers are in this state, the servers still contain their original files, but the data isn't available to users and apps.
> 
> **Decommision**
> 
> Don't remove files from your source servers until you're ready to completely decommission the servers.
> The decommission process can be completed at your convenience.

## Azure File Sync

Azure File Sync is a feature of Azure Files. Azure Files is an Azure service that provides the functionality of an on-premises file share with the benefits of a platform as a service (PaaS) cloud service. 

Azure File Sync enables you to centralize your organization's file shares in Azure Files, while keeping the flexibility, performance, and compatibility of an on-premises file server. You can also use Azure File Sync to cache Azure file shares on Windows Server computers for fast access close to where the data is accessed. You can use any protocol that's available on Windows Server to access your data locally, including SMB, NFS, and FTPS.

In addition to using Azure Disks as back-end storage, you can utilize both Azure Files and a file server that's hosted in Azure virtual machines. This method involves installing Azure File Sync on a file server that's hosted on a cloud virtual machine. If the Azure file share is in the same region as your file server, you can enable cloud tiering and set the volume of free space percentage to maximum (99%). This option ensures minimal duplication of data. You also can use any applications you want with your file servers, such as applications that require NFS protocol support.

### Things to know about Azure File Sync

Let's take a closer look at how Azure File Sync works by using the Storage Sync Service.

:::image type="content" source="../media/azure-file-synchronization-components.png" alt-text="Diagram that shows how Azure File Sync uses the Storage Sync Service." border="false":::

- In the diagram, the server running Windows Server has the Azure File Sync agent and is registered with Azure File Sync.

- Next to this server are two sync groups: Accounting and Sales.

- The Accounting sync group has `D:\Accounting` as the server endpoint. The Sales sync group has `D:\Sales` as the server endpoint.

- Each sync group has a two-way interaction with the cloud endpoint. The server endpoint syncs its content with the cloud endpoint content. (The Azure file share is the cloud endpoint.)

- Both cloud endpoints have a two-way interaction with the same Storage Sync Service.

- Azure File Sync uses the Storage Sync Service.

- The Storage Sync Service has a two-way interaction with the Azure storage account. The cloud endpoints (Azure file shares) are created in the Azure storage account.

- The storage account has two-way interaction with Azure Backup. The Azure storage account can be backed up by using Backup.

After you configure Azure File Sync, data on your configured on-premises server endpoints is synchronized to Azure Files. 

### Things to consider when using Azure Files and Azure File Sync

There are several common scenarios for working with Azure File Sync and Azure Files.

| Scenario | Description |
| --- | --- |
| _Replace or supplement on-premises file servers_ | Virtually all companies use file servers. Azure Files can completely replace or supplement traditional on-premises file servers or Network Attached Storage (NAS) devices. With Azure file shares and Azure Active Directory Domain Services (Azure AD DS) authentication, you can migrate data to Azure Files and utilize high availability and scalability while minimizing client changes. |
| _Lift and shift (rehome)_ | Azure Files makes it easy to lift-and-shift applications that expect a file share to store application or user data to the cloud. |
| _Backup and disaster recovery_ | You can use Azure file shares as storage for backups, or for disaster recovery to improve business continuity. You can use Azure file shares to back up your data from existing file servers while preserving configured Windows discretionary access control lists (ACLs). Data that's stored on Azure file shares isn't affected by disasters that might affect on-premises locations. |
| _Azure File Sync_ | With Azure File Sync, Azure file shares can replicate to Windows Server, either on-premises or in the cloud, for performance and distributed caching of data where it's being used. Consider using Azure File Sync when you want to migrate shared folder content to Azure. This method is especially useful as a means for replacing the Distributed File System on your Windows Servers in your on-premises datacenters. |