Some applications place greater demands on storage than others. Apps such as Dynamics CRM, Exchange Server, SAP Business Suite, SQL Server, Oracle, and SharePoint require constant high performance and low latency to run at their best.

When creating your VMs or adding new disks, you have a few choices that will have a dramatic impact on disk performance, starting with the *type* of storage you choose.

## Types of disks 

Azure Disks are designed for 99.999% availability. 

There are five types of disks you can choose when creating a managed disk: Ultra disks, Premium SSD v2,  Premium SSD, Standard SSD, and Standard HDD storage. Depending on the VM size, you can mix and match these disk types.

### Ultra Disk

Azure Ultra Disks deliver high throughput, high IOPS, and consistent low-latency disk storage for Azure IaaS VMs. Ultra Disks include the ability to dynamically change the performance of the disk without the need to restart your virtual machines (VM). Ultra disks are suited for data-intensive workloads such as SAP HANA, top tier databases, and transaction-heavy workloads. You can only use Ultra disks as data disks. We recommend using Premium SSDs as OS disks.

### Premium SSD v2

Premium SSD v2 offers higher performance than Premium SSDs while also generally being less costly. You can individually tweak the performance (capacity, throughput, and IOPS) of Premium SSD v2 disks at any time, allowing workloads to be cost efficient while meeting shifting performance needs. For example, a transaction-intensive database may need a large amount of IOPS at a small size, or a gaming application may need a large amount of IOPS but only during peak hours. Because of this, for most general purpose workloads, Premium SSD v2 can provide the best price performance. Premium SSD v2 is suited for a broad range of workloads such as SQL server, Oracle, MariaDB, SAP, Cassandra, Mongo DB, big data/analytics, and gaming, on virtual machines or stateful containers.

You can only use Premium SSD v2 as data disks, we recommend using Premium SSDs as OS disks.

### Premium SSD

Premium SSD disks are backed by solid-state drives (SSDs), and deliver high-performance, low-latency disk support for VMs running I/O-intensive workloads. These drives tend to be more reliable because they have no moving parts. A read or write head doesn't have to move to the correct location on a disk to find the requested data.

You can use Premium SSD disks with VM sizes that include an "s" in the series name. For example, there is the **Dv3-Series** and the **Dsv3-series**; you can use the **Dsv3-series** with Premium SSD disks.

### Standard SSD

Premium storage is limited to specific VM sizes, so the VM type you create will impact the storage capabilities: size, max capacity, and storage type. What if you have a low-end VM, but you need SSD storage for I/O performance? That's what Standard SSDs are for. Standard SSDs are between Standard HDDs and Premium SSDs from a performance and cost perspective.

You can use standard SSDs with any VM size, including VM sizes that don't support premium storage. Using standard SSDs is the only way to use SSDs with those VMs. This disk type is only available in specific regions and only with *managed disks*.

### Standard HDD

Standard HDD disks are backed by traditional hard disk drives (HDDs). Standard HDD disks are billed at a lower rate than the Premium disks. You can use Standard HDD disks with any VM size.

### Disk comparison

The following table provides a comparison of Ultra disk, Premium SSD, Standard SSD, and Standard HDD to help you decide what to use.


|         | Ultra disk | Premium SSD v2 | Premium SSD | Standard SSD | <nobr>Standard HDD</nobr> |
| ------- | ---------- | ----------- | ------------ | ------------ | ------------ |
| **Disk type** | SSD | SSD |SSD | SSD | HDD |
| **Scenario**  | IO-intensive workloads such as [SAP HANA](/azure/sap/workloads/hana-vm-operations-storage), top tier databases (for example, SQL, Oracle), and other transaction-heavy workloads. | Production and performance-sensitive workloads that consistently require low latency and high IOPS and throughput | Production and performance sensitive workloads | Web servers, lightly used enterprise applications and dev/test | Backup, non-critical, infrequent access |
| **Max disk size** | 65,536 GiB | 65,536 GiB |32,767 GiB | 32,767 GiB | 32,767 GiB |
| **Max throughput** | 4,000 MB/s | 1,200 MB/s | 900 MB/s | 750 MB/s | 500 MB/s |
| **Max IOPS** | 160,000 | 80,000 | 20,000 | 6,000 | 2,000, 3,000* |
| **Usable as OS Disk?** | No | No | Yes | Yes | Yes |

Next, we'll go into more detail on disk performance.

## Data replication

The data in your managed disk is automatically replicated to ensure durability and high availability. Azure Storage replication copies your data so that it's protected from planned and unplanned events like transient hardware failures, network or power outages, natural disasters, and so on. You can choose to replicate your data within the same data center, across zonal data centers within the same region, and even across regions.

There are several types of replication:

- **Locally redundant storage (LRS)**: Azure replicates the data within the same Azure data center. The data remains available if a node fails. However, if an entire data center fails, data may be unavailable.
- **Zone-redundant storage (ZRS)**: Azure replicates your data synchronously across three storage clusters in a single region. Each storage cluster is physically separated from the others and resides in its own availability zone (AZ). With this type of replication, you can still access and manage your data in the event that a zone becomes unavailable.

## Disk performance

For most disks, the performance of a disk is determined by its performance tier, which is determined by the capacity of the disk. However, Ultra Disks and Premium SSD v2 offer the ability to set individual performance characteristics independently of the size of the disk. 

There are a few other ways to alter the performance of your disk. You can change the performance tier of a Premium SSD, independent of the size of the disk. Both Premium SSD and Standard SSD offer disk bursting, as well.
