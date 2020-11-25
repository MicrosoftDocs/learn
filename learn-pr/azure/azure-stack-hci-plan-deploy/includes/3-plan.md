Once you verify that Azure Stack HCI is suitable for hosting your workload, you need to consider infrastructure requirements, including compute, storage, and networking components. These considerations are workload dependent, so in the case of Contoso, they should account for distinct performance requirements of Microsoft SQL Server and VDI.

## Plan for Azure Stack HCI

In general, when planning for Azure Stack HCI implementation, you should consider:

- The number of physical servers per cluster. This number must be between 2 and 16.
- The number of fault domains per cluster. By default, each node in a Storage Spaces Direct cluster constitutes one fault domain.
- The number and type of processors per server. The first of these values determines the core count, while the latter dictates their speed.
- The amount and type of memory per server. This includes the decision whether to use persistent memory (PMEM).
- The number and types of disks, including HDDs, SSDs and NVMe. Your choice impacts storage performance and total capacity.
- Storage Spaces Direct resiliency levels. Besides resiliency, this affects storage performance and usable capacity.
- Tiering and caching configuration. This also affects storage performance and usable capacity.
- Disk performance. The performance considerations include the corresponding tiering and caching configuration.
- The number and type of network adapters per server. This impacts throughput and latency of storage and network traffic.
- The number and type of network switches per cluster. This also has impact on throughput and latency of storage and network traffic.
- The Azure subscription in which you will register your Azure Stack HCI deployment. Note that your decision this has pricing implications, since the ongoing charges for Azure Stack HCI clusters are associated with that Azure subscription.

There are also additional considerations that apply to stretched clusters. You need to determine how many servers you will need at each site, and whether the cluster configuration will be active/passive or active/active. In active-passive mode, a designated primary site unidirectionally replicates to another site that provides the disaster recovery capability. In active-active mode, two sites replicate their respective volumes unidirectionally to each other, providing failover capability in case of a failure in either site. The active-active mode helps minimize business continuity costs by eliminating the need for a dedicated disaster recovery site.

All of these considerations depend to large extent on the intended workloads. Effectively, the use cases mentioned earlier in this module serve as the basis for identifying the optimal Azure Stack HCI hardware configuration. The list of all Azure Stack HCI solutions offered by third-party hardware vendors that have been approved by Microsoft for these use cases is maintained in the Azure Stack HCI catalog.

### Plan for Azure Stack HCI host storage

In the simplest terms, planning for Azure Stack HCI host storage involves identifying the optimal balance between resiliency, capacity, and performance of Storage Spaces Direct. The challenge results from the fact that maximizing one of these characteristics typically has a negative impact on at least one of the other two. For example, increasing resiliency reduces the usable capacity, although the resulting performance might vary depending on the resiliency type.

#### Drives

Storage Spaces Direct supports hard disk drives (HDDs), solid state drives (SSDs), and Non-Volatile Memory Express (NVMe) drives, including PMEM. The choice of the drive type directly impacts storage performance, due to differences in performance characteristics between each type, and the cache mechanism.

#### Storage Spaces Direct cache

In general, Storage Spaces Direct assigns drives to one of two categories based on the drive type: capacity, or cache. Cache drives don't contribute to the usable or raw storage capacity of a cluster, which means that the total raw storage capacity of a cluster is the sum of capacity drives on all of its nodes.

In clusters with multiple types of drives, Storage Spaces Direct automatically assigns all of the fastest type of drives to the cache. The remaining drives are used for capacity. You have the option to set caching manually in cases where the default configuration doesn't yield the optimal performance.

#### Drive symmetry

Storage Spaces Direct works in the optimal manner when every server has the exact the same number and type of drives. In general, you should configure your Storage Spaces Direct cluster in such way that:

- All servers have the same types of drives.
- All servers have the same number of drives of each type.
- All drives have the same model and firmware version.
- All drives of the same type have the same size.

#### Cluster and pool quorums

In a failover cluster, the term quorum represents the number of clustering components that must be available for that cluster to remain online. These components can include the cluster nodes and, optionally, a witness. The term witness designates a resource dedicated exclusively to the purpose of establishing and maintaining a quorum.

In the context of Storage Spaces Direct, there are two distinct quorum mechanisms:

