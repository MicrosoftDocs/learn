Now that you’re familiar with the fault tolerance options and their impact on storage efficiency, your next task is to plan for an optimal volume configuration that reflects your Azure Stack HCI workload requirements. This will involve choosing the number of volumes and their characteristics, including size, resiliency type, provisioning type, and their file system.

## Describe Azure Stack HCI volumes

In the context of Storage Spaces Direct in Azure Stack HCI, volumes enable you to group the drives in the storage pool in the manner that yields the optimal combination of fault tolerance, scalability, and performance requirements.

> [!NOTE]
> As illustrated in the following image, all Storage Spaces Direct volumes are accessible by all servers in the cluster at the same time. They’re created in the **C:\ClusterStorage** folder on all servers.

:::image type="content" source="../media/3-plan-for-volumes.png" alt-text="Volumes constitute a layer of abstraction on top of a storage pool accessible via Cluster Shared Volumes (CSVs)." border="false":::

When planning for Storage Spaces Direct volumes, you should consider:

- Number of volumes per cluster

- Volume size

- Resiliency type

- Partitioning type

- File system

> [!NOTE]
> The resiliency type heavily influences performance and capacity characteristics and is closely correlated with the first two considerations.

## Choose the number of volumes

To optimize storage performance, the number of volumes per server should be a multiple of the number of servers per cluster. For example, if you have four servers, you will experience more consistent performance with four or eight volumes per server. Configured this way, the cluster can evenly distribute the volume ownership across all cluster nodes.

> [!NOTE]
> The total number of volumes per an Azure Stack HCI cluster shouldn't exceed 64.

## Choose the size of volumes

The size of a volume refers to its *usable capacity*, which is the amount of data it can store. Size is different than a volume's *footprint*, which is the total physical storage capacity it occupies in the storage pool. The footprint depends on the volume resiliency type. The combined footprints of all cluster volumes need to fit in the storage pool.

> [!NOTE]
> The size of a volume on an Azure Stack HCI cluster shouldn't exceed 64 terabytes (TB).

## Choose the resiliency type

Volume resiliency is the primary mechanism that helps protect data residing in the storage pool against hardware issues such as drive or server failures. It also enables continuous availability during server maintenance events such as software updates that require node reboots. The choice of the resiliency type is related to the number of cluster nodes.

### Resiliency with two-node clusters

With two nodes in a cluster, you can use either two-way mirroring or nested resiliency. Two-way mirroring is supported on clusters with any number of nodes. Nested resiliency is available exclusively on two-node clusters.

> [!NOTE]
> Nested resiliency can withstand two simultaneous hardware failures, including either two drives or a server and a drive on the remaining server. You should consider using it when running production workloads on two-node clusters.

### Resiliency with three-node clusters

With three nodes in a cluster, you should use three-way mirroring if you want to maximize fault tolerance and performance. Volumes with three-way mirroring can withstand two (or potentially more) simultaneous hardware failures involving one node and a drive, or multiple drives on one of the remaining nodes. Similarly, such volumes can withstand multiple drive failures provided they don't include any of the drives on one of three cluster nodes.

> [!NOTE]
> If two nodes fail at the same time, the storage pool loses its quorum and the volumes become inaccessible.

### Resiliency with four or more cluster nodes

With four or more servers, you additionally have the option to implement volumes with dual parity or mirror-accelerated parity. Dual parity provides the same fault tolerance as three-way mirroring, but with better storage efficiency. The tradeoff is performance, because parity encoding is more compute-intensive, resulting in increased latency and CPU utilization.

### Choose optimal resiliency for a workload

The following image illustrates the tradeoffs between the resiliency, capacity, and performance characteristics of Azure Stack HCI Storage Spaces Direct volumes. The challenge results from the fact that maximizing one of these storage characteristics typically has a negative impact on at least one of the other two. For example, increasing resiliency reduces usable capacity, although the resulting performance might vary depending on the resiliency type.

