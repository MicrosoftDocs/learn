Software-defined storage is another of the foundational building blocks of Azure Stack HCI. However, unlike Hyper-V or Failover Clustering, software-defined storage is not an individual server role or a feature, but instead consists of different, frequently complementing each other, technologies that you can combine in order to implement various storage virtualization scenarios. 

## What is Windows Server software-defined storage?

Software-defined storage uses storage virtualization to separate storage management and presentation from the underlying physical hardware. One of the primary benefits of this approach is simplification of provisioning and accessing storage resources. 

## What are Storage Spaces?

A storage space is a storage-virtualization capability built into Windows Server and Windows 10. The Storage Spaces feature consists of two components:

- Storage pools. A storage pool is a collection of physical disks aggregated into a logical disk that you can manage as a single entity. The pool can contain physical disks of any type and size. A single physical disk can belong to only one storage pool.
- Storage spaces. Storage Spaces are virtual disks that you can create from free space in a storage pool. Virtual disks are equivalent to logical unit numbers (LUNs) on a storage area network (SAN).

### What are common use cases for Storage Spaces?

The most common uses of Storage Spaces include:

- Increasing storage resiliency levels, including mirroring and parity. Virtual disks resiliency resembles Redundant Array of Independent Disks (RAID) technologies.
- Improving storage performance by using storage tiers. Storage tiers allow you optimize the use of different disk types in a storage space. For example, you could use very fast but small-capacity solid-state drives (SSDs) with slower, but large-capacity hard disks. When you use this combination of disks, Storage Spaces automatically moves data that is accessed frequently to the faster disks, and then moves data that is accessed less often to the slower disks. The goal of tiering is to balance capacity against performance. 
- Improving storage performance by using write-back caching. The purpose of write-back caching is to optimize writing data to the disks in a storage space. Write-back caching works with Tiered Storage Spaces. If the server that is running the storage space detects a peak in disk-writing activity, it automatically starts writing data to the faster disks. By default, write-back caching is enabled.
- Increasing storage efficiency by using thin provisioning. Thin provisioning enables storage to be allocated readily on a just-enough and just-in-time (JIT) basis. Instead of the traditional fixed storage allocation method in which large portions of storage capacity are allocated but might remain unused, thin provisioning optimizes any available storage by reclaiming storage that is no longer needed using a process known as trim.

## What are Cluster Shared Volumes?

Cluster Shared Volumes (CSV) is a clustered file system (referred to as CSVFS) that enables multiple nodes of a Failover Cluster to simultaneously read from and write to the same set of storage volumes. The CSV volumes map to subdirectories within the C:\ClusterStorage\ directory on each cluster node. This means that cluster nodes can access the same content via the same file system path. While each node can independently read from and write to individual files on a given volume, a single cluster node serves a special role of the CSV owner (or, *coordinator*) of that volume. That node hosts the mount of the volume. You have the option of assigning an individual volume to a specific owner, however, a failover cluster automatically distributes CSV ownership between cluster nodes. The cluster service rebalances the ownership following such changes as adding, removing, or restarting a node.

When changes to file system metadata take place on a CSV volume, the owner is responsible for implementing them and managing their orchestration, synchronizing them across all cluster nodes with access to that volume. Such changes include, for example, creating or deleting a file. On the other hand, standard write and read operations to open files on a CSV volume doesn't affect metadata. Effectively, each cluster node with direct connectivity to the underlying storage can perform them independently, without relying on the CSV owner of that volume. 

### What are common use cases for CSV?

The most common uses of CSV include:

- Clustered Microsoft Hyper-V VMs (including their virtual hard disk (VHD) files).
- Scale-out file shares hosting application data for the Scale-Out File Server (SOFS) clustered role. Such data includes Hyper-V VM files and Microsoft SQL Server database files.

## What is Server Message Block 3.x?

Server Message Block 3.x 

## What is Storage Spaces Direct?

Storage Spaces Direct represent the evolution of Storage Spaces. It leverages Storage Spaces, Failover Clustering, Cluster Shared Volumes (CSVs), Software Storage Bus, and SMB 3.x to implement virtualized, highly-available shared storage by using local disks on each of the Storage Spaces Direct cluster nodes. It is suitable for hosting highly-available workloads, including virtual machines and SQL Server databases. Storage Spaces Direct supports both direct-attached storage (DAS) and JBODs. This eliminates the need for a shared storage fabric and enables you to use a mix of Serial ATA (SATA) disks to lower costs and NVM Express (NVMe) devices to improve performance.





Implementing virtualized workloads no longer requires continuous configuration of physical LUNs and SAN switches from different vendors. Instead, you can manage storage in the same, consistent manner regardless of its actual implementation. In addition, in many cases, you have the option of replacing proprietary and expensive technologies with flexible and commodity hardware-based solutions. Rather than relying on dedicated Storage Area Networks (SANs) for highly available and high-performing storage, you have the option of using local disks by using enhancements in the Server Message Block (SMB) protocol and high-bandwidth, low-latency networking. You can further control storage traffic distribution with converged networking and Quality of Service (QoS) policies.






