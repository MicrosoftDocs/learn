Some applications place greater demands on data storage than others. Apps such as Dynamics CRM, Exchange Server, SAP Business Suite, SQL Server, Oracle, and SharePoint require constant high performance and low latency to run at their best.

When creating your VMs or adding new disks, you have a few choices which will have a dramatic impact on disk performance, starting with the _type_ of storage you choose.

## Types of disks 
Azure Disks are designed for 99.999% availability. 

There are three performance tiers for storage that you can choose from when creating your disks -- Premium SSD Disks, Standard HDD storage, and Standard SSD. Depending on the VM size, you can mix and match these disk types.

### Premium SSD disks 

Premium SSD disks are backed by solid-state drives (SSDs), and deliver high-performance, low-latency disk support for VMs running I/O-intensive workloads. These drives tend to be more reliable because they have no moving parts. A read or write head doesn't have to move to the correct location on a disk to find the data requested. 

You can use Premium SSD disks with VM sizes that include an "s" in the series name. For example, there is the **Dv3-Series** and the **Dsv3-series**, the **Dsv3-series** can be used with Premium SSD disks.

### Standard HDD storage

Standard HDD disks are backed by traditional hard disk drives (HDDs). Standard HDD disks are billed at a lower rate than the Premium disks. Standard HDD disks can be used with any VM size.

### Standard SSD

Premium storage is limited to specific VM sizes - so the VM type you create will impact the storage capabilities: size, max capacity, and storage type. What if you have a low-end VM, but you need SSD storage for I/O performance? That's what Standard SSDs are for. Standard SSDs are between standard HDDs and premium SSDs from a performance and cost perspective.

You can use standard SSDs with any VM size, including VM sizes that don't support premium storage. Using standard SSDs is the only way to use SSDs with those VMs. This disk type is only available in specific regions and only with _managed disks_.

### Unmanaged versus managed disks

When you create VMs or VHDs, you have the choice to use **unmanaged** or **managed** disks.

With unmanaged disks, you are responsible for the storage accounts that are used to hold the VHDs that correspond to your VM disks. You pay the storage account rates for the amount of space you use. A single storage account has a fixed rate limit of 20,000 I/O operations/sec. This means that a single storage account is capable of supporting 40 standard virtual hard disks at full throttle. If you need to scale out, then you need more than one storage account, which can get complicated.

Managed disks are the newer and **recommended disk storage model**. They elegantly solve this complexity by putting the burden of managing the storage accounts onto Azure. You specify the disk type, and the size of the disk and Azure creates and manages both the disk _and_ the storage it uses. You don't have to worry about storage account limits, which makes them easier to scale out. Here are some of the benefits you get over the older unmanaged disks:

- **Increased reliability**: Azure ensures that VHDs associated with high-reliability VMs will be placed in different parts of Azure storage to provide similar levels of resilience.
- **Better security**: Managed disks are managed resources in the resource group. This means they can use role-based access control to restrict who can work with the VHD data.
- **Snapshot support**: Snapshots can be used to create a read-only copy of a VHD. You have to shut down the owning VM but creating the snapshot only takes a few seconds. Once it's done, you can power on the VM and use the snapshot to create a duplicate VM to troubleshoot a production issue or rollback the VM to the point in time that the snapshot was taken.
- **Backup support**: Managed disks can be automatically backed up to different regions for disaster recovery with Azure Backup all without affecting the service of the VM.

With all the additional benefits, including the guaranteed performance characteristics, you should always choose managed disks for new VMs.

### Disk comparison
The following table provides a comparison of Standard HDD, Standard SSD, and Premium SSD to help you decide what to use.

|    | Azure Premium Disk |Azure Standard SSD Disk (preview)| Azure Standard HDD Disk 
|--- | ------------------ | ------------------------------- | ----------------------- 
| **Disk Type** | Solid State Drives (SSD) | Solid State Drives (SSD) | Hard Disk Drives (HDD)  
| **Overview**  | SSD-based high-performance, low-latency disk support for VMs running IO-intensive workloads or hosting mission-critical production environment |More consistent performance and reliability than HDD. Optimized for low-IOPS workloads| HDD-based cost-effective disk for infrequent access
| **Scenario**  | Production and performance sensitive workloads |Web servers, lightly used enterprise applications, and Dev/Test| Backup, Non-critical, Infrequent access 
| **Disk Size** | 32-4095 GiB | 128-4095 GiB | 32-4095 GiB 
| **Max Throughput per disk** | 250 MiB/s | Up to 60 MiB/s | Up to 60 MiB/s 
| **Max IOPS per disk** | 7500 IOPS | Up to 500 IOPS | Up to 500 IOPS 

There is more detail on disk performance below.

## Data replication

The data in your Microsoft Azure storage account is always replicated to ensure durability and high availability. Azure Storage replication copies your data so that it's protected from planned and unplanned events like transient hardware failures, network or power outages, natural disasters, and so on. You can choose to replicate your data within the same data center, across zonal data centers within the same region, and even across regions. There are four types of replication:

- **Locally redundant storage (LRS)** - Azure replicates the data within the same Azure data center. The data remains available if a node fails. However, if an entire data center fails, data may be unavailable.
- **Geo-redundant storage (GRS)** - Azure replicates your data to a second region that is hundreds of miles away from the primary region. If your storage account has GRS enabled, then your data is durable even if there's a complete regional outage or a disaster in which the primary region isn't recoverable.
- **Read-access geo-redundant storage (RA-GRS)** - Azure provides read-only access to the data in the secondary location, and geo-replication across two regions. If a data center fails, the data remains readable but can't be modified.
- **Zone-redundant storage (ZRS)** - Azure replicates your data synchronously across three storage clusters in a single region. Each storage cluster is physically separated from the others and resides in its own availability zone (AZ). With this type of replication, you can still access and manage your data in the event that a zone becomes unavailable.

Standard storage accounts support all replication types, but premium storage accounts only support locally redundant storage (LRS). Since VMs themselves run in a single region, this restriction isn't usually an issue for VHD storage.

## Disk performance

The performance of your disks depends on the type of disk you chose. Each disk is rated to a specific number of I/O operations per second, or IOPS (pronounced "eye-ops"). In addition, each drive has a throughput rating - this determines how much data you can read or write in a second. The combination of these two determines how fast the disk is.

With standard storage, you get a maximum of **500 IOPS and 60 MB/second** throughput per disk (even on SSDs). With premium storage, the IOPS depends on the premium disks you choose and the VM size.

|  | P4 | P6 | P10 | P20 | P30 | P40 | P50 |
|--|----|----|-----|-----|-----|-----|-----|
| **Disk Size** | 32 GiB | 64 GiB | 128 GiB | 512 GiB | 1 TiB | 2 TiB | 4 TiB |
| **Max IOPS per disk** | 120 | 240 | 500 | 2300 | 5000 | 7500 | 7500 |
| **Max Throughput per disk** | 25 MB/sec | 50 MB/sec | 100 MB/sec | 200 MB/sec | 250 MB/sec | 250 MB/sec |

As you can see, you can go from **25 MB/sec** and **120 IOPS** to **250 MB/sec** and **7500 IOPS**.