To accommodate a wide range of high availability scenarios, clustering technologies should include support for distributed-access file system. This allows for efficient, coordinated access to shared storage across multiple cluster nodes that doesn't lead to data corruption. Windows Server implements such support by using CSV.

## What are Cluster Shared Volumes?

CSV is a general-purpose clustered file system (referred to as CSVFS) that enables cluster nodes to simultaneously read from and write to the same set of NT file system (NTFS) or Resilient File System (ReFs) volumes. CSV maps the volumes hosted on disks connected to cluster nodes to the C:\ClusterStorage\ directory on each cluster node. This approach provides a single namespace, with all CSV content available via the same name and path on any node in a cluster.

:::image type="content" source="../media/m30-csv-architecture1.png" alt-text="The correlation between the storage pool, CSVs, and C:\ClusterStorage\ file system directories." border="false":::

### CSV capabilities

Allowing concurrent volume access provides more balanced load distribution and increases failover speed by eliminating the need for drive ownership changes or dismounting and remounting volumes. Additionally, CSV offers the following capabilities:

- Support for the online chkdsk. The chkdsk operation runs online, without affecting workloads with open handles on the file system.
- Support for BitLocker Drive Encryption. You can use BitLocker to encrypt volumes for both traditional clustered disks and CSV-based volumes.
- Integration with SMB Multichannel and SMB Direct. This enables CSV traffic to stream across multiple networks in the cluster and to take advantage of network adapters that support Remote Direct Memory Access (RDMA).
- Integration with Storage Spaces. This allows virtualized storage on clusters with commodity hardware.
- The ability to scan and repair volumes online. CSV allows you to scan and repair volumes with no downtime when using tools such as chkdsk, fsutil, and the `Repair-Volume` Windows PowerShell cmdlet.
- Enhanced CSV Resiliency. Windows Server implements multiple instances of the Server service, which improves the resiliency and scalability of inter-node SMB traffic. The default instance of the Server service accepts requests that access regular file shares, while the additional instances manage inter-node CSV traffic.

CSV supports two main types of workloads:

- Clustered Microsoft Hyper-V VMs (including their virtual hard disk (VHD) files).
- Scale-out file shares hosting application data for the SOFS clustered role.

CSV allows you to store disk files of multiple VMs on a single volume and run the VMs anywhere on any cluster node. Additionally, CSV accelerates the Live Migration functionality, eliminating the need to change the disk ownership when a VM moves to another node, which improves the performance and stability of the migration process.

While each node can independently read from and write to individual files on the volume, a single node functions as the CSV owner (or, *coordinator*) of the volume. That node hosts the mount of the volume. You have the option of assigning an individual volume to a specific owner, however, a failover cluster automatically distributes CSV ownership between cluster nodes. The distribution mechanism considers the number of CSVs that each node owns. The cluster service rebalances the ownership following such changes as adding, removing, or restarting a node.

When changes to file system metadata take place on a CSV volume, the owner is responsible for implementing them and managing their orchestration, synchronizing them across all cluster nodes with access to that volume. Such changes include, for example, starting, creating, migrating, or deleting VM disk files which reside on the volume. Metadata updates don't involve direct communication from non-owner cluster nodes to the shared storage hosting the volume.

In contrast, standard write and read operations to open files on a CSV volume don't affect metadata. Effectively, each cluster node with direct connectivity to the underlying storage can perform them independently, without relying on the CSV owner of that volume. Such operations, unlike metadata updates, constitute most of the storage activity.

The owner node also minimizes negative impact of storage connectivity failures and storage operations that prevent a given node from communicating directly with the storage. In case of such events, a node that needs to communicate with the underlying storage redirects disk I/O through a cluster network to the owner node of the corresponding volume. If the current coordinator node experiences a storage connectivity failure, all disk I/O operations are temporarily queued while the cluster automatically assigns the coordinator role to a new node.

## Plan for CSV

To use CSV, your storage and disks must satisfy the following requirements:

- File system format and disk configuration. A disk or storage space for a CSV volume must use a basic disk in either NTFS of ReFs format. When using storage spaces, you can configure a simple space, a mirror space, or a parity space.
- Physical Disk cluster resources. CSV volume relies on the Physical Disk resource type. To create Physical Disk resource type, you need to add a disk or storage space to cluster storage.

Additional planning considerations include:

- The number and size of logical unit numbers (LUNs) and volumes. You should consult your storage vendor for guidance.
- The number and size of VMs (for VM deployments). While there are no limitations on the number of VMs per volume, you should consider aggregate I/O requirements when deciding on the optimal number.
- Cluster networks. Cluster networks should allow for the potential increase in network traffic to the coordinator node during I/O redirection.

## Implement CSV

The CSV feature is enabled by default in Failover Clustering. To add a disk to CSV, you must first include it in the Available Storage group of the cluster. Before you can add storage to the CSV, the corresponding disk must be available as shared storage to the cluster. When you create a failover cluster, all of the existing shared disks are automatically added to the cluster. At that point, you can add them to CSV. If you add more disks to the shared storage afterwards, you must first add the storage to the cluster and then add the storage to the CSV. You can perform all of these tasks by using Failover Cluster Manager or Windows PowerShell cmdlets.