:::image type="content" source="../media/3-performance-resiliency-capacity.png" alt-text="A pyramid shaped graph illustrates the tradeoffs between resiliency, capacity, and performance of Azure Stack HCI Storage Spaces Direct volumes." border="false":::

The choice of resiliency type should be based on the intended workload. The following table summarizes which workloads are a good fit for each resiliency type, along with their respective capacity efficiency and performance.

| **Resiliency type**       | **Capacity efficiency**        | **Performance**         |**Workloads**                |
| ------------------------- | -------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Mirror                    | Three-way mirror: 33 percent and two-way mirror: 50 percent | Best performance                                             | Virtualized, databases, others with high-performance  demands |
| Mirror-accelerated parity | Depends on the proportion between mirror  and parity     | Much slower than mirror, but up to twice as  fast as dual-parity. Best for large sequential writes and reads. | Archival and backup, virtualized desktop  infrastructure     |
| Dual-parity               | 4 servers: 50 percent and 16 servers: up to 80 percent     | Highest input/output (I/O) latency and CPU usage  on writes. Best for large sequential writes and reads. | Archival and backup, virtualized desktop  infrastructure     |

Workloads that have strict latency requirements or that perform large amounts of mixed random I/O operations per second (IOPS) (such as Microsoft SQL Server databases or performance-sensitive Microsoft Hyper-V virtual machines (VMs)), should be hosted on volumes that use mirroring to maximize performance. Workloads that have less demanding I/O requirements (such as file servers or Virtual Desktop Infrastructure (VDI)), can use dual-parity to improve capacity efficiency. Workloads that perform large, sequential writes (such as backup software) are best suited for mirror-accelerated parity. When sizing the mirror and parity portions, consider that the quantity of writes that happen at once (such as daily backups) should fit in the mirror portion.

## Choose between thin and fixed­–provisioned volumes

Fixed provisioning is a traditional approach to allocating space from the underlying storage pool to a volume during its creation. With this approach, disk space is effectively reserved for the volume’s exclusive use, even when it's not actively used. This negatively impacts storage efficiency and increases maintenance overhead.

With thin provisioning, you can specify an arbitrary size of the volume you create that represent its expected usage and anticipated growth. While this size can be larger than the storage pool’s available capacity (allowing for over-provisioning), the footprint will be smaller than the one resulting from fixed provisioning.

Thin provisioning is recommended when you can't predict the volume growth rate. Fixed provisioning is the preferred choice if you want to ensure that the size of the volume won’t exceed the space available in the underlying storage pool.

> [!NOTE]
> Thin provisioning will work with all resiliency settings.

## Choose the file system

Azure Stack HCI uses two file system technologies: Resilient File System (ReFS), and New Technology File System (NTFS).

ReFS is the newer of the two file systems, but it provides backward compatibility with NTFS. It also inherits a number of NTFS features, including support for:

- Access control lists (ACLs)

- Update sequence number (USN) journal

- Change notifications

- Symbolic links, junction points, mount points, and reparse points

- Volume-level snapshots

- Volume-level encryption via BitLocker Drive Encryption

- Volume-level deduplication

One of the primary strengths of ReFS—as indicated by its name—is its enhanced resiliency to data corruption and the ability to remediate integrity issues online. ReFS is particularly beneficial in Azure Stack HCI because its enhancements that affect virtualized workloads and software-defined storage. These enhancements include:

- Block cloning, which accelerates the speed of copy operations, facilitating fast, low-impact VM checkpoint merge operations.

- Sparse valid data length, which accelerates initializing large files, thereby considerably reducing the time needed to create fixed VM disks.

- Mirror-accelerated parity, which delivers high performance and capacity-efficient storage in Storage Spaces Direct.

> [!NOTE]
> Mirror-accelerated parity volumes require the use of ReFS.

Consider using ReFS for Storage Spaces Direct volumes. Use NTFS-formatted volumes if your workloads require any of the functionality that’s not supported by ReFS. These include disk quotas, file system compression, file system encryption, or extended attributes.

> [!NOTE]
> NTFS and ReFS volumes can coexist in the same cluster.
