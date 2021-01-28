Managing physical disks that are attached directly to a server can be a tedious task. To address this issue and make more-efficient use of storage, many organizations have implemented storage area networks (SANs). However, most SANs require advanced configurations and expensive hardware. Storage Spaces is a solution that provides a viable alternative to SAN.

## What are Storage Spaces?

A storage space is a storage-virtualization capability built into Windows Server and Windows 10. The Storage Spaces feature consists of two components:

- Storage pools. A storage pool is a collection of physical disks aggregated into a logical disk that you can manage as a single entity. The pool can contain physical disks of any type and size. A single physical disk can belong to only one storage pool.
- Storage Spaces. Storage Spaces are virtual disks created from free space in a storage pool. Storage Spaces provide such functionality as resiliency levels, including mirroring and parity, storage tiers, write-back caching, fixed and thin provisioning, and management controls. Virtual disks are equivalent to logical unit numbers (LUNs) on a SAN.

### Resiliency levels

To create a highly available virtual disk, you need at least one physical disk that satisfies the following requirements:

- One physical disk is required to create a storage pool.
- A minimum of two physical disks are required to create a resilient mirror virtual disk.
- A minimum of three physical disks are required to create a virtual disk with resiliency through parity.
- Three-way mirroring requires at least five physical disks.
- Disks must be blank and unformatted. No volume can exist on the disks.
- You can attach disks by using a variety of bus interfaces, including, small computer system interface (SCSI), shared access signature (SAS), Serial ATA (SATA), NVM Express (NVMe).

> [!NOTE]
> Virtual disks resiliency resembles Redundant Array of Independent Disks (RAID) technologies, but Storage Spaces store the data differently than RAID.

> [!IMPORTANT]
> If you want to use failover clustering with storage pools, you can't use SATA, USB, or SCSI disks.

### Storage tiers

Storage tiers allow you to optimize the use of different disk types in a storage space. For example, you could use very fast but small-capacity solid-state drives (SSDs) with slower, but large-capacity hard disks. When you use this combination of disks, Storage Spaces automatically moves data that is accessed frequently to the faster disks, and then moves data that is accessed less often to the slower disks. By default, the Storage Spaces feature moves data once a day at 01:00 AM. You can also configure where files are stored. The advantage is that if you have files that are accessed frequently, you can pin them to the faster disk. The goal of tiering is to balance capacity against performance. Windows Server recognizes only two levels of disk tiers: SSD, and non-SSD.

> [!NOTE]
> Windows Server 2019 added support for persistent memory (PMem). You use PMem as a cache to accelerate the active working set, or as capacity to guarantee consistent low latency on the order of microseconds.

By default, the Storage Spaces feature moves data once a day at 01:00 AM. You have the option of changing this default and to run the optimization task on demand. You can also exclude individual files from the scope of optimization by assigning them explicitly to a particular tier. The advantage is that if you have files that are accessed frequently, you can pin them to the faster disk. The goal of tiering is to balance capacity against performance. Windows Server recognizes only two levels of disk tiers: SSD, and non-SSD.

### Write-back caching

The purpose of write-back caching is to optimize writing data to the disks in a storage space. Write-back caching works with Tiered Storage Spaces. If the server that is running the storage space detects a peak in disk-writing activity, it automatically starts writing data to the faster disks. By default, write-back caching is enabled.

> [!NOTE]
> Write-back cache has the size limit of 1 gigabyte (GB).

### Fixed and thin provisioning

Fixed provisioning allocates the storage capacity up front when you create the space. Thin provisioning enables storage to be allocated readily on a just-enough and just-in-time (JIT) basis. In this case, storage capacity in the pool is organized into provisioning slabs that aren't allocated until datasets require the storage. Instead of the traditional fixed storage allocation method in which large portions of storage capacity are allocated but might remain unused, thin provisioning optimizes any available storage by reclaiming storage that is no longer needed using a process known as trim.

You can create both thin and fixed provisioning virtual disks within the same storage pool. Having both in the same storage pool is convenient, especially when they are related to the same workload. For example, you can choose to use a thin provisioning space for a shared folder containing user files, and a fixed provisioning space for a database that requires high disk I/O.

### Managing Storage Spaces

You can manage Storage Spaces interactively by using File and Storage Services role in Server Manager, via command line with Windows PowerShell, or programmatically, via Windows Storage Management application programming interface (API) in Windows Management Instrumentation (WMI). After you have provisioned the virtual disks, you can make them available to the Windows operating system by creating disk drives and either mounting them onto a local file system directory or assigning to them a drive letter. You can format a storage space virtual disk with FAT32, NT File System (NTFS), or Resilient File System (ReFS).