You can use Windows Server 2019 functionality to build feature-rich virtual storage on commodity hardware by leveraging the following features:

- Server Message Block 3.0 (SMB3). When storing Hyper-V guest virtual machine (VM) disks, SMB3 shares can provide a similar level of reliability, availability, manageability, and performance to that available with SAN-based implementations. SMB3 has several useful features, including the following:

  - SMB Transparent Failover. This feature is available in a failover cluster with two or more nodes. It allows clients to access an SMB file share without interruption even if the SMB file server node to which the client is connected fails. A failover cluster preserves information on the server side and allows the client to reconnect automatically to the same share on one of the remaining cluster nodes.
  - SMB Scale Out. Administrators can use this feature to create file shares in failover clusters on CSVs that provide simultaneous access to files, with direct I/O, through all nodes in a file server cluster. This feature helps provide load-balancing of clients and better utilization of network bandwidth.
  - SMB Multichannel. This feature provides the ability to use multiple network interfaces for aggregation of network bandwidth and network fault tolerance, if multiple paths exist between an SMB client and an SMB server. Server-based applications benefit from aggregated network bandwidth and increased resiliency to network failures.
  - SMB Direct. This feature provides the ability to use network adapters that have Remote Direct Memory Access (RDMA) capability. Network adapters that have RDMA can function at full speed with very low latency by using minimal CPU resources.
  - SMB Encryption. This feature enables file encryption while files are transferred over the network without dependency on public key infrastructure (PKI). You can configure SMB Encryption per share or for the entire server.

- Scale-Out File Server (SoFS). SoFS is a cluster role that optimizes processing of read/write access requests targeting files on the same CSV volume.

- Storage Spaces Direct (S2D). S2D implements highly available and scalable storage by using local disks of failover cluster nodes. S2D is an evolution of Storage Spaces, and it leverages SMB3 for all intra-node communication, including SMB Direct and SMB Multichannel. S2D uses Storage Replica to keep multiple copies of local data synchronized and highly available. S2D was introduced in Windows Server 2016 Datacenter.

- Storage Quality of Service (QoS). By using Storage QoS you can centrally limit I/O operations per second (IOPS) and maximum bandwidth that is available to virtual hard disks that are stored on an SoFS. Storage QoS can limit IOPS and bandwidth for each VM individually, or all virtual machines (VMs) in the same SoFS can share the QoS limits. The ability to limit IOPS and maximum bandwidth on the SoFS level was introduced in Windows Server 2016. In earlier versions of Windows Server, you could limit these parameters only on a per virtual hard disk basis.

- Data Deduplication. Data deduplication is a background process that analyzes the content of files and removes duplicate blocks without compromising file integrity. Data deduplication improves disk space usage efficiency by segmenting files into small chunks of variable size, identifying duplicate chunks, and maintaining a single copy of each chunk. It replaces duplicate copies of the chunks with a reference to the single copy. The chunks are compressed and then organized into special container files in the System Volume Information folder. This process does not affect the way in which files are accessed and retrieved. Data deduplication in Windows Server 2019 supports volumes up to 64 TB, with individual files up to 1 TB on NTFS volumes. On ReFS volumes, data deduplication is capable of processing the first 4 TB of each file.

- Storage Replica. As described earlier in this lesson, Storage Replica enables storage-agnostic, block-level, synchronous and asynchronous replication between servers or clusters that are in the same location or different sites.

- Storage space tiering. When you have different disk types in the same storage space, you can improve performance by configuring storage tiering. When tiering is enabled, Windows Server will move frequently accessed file blocks to faster storage, while leaving infrequently accessed data on slower storage. The process of data moving between storage tiers is dynamic and automatic, but you can also define files that are always available from the faster storage.

## Storage Spaces Direct

Traditionally, in enterprise environments, mission-critical data was stored on SANs rather than direct-attached storage (DAS). In general, SAN-based storage offers higher resiliency and is more scalable when compared to local, directly attached disks.

With the introduction of SOFS in Windows Server 2012 R2, Microsoft provided an alternative solution to SAN storage. The solution involved deploying a cluster of up to four file servers connected to a shared set of up to four Just a Bunch of Disks (JBOD) chassis hosting SAS disks. With the shared disks accessible to all cluster nodes, you could configure them as one or more CSVs and make them available for remote access by using SMB 3.x. With the storage cluster in place, you had the option of deploying another cluster to provide compute resources for VMs with virtual disks residing on the storage cluster. Hyper-V hosts forming the compute cluster would access virtual disk files by using SMB 3.x protocol over a high-bandwidth, low-latency Ethernet network.

However, since this design relies on shared JBODs, it has limited scalability and requires the use of SAS disks. The scalability limit is dictated by the maximum number of physical connections to the shared set of chassis and the maximum number of disks per pool (80). The SAS disk requirement precludes the option of using other drive types, such as Serial ATA (SATA) SSD or NVMe, which could lower the cost or improve performance.

Storage Spaces Direct (S2D), introduced in Windows Server 2016 eliminates these limitations and offers additional performance improvements. Instead of relying on external JBODs, it implements shared storage by using directly attached SAS, SATA, or NVMe drives across two or more servers that are part of the same Windows Server 2016 failover cluster.  S2D supports up to 16 servers and 400 disks.

