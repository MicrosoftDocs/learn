This section compares storage solutions that Azure offers for Azure Virtual Desktop FSLogix user profile containers.

As mentioned in Module 2, it's best to store FSLogix profile containers on Azure Files.

FSLogix is designed to roam profiles in remote computing environments, such as Azure Virtual Desktop.

 -  At sign-in, this container is dynamically attached to the computing environment using a natively supported Virtual Hard Disk (VHD) and a Hyper-V Virtual Hard Disk (VHDX).
 -  The user profile is immediately available and appears in the system exactly like a native user profile.

The following tables compare the storage solutions Azure Storage offers for Azure Virtual Desktop FSLogix profile container user profiles.

## Azure platform details

:::row:::
  :::column:::
    **Features**
  :::column-end:::
  :::column:::
    **Azure Files**
  :::column-end:::
  :::column:::
    **Azure NetApp Files**
  :::column-end:::
  :::column:::
    **Storage Spaces Direct**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Use case.
  :::column-end:::
  :::column:::
    General purpose
  :::column-end:::
  :::column:::
    Ultra performance or migration from NetApp on-premises
  :::column-end:::
  :::column:::
    Cross-platform
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Platform service.
  :::column-end:::
  :::column:::
    Yes, Azure-native solution
  :::column-end:::
  :::column:::
    Yes, Azure-native solution
  :::column-end:::
  :::column:::
    No, self-managed
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Regional availability.
  :::column-end:::
  :::column:::
    All regions
  :::column-end:::
  :::column:::
    Select regions.
  :::column-end:::
  :::column:::
    All regions
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Redundancy
  :::column-end:::
  :::column:::
    Locally redundant/zone-redundant/geo-redundant
  :::column-end:::
  :::column:::
    Locally redundant
  :::column-end:::
  :::column:::
    Locally redundant/zone-redundant/geo-redundant
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Tiers and performance.
  :::column-end:::
  :::column:::
    Standard
Premium
Up to max 100k IOPS per share with 5 Gbps per share at about 3-ms latency
  :::column-end:::
  :::column:::
    Standard
Premium
Ultra
Up to 320k (16K) IOPS with 4.5 Gbps per volume at about 1-ms latency
  :::column-end:::
  :::column:::
    Standard HDD: up to 500 IOPS per-disk limits
Standard SSD: up to 4k IOPS per-disk limits
Premium SSD: up to 20k IOPS per-disk limits
We recommend Premium disks for Storage Spaces Direct.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Capacity
  :::column-end:::
  :::column:::
    100 TiB per share
  :::column-end:::
  :::column:::
    100 TiB per volume, up to 12.5 PiB per subscription
  :::column-end:::
  :::column:::
    Maximum 32 TiB per disk
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Required infrastructure
  :::column-end:::
  :::column:::
    Minimum share size 1 GiB
  :::column-end:::
  :::column:::
    Minimum capacity pool 4 TiB, min volume size 100 GiB
  :::column-end:::
  :::column:::
    Two VMs on Azure IaaS (+ Cloud Witness) or at least three VMs without and costs for disks
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Protocols
  :::column-end:::
  :::column:::
    SMB 2.1/3 and REST
  :::column-end:::
  :::column:::
    NFSv3, NFSv4.1 (preview), SMB 3.x/2.x
  :::column-end:::
  :::column:::
    NFSv3, NFSv4.1, SMB 3.1
  :::column-end:::
:::row-end:::
