When deploying an Azure Virtual Machine for SAP workloads, use managed disks for the operating system disk and any persistent data disks. Select a disk type based on the workload's capacity, performance, and support requirements.

## Managed disk capabilities

With managed disks, the Azure platform controls the placement of virtual machine disk files and manages the underlying storage accounts.

Managed disks provide better reliability for Availability Sets by ensuring that the disks of virtual machines in an Availability Set are sufficiently isolated from each other to avoid single points of failure. Managed disks, by automatically placing the disks in different storage fault domains (storage clusters) and aligning them with the virtual machine fault domain the virtual machine disks are adequately isolated. If a storage fault domain fails due to hardware or software failure, only the virtual machine instance with disks on the storage fault domain fails.

Managed disks also support creating Azure Virtual Machines from custom images without requiring you to manage storage accounts for the virtual machine disks.

> [!IMPORTANT]
> Unmanaged disks are fully retired as of March 31, 2026. IaaS VMs that use them can't be started. Migrate any remaining unmanaged disks to managed disks. See [Migrate your Azure unmanaged disks](/azure/virtual-machines/unmanaged-disks-deprecation).

## Managed disk types

Azure offers five tiers of managed disks according to their performance characteristics:

|  | Ultra disk | Premium SSD v2 | Premium SSD | Standard SSD | Standard HDD |
|---|---|---|---|---|---|
| **Disk type** | SSD | SSD | SSD | SSD | HDD |
| **Scenario** | IO-intensive workloads such as SAP HANA, top-tier databases (for example, SQL, Oracle), and other transaction-heavy workloads. | Production and performance-sensitive workloads that consistently require low latency and high IOPS and throughput | Production and performance-sensitive workloads | Web servers, lightly used enterprise applications, and dev/test | Backup, non-critical, infrequent access |
| **Max disk size** | 65,536 GiB | 65,536 GiB | 32,767 GiB | 32,767 GiB | 32,767 GiB |
| **Max throughput** | 4,000 MiB/s | 1,200 MiB/s | 900 MiB/s | 750 MiB/s | 500 MiB/s |
| **Max IOPS** | 160,000 | 80,000 | 20,000 | 6,000 | 2,000, 3,000* |
| **Usable as OS disk?** | No | No | Yes | Yes | Yes |

> [!NOTE]
> Only applies to disks with performance plus (preview) enabled.

To determine overall performance of Azure Premium Storage disks attached to an Azure Virtual Machine, you not only need to calculate the cumulative throughput and IOPS of all disks, but you also need to take into account the virtual machine I/O throughput. This means that if you, for example, mount 32 x P30 disks to a single DS14 virtual machine you don't get 32 x the maximum throughput of a P30 disk. Instead the maximum throughput is determined by the performance characteristics of that specific virtual machine size, as documented in [Sizes for virtual machines in Azure](/azure/virtual-machines/sizes).
