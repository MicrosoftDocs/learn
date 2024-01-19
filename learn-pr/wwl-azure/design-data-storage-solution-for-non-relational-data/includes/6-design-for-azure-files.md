

[Azure Files](/azure/storage/files/storage-files-introduction) provides fully managed cloud-based file shares that are hosted on Azure. Shared files are accessible by using the industry standard Server Message Block (SMB) protocol, Network File System (NFS) protocol, and the Azure Files REST API. You can mount or connect to an Azure file share at the same time on all the main operating systems.

:::image type="content" source="../media/azure-files.png" alt-text="Diagram that shows an Azure storage account, Azure Files and file shares, directories, and files." border="false":::

### Things to know about Azure Files

Azure Files can be used to add to or replace a company's existing on-premises network attached storage (NAS) devices or file servers. Here are some reasons why your organization might want to use Azure Files:

- Developers can store apps and configuration files in a file share and connect new VMs to the shared files. This action reduces the time to get new machines into production.

- With file shares on Azure, a company doesn't need to buy and deploy expensive redundant hardware and manage software updates. The shares are cross-platform, and you can connect to them from Windows, Linux, or macOS.

- All the resilience of the Azure platform is inherited by your file share, which makes files globally redundant. You also gain options to use the integrated snapshots feature, and set up automatic backups by using Recovery Services vaults.

- All the data is encrypted in transit by using HTTPS and is stored encrypted when at rest.

#### Choose your data access method

To move your company's shared files into Azure Files, you need to analyze your options and make an important decision. How are you going to access and update the files? You could replace your existing Server Message Block (SMB) file shares with their equivalent in Azure Files. Another option is to set up an instance of [Azure File Sync](/azure/storage/file-sync/file-sync-introduction). If you choose to use Azure File Sync, there's more flexibility on how files are secured and accessed. 

Azure file shares can be used in two ways. You can directly mount serverless Azure file shares (SMB) or cache Azure file shares on-premises by using Azure File Sync.

- **Direct mount of Azure file shares**: Because Azure Files provides SMB access, you can mount Azure file shares on-premises or in the cloud. Mounting uses the standard SMB client available in Windows, macOS, and Linux. Because Azure file shares are serverless, deploying for production scenarios doesn't require managing a file server or NAS device. Direct mounting means you don't have to apply software patches or swap out physical disks.

- **Cache Azure file shares on-premises with Azure File Sync**: Azure File Sync lets you centralize your organization's file shares. Azure Files provides the flexibility, performance, and compatibility of an on-premises file server. Azure File Sync transforms an on-premises (or cloud) Windows Server into a quick cache of your Azure file share.

#### Choose your performance level

Because Azure Files stores files in a storage account, you can [choose your performance level](/azure/storage/files/storage-files-scale-targets). Performance metrics differ between standard and premium storage account levels. Premium accounts offer lower latency and higher IOPS and bandwidth.

Standard performance accounts use HDD to store data. With HDD, the costs are lower but so is the performance. SSD arrays back the premium storage account's performance, which comes with higher costs. Currently, premium accounts can only use file storage accounts with ZRS storage in a limited number of regions.

#### Determine your storage tier

Azure Files offers four tiers of storage. These tiers allow you to tailor your file shares to meet the performance and price requirements for your scenarios.

- **Premium**: File shares are backed by solid-state drives (SSDs) and provide consistent high performance and low latency. Used for the most intensive IO workloads. Suitable workloads include databases, web site hosting, and development environments. Can be used with both Server Message Block (SMB) and Network File System (NFS) protocols.

- **Transaction optimized**: Used for transaction heavy workloads that don't need the latency offered by premium file shares. File shares are offered on the standard storage hardware backed by hard disk drives (HDDs). 

- **Hot access tier**: Storage optimized for general purpose file sharing scenarios such as team shares. Offered on standard storage hardware backed by HDDs.

- **Cool access tier**: Cost-efficient storage optimized for online archive storage scenarios. Offered on storage hardware backed by HDDs.

### Things to consider when choosing your implementation

[Your decision about which technology](/azure/storage/common/nfs-comparison) to implement depends on your business use cases, the protocols required for your files, and your performance goals. We've reviewed considerations for using Azure Blob Storage and Azure Files. Another option is to use [Azure NetApp Files](/azure/azure-netapp-files/), which is a fully managed, highly available, enterprise-grade NAS service. Azure NetApp Files can handle the most demanding, high-performance, low-latency workloads. You can migrate workloads that are deemed "un-migratable."

The following table compares features and uses cases for these three implementation options. Consider how you might implement Azure Blob Storage or Azure NetApp Files instead of Azure Files storage for Tailwind Traders.

| Comparison | Azure Blob Storage | Azure Files | Azure NetApp Files |
| --- | --- | --- | --- |
| **Description** | Azure Blob Storage is best suited for large scale read-heavy sequential access workloads where data is ingested once and modified later. <br><br>Blob Storage offers the lowest total cost of ownership, if there's little or no maintenance. | Azure Files is a highly available service best suited for random access workloads. <br><br>For NFS shares, Azure Files provides full POSIX file system support and can easily be used from container platforms like Azure Container Instance (ACI) and Azure Kubernetes Service (AKS) with the built-in CSI driver, in addition to VM-based platforms. | Azure NetApp Files is a fully managed file service in the cloud, powered by NetApp, with advanced management capabilities. <br><br>Azure NetApp Files is suited for workloads that require random access and provides broad protocol support and data protection capabilities. |
| **Use cases** | Large scale analytical data, Throughput sensitive high-performance computing, Backup and archive, Autonomous driving, Media rendering, or Genomic sequencing | Shared files, Databases, Home directories, Traditional applications, ERP, CMS, NAS migrations that don't require advanced management, Custom applications that require scale-out file storage | On-premises enterprise NAS migration that requires rich management capabilities, Latency sensitive workloads like SAP HANA, Latency-sensitive or IOPS intensive high performance compute, Workloads that require simultaneous multi-protocol access |
| **Available protocols** | - NFS 3.0 <br> - REST <br> - Data Lake Storage Gen2 | - SMB <br> - NFS 4.1 <br> - REST | - NFS 3.0 and 4.1 <br> - SMB |
| **Performance (per volume)** | Up to 20,000 IOPS, up to 15 GiB/s throughput | Up to 100,000 IOPS, up to 10 GiB/s throughput | Up to 460,000 IOPS, up to 4.5 GiB/s throughput for regular volumes, up to 10 GiB/s throughput for large volumes |