- *Cluster quorum*, which operates at the cluster level, and is based on votes from nodes and a witness. Storage Spaces Direct doesn't support Disk Witness, leaving Cloud Witness and the file share witness as the two viable options.
- *Pool quorum*, which operates on the storage pool level, and is based on votes from nodes and storage resiliency. To optimize pool quorum configuration when implementing Storage Spaces Direct, ensure there's a matching storage configuration in each cluster node.

#### Volumes

In the context of Storage Spaces Direct, volumes allow you to group the drives in the storage pool in the manner that yields the optimal combination of fault tolerance, scalability, and performance requirements. When planning for Storage Spaces Direct volumes, you should consider the following:

- Number of volumes per cluster. To optimize storage performance, the number of volumes per server should be a multiple of the number of servers per cluster.
- File system. Consider using the ReFS for Storage Spaces Direct volumes.
- Volume size. The size of a volume on an Azure Stack HCI cluster shouldn't exceed 64 TB.
- Reserve capacity. To optimize disk space usage, consider setting aside the equivalent of one capacity drive per server, up to 4 drives per server.
- <!--Marcin can this content be broken/split into another bullet point? The content is longer than the other bullets (perhaps it just needs to be and we leave it as is) I'm just wondering about a way to balance things out a bit more. Maybe create a shorter bullet point about resiliency type and add a follow up consideration paragraph about mirroring? -->Resiliency type. Volume resiliency is the primary mechanism that protects data residing in the storage pool against hardware issues, such as drive or server failures. The choice of resiliency type is workload dependent. Workloads that have strict latency requirements or that perform large amounts of mixed random IOPS, such as Microsoft SQL Server databases or performance-sensitive Hyper-V VMs, should run on volumes that use mirroring to maximize performance. Workloads that have less demanding I/O requirements, such as file servers or Virtual Desktop Infrastructure (VDI), can use dual-parity to improve capacity efficiency. Workloads that perform large, sequential writes, such as backup software, are best suited for mirror-accelerated parity.

### Plan for Azure Stack HCI host networking

In the simplest terms, planning for host networking in Azure Stack HCI involves identifying the optimal configuration of node interconnects, remote direct memory access (RDMA) adapters, datacenter integration, and bandwidth allocation. There are additional considerations for stretched clusters, such as inter-site network port requirements and latency.

> [!NOTE]
> For details regarding the bandwidth allocation and network port requirements, refer to documents referenced in the Summary unit of this module.

> [!NOTE]
> For stretched clusters, you should have at least one 1 Gb connection between sites with at most 5 ms round trip latency.

#### Node interconnect

While each cluster node must have direct network path to each of the other nodes in the same cluster, you can satisfy this requirement in one of two ways:

- Switched. This implementation provides cross-node connectivity via Ethernet switches. This is suitable for clusters with four or more nodes.
- Switchless. This implementation uses multiple, direct Ethernet connections between each pair of cluster nodes. You have the option to use this configuration with smaller clusters consisting of 2-3 nodes.

#### RDMA

RDMA is a networking technology that provides high-throughput, low-latency communication that minimizes CPU usage. RDMA supports *zero-copy networking*, which allows the pNIC to transfer data directly to or from an application memory. Azure Stack HCI configurations implement one of the two common RDMA technologies:

- RDMA over Converged Ethernet (RoCE and RoCEv2) over UDP/IP, with Data Center Bridging (DCB) providing flow control and congestion management.
- Internet Wide Area RDMA Protocol (iWarp) over TCP/IP, with TCP providing flow control and congestion management.

Although the Microsoft RDMA implementation is RDMA-technology agnostic, RoCE and RoCEv2 installations are difficult to configure and problematic at any scale above a single rack. For all other scenarios, you should consider iWarp instead. iWarp does not require any configuration of DCB on network hosts or network switches and can operate over the same distances as any other TCP connection.

#### Datacenter integration

Azure Stack HCI gives you the option to virtualize its network resources by implementing Software-Defined Networking (SDN). Because such SDN implementation is optional, you have the choice of integrating Azure Stack HCI into an existing Virtual Local Area Network (VLAN)-based infrastructure or isolating its workloads by making use of SDN-based network virtualization.

> [!NOTE]
> Coverage of the planning for SDN on Azure Stack HCI is beyond the scope of this module.
