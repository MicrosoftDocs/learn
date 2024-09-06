
When deploying an Azure VM, Contoso IT staff must choose the type of disks that will host the operating system disk and optionally any data disks. In addition, each Azure VM will include temporary disks. The following table describes the characteristics of each of these types of disks.

|Type of disk|Description|
|----------------------|------------------------------------------------------------|
|Operating system (OS) disks|Each Azure VM has one OS disk that contains the operating system drive. The maximum size of this disk is 2 terabytes (TB). On Azure VMs running Windows Server, the disk operating system is labeled as drive C. OS disks are managed disks.|
|Data disks|The maximum number of data disks you can attach to the Azure VM is dependent on the Azure VM size. Disks have a maximum size of 32,767 GiB, unless you're using Ultra Disks or Premium SSD v2, which have a maximum size of 65,536 GiB. On Azure VMs running the Windows operating system, you can assign any available drive letter (starting with F), or mount the disk without assigning a drive letter. Data disks are managed disks.|
|Temporary disks|Most VMs contain a temporary disk, which isn't a managed disk. The disk size is dependent on the size of the Azure VM. On VMs running Windows Server, these drives are labeled as drive D. These disks provide temporary, non-persistent storage, and by default, host the paging file. The temporary disk resides on the host where the Azure VM runs. Temporary disks are only intended to store data such as page files, swap files, or SQL Server tempdb. Data on the temporary disk may be lost during maintenance events or when the VM is redeployed.|

## Choose appropriate disk storage

Azure offers two primary tiers of Azure Storage—Standard and Premium—both of which are capable of storing Azure VM disk files. In both cases, Azure VM disks take the form of .vhd files stored as page blobs, because page blobs are optimized for random read-write access.

Premium Storage vs. Standard Storage:

- Premium Storage offers superior performance. VMs that support Premium Storage are required to use Ultra Disks, Premium SSD v2, or Premium SSD.
- Standard Storage provides performance similar to commodity magnetic disks, referred to typically as *hard disk drives* (HDD). Standard Storage includes Standard HDDs and Standard SSDs.

All Azure VM sizes support Standard Storage. A large number of Azure VM sizes also support Premium Storage.

> [!TIP]
> You can easily distinguish Premium Storage by the letter *S* in the Azure VM size designation.

## Choose a disk type

Azure has five different types of managed disks you can select. It's important that you pick the one that best fits your needs.

- **Standard HDD**: This type of storage is spindle disk storage. It might fit well where your application isn't bound by inconsistent latency or lower levels of throughput. A dev/test workload where guaranteed performance isn't required is a great use case for this disk type.
- **Standard SSD**: This SSD-backed storage has the low latency of an SSD, but with lower levels of throughput. A non-production web server is a good use case for this disk type.
- **Premium SSD**: This SSD-backed storage is well suited for those workloads that are going into production and require the high reliability, demand consistent low latency, or need high levels of throughput and IOPS. Because these disks have greater performance and reliability capabilities, they're recommended for all production workloads.
- **Premium SSD v2**: Premium SSD v2 offers higher performance than Premium SSDs while also generally being less costly. You can individually tweak the performance (capacity, throughput, and IOPS) of Premium SSD v2 disks at any time, allowing workloads to be cost efficient while meeting shifting performance needs. For example, a transaction-intensive database may need a large amount of IOPS at a small size, or a gaming application may need a large amount of IOPS but only during peak hours. Because of this, for most general purpose workloads, Premium SSD v2 can provide the best price performance. Premium SSD v2 can't be used as OS disks.
- **Ultra Disks**: Azure ultra disks are the highest-performing storage option for Azure virtual machines (VMs). You can change the performance parameters of an ultra disk without having to restart your VMs. Ultra disks are suited for data-intensive workloads such as SAP HANA, top-tier databases, and transaction-heavy workloads. Ultra disks must be used as data disks and can only be created as empty disks.