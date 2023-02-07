
Azure offers multiple storage solutions that you can use to store your FSLogix profile container. This unit compares storage solutions that Azure offers for Azure Virtual Desktop FSLogix user profile containers.

We recommend storing FSLogix profile containers on Azure Files for most of our customers.

Azure Virtual Desktop offers FSLogix profile containers as the recommended user profile solution. FSLogix is designed to roam profiles in remote computing environments, such as Azure Virtual Desktop.

When a user signs in the container is dynamically attached to the environment using a natively supported Virtual Hard Disk (VHD) and a Hyper-V Virtual Hard Disk (VHDX). The user profile is immediately available and appears exactly like a native user profile. :::image type="content" source="../media/fslogix-profiles-folder-9ef2ec40.png" alt-text="Graphic of  available services appears exactly like a native user profile.":::


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
    [Select regions](https://azure.microsoft.com/global-infrastructure/services/?products=netapp&regions=all).
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
    Locally redundant/zone-redundant/geo-redundant/geo-zone-redundant
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
    Tiers and performance
  :::column-end:::
  :::column:::
    Standard (Transaction optimized)
Premium
Up to max 100 K IOPS per share with 10 Gbps per share at about 3-ms latency
  :::column-end:::
  :::column:::
    Standard
Premium
Ultra
Up to 4.5Gbps per volume at about 1-ms latency.
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
    100 TiB per share, Up to 5 PiB per general purpose account
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
    SMB 3.0/2.1, NFSv4.1 (preview), REST
  :::column-end:::
  :::column:::
    NFSv3, NFSv4.1 (preview), SMB 3.x/2.x
  :::column-end:::
  :::column:::
    NFSv3, NFSv4.1, SMB 3.1
  :::column-end:::
:::row-end:::


## Azure management details

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
    Access
  :::column-end:::
  :::column:::
    Cloud, on-premises and hybrid (Azure file sync)
  :::column-end:::
  :::column:::
    Cloud, on-premises (via ExpressRoute)
  :::column-end:::
  :::column:::
    Cloud, on-premises
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Backup
  :::column-end:::
  :::column:::
    Azure backup snapshot integration
  :::column-end:::
  :::column:::
    Azure NetApp Files snapshots
  :::column-end:::
  :::column:::
    Azure backup snapshot integration
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Security and compliance
  :::column-end:::
  :::column:::
    All Azure supported certificates.
  :::column-end:::
  :::column:::
    ISO completed
  :::column-end:::
  :::column:::
    All Azure supported certificates.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Active Directory integration
  :::column-end:::
  :::column:::
    [Native Active Directory and Azure Active Directory Domain Services](/azure/storage/files/storage-files-active-directory-overview)
  :::column-end:::
  :::column:::
    [Azure Active Directory Domain Services and Native Active Directory](/azure/azure-netapp-files/faq-smb#does-azure-netapp-files-support-azure-active-directory)
  :::column-end:::
  :::column:::
    Native Active Directory or Azure Active Directory Domain Services support only.
  :::column-end:::
:::row-end:::
