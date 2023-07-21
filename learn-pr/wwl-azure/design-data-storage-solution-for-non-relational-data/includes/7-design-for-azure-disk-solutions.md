

Azure offers many disk solutions. In this module, we examine how to work with data disks by using Azure managed disks.

Data disks are used by virtual machines to store data like database files, website static content, or custom application code. The number of data disks you can add depends on the virtual machine size. Each data disk has a maximum capacity of 32,767 GB.

> [!Tip]
> Microsoft recommends always using [Azure managed disks](/azure/virtual-machines/managed-disks-overview). You specify the disk size, the disk type, and provision the disk. Azure handles the remaining operations. 

### Things to know about managed disks

Azure offers several types of managed disks. The following table shows a [comparison of four data disk types](/azure/virtual-machines/disks-types#disk-type-comparison). 

| Comparison | Ultra-disk | Premium SSD | Standard SSD | Standard HDD |
| --- | --- | --- | --- | --- |
| **Disk type** | SSD | SSD | SSD | HDD |
| **Scenario** | IO-intensive workloads, such as SAP HANA, top tier databases like SQL Server and Oracle, and other transaction-heavy workloads | Production and performance sensitive workloads | Web servers, Lightly used enterprise applications, Development and testing | Backup, Non-critical, Infrequent access |
| **Max throughput** | 2,000 Mbps| 900 Mbps| 750 Mbps| 500 Mbps |
| **Max IOPS** | 160,000 | 20,000 | 6,000 | 2,000 |

#### Choose an encryption option

There are several encryption types available for your managed disks.

- **[Azure Disk Encryption (ADE)](/azure/virtual-machines/linux/disk-encryption-overview)** encrypts the VM's virtual hard disks (VHDs). If VHD is protected with ADE, the disk image is accessible only by the VM that owns the disk.

- **[Server-Side Encryption (SSE)](/azure/virtual-machines/disk-encryption)** is performed on the physical disks in the data center. If someone directly accesses the physical disk, the data will be encrypted. When the data is accessed from the disk, it's decrypted and loaded into memory. This form of encryption is also referred to as _encryption at rest_ or Azure Storage encryption.

- **[Encryption at host](/azure/virtual-machines/disk-encryption)** ensures that data stored on the VM host is encrypted at rest and flows encrypted to the Storage service. Disks with encryption at host enabled aren't encrypted with SSE. Instead, the server hosting your VM provides the encryption for your data, and that encrypted data flows into Azure Storage.

### Things to consider when using managed disks

Think about what data disk types are needed for Tailwind Traders. Consider your scenarios, throughput, and IOPS.

- **Consider your scenarios, throughput, and IOPS**. Compare disk types and choose the data disks that satisfy your business scenarios, and throughput and IOPS requirements. For more information, see [Select a disk type for Azure IaaS VMs - managed disks](/azure/virtual-machines/disks-types)

   - **Ultra-disk storage**: Azure Ultra Disk storage provides the best performance. Choose this option when you need the fastest storage performance in addition to high throughput, high input/output operations per second (IOPS), and low latency. Ultra-disk storage might not be available in all regions. 

   - **Premium SSD storage**: Azure Premium SSD-managed disks provide high throughput and IOPS with low latency. These disks offer a slightly less performance compared to Ultra Disk Storage. Premium SSD storage is available in all regions.

   - **Standard SSD**: Azure Standard SSD-managed disks are a cost-effective storage option for VMs that need consistent performance at lower speeds. Standard SSD disks aren't as fast as Premium SSD disks or Ultra Disk Storage. You can attach Standard SSD disks to any VM.

   - **Standard HDD**: In Azure Standard HDD-managed disks, data is stored on conventional magnetic disk drives that have moving spindles. Disks are slower and the variation in speeds is higher compared to solid-state drives (SSDs). Like Standard SSD disks, you can use Standard HDD disks for any VM.

- **Consider data caching**. Improve performance with disk caching. Azure Virtual Machines [disk caching](/azure/virtual-machines/premium-storage-performance#disk-caching) optimizes read and write access to the virtual hard disk (VHD) files. The VHDs are attached to Azure Virtual Machines. For OS disks, the default cache setting is `ReadWrite`, and for data disks, the default is `ReadOnly`.

   > [!Warning]
   > Disk caching isn't supported for disks 4 TiB and larger. When multiple disks are attached to your Virtual Machine, each disk smaller than 4 TiB supports caching. Changing the cache setting of an Azure disk, detaches and reattaches the target disk. When it's the OS disk, the VM is restarted. 

- **Consider using encryption**. Secure your data disks with encryption. To fully protect your data disks, combine encryption services: ADE, SSE, and encryption at rest.