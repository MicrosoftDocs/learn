When deploying an Azure Virtual Machine, you can use the unmanaged or managed disk type to host the operating system disk and can optionally define data disks. Your decision has important implications for functionality, manageability, and pricing.

## Unmanaged disks

With unmanaged disks, you must manage Azure Storage accounts where Azure Virtual Machine disks are located. You also need to determine the number of storage accounts you create and how you distribute .vhd disk files across them. This management overhead might be significant in larger environments, due to the need to address capacity, performance, and resiliency constraints.

Using managed disks can eliminate this management overhead. With managed disks, the Azure platform controls the placement of virtual machine disk files and hides the complexity associated with managing Azure Storage accounts.

> [!IMPORTANT]
> As of January 30, 2024, new customers won't be able to create unmanaged disks. On September 30, 2025, customers will no longer be able to start IaaS VMs by using unmanaged disks. Any VMs that are still running or allocated will be stopped and deallocated. More information is available in the article [Migrate your Azure unmanaged disks](/azure/virtual-machines/unmanaged-disks-deprecation).

## Managed disks

Managed disks provide better reliability for Availability Sets by ensuring that the disks of virtual machines in an Availability Set are sufficiently isolated from each other to avoid single points of failure. Managed disks, by automatically placing the disks in different storage fault domains (storage clusters) and aligning them with the virtual machine fault domain the virtual machine disks are adequately isolated. If a storage fault domain fails due to hardware or software failure, only the virtual machine instance with disks on the storage fault domain fails.

Managed disks also provide other functional benefits. For example, you can create an Azure Virtual Machine from a custom image stored in any storage account in the same region and the same subscription. With unmanaged disks, you must store Azure Virtual Machine disks in the same storage account as the image.

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

To determine overall performance of Azure Premium Storage disks attached to an Azure Virtual Machine, you not only need to calculate the cumulative throughput and IOPS of all disks, but you also need to take into account the virtual machine I/O throughput. This means that if you, for example, mount 32 x P30 disks to a single DS14 virtual machine you don't get 32 x the maximum throughput of a P30 disk. Instead the maximum throughput is determined by the performance characteristics of that specific virtual machine size, as documented in [Sizes for virtual machines in Azure](/azure/virtual-machines/sizes).
