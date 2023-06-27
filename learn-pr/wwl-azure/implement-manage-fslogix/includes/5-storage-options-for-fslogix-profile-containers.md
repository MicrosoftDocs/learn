This unit compares storage solutions that Azure offers for Azure Virtual Desktop FSLogix user profile containers.

As mentioned in Module 2, it's best to store FSLogix profile containers on Azure Files.

FSLogix is designed to roam profiles in remote computing environments, such as Azure Virtual Desktop.

 -  At sign-in, this container is dynamically attached to the computing environment using a natively supported Virtual Hard Disk (VHD) and a Hyper-V Virtual Hard Disk (VHDX).
 -  The user profile is immediately available and appears in the system exactly like a native user profile.

The following tables compare the storage solutions Azure Storage offers for Azure Virtual Desktop FSLogix profile container user profiles.

## Azure platform details

| **Features**            | **Azure Files**                                                                                                     | **Azure NetApp Files**                                                | **Storage Spaces Direct**                                                                                                             |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| Use case                | General purpose                                                                                                     | Ultra performance or migration from NetApp on-premises                | Cross-platform                                                                                                                        |
| Platform service        | Yes, Azure-native solution                                                                                          | Yes, Azure-native solution                                            | No, self-managed                                                                                                                      |
| Regional availability   | All regions                                                                                                         | Select regions                                                        | All regions                                                                                                                           |
| Redundancy              | Locally redundant/zone-redundant/geo-redundant/geo-zone-redundant                                                   | Locally redundant                                                     | Locally redundant/zone-redundant/geo-redundant                                                                                        |
| Tiers and performance   | Standard (Transaction optimized) Premium Up to max 100K IOPS per share with 10 GBps per share at about 3 ms latency | Standard Premium Ultra Up to 4.5GBps per volume at about 1 ms latency | Standard HDD: up to 500 IOPS per-disk limits, Standard SSD: up to 4k IOPS per-disk limits Premium SSD: up to 20k IOPS per-disk limits |
| Capacity                | 100 TiB per share, Up to 5 PiB per general purpose account                                                          | 100 TiB per volume, up to 12.5 PiB per subscription                   | Maximum 32 TiB per disk                                                                                                               |
| Required infrastructure | Minimum share size 1 GiB                                                                                            | Minimum capacity pool 4 TiB, min volume size 100 GiB                  | Two VMs on Azure IaaS or at least three VMs without and costs for disks                                                               |
| Protocols               | SMB 3.0/2.1, NFSv4.1 (preview), REST                                                                                | NFSv3, NFSv4.1 (preview), SMB 3.x/2.x                                 | NFSv3, NFSv4.1, SMB 3.1                                                                                                               |

## Azure management details

| **Features**                       | **Azure Files**                                                    | **Azure NetApp Files**                                             | **Storage Spaces Direct**                                                      |
| ---------------------------------- | ------------------------------------------------------------------ | ------------------------------------------------------------------ | ------------------------------------------------------------------------------ |
| Access                             | Cloud, on-premises and hybrid (Azure file sync)                    | Cloud, on-premises (via ExpressRoute)                              | Cloud, on-premises                                                             |
| Backup                             | Azure backup snapshot integration                                  | Azure NetApp Files snapshots                                       | Azure backup snapshot integration                                              |
| Security and compliance            | All Azure supported certificates                                   | ISO completed                                                      | All Azure supported certificates                                               |
| Azure Active Directory integration | Native Active Directory and Azure Active Directory Domain Services | Azure Active Directory Domain Services and Native Active Directory | Native Active Directory or Azure Active Directory Domain Services support only |

## Azure Files tiers

Azure Files offers two different tiers of storage: **premium** and **standard**. These tiers let you tailor the performance and cost of your file shares to meet your scenario's requirements.

 -  **Premium file shares are backed by solid-state drives (SSDs)** and are deployed in the FileStorage storage account type. Premium file shares provide consistent high performance and low latency for input and output (IO) intensive workloads.
 -  **Standard file shares are backed by hard disk drives (HDDs)** and are deployed in the general purpose version 2 (GPv2) storage account type. Standard file shares provide reliable performance for IO workloads that are less sensitive to performance variability, such as general-purpose file shares and dev/test environments.

The following table lists our recommendations for which performance tier to use based on your workload.

| **Workload type**            | **Recommended file tier**                                 |
| ---------------------------- | --------------------------------------------------------- |
| Light (fewer than 200 users) | Standard file shares                                      |
| Light (more than 200 users)  | Premium file shares or standard with multiple file shares |
| Medium                       | Premium file shares                                       |
| Heavy                        | Premium file shares                                       |
| Power                        | Premium file shares                                       |