It is important to point out that sharing storage in this manner requires a high-bandwidth, low-latency network between the nodes. To satisfy this requirement, you should deploy redundant network connections in combination with high-end Remote Direct Memory Access (RDMA) network adapters. This allows you to benefit from technologies such as SMB 3.x, SMB Direct, and SMB Multichannel to deliver high-speed, low-latency, CPU-efficient storage. To scale out, you add more servers to increase storage capacity and I/O performance. This way, you can convert directly attached storage from a collection of individual disks with limited scalability and resiliency to a highly available and easily expanded storage fabric. By mixing standard hard disk drives with SSDs and NVMe drives, you can further benefit from S2D Storage Bus automatic caching.

Note that ReFS, recommended for S2D deployments, offers a range of additional performance improvements. It helps in accelerating virtual disk operations such as creating, expanding, or merging checkpoints. ReFS also supports combining different Storage Spaces resiliency methods within the same Storage Spaces-based virtual disk. In particular, it supports both three-way mirroring and distributed parity with Local Reconstruction Codes. With both resiliency methods in place, ReFS performs real-time tiering, moving data between both tiers, depending on data usage patterns. Frequently used or hot data is stored in the mirrored tier, which offers better performance but less efficient disk space utilization. Cold or less frequently used data is stored in the parity tier, which offers more efficient disk space utilization but is more computationally intensive.

   > **Note**: Local Reconstruction Codes is a Microsoft implementation of erasure coding included in CSV, which S2D depends on for data protection. This feature facilitates data redundancy by splitting a data set into multiple segments, encoding them, and storing them across multiple disks. This is similar to traditional striping with parity.

While we recommend ReFS for S2D deployments, you can also use the NTFS file system if you need to implement deduplication. At the time of the authoring of this course, ReFS does not support deduplication.

   > **Note**: S2D deployments can also significantly benefit from persistent memory (PMem), which was introduced in Windows Server 2016. This technology will be covered in more detail in Module 3: Planning for and Implementing Azure Stack HCI storage.

### Storage Spaces Direct architectural models

There are two basic architectural models that you can follow when deploying Storage Spaces Direct:

- Disaggregated. In the disaggregated deployment model, the Hyper-V hosts (compute component) are in a separate cluster from the Storage Spaces Direct hosts (storage component). You configure Hyper-V VMs to store their files in the storage cluster, operating as an SOFS. This allows you to scale the Hyper-V cluster (compute) and S2D-based SOFS cluster (storage) independently.
- Hyperconverged. In the hyperconverged deployment model, the cluster nodes operate as both Hyper-V hosts (compute component) and Storage Spaces Direct hosts (storage component). This means that compute and storage are co-located on the same set of cluster nodes. This option does not require implementing an SOFS because the CSVs within the same cluster store the virtual machine files. Increasing the number of nodes in the cluster contributes to the scalability of both the compute and storage components.












## What is guest clustering?

You configure guest failover clustering similarly to physical-server failover clustering, except that the cluster nodes are VMs. In this scenario, you create two or more VMs and install and implement failover clustering within the guest operating systems. The application or service is then able to take advantage of high availability between the VMs. Because you implement failover clustering within the guest operating system of each VM node, you can put the VMs on a single host. This is a quick and cost-effective configuration in a test or staging environment.

For production environments, however, you can protect an application or service more robustly if you deploy the VMs on separate failover clustering–enabled Hyper-V host computers. With failover clustering implemented at both the host and VM levels, you can restart the resource regardless of whether the node that fails is a VM or a host. Such high-availability configurations for VMs that are running mission-critical applications in a production environment are considered optimal.

You should consider several factors when implementing guest clustering:

- The application or service must be Failover Clustering–aware. This includes any of the Windows Server services that are cluster-aware, in addition to any applications such as clustered Microsoft SQL Server and Microsoft Exchange Server.
- Hyper-V VMs in Windows Server can use shared storage. You can connect to such storage via Fibre Channel or Internet SCSI (iSCSI) from the clustered VMs. Alternatively, you can configure shared storage on the clustered Hyper-V hosts by using the shared virtual hard disk feature and then attach the shared disks to clustered VMs.

### Deploying a Guest Cluster Using a Shared VHD

You can deploy a guest failover cluster that uses shared .vhdx files on a Hyper-V failover cluster in either of the following scenarios:

- **Scenario 1**: Hyper-V failover cluster using Cluster Shared Volumes (CSV) on block-level storage.
In this scenario, all virtual machine files, including the shared .vhdx files are stored on a CSV that is configured as shared storage for a Hyper-V failover cluster.

- **Scenario 2**: Hyper-V failover cluster using file-based storage in a separate Scale-Out File Server
This scenario uses Server Message Block (SMB) file-based storage as the location of the shared .vhdx files. You must deploy a Scale-Out File Server and create an SMB file share as the storage location. You also need a separate Hyper-V failover cluster.

:::image type="content" source="../media/csv-vs-filebased-storage.png" alt-text="An image of CSV based storage versus file based storage.":::

