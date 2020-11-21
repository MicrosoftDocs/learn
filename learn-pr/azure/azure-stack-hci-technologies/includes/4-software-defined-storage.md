Software-defined storage is another of the foundational building blocks of Azure Stack HCI. However, unlike Hyper-V or Failover Clustering, software-defined storage is not an individual server role or a feature, but instead consists of different, frequently complementing each other, technologies that you can combine in order to implement various storage virtualization scenarios, such as, for example, guest clustering. These technologies include Storage Spaces, Cluster Shared Volumes (CSV), Server Message Block (SMB), SMB Multichannel, SMB Direct, Storage Spaces Direct (S2D), and Storage Replica. 

> [!NOTE] 
> This is not the complete list, but is sufficient to gain basic understanding of the core software-defined storage functionality in Azure Stack HCI.

## What is Windows Server software-defined storage?

Software-defined storage uses storage virtualization to separate storage management and presentation from the underlying physical hardware. One of the primary benefits of this approach is simplification of provisioning and accessing storage resources. 

### What are the reasons for using software-defined storage?

Implementing virtualized workloads no longer requires continuous configuration of physical LUNs and SAN switches from different vendors. Instead, you can manage storage in the same, consistent manner regardless of its actual implementation. In addition, in many cases, you have the option of replacing proprietary and expensive technologies with flexible and commodity hardware-based solutions. Rather than relying on dedicated Storage Area Networks (SANs) for highly available and high-performing storage, you have the option of using local disks by using enhancements in remote file sharing protocols and high-bandwidth, low-latency networking. 

## What are Storage Spaces?

A storage space is a storage-virtualization capability built into Windows Server and Windows 10. The Storage Spaces feature consists of two components:

- Storage pools. A storage pool is a collection of physical disks aggregated into a logical disk that you can manage as a single entity. The pool can contain physical disks of any type and size. A single physical disk can belong to only one storage pool.
- Storage spaces. Storage Spaces are virtual disks that you can create from free space in a storage pool. Virtual disks are equivalent to logical unit numbers (LUNs) on a storage area network (SAN).

### What are the reasons for using Storage Spaces?

The most common reasons for using Storage Spaces include:

- Increasing storage resiliency levels, including mirroring and parity. Virtual disks resiliency resembles Redundant Array of Independent Disks (RAID) technologies.
- Improving storage performance by using storage tiers. Storage tiers allow you optimize the use of different disk types in a storage space. For example, you could use very fast but small-capacity solid-state drives (SSDs) with slower, but large-capacity hard disks. When you use this combination of disks, Storage Spaces automatically moves data that is accessed frequently to the faster disks, and then moves data that is accessed less often to the slower disks. The goal of tiering is to balance capacity against performance. 
- Improving storage performance by using write-back caching. The purpose of write-back caching is to optimize writing data to the disks in a storage space. Write-back caching works with storage tiers. If the server that is running the storage space detects a peak in disk-writing activity, it automatically starts writing data to the faster disks. By default, write-back caching is enabled.
- Increasing storage efficiency by using thin provisioning. Thin provisioning enables storage to be allocated readily on a just-enough and just-in-time (JIT) basis. Instead of the traditional fixed storage allocation method in which large portions of storage capacity are allocated but might remain unused, thin provisioning optimizes any available storage by reclaiming storage that is no longer needed using a process known as trim.

## What are Cluster Shared Volumes?

Cluster Shared Volumes (CSV) is a clustered file system (referred to as CSVFS) that enables multiple nodes of a Failover Cluster to simultaneously read from and write to the same set of storage volumes. The CSV volumes map to subdirectories within the C:\ClusterStorage\ directory on each cluster node. This means that cluster nodes can access the same content via the same file system path. While each node can independently read from and write to individual files on a given volume, a single cluster node serves a special role of the CSV owner (or, *coordinator*) of that volume. That node hosts the mount of the volume. You have the option of assigning an individual volume to a specific owner, however, a failover cluster automatically distributes CSV ownership between cluster nodes. The cluster service rebalances the ownership following such changes as adding, removing, or restarting a node.

When changes to file system metadata take place on a CSV volume, the owner is responsible for implementing them and managing their orchestration, synchronizing them across all cluster nodes with access to that volume. Such changes include, for example, creating or deleting a file. On the other hand, standard write and read operations to open files on a CSV volume doesn't affect metadata. Effectively, each cluster node with direct connectivity to the underlying storage can perform them independently, without relying on the CSV owner of that volume. 

