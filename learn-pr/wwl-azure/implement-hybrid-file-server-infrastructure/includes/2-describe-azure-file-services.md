

The IT staff at Contoso plan to migrate its file sharing and have asked you to investigate options for moving this shared content to Azure. You discover that Azure Storage offers four types of storage services, depending on the characteristics of data you store. The following table summarizes these storage services.

|Storage service|Description|
|---------------|------------------------------------------------------------|
|Blobs|Blobs typically represent unstructured files such as media content, virtual machine (VM) disks, backups, or logs. Blobs facilitate locking mechanisms, ensuring exclusive file access that IaaS VM disks require.|
|Tables|Tables host nonrelational, semi-structured content, which consists of multiple rows of data. In the context of Azure Table storage, these rows are referred to as *entities*. Developers frequently implement table storage as the backend data store for App Service or Azure Cloud Services.|
|Queues|Queues offer temporary storage for messages that components of distributed applications use to asynchronously communicate with each other. For example, rather than sending a message directly to a destination component, a source component can place the message in a queue. This way, the destination component can process all messages in the queue according to its own schedule, without forcing the source component to wait for an acknowledgment.|
|Files|Like blobs, files provide storage for unstructured data. However, their locking mechanism allows file sharing in a manner that is similar to on-premises Windows file shares.|

In this unit, you'll learn about using Azure Files.

> [!NOTE]
> To use Azure Files, you first must create a storage account.

## What is Azure Files

*Azure Files* is an Azure service that provides the functionality of an on-premises file share with the benefits of a platform as a service (PaaS) cloud service, including:

- Serverless deployment. An Azure file share is a PaaS offering of a fully managed file share that doesn't require any infrastructure. You don't need to take care of any VMs, operating systems, or updates.
- Almost unlimited storage. A single Azure file share can store up to 100 tebibytes (TiB) of files, and a file can be up to 4 TiB in size. The files are organized in a hierarchical folder structure in the same way as on on-premises file servers.
- Data redundancy. Azure file share data replicates to multiple locations in the same Azure datacenter or across many Azure datacenters. The replication setting of the Azure storage account that includes the file share controls the data redundancy.
- Data encryption. The data on an Azure file share is encrypted at rest when it's stored in an Azure datacenter and in transit on a network.
- Access from anywhere. By default, clients can access Azure file shares from anywhere if they have internet connectivity.
- Use of standard protocols. You can access Azure file shares by using the Server Message Block (SMB), Network File System (NFS), and HTTP protocols. Clients can connect to Azure file shares from Windows, Linux, and macOS devices.
- Integration into an existing environment. You can control access to Azure file shares by using Microsoft Entra identities or AD DS identities that are synced to Microsoft Entra ID. This helps ensure that users can have the same experience accessing an Azure file share as when they access an on-premises file server.
- Granular file permissions. You can use NTFS file system permissions to control access (and the level of access) to files on Azure file shares in the same way as with on-premises file servers.
- Previous versions and backups. You can create Azure file share snapshots that integrate with the **Previous Versions** feature in File Explorer. You can also use Azure Backup to back up Azure file shares.
- Optional integration with on-premises file servers. Azure file shares can sync with on-premises file shares to provide benefits such as faster local access, and more free space available in on-premises file servers when using cloud tiering.

You can deploy Azure Files by using the storage account types described in the following table.

