



When deploying an Azure VM, you can use the unmanaged or managed disk type to host the operating system disk and can optionally define data disks. Your decision has important implications for functionality, manageability, and pricing.

## Unmanaged disks

With unmanaged disks, you must manage Azure Storage accounts where Azure VM disks will be located. You also need to determine the number of storage accounts you create and how you distribute .vhd disk files across them. This management overhead might be significant in larger environments, due to the need to address capacity, performance, and resiliency constraints.

Using managed disks can eliminate this management overhead. With managed disks, the Azure platform controls the placement of VM disk files and hides the complexity associated with managing Azure Storage accounts.

## Managed disks

Managed disks provide better reliability for Availability Sets by ensuring that the disks of VMs in an Availability Set are sufficiently isolated from each other to avoid single points of failure. Managed disks, by automatically placing the disks in different storage fault domains (storage clusters) and aligning them with the VM fault domain the VM disks will be adequately isolated. If a storage fault domain fails due to hardware or software failure, only the VM instance with disks on the storage fault domain fails.

Managed disks also provide other functional benefits. For example, you can create an Azure VM from a custom image stored in any storage account in the same region and the same subscription. With unmanaged disks, you must store Azure VM disks in the same storage account as the image.

Azure offers five tiers of managed disks according to their performance characteristics:

:::row:::
  :::column:::

  :::column-end:::
  :::column:::
    **Ultra disk**
  :::column-end:::
  :::column:::
    **Premium SSD v2**
  :::column-end:::
  :::column:::
    **Premium SSD**
  :::column-end:::
  :::column:::
    **Standard SSD**
  :::column-end:::
  :::column:::
    **Standard HDD**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Disk type**
  :::column-end:::
  :::column:::
    SSD
  :::column-end:::
  :::column:::
    SSD
  :::column-end:::
  :::column:::
    SSD
  :::column-end:::
  :::column:::
    SSD
  :::column-end:::
  :::column:::
    HDD
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Scenario**
  :::column-end:::
  :::column:::
    IO-intensive workloads such as SAP HANA, top-tier databases (for example, SQL, Oracle), and other transaction-heavy workloads.
  :::column-end:::
  :::column:::
    Production and performance-sensitive workloads that consistently require low latency and high IOPS and throughput
  :::column-end:::
  :::column:::
    Production and performance-sensitive workloads
  :::column-end:::
  :::column:::
    Web servers, lightly used enterprise applications, and dev/test
  :::column-end:::
  :::column:::
    Backup, non-critical, infrequent access
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Max disk size**
  :::column-end:::
  :::column:::
    65,536 gibibyte (GiB)
  :::column-end:::
  :::column:::
    65,536 GiB
  :::column-end:::
  :::column:::
    32,767 GiB
  :::column-end:::
  :::column:::
    32,767 GiB
  :::column-end:::
  :::column:::
    32,767 GiB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Max throughput**
  :::column-end:::
  :::column:::
    4,000 MiB/s
  :::column-end:::
  :::column:::
    1,200 MiB/s
  :::column-end:::
  :::column:::
    900 MiB/s
  :::column-end:::
  :::column:::
    750 MiB/s
  :::column-end:::
  :::column:::
    500 MiB/s
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Max IOPS**
  :::column-end:::
  :::column:::
    160,000
  :::column-end:::
  :::column:::
    80,000
  :::column-end:::
  :::column:::
    20,000
  :::column-end:::
  :::column:::
    6,000
  :::column-end:::
  :::column:::
    2,000, 3,000*
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Usable as OS disk?**
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::

> [!NOTE]
> * Only applies to disks with performance plus (preview) enabled.

It's important to understand that to determine overall performance of Azure Premium Storage disks attached to an Azure VM, you not only need to calculate the cumulative throughput and IOPS of all disks, but you also need to take into account the VM I/O throughput. This means that if you, for example, mount 32 x P30 disks to a single DS14 VM you won't get 32 x the maximum throughput of a P30 disk. Instead the maximum throughput would be determined by the performance characteristics of that specific VM size, as documented in [Sizes for virtual machines in Azure](/azure/virtual-machines/sizes).