### What are the reasons for using CSV?

The most common uses of CSV include:

- Clustered Microsoft Hyper-V VMs (including their virtual hard disk (VHD) files).
- Scale-out file shares hosting application data for the Scale-Out File Server (SOFS) clustered role. Such data includes Hyper-V VM files and Microsoft SQL Server database files.

## What is Server Message Block 3.x?

The Server Message Block (SMB) protocol is a network file sharing protocol that provides access to files over a traditional Ethernet network via TCP/IP transport protocol. SMB serves as one of the core components of software-defined storage technologies. Microsoft introduced SMB version 3.0 in Windows Server 2012 and has been incrementally improving it  in subsequent releases.

### What are the reasons for using SMB?

The most common uses of SMB include:

- Storage for VM disk files (Hyper-V over SMB). Hyper-V can store virtual machine files, such as configuration, Virtual hard disk (VHD) files, and snapshots, in file shares over the SMB 3.x protocol. This can be used for both stand-alone file servers and clustered file servers that use Hyper-V together with shared file storage for the cluster.
- Microsoft SQL Server over SMB. SQL Server can store user database files on SMB file shares. 
- Traditional storage for end-user data. The SMB 3.x protocol supports the traditional information worker workloads. 

## What is SMB Multichannel?

SMB Multichannel is part of the implementation of the SMB 3.x protocol, which significantly improves network performance and availability for Windows Servers operating as file servers. SMB Multichannel allows such servers to take advantage of multiple network connections to provide the following capabilities:

- Increased throughput. The file server can simultaneously transmit more data using multiple connections. This is particularly beneficial when using servers with multiple, high-speed network adapters.
- Automatic configuration: SMB Multichannel automatically discovers multiple available network paths and dynamically adds connections as required.
- Network fault tolerance. If an existing connection is terminated due to an issue along one of network paths to an SMB 3.x server, SMB 3.x clients have a built-in ability to automatically fail over to another one.

## What is SMB Direct?

SMB Direct optimizes the use of RDMA network adapters for SMB traffic, allowing them to function at full speed with very low latency and low CPU utilization. This makes SMB Direct suitable for scenarios in which workloads such as Hyper-V or Microsoft SQL Server rely on remote SMB 3.x file servers to emulate local storage. SMB Direct is available and enabled by default on all currently supported versions of Windows Server.

SMB Multichannel is responsible for detecting the RDMA capabilities of network adapters necessary to enable SMB Direct. It automatically creates two RDMA connections per interface. SMB clients automatically detect and use multiple network connections if an appropriate configuration is identified.

## What are Scale-Out File Servers?

Scale-Out File Server (SOFS) is a CSV-based failover clustering feature. When you configure the File Services server role as a cluster role, you can set it up as *File Server for general use*, or as *Scale-Out File Server for application data*. The former implements highly available shared folders accessible via one of the cluster nodes. If that node fails, another node takes ownership of the role and its resources, maintaining the availability of the shared folders. However, clients always access them via a single node. SOFS implements a different approach, in which shared folders reside on a CSV-based volume. 

### What are the reasons for using SMB?

An SOFS provides the following benefits:

- Improved scaling. Because clients access shared folders via multiple nodes, if the volume of access requests increases, you can add an additional node to the SOFS.
- Load-balanced utilization. All failover cluster nodes can accept and process client read and write requests targeting one or more SOFS. When you combine their bandwidth and processor power, you can achieve higher utilization rates than with any single node. A single cluster node is no longer a potential bottleneck, because SOFS can support as many clients as all the cluster nodes can collectively facilitate.
- Nondisruptive maintenance, updates, and node failures. Fixing disk corruption issues, performing maintenance, updating, or restarting a failover cluster node do not affect the availability of an SOFS. While Microsoft has configured CHKDSK to, by default, shorten the time a file system is offline for repair, CSVs on SOFS eliminate the offline phase completely. An SOFS also provides transparent failover triggered by a node failure.

> [!NOTE] 
> Azure Stack HCI does not use SOFS.

## What is Storage Spaces Direct?

