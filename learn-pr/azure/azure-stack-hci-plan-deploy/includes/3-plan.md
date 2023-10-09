After you verify that Azure Stack HCI is suitable for hosting your workload, you must consider your infrastructure requirements, including compute, storage, and networking components. These considerations are workload-dependent, so for a scenario such as Contoso's, you must account for distinct performance requirements of Microsoft SQL Server and VDI.

## Plan for Azure Stack HCI

General planning considerations for an Azure Stack HCI implementation include:

- The number of physical servers per cluster. This number must be between 1 and 16.
- The number of fault domains per cluster. By default, each node in a Storage Spaces Direct cluster is one fault domain.
- The number and type of processors per server. The first of these values determine the core count and the latter dictates their speed.
- The amount and type of memory per server, including whether to use persistent memory (PMEM).
- Disk performance, including the corresponding tiering and caching configuration.
- The number, types, and capabilities of your network adapters.
- The Azure subscription in which you'll register your Azure Stack HCI deployment, because there are ongoing charges for Azure Stack HCI clusters depending on Azure subscription type.

Planning considerations with respect to storage performance and capacity include:

- The number and types of disks, including HDDs, SSDs, and NVMe.
- Storage Spaces Direct resiliency levels.
- Tiering and caching configuration.

Some other networking factors to consider:

- Whether to use network switches or go switchless (small clusters can use a full-mesh network to connect servers to each other without switches)
- Physical cabling requirements for adapters (switched vs switchless)
- The network switches per cluster and ownership thereof

Other considerations apply to stretched clusters, including how many servers each site requires and the cluster configuration's mode. The two modes are:

- **Active-passive mode**, in which a designated primary site unidirectionally replicates to another site that provides disaster-recovery capability.
- **Active-active mode**, in which two sites replicate their respective volumes unidirectionally to each other, providing failover capability if either site fails. The active-active mode helps minimize business-continuity costs because you won't need a dedicated disaster-recovery site.

Your intended workloads affect all of these factors. Effectively, the use cases previously discussed are a basis for identifying an optimal Azure Stack HCI hardware configuration. The Azure Stack HCI catalog has a list of all Azure Stack HCI solutions that third-party hardware vendors offer and of which Microsoft approves.

### Plan for Azure Stack HCI host storage

In the simplest terms, planning for Azure Stack HCI host storage involves identifying the optimal balance between resiliency, capacity, and performance of Storage Spaces Direct. However, there's a challenge; maximizing one of these characteristics typically has a negative impact on at least one of the other two. For example, increasing resiliency reduces the usable capacity, although resulting performance might vary depending on resiliency type.

#### Drives

Storage Spaces Direct supports hard disk drives (HDDs), solid-state drives (SSDs), and Non-Volatile Memory Express (NVMe) drives, including PMEM. The choice of drive type directly affects storage performance due to differences in performance characteristics between each type and the cache mechanism.

#### Storage Spaces Direct cache

In general, Storage Spaces Direct assigns drives to one of two categories based on the drive type: capacity or cache.

- **Capacity** drives provide the raw storage for the cluster and are typically slower and more capacious than cache drives.
- **Cache** drives are used to accelerate reads and writes to slower capacity drives.

In clusters with multiple drive types, Storage Spaces Direct automatically assigns all the fastest drive types to the cache and uses the remaining drives for capacity. You can manually cache in scenarios where the default configuration doesn't yield optimal performance.

#### Drive symmetry

Storage Spaces Direct works in the optimal manner when every server has the exact the same number and type of drives. In general, you should configure your Storage Spaces Direct cluster in such way that:

- All servers have the same drive type.
- All servers have the same number of drives per type.
- All drives have the same model and firmware version.
- All drives of the same type have the same size.

It’s OK for the number of drives to differ temporarily during failures or while adding or removing drives. There’s also some flexibility with the drive models and sizes; for example, you might not be able to replace a failed drive with the exact same model. However, if the drives are too different, you could end up with stranded capacity or uneven performance.

#### Cluster and pool quorums

In a failover cluster, the term *quorum* is the number of clustering components that must be available for that cluster to remain online. These components can include the cluster nodes and, optionally, a witness. The term witness specifies a resource dedicated exclusively to establishing and maintaining quorum.

With Storage Spaces Direct, there are two distinct quorum mechanisms:

- **Cluster quorum**, which operates at the cluster level, and is based on votes from nodes and a witness. Storage Spaces Direct doesn't support Disk Witness, leaving Cloud Witness and the file-share witness as the two viable options.
- **Pool quorum**, which operates on the storage pool level, and is based on votes from nodes and storage resiliency. To optimize pool quorum configuration when implementing Storage Spaces Direct, ensure there's a matching storage configuration in each cluster node.

#### Volumes

With Storage Spaces Direct, volumes allow you to group drives in the storage pool in order to yield the optimal combination of fault tolerance, scalability, and performance requirements. When planning for Storage Spaces Direct volumes, you should consider the following:

- **Number of volumes per cluster**: To optimize storage performance, the number of volumes per server should be a multiple of the number of servers per cluster.
- **File system**: We recommend using the Resilient File System (ReFS) for Storage Spaces Direct volumes.

  If your workload requires a feature that ReFS doesn't support yet, you can use NTFS volumes instead for that workload (you can have ReFS and NTFS volumes in the same cluster).
