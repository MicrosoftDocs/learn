Storage Spaces offer a range of benefits over traditional SANs. Storage virtualization provides companies like Contoso flexible storage options that maximize storage efficiency without compromising resiliency and manageability.

## What are benefits of Storage Spaces?

When considering whether to use Storage Spaces in each situation, you should consider their benefits. Storage Spaces allow you to:

- Implement and easily manage scalable, reliable, and inexpensive storage.
- Aggregate individual drives into storage pools, which are managed as a single entity.
- Use inexpensive storage with or without external storage.
- Use different types of storage in the same pool (for example, SATA, SAS, USB, and SCSI).
- Grow storage pools as required.
- Provision storage when required from previously created storage pools.
- Designate specific drives as hot spares.
- Automatically repair pools containing hot spares.
- Delegate administration by pool.
- Use the existing tools for backup and restore, and use Volume Shadow Copy Service (VSS) for snapshots.
- Manage either locally or remotely, by using Microsoft Management Console (MMC) or Windows PowerShell.
- Utilize Storage Spaces with Failover Clusters.

> [!TIP]
> Using USB in a pool might be more practical on a Windows client or while developing a proof of concept.

## What are limitations of Storage Spaces?

It is equally important to consider the limitations of Storage Spaces. For example, in Windows Server:

- Storage Spaces volumes aren't supported as boot or system volumes.
- You should add only unformatted, non-partitioned, disks to a storage pool.
- All drives in a pool must use the same sector size.
- Storage layers that abstract the physical disks aren't compatible with Storage Spaces, including:
  - Pass-through disks in a virtual machine (VM).
  - Storage subsystems deployed in a separate RAID layer.
- Fibre Channel and Internet Small Computer System Interface (iSCSI) aren't supported.
- Failover Clusters are limited to SAS as the storage technology.

> [!IMPORTANT]
> Microsoft Support provides troubleshooting assistance only in environments where you deploy Storage Spaces on a physical machine, not a VM. Additionally, any just a bunch of disks (JBOD) hardware solutions that you implement must be Microsoft-certified.

## Workload types and resiliency types

When evaluating the use of Storage Spaces, you should identify the optimal Storage Spaces resiliency types based on the workload type. The following table illustrates the relationship between the workload type and Storage Spaces resiliency type.

|Resiliency type|Number of data copies maintained|Workload recommendations|
|---|---|---|
|Mirror|2 (two-way mirror) 3 (three-way mirror)|Recommended for all workloads|
|Parity|2 (single parity) 3 (dual parity)|Sequential workloads with large units of read/write, such as archival|
|Simple|1 |Workloads that don't need resiliency, or provide an alternate resiliency mechanism|

## Storage efficiency and provisioning schemes

Thin provisioning optimizes utilization of available storage. This can be a factor contributing to datacenter consolidation, resulting in lower operating costs. The downside of using thin provisioning, when compared with fixed provisioning, is slightly decreased storage performance.
