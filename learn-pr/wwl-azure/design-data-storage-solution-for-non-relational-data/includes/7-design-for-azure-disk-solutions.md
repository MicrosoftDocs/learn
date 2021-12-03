For this module, we’ll concern ourselves with data disks. Data disks are used by virtual machines to store data. For example, database files, website static content, or custom application code would be stored on data disks. The number of data disks you can add depends on the virtual machine size. Each data disk has a maximum capacity of 32,767 GB.

> [!Tip]
> Microsoft recommends always using managed disks. With [managed disks](/azure/virtual-machines/managed-disks-overview), you specify the disk size, the disk type, and provision the disk. Once you provision the disk, Azure handles the rest. 

### Determine the type of data disk

Azure offers several types of data disks. When selecting a disk type, consider your scenario, throughput, and IOPS. The following table provides a [comparison of the four disk types](/azure/storage/common/nfs-comparison). 

| **Detail**| **Ultra-disk**| **Premium SSD**| **Standard SSD**| **Standard HDD** |
| - | - | - | - | -|
| Disk type| SSD| SSD| SSD| HDD |
| Scenario| IO-intensive workloads such as SAP HANA, top tier databases (for example, SQL, Oracle), and other transaction-heavy workloads.| Production and performance sensitive workloads| Web servers, lightly used enterprise applications and dev/test| Backup, non-critical, infrequent access |
| Max throughput| 2,000 MB/s| 900 MB/s| 750 MB/s| 500 MB/s |
| Max IOPS| 160,000| 20,000| 6,000| 2,000 |


 

- **Ultra-disk storage**. Azure Ultra Disk storage provides the best performance. Choose this option when you need the fastest storage performance in addition to high throughput, high input/output operations per second (IOPS), and low latency. Ultra-disk storage may not be available in all regions. 

- **Premium SSD storage**. Azure Premium SSD-managed disks provide high throughput and IOPS with low latency. These disks offer a slightly less performance compared to Ultra Disk Storage. Premium SSD storage is available in all regions.

- **Standard SSD.** Azure Standard SSD-managed disks are a cost-effective storage option for VMs that need consistent performance at lower speeds. Standard SSD disks aren't as fast as Premium SSD disks or Ultra Disk Storage. You can attach Standard SSD disks to any VM.

- **Standard HDD.** In Azure Standard HDD-managed disks, data is stored on conventional magnetic disk drives that have moving spindles. Disks are slower and the variation in speeds is higher compared to solid-state drives (SSDs). Like Standard SSD disks, you can use Standard HDD disks for any VM.

>[!TIP]
>Read more about how to [Select a disk type for Azure IaaS VMs - managed disks - Azure Virtual Machines | Microsoft Docs](/azure/virtual-machines/disks-types).

### Improve performance with disk caching

Azure virtual machine [disk caching](/azure/virtual-machines/premium-storage-performance) is about optimizing read and write access to the virtual hard disk (VHD) files. These VHDs are attached to Azure virtual machines. Here are the recommended disk cache settings for data disks. 

| **Disk caching setting**| **Recommendation** |
| - | - |
| None| Use for write-only and write-heavy disks. |
| Read only| Use for read-only and read-write disks. Provides low read latency and high read IOPS and throughput. |
| Read & write| Use only if your application properly handles writing cached data to persistent disks. |


Warning: Disk Caching isn’t supported for disks 4 TiB and larger. When multiple disks are attached to your VM, each disk that is smaller than 4 TiB will support caching. Changing the cache setting of an Azure disk detaches and reattaches the target disk. When it’s the operating system disk, the VM is restarted. 

### Secure your data disks with encryption

There are several encryption types available for your managed disks. Encryption types includes Azure Disk Encryption (ADE), Server-Side Encryption (SSE) and encryption at host.

- [Azure Disk Encryption ](/azure/virtual-machines/linux/disk-encryption-overview) ADE encrypts the virtual machine's virtual hard disks (VHDs). If VHD is protected with ADE, the disk image will only be accessible by the virtual machine that owns the disk.

- [Server-Side Encryption ](/azure/virtual-machines/disk-encryption)(also referred to as encryption-at-rest or Azure Storage encryption) is performed on the physical disks in the data center. If someone directly accesses the physical disk, the data will be encrypted. When the data is accessed from the disk, it’s decrypted and loaded into memory.

- [Encryption at host ](/azure/virtual-machines/disk-encryption)ensures that data stored on the VM host is encrypted at rest and flows encrypted to the Storage service. Disks with encryption at host enabled aren’t encrypted with SSE. Instead, the server hosting your VM provides the encryption for your data, and that encrypted data flows into Azure Storage.

> [!NOTE]
> To fully protect your data disks, combine encryption services.