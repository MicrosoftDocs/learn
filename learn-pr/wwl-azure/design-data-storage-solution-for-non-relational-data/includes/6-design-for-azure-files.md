Moving a company's shared files into the cloud-based [Azure Files](/azure/storage/files/storage-files-introduction) requires an analysis of the options and a plan for the implementation. There's an important decision to make. How are you going to access and update the files? You could choose to replace your existing Server Message Block (SMB) file shares with their equivalent in Azure Files. The other option is to set up an instance of Azure File Sync. If you choose to use Azure File Sync, there's more flexibility on how files are secured and accessed. 

### What are Azure Files?

:::image type="content" source="../media/azure-files.png" alt-text="Account, share, directories, and files.":::

 

You can think of Azure Files as a standard file share, hosted on Azure, that you can access with the industry standard SMB/CIFS protocol. You can mount or connect to an Azure file share at the same time on all the main operating systems.

Azure Files can be used to add to or replace a company's existing on-premises NAS devices or file servers. Some reasons why your organization will want to use Azure Files are:

- Developers can store apps and configuration files in a file share and connect new VMs to the shared files. This action reduces the time to get new machines into production.

- With file shares on Azure, a company doesn't need to buy and deploy expensive redundant hardware and manage software updates. The shares are cross-platform, and you can connect to them from Windows, Linux, or macOS.

- All the resilience of the Azure platform is inherited by your file share, which makes files globally redundant. You also gain options to use the integrated snapshots feature and set up automatic backups by using Recovery Services vaults.

- All the data is encrypted in transit by using HTTPS and is stored encrypted when at rest.

### Choose your data access method

Azure file shares can be used in two ways: by directly mounting these serverless Azure file shares (SMB) or by caching Azure file shares on-premises using Azure File Sync.

- **Direct mount of an Azure file share**: Since Azure Files provides SMB access, you can mount Azure file shares on-premises or in the cloud, Mounting uses the standard SMB client available in Windows, macOS, and Linux. Because Azure file shares are serverless, deploying for production scenarios doesn’t require managing a file server or NAS device. Direct mounting means you don't have to apply software patches or swap out physical disks.

- **Cache Azure file share on-premises with Azure File Sync**: [Azure File Sync](/azure/storage/file-sync/file-sync-introduction) lets you centralize your organization's file shares. Azure Files provides the flexibility, performance, and compatibility of an on-premises file server. Azure File Sync transforms an on-premises (or cloud) Windows Server into a quick cache of your Azure file share.

### [**Choose your performance level**](/azure/storage/files/storage-files-scale-targets)

Because Azure Files stores files in a storage account, you can choose between standard or premium performance storage accounts.

| **Performance level**| **Latency**| **IOPS**| **Bandwidth** |
| - | -| - | -|
| Standard| Double-digit ms| 10,000 IOPS| 300-MBps |
| Premium| Single-digit ms| 100,000 IOPS| 5-GBps |


Standard performance accounts use HDD to store data. With HDD, the costs are lower but so is the performance. SSD arrays back the premium storage account's performance, which comes with higher costs. Currently, premium accounts can only use file storage accounts with ZRS storage in a limited number of regions.

### Determine your storage tier

Azure Files offers four different tiers of storage, premium, transaction optimized, hot, and cool. These tiers allow you to tailor your shares to the performance and price requirements of your scenario.

| **Storage tier**| **Usage** |
| - | - |
| Premium| File shares are backed by solid-state drives (SSDs) and provide consistent high performance and low latency. Used for the most intensive IO workloads. Suitable workloads include databases, web site hosting, and development environments. Can be used with both Server Message Block (SMB) and Network File System (NFS) protocols. |
| Transaction optimized| Used for transaction heavy workloads that don't need the latency offered by premium file shares. File shares are offered on the standard storage hardware backed by hard disk drives (HDDs). |
| Hot| Storage optimized for general purpose file sharing scenarios such as team shares. Offered on standard storage hardware backed by HDDs. |
| Cool| Cost-efficient storage optimized for online archive storage scenarios. Offered on storage hardware backed by HDDs. |



### When to use Azure files instead of Azure blobs or Azure NetApp Files


Let’s take a minute to review when you should select Azure blob storage or [Azure NetApp Files](/azure/azure-netapp-files/) instead of Azure file storage. 

NetApp Files is a fully managed, highly available, enterprise-grade NAS service. NetApp Files can handle the most demanding, high-performance, low-latency workloads. It enables the migration of workloads, which are deemed "un-migratable" without. 

[Your decision on which technology](/azure/storage/common/nfs-comparison) depends on the use case, protocol, and performance required. 

 

| **Category**| **Azure Blob Storage**| **Azure Files**| **Azure NetApp Files** |
| - | -| -| - |
| Use cases| Blob Storage is best suited for large scale read-heavy sequential access workloads where data is ingested once and modified later. <br><br>Blob Storage offers the lowest total cost of ownership, if there is little or no maintenance. <br><br>‎Some example scenarios are: Large scale analytical data, throughput sensitive high-performance computing, backup and archive, autonomous driving, media rendering, or genomic sequencing.| Azure Files is a highly available service best suited for random access workloads.  <br><br>‎For NFS shares, Azure Files provides full POSIX file system support and can easily be used from container platforms like Azure Container Instance (ACI) and Azure Kubernetes Service (AKS) with the built-in CSI driver, in addition to VM-based platforms. <br><br>‎Some example scenarios are: Shared files, databases, home directories, traditional applications, ERP, CMS, NAS migrations that don't require advanced management, and custom applications requiring scale-out file storage.| Fully managed file service in the cloud, powered by NetApp, with advanced management capabilities.  <br><br>NetApp Files is suited for workloads that require random access and provides broad protocol support and data protection capabilities.  <br><br>‎Some example scenarios are: On-premises enterprise NAS migration that requires rich management capabilities, latency sensitive workloads like SAP HANA, latency-sensitive or IOPS intensive high performance compute, or workloads that require simultaneous multi-protocol access. |
| Available protocols| NFS 3.0  <br>REST  <br>Data Lake Storage Gen2| SMB  <br>NFS 4.1 (preview)  <br>‎(No interoperability between either protocol)| NFS 3.0 and 4.1  <br>SMB |
| Performance (Per volume)| Up to 20,000 IOPS, up to 100 GiB/s throughput.| Up to 100,000 IOPS, up to 80 Gib/s throughput.| Up to 460,000 IOPS, up to 36 Gib/s throughput. |


 
 

> [!Tip]
> Take a few minutes to think through your company file share strategy. Will you need files shares? Will you need file sync? 