After you verify that Azure Stack HCI is suitable for hosting your workload, you must consider your infrastructure requirements, including compute, storage, and networking components. These considerations are workload-dependent, so for a scenario such as Contoso's, you must account for distinct performance requirements of Microsoft SQL Server and VDI.

## Plan for Azure Stack HCI

General planning considerations for an Azure Stack HCI implementation include:

- The number of physical servers per cluster. This number must be between 2 and 16.
- The number of fault domains per cluster. By default, each node in a Storage Spaces Direct cluster is one fault domain.
- The number and type of processors per server. The first of these values determine the core count and the latter dictates their speed.
- The amount and type of memory per server, including whether to use persistent memory (PMEM).
- Disk performance, including the corresponding tiering and caching configuration.
- The Azure subscription in which you'll register your Azure Stack HCI deployment, because there are ongoing charges for Azure Stack HCI clusters depending on Azure subscription type.

Planning considerations with respect to storage performance and capacity include:

- The number and types of disks, including HDDs, SSDs, and NVMe.
- Storage Spaces Direct resiliency levels.
- Tiering and caching configuration.

Factors to consider about throughput and latency of storage and network traffic include:

- The number and type of network adapters per server.
- The number and type of network switches per cluster.

Other considerations apply to stretched clusters, including how many servers each site requires and the cluster configuration's mode. The two modes are:

- Active-passive mode, in which a designated primary site unidirectionally replicates to another site that provides disaster-recovery capability.
- Active-active mode, in which two sites replicate their respective volumes unidirectionally to each other, providing failover capability if either site fails. The active-active mode helps minimize business-continuity costs because you won't need a dedicated disaster-recovery site.

Your intended workloads affect all of these factors. Effectively, the use cases previously discussed are a basis for identifying an optimal Azure Stack HCI hardware configuration. The Azure Stack HCI catalog has a list of all Azure Stack HCI solutions that third-party hardware vendors offer and of which Microsoft approves.

### Plan for Azure Stack HCI host storage

In the simplest terms, planning for Azure Stack HCI host storage involves identifying the optimal balance between resiliency, capacity, and performance of Storage Spaces Direct. However, there's a challenge. Typically, maximizing one of these characteristics typically has a negative impact on at least one of the other two. For example, increasing resiliency reduces the usable capacity, although resulting performance might vary depending on resiliency type.

#### Drives

Storage Spaces Direct supports hard disk drives (HDDs), solid-state drives (SSDs), and Non-Volatile Memory Express (NVMe) drives, including PMEM. The choice of drive type directly affects storage performance due to differences in performance characteristics between each type and the cache mechanism.

#### Storage Spaces Direct cache

In general, Storage Spaces Direct assigns drives to one of two categories based on the drive type: capacity, or cache. Cache drives don't contribute to a cluster's usable or raw storage capacity, which means that a cluster's total raw storage capacity is the sum of capacity drives on all of its nodes.

In clusters with multiple drive types, Storage Spaces Direct automatically assigns all the fastest drive types to the cache and uses the remaining drives for capacity. You can manually cache in scenarios where the default configuration doesn't yield optimal performance.

#### Drive symmetry

Storage Spaces Direct works in the optimal manner when every server has the exact the same number and type of drives. In general, you should configure your Storage Spaces Direct cluster in such way that:

- All servers have the same drive type.
- All servers have the same number of drives per type.
- All drives have the same model and firmware version.
- All drives of the same type have the same size.

#### Cluster and pool quorums

In a failover cluster, the term quorum is the number of clustering components that must be available for that cluster to remain online. These components can include the cluster nodes and, optionally, a witness. The term witness specifies a resource dedicated exclusively to establishing and maintaining quorum.

With Storage Spaces Direct, there are two distinct quorum mechanisms:

- *Cluster quorum*, which operates at the cluster level, and is based on votes from nodes and a witness. Storage Spaces Direct doesn't support Disk Witness, leaving Cloud Witness and the file share witness as the two viable options.
- *Pool quorum*, which operates on the storage pool level, and is based on votes from nodes and storage resiliency. To optimize pool quorum configuration when implementing Storage Spaces Direct, ensure there's a matching storage configuration in each cluster node.

#### Volumes

With Storage Spaces Direct, volumes allow you to group drives in the storage pool so as to yield the optimal combination of fault tolerance, scalability, and performance requirements. When planning for Storage Spaces Direct volumes, you should consider the following:

- Number of volumes per cluster. To optimize storage performance, the number of volumes per server should be a multiple of the number of servers per cluster.
- File system. Consider using the ReFS for Storage Spaces Direct volumes.
- Volume size. The size of a volume on an Azure Stack HCI cluster shouldn't exceed 64 TB.
- Reserve capacity. To optimize disk space usage, consider setting aside the equivalent of one capacity drive per server, up to four drives per server.
- Resiliency type. Volume resiliency is the primary mechanism that protects data residing in the storage pool against hardware issues, such as drive or server failures. The choice of resiliency type is workload-dependent. Workloads that have strict latency requirements or that perform large amounts of mixed random IOPS, such as Microsoft SQL Server databases or performance-sensitive Hyper-V VMs, should run on volumes that use mirroring to maximize performance. Workloads that have less demanding I/O requirements, such as file servers or Virtual Desktop Infrastructure (VDI), can use dual-parity to improve capacity efficiency. Workloads that perform large, sequential writes, such as backup software, are best suited for mirror-accelerated parity.

### Plan for Azure Stack HCI host networking

In the simplest terms, planning for host networking in Azure Stack HCI involves identifying the optimal configuration of node interconnects, remote direct memory access (RDMA) adapters, datacenter integration, and bandwidth allocation. Additionally, considerations for stretched clusters include inter-site network-port requirements and latency.

> [!NOTE]
> For details about bandwidth allocation and network port requirements, refer to documents referenced in this module's  Summary unit.

> [!NOTE]
> For stretched clusters, you should have at least one 1 gigabyte (GB) connection between sites with at most 5 milliseconds (ms) round-trip latency.

#### Node interconnect

While each cluster node must have direct network path to each of the other nodes in the same cluster, you can satisfy this requirement in one of two ways:

- Switched. This implementation provides cross-node connectivity via Ethernet switches. This is suitable for clusters with four or more nodes.
- Switchless. This implementation uses multiple, direct Ethernet connections between each pair of cluster nodes. You can use this configuration with smaller clusters consisting of two or three nodes.

#### RDMA

RDMA is a networking technology that provides high-throughput, low-latency communication that minimizes CPU usage. RDMA supports *zero-copy networking*, which allows the pNIC to transfer data directly to or from an application memory. Azure Stack HCI configurations implement one of the two common RDMA technologies:

- RDMA over Converged Ethernet (RoCE and RoCEv2) over UDP/IP, with Data Center Bridging (DCB) providing flow control and congestion management.
- Internet-Wide Area RDMA Protocol (iWarp) over TCP/IP, with TCP providing flow control and congestion management.

Although a Microsoft RDMA implementation is RDMA-technology agnostic, RoCE and RoCEv2 installations are difficult to configure and problematic at any scale beyond a single rack. For all other scenarios, you should consider using iWarp, which doesn't require configuration of DCB on network hosts or network switches, and which can operate over the same distances as any other TCP connection.

#### Datacenter integration

Azure Stack HCI allows you to virtualize its network resources by implementing Software-Defined Networking (SDN). This type of SDN implementation is optional, and you can choose to integrate Azure Stack HCI into an existing Virtual Local Area Network (VLAN)-based infrastructure or isolate its workloads by using SDN-based network virtualization.

> [!NOTE]
> Details about planning for SDN on Azure Stack HCI are beyond this module's scope.