|Storage account type|Description|
|-----------------------------------------------------|------------------------------------------------------------|
|Locally redundant storage (LRS)|Data updates replicate synchronously across three copies within a single facility in a single region. LRS protects your data against server hardware failures but not against a failure of the facility itself. This is the only option available for Premium storage accounts.|
|Zone-redundant storage (ZRS)|Data updates replicate asynchronously across three copies that reside in separate datacenters in one or two Azure regions. ZRS offers more resiliency than LRS. However, it doesn't protect against failures that affect an entire region. More importantly, ZRS can contain only block blobs, which makes it unsuitable for hosting IaaS VM disk files, tables, queues, or file shares.|
|Geo-redundant storage (GRS)|Data updates first replicate synchronously within the same region. Then, when the update successfully completes, they replicate asynchronously from the primary region to a secondary region. Predefined pairing between the two regions ensures that data stays within the same geographical area. Data also replicates synchronously across three replicas in each of the regions, resulting in six copies of storage account content. If failure occurs in the primary region, Azure Storage automatically fails over to the secondary region. Effectively, GRS offers improved resiliency over LRS and ZRS.|
|Geographically zone-redundant storage (GZRS)|Data updates first replicate three replicas of your data across multiple Azure Availability Zones, protecting from cluster, datacenter, or an entire zone failure. Then, when the update successfully completes, they replicate asynchronously to another region within the same geographical area within a single zone, such as LRS, protecting from a regional outage. GZRS provides a great balance of high performance, high availability, and disaster recovery and is beneficial when building highly available applications or services in Azure. When using GZRS, you can continue to read and write the data even if one of the availability zones in the primary region is unavailable. In the event of a regional failure, you can also use GZRS to continue having read access.|
|Read-access geographically-redundant storage (RA-GRS)|As with GRS, data updates replicate synchronously within each region and then asynchronously across two regions, resulting in six copies of a storage account. However, with RA-GRS, the copies in the secondary region are readable. This increases availability by giving you the option of redirecting read requests in case the primary region becomes temporarily unavailable. You also can perform near real-time data analysis and reporting tasks without affecting performance of your production workloads.|

Azure Files supports two storage tiers: premium, and standard. Standard file shares are created in general purpose (GPv1 or GPv2) storage accounts, while premium file shares are created in FileStorage storage accounts. The two storage tiers have the attributes described in the following table.

|Storage tier|Description|
|------------|------------------------------------------------------------|
|Premium|Premium tier content is stored on solid-state drives (SSDs), and are available only in the FileStorage type of storage account. Provide consistent high performance and low latency. Are available only for LRS storage accounts. Not available in all Azure regions.|
|Standard|Standard tier content is stored on hard drives and deploy in the general-purpose version 2 (GPv2) storage account type. Provide performance for input/output (I/O) workloads such as general-purpose file shares and dev/test environments. They are available for LRS, ZRS, GRS, and GZRS, in all Azure regions.|

### Common uses of Azure Files

You can use Azure Files in a number of common scenarios as described in the following table.

|Usage|Description|
|----------------------------------------------|------------------------------------------------------------|
|Replace or supplement on-premises file servers|Virtually all companies use file servers. Azure Files can completely replace or supplement traditional on-premises file servers or Network Attached Storage (NAS) devices. With Azure file shares and AD DS authentication, you can migrate data to Azure Files and utilize high availability and scalability while minimizing client changes.|
|Lift and shift|Azure Files makes it easy to lift-and-shift applications that expect a file share to store application or user data to the cloud.|
|Backup and disaster recovery|You can use Azure file shares as storage for backups, or for disaster recovery to improve business continuity. You can use Azure file shares to back up your data from existing file servers while preserving configured Windows discretionary access control lists (ACLs). Data that's stored on Azure file shares isn't affected by disasters that might affect on-premises locations.|
|Azure File Sync|With Azure File Sync, Azure file shares can replicate to Windows Server, either on-premises or in the cloud, for performance and distributed caching of data where it's being used.|

## What is Azure File Sync?

Azure File Sync enables you to centralize your organization's file shares in Azure Files, while keeping the flexibility, performance, and compatibility of an on-premises file server. You can also use Azure File Sync to cache Azure file shares on Windows Server computers for fast access close to where the data is accessed. You can use any protocol that's available on Windows Server to access your data locally, including SMB, NFS, and File Transfer Protocol Service (FTPS).

In addition to using Azure Disks as back-end storage, you can utilize both Azure Files and a file server that's hosted in Azure VMs by installing Azure File Sync on a file server that's hosted on a cloud VM. If the Azure file share is in the same region as your file server, you can enable cloud tiering and set the volume of free space percentage to maximum (99%). This ensures minimal duplication of data. You also can use any applications you want with your file servers, such as applications that require NFS protocol support.
