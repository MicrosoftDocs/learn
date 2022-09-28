You’ve been working with CSV on a number of your Windows Server clusters that host highly available virtualized workloads, so you’re familiar with the underlying technology. Now you want to determine how you can use the CSV capabilities to improve performance of the equivalent workloads running on Azure Stack HCI.

## Describe the benefits of CSV in-memory read cache in Azure Stack HCI

*CSV* is a technology that implements distributed file access, thereby allowing multiple cluster nodes to simultaneously access clustered volume’s file system (NTFS or ReFS). However, that simultaneous access applies to the volume, and not individual files within that volume.

While it might seem that CSV is a distinct file system, it still relies on either NTFS or ReFS. With Storage Spaces Direct, you can create a CSV spanning the local drives of cluster nodes.

Azure Stack HCI cluster nodes support using system memory to cache reads, resulting in improved performance of read-intensive workloads. This tends to be particularly beneficial in Virtual Desktop Infrastructure (VDI) scenarios, with Hyper-V using unbuffered I/O to access VM disk files.

> [!NOTE]
> Unbuffered I/O is not cached by Windows Cache Manager.

The in-memory cache is local to each cluster node. Provided that VMs continue running on the same node, some of the subsequent read operations might be retrieved from the cache. This results in improved latency and storage performance.

> [!NOTE]
> Cache does introduce an overhead, so it should be disabled for write-intensive workloads.

## Implement CSV in-memory read cache in Azure Stack HCI

CSV in-memory read cache is configurable on the cluster level. To configure it, you can use Windows Admin Center or PowerShell. By default, the cache is enabled, and its size is set to 1 GB per cluster node. The maximum cache size is configurable and can be increased to up to 80 percent of the total physical memory.
