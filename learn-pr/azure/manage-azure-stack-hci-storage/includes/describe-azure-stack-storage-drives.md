As the lead systems engineer, your task is to research and evaluate Azure Stack HCI software-defined storage. Your first step is to understand its architecture and explore its main components, beginning with storage drives.

## Describe Azure Stack HCI storage requirements

Azure Stack HCI storage combines and uses several interrelated groups of technologies. These include:

- A file system, which provides the core functionality for storage volumes.

- Failover clustering, which provides core storage resiliency capabilities.

- Network hardware, which supports intra-cluster and external storage traffic.

- Storage-related network protocols that implement and optimize intra-cluster and external storage traffic.

- Software-defined storage components, including Software Storage Bus, Storage Bus Layer Cache, Storage Spaces, and Storage Spaces Direct. These components form the abstraction layer over physical hardware, resulting in simplified configuration, optimized resiliency, and performance.

- Storage hardware that provides different performance and capacity characteristics.

You can identify the components representing these technologies in the following diagram, which illustrates the basic Azure Stack HCI software-defined storage architecture. Virtual machines (VMs)–based workloads store their files on Resilient File System (ReFS)-formatted Cluster Shared Volumes (CSVs), using storage spaces hosted by a failover cluster. Cluster nodes are connected by high-speed, resilient Ethernet and Remote Direct Memory Access (RDMA) networking. Software Storage Bus provides access to a storage pool composed of different types of drives.

:::image type="content" source="../media/2-architecture.png" alt-text="Diagram that shows the Azure Stack HCI software-defined storage architecture displays." border="false" lightbox="../media/2-architecture.png":::

The physical drives used by Azure Stack HCI are subject to the following rules:

- Azure Stack HCI supports drives that are attached directly to individual cluster nodes.

- Drives can be internal or hosted in an external enclosure, if they connect only to a single server.

- Each server in the cluster should use the same number of drives. Each drive should have the same model, size, and sector size.

- There's no support for:

  - Redundant Array of Independent Disks (RAID) controllers or Storage Area Network (SAN)-based drives.
  - Shared disk enclosures connected to multiple servers.
  - Any form of Multipath I/O (MPIO) on which drives are accessible by multiple paths.

- It’s possible to use host bus adapter (HBA) cards that implement the simple pass-through mode.

## Identify drive types for Azure Stack HCI

Azure Stack HCI supports four types of non-volatile drives: 

- Hard disk drive (HDD). *HDDs* are rotational, magnetic disks. Their key benefits are their low price and support for large disk sizes. Their primary disadvantage is susceptibility to physical wear inherent to their design, which leads to relatively frequent failures. This physical wear translates into lower mean time between failures (MTBF).

- Solid-state drive (SSD). *SSDs* connect through conventional Serial ATA (SATA), or serial attached SCSI (SAS) connections common to HDDs. SSDs rely on integrated circuit assemblies to persist data and commonly include flash memory. The biggest advantage of the SSD is the speed at which data can be written and retrieved. In addition, the use of electronic components instead of physical disks results in higher MTBF.

- Non-Volatile Memory Express (NVMe). *NVMe* refers to SSDs that attach directly to the PCI express (PCIe) bus. NVMe offers higher input/output (I/O) operations per second (IOPS) and I/O throughput that has lower latency when compared to SSDs.

- Persistent memory (PMEM). *PMEM* is a non-volatile dual in-line memory module, which justifies its nickname of *storage-class memory*. It offers the best performance out of the four drive types supported by Azure Stack HCI, but has considerably higher cost and limited capacity.

> [!NOTE]
> The non-volatile designation means that a drive retains its contents when electrical power is removed.

## Describe drive type pricing, performance, durability, and capacity characteristics

The choice of the drive types impacts the Azure Stack HCI storage performance and capacity, based on the performance and capacity characteristics of individual drive types. However, the caching mechanism also affects that relationship. The caching mechanism constitutes an integral part of the Storage Spaces Direct technology that Azure Stack HCI uses.

The following diagram provides a comparison between non-volatile storage technologies available in Azure Stack HCI (HDD, SSD, NVMe, and PMEM). Horizontal bars represent relative values of price per gigabyte (GB), throughput and IOPS, MTBF, latency, and maximum capacity. Latency and maximum capacity are highest in HDD and lowest in PMEM. All four technologies have relatively high MTBF values.

:::image type="content" source="../media/2-non-volatile-storage-comparison.png" alt-text="Diagram that compares price per GB, throughput/IOPS, MTBF, latency, and maximum capacity between the four drive types (HDD, SSD, NVMe, and PMEM)." border="false" lightbox="../media/2-non-volatile-storage-comparison.png":::
