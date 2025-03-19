When deploying an Azure VM, you can use the unmanaged or managed disk type to host the operating system disk and can optionally define data disks. Your decision has important implications for functionality, manageability, and pricing.

## Unmanaged disks

With unmanaged disks, you must manage Azure Storage accounts where Azure VM disks are located. You also need to determine the number of storage accounts you create and how you distribute .vhd disk files across them. This management overhead might be significant in larger environments, due to the need to address capacity, performance, and resiliency constraints.

Using managed disks can eliminate this management overhead. With managed disks, the Azure platform controls the placement of VM disk files and hides the complexity associated with managing Azure Storage accounts.

## Managed disks

Managed disks provide better reliability for Availability Sets by ensuring that the disks of VMs in an Availability Set are sufficiently isolated from each other to avoid single points of failure. Managed disks, by automatically placing the disks in different storage fault domains (storage clusters) and aligning them with the VM fault domain the VM disks are adequately isolated. If a storage fault domain fails due to hardware or software failure, only the VM instance with disks on the storage fault domain fails.

Managed disks also provide other functional benefits. For example, you can create an Azure VM from a custom image stored in any storage account in the same region and the same subscription. With unmanaged disks, you must store Azure VM disks in the same storage account as the image.

Azure offers five tiers of managed disks according to their performance characteristics:

|  | Ultra disk | Premium SSD v2 | Premium SSD | Standard SSD | Standard HDD |
|---|---|---|---|---|---|
| **Disk type** | SSD | SSD | SSD | SSD | HDD
| **Scenario** | IO-intensive workloads such as SAP HANA, top-tier databases (for example, SQL, Oracle), and other transaction-heavy workloads. | Production and performance-sensitive workloads that consistently require low latency and high IOPS and throughput | Production and performance-sensitive workloads | Web servers, lightly used enterprise applications, and dev/test | Backup, non-critical, infrequent access
| **Max disk size** | 65,536 GiB | 65,536 GiB | 32,767 GiB | 32,767 GiB | 32,767 GiB
| **Max throughput** | 4,000 MiB/s | 1,200 MiB/s | 900 MiB/s | 750 MiB/s | 500 MiB/s
| **Max IOPS** | 160,000 | 80,000 | 20,000 | 6,000 | 2,000, 3,000*
| **Usable as OS disk?** | No | No | Yes | Yes | Yes

> [!NOTE]
> Only applies to disks with performance plus (preview) enabled.

To determine overall performance of Azure Premium Storage disks attached to an Azure VM, you not only need to calculate the cumulative throughput and IOPS of all disks, but you also need to take into account the VM I/O throughput. This means that if you, for example, mount 32 x P30 disks to a single DS14 VM you don't get 32 x the maximum throughput of a P30 disk. Instead the maximum throughput is determined by the performance characteristics of that specific VM size, as documented in [Sizes for virtual machines in Azure](/azure/virtual-machines/sizes).