- **Volume size**: The size of a volume on an Azure Stack HCI cluster shouldn't exceed 64 TB.
- **Reserve capacity**: To optimize disk space usage, consider setting aside the equivalent of one capacity drive per server, up to four drives per cluster.
- **Resiliency type**: Volume resiliency is the primary mechanism that protects data residing in the storage pool against hardware issues, such as drive or server failures. The choice of resiliency type is workload-dependent.
  - Use mirroring for volumes that need to maximize performance for workloads that have strict latency requirements or that perform large amounts of mixed random IOPS, such as Microsoft SQL Server databases or performance-sensitive Hyper-V VMs.
  - Use dual-parity for volumes that need to maximize capacity efficiency and for workloads that have less demanding I/O requirements, such as file servers or Virtual Desktop Infrastructure (VDI).
  - Use mirror-accelerated parity to balance performance and capacity for workloads that perform large, sequential writes, such as backup software.
  - Use nested resiliency on two-server clusters that run production workloads to add resiliency to a drive failure that happens while one server is offline. You can use either nested mirroring or mirror-accelerated parity, depending on your workload.

### Plan for Azure Stack HCI host networking

In the simplest terms, planning for host networking in Azure Stack HCI involves identifying the adapter and physical switch configuration you'll use. Additionally, considerations for stretched clusters include inter-site network-port requirements and latency.

#### Physical network considerations

At a minimum, customers must ensure:

- They're using a compliant Azure Stack HCI switch.
- They know the IP subnets and VLANs for management, storage, and compute traffic.

Other network requirements, such as the Data Center Bridging, might also be necessary to integrate into your network requirements for your solution (more on this later).

#### Network ATC

Network ATC is a new service that helps deploy and maintain the host networking configuration and is only available on Azure Stack HCI. Network ATC provides these benefits:

- Simplifies host networking deployment across the entire cluster
- Implements the latest Microsoft-validated best practices
- Keeps all host networking configurations synchronized within the cluster
- Remediates administrator misconfigurations to prevent configuration drift
- Streamlines cluster expansion, helping to ensure new servers are deployed exactly as the others

With Network ATC, you reduce the host configuration to a single command or user interface (via Windows Admin Center).

#### RDMA

RDMA is a key networking technology that provides high-throughput, low-latency communication that offloads networking traffic from the CPUs, freeing up CPU time for running workloads. Azure Stack HCI configurations can use one of the two common RDMA technologies:

- (Recommended) Internet-Wide Area RDMA Protocol (iWarp) over TCP/IP, with TCP providing flow control and congestion management
- RDMA over Converged Ethernet (RoCE) over UDP/IP, with Data Center Bridging (DCB)

If you're unsure of which technology to use, we recommend using iWARP because it's simpler to configure.

#### Plan for Software Defined Networking

Azure Stack HCI includes Software Defined Networking (SDN), which can provide network services on your existing Virtual Local Area Network (VLAN) based infrastructure, as well as virtualize your networks and provide network services on the virtualized networks.

SDN scenarios on traditional VLAN networks:

- **Microsegmentation**: Customers can apply security access control list (ACL) policies to protect their workloads from external as well as internal attacks.
- **Quality of Service (QoS)**: Customers can apply QoS policies to prevent one application or workload VM from hogging the entire bandwidth of their HCI cluster nodes.
- **Software Load Balancing (SLB)**: Customers can deploy SLB to evenly distribute customer network traffic among multiple resources. SLB enables multiple servers to host the same workload, providing high availability and scalability. It also provides Network Address Translation (NAT) services.

SDN scenarios on virtualized networks:

- **Network virtualization**: Customers can bring their own IP networks and provision workloads on these networks.
- **Microsegmentation**: Customers can apply security access control list (ACL) policies to protect their workloads from external as well as internal attacks.
- **Quality of Service (QoS)**: Customers can apply QoS policies to prevent one application or workload VM from consuming the entire bandwidth of their cluster.
- **Software Load Balancing (SLB)**: Customers can deploy Software Load Balancing to evenly distribute customer network traffic among multiple resources. Software Load Balancing enables multiple servers to host the same workload, providing high availability and scalability. It also provides Network Address Translation (NAT) services.
- **Virtual appliances**: Customers can use their own third-party virtual appliances—like firewalls, intrusion detection devices, load balancers, and more—and attach them to the virtualized networks.
- **Connectivity to external networks**: Customers can use SDN gateways to provide connectivity from their virtualized networks to external networks. SDN provides connectivity to on-premises networks over the internet or over dedicated networks. It also provides connectivity between virtualized networks and physical networks in the same location.

SDN has three infrastructure components, and you can choose to deploy some or all of them based on your needs.

- **Network Controller**: This is the primary component of SDN. Network Controller is the centralized control plane for SDN. It receives policy from the management plane and configures the data plane with the policy. With Network Controller, customers can manage network services like microsegmentation and QoS for traditional VLAN networks and virtualized networks.
- **Software Load Balancer (SLB)**: This in the infrastructure component responsible for providing the load balancing and NAT capabilities for workloads on traditional VLAN networks and virtualized networks.
- **Gateways**: This is the infrastructure components responsible for providing virtual-network connectivity to external networks.
