To accommodate a wide range of high-availability scenarios, clustering technologies should include support for distributed-access file system. This allows for efficient, coordinated access to shared storage across multiple cluster nodes that doesn't lead to data corruption. Windows Server implements such support by using CSV.

## What are Cluster Shared Volumes?

CSV is a general-purpose clustered file system (referred to as CSVFS) that enables cluster nodes to simultaneously read from and write to the same set of NT File System (NTFS) or Resilient File System (ReFS) volumes. CSV consolidates volumes hosted on disks connected to cluster nodes into a single namespace that's accessible in the uniform manner on each cluster node. Allowing concurrent volume access provides more balanced load distribution and considerably increases failover speed by eliminating the need for drive ownership changes or dismounting and remounting volumes.

Additionally, CSV offers the following capabilities:

- Support for the online chkdsk. The chkdsk operation runs online, without affecting workloads with open handles on the file system.
- Support for BitLocker Drive Encryption. You can use BitLocker to encrypt volumes for both traditional clustered disks and CSV-based volumes.
- Integration with SMB Multichannel and SMB Direct. This enables CSV traffic to stream across multiple networks in the cluster and to take advantage of network adapters that support Remote Direct Memory Access (RDMA).
- Integration with Storage Spaces. This allows you to use virtualized storage on clusters with commodity hardware.
- The ability to scan and repair volumes online. CSV allows you to scan and repair volumes with no downtime when using tools such as chkdsk, fsutil, and the `Repair-Volume` Windows PowerShell cmdlet.
- Enhanced CSV Resiliency. Windows Server implements multiple instances of the Server service, which improves the resiliency and scalability of inter-node SMB traffic. The default instance of the Server service accepts requests that access regular file shares, while the additional instances manage inter-node CSV traffic.

> [!NOTE]
> In general, CSVFS supports the same functionality as NTFS or ReFS. However, there are some exceptions, such as compression.

CSV supports two main types of workloads:

- Clustered Microsoft Hyper-V VMs (including their virtual hard disk (VHD) files).
- Scale-out file shares hosting application data for the Scale-Out File Server (SOFS) clustered role. Such data includes Hyper-V VM files and Microsoft SQL Server database files.

CSV allows you to store disk files of multiple virtual machines (VMs) on a single volume and run the VMs anywhere on any cluster node, or even on a different cluster. Additionally, CSV accelerates the Live Migration functionality. Eliminating the need to change the disk ownership when a VM moves to another node improves the performance and stability of the migration process.

> [!NOTE]
> ReFS isn't supported for a SOFS.

### CSV cache

The CSV cache provides block-level caching of read-only, unbuffered, I/O operations by allocating system memory as a write-through cache. This can improve performance of Hyper-V host read requests when accessing a VHD without caching write requests. This is especially useful in deployments where a Hyper V cluster uses a SOFS cluster to host VM disks.

> [!NOTE]
> CSV cache is enabled by default on Windows Server.
