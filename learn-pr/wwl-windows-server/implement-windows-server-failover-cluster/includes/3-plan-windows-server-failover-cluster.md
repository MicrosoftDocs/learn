Windows Server failover clusters have more stringent hardware and software requirements than standalone servers. As a result, implementation requires additional planning tasks. Examining the requirements for implementation and careful planning will streamline your cluster provisioning process.

## Failover cluster planning considerations

When planning for deployment of Windows Server failover clusters, start with identifying suitable workloads, and then consider the resources that the workloads require.

### Failover clustering workloads

Because failover clustering isn't always appropriate, before implementing failover clustering technology, you should identify the services and applications that can and should run as clustered resources.

Failover clustering supports:

- A range of stateful applications that support storing data on shared storage.
- Hosting stateful applications that use their own, native data replication mechanisms, with a single writeable copy of that data.

Both of these scenarios are common among database management systems, such as Microsoft SQL Server. Failover clustering is also well suited for Hyper-V VMs and stateful applications running within their operating systems.  

### Failover clustering capacity

Use the following guidelines when planning for capacity in a failover cluster:

- Distribute highly available workloads from a failed node in a well-balanced manner. If all the nodes in a failover cluster are active, the highly available services or applications from a failed node should fail over to different surviving nodes to prevent a single node from overloading.
- Ensure that each node has enough capacity to service the highly available services or applications that you allocate to it when another node fails. This capacity should be sufficient to accommodate additional resource demands.
- Use hardware with similar capacity on all the cluster's nodes. This simplifies the failover planning process, allowing for even distribution among the surviving nodes.
- Consider using a standby server to simplify capacity planning. A passive node in a cluster minimizes the need for complex capacity planning.

### Failover clustering resiliency

Examine all cluster configuration components to identify single points of failure. Remedy single points of failure with such configurations as redundant storage controllers, multi-disk configurations such as mirroring or parity, teamed network adapters, and multipath software. These solutions reduce the probability that a single device failure will have a detrimental impact on the stability of a failover cluster.

> [!NOTE]
> Commonly, server hardware includes multiple power supplies to provide power redundancy and Redundant Array of Independent Disks (RAID) controllers.

### General hardware recommendations and requirements

Failover clusters should conform to the following hardware guidelines:

- The hardware should be certified for Windows Server.
- The same or similar hardware should be installed on each failover cluster node.
- Each node must run the same processor architecture and the same processor family.
- If you use serial attached SCSI (SAS) or Fibre Channel storage connections, the mass-storage device controllers  dedicated to the cluster storage should be identical in all clustered servers and use the same firmware version.
- If you use Internet SCSI (iSCSI) storage connections, each clustered server should have one or more network adapters or host bus adapters that are dedicated to the cluster storage. In all clustered servers, the network adapters that you use to connect to the iSCSI storage target should be identical.

> [!Important]
> You shouldn't use the network used for iSCSI storage connections for non-storage network communication.

### Networking requirements

In addition to general hardware requirements, network-specific requirements include:

- Network adapters in each node should be identical and have the same speed, duplex, and flow control capabilities.
- Network adapters in a cluster network should have the same IP address assignment method, either static or dynamic by using DHCP.
- If you have private networks that aren't routed to the rest of the network infrastructure, ensure that each of those private networks uses a unique subnet. This is necessary even if you give each network adapter a unique IP address.

### Infrastructure requirements

Failover clusters might depend on infrastructure services. Windows Server supports multiple-domain clusters and workgroup clusters.

> [!NOTE]
> Though you can deploy multiple-domain clusters and workgroup clusters, you shouldn't use this configuration for Hyper-V or file server clusters.

You should install the same Windows Server features and roles on each node. Inconsistent configurations on cluster nodes might cause instability and performance issues. Additionally, you shouldn't install the Active Directory Domain Services (AD DS) role on any of the cluster nodes because AD DS has its own fault-tolerance mechanism.

You must have the network infrastructure elements for a failover cluster described in the following table.

| Element                   | Description                                                  |
| ------------------------- | ------------------------------------------------------------ |
| DNS                       | The servers in the cluster use Domain Name System (DNS) for name resolution. |
| A domain membership       | In Windows Server failover clusters, the cluster nodes don't need to be members of the same domain. |
| An administrative account | When you first create a cluster or add servers to it, you must sign in to the domain with an account that has administrative privileges to all servers in that cluster. |

> [!IMPORTANT]
> The administrative account doesn't have to be a member of the Domain Admins group if it's a member of the local Administrators group on each cluster node. However, if that account isn't a member of the Domain Admins group, it needs to have the Create Computer Objects permission in the domain hosting the cluster nodes.

> [!NOTE]
> Starting with Windows Server 2016, you can create so-called *detached clusters*, which don't require this permission assignment.

In Windows Server, you don't need to have a cluster service account. Instead, the cluster service automatically runs in a special context that provides the specific permissions and credentials that are necessary for the service. When a failover cluster is created and a corresponding computer object is created in AD DS, that object is configured to help prevent accidental deletion. Additionally, the cluster Network Name resource has additional health check logic, which periodically checks the health and properties of the computer object that represents the Network Name resource.

### Software requirements for a failover cluster implementation

As a best practice, each cluster node should run the same edition of Windows Server, either Windows Server 2025 Standard or Windows Server 2025 Datacenter. The nodes should have the same software updates installed. You have the option of using Server Core installation of Windows Server 2025 as cluster nodes, although that depends on the workloads and server roles you intend to deploy.