Storage Spaces Direct represent the evolution of Storage Spaces. It leverages Storage Spaces, Failover Clustering, Cluster Shared Volumes (CSVs), and SMB 3.x to implement virtualized, highly-available shared storage by using local disks on each of the Storage Spaces Direct cluster nodes. It is suitable for hosting highly-available workloads, including VMs and SQL Server databases. This eliminates the need for shared storage in Failover Clustering scenarios.

Sharing storage in this manner requires a high-bandwidth, low-latency network between the nodes. To satisfy this requirement, you should deploy redundant network connections in combination with high-end RDMA network adapters. This allows you to benefit from technologies such as SMB 3.x, SMB Direct, and SMB Multichannel to deliver high-speed, low-latency, CPU-efficient storage. To scale out, you add more servers to increase storage capacity and I/O performance. This way, you can convert directly attached storage from a collection of individual disks with limited scalability and resiliency to a highly available and easily expanded storage fabric. By mixing standard hard disk drives with SSDs and NVMe drives, you can further benefit from S2D Storage Bus automatic caching.

### What are two deployment models of Storage Spaces Direct?

There are two deployment models of Storage Spaces Direct:

- Disaggregated. In the disaggregated model, the Hyper-V hosts (compute component) are in a separate cluster from the Storage Spaces Direct hosts (storage component). You configure Hyper-V VMs to store their files in the storage cluster. This allows you to scale the Hyper-V cluster (compute) and S2D-based cluster (storage) independently.
- Hyperconverged. In the hyperconverged model, the cluster nodes operate as both Hyper-V hosts (compute component) and Storage Spaces Direct hosts (storage component). This means that compute and storage are co-located on the same set of cluster nodes. To scale up the cluster, you need to increase the number of its nodes.

## What is Storage Replica?

Storage Replica enables storage-agnostic, block-level, synchronous and asynchronous replication between servers or clusters across different physical locations. 

## What are the reasons for using Storage Replica?

You can use Storage Replica to create stretch failover clusters that span two distinct physical sites, with all nodes staying in sync. - Synchronous replication replicates volumes between sites in relative proximity to each other. Replication is crash-consistent, which ensures zero data loss at the file system–level during a failover. Asynchronous replication enables replication across longer distances in cases where network round trip latency exceeds 5 milliseconds (ms), but it is subject to data loss. The extent of data loss depends on the lag of replication between the source and target volumes.

> [!NOTE] 
> Storage Replica provides the ability to implement Azure Stack HCI stretched clusters.

## What is guest clustering?

You configure guest failover clustering similarly to physical-server failover clustering, except that the cluster nodes are VMs. In this scenario, you create two or more VMs and install and implement failover clustering within the guest operating systems. The application or service is then able to take advantage of high availability between the VMs. Because you implement failover clustering within the guest operating system of each VM node, you can put the VMs on a single host. This is a quick and cost-effective configuration in a test or staging environment.

For production environments, however, you should deploy the VMs on separate failover clustering–enabled Hyper-V host computers. With failover clustering implemented at both the host and VM levels, you can restart the resource regardless of whether the node that fails is a VM or a host. Such high-availability configurations for VMs that are running mission-critical applications in a production environment are considered optimal.

You should consider several factors when implementing guest clustering:

- The application or service must be Failover Clustering–aware. This includes any of the Windows Server services that are cluster-aware, in addition to any applications such as clustered Microsoft SQL Server and Microsoft Exchange Server.
- Hyper-V VMs in Windows Server can use shared storage. You can connect to such storage via Fibre Channel or Internet SCSI (iSCSI) from the clustered VMs. Alternatively, you can configure shared storage on the clustered Hyper-V hosts by using the shared virtual hard disk feature and then attach the shared disks to clustered VMs.

### Deploying a Guest Cluster Using a Shared VHD

You can deploy a guest failover cluster that uses shared .vhdx files on a Hyper-V failover cluster in either of the following scenarios:

- **Scenario 1**: Hyper-V failover cluster using Cluster Shared Volumes (CSV) on block-level storage.
In this scenario, all virtual machine files, including the shared .vhdx files are stored on a CSV that is configured as shared storage for a Hyper-V failover cluster.

- **Scenario 2**: Hyper-V failover cluster using file-based storage in a separate Scale-Out File Server
This scenario uses Server Message Block (SMB) file-based storage as the location of the shared .vhdx files. You must deploy a Scale-Out File Server and create an SMB file share as the storage location. You also need a separate Hyper-V failover cluster.
