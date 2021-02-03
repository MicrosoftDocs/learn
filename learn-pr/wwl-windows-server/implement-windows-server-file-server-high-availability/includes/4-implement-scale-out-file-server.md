When deploying highly available Hyper-V VMs or SQL Server databases, it's important to optimize their performance and resiliency. To accomplish this, you should consider using SOFS.

## Scale-Out File Servers

SOFS is a CSV-based Windows Server failover clustering role. SOFS provides the following benefits:

- Improved scaling. Because clients access shared folders via multiple nodes, if the volume of access requests increases, you can add an additional node to the SOFS.
- Load-balanced utilization. All failover cluster nodes can accept, and process client read and write requests targeting one or more SOFS. When you combine their bandwidth and processor power, you can achieve higher utilization rates than with any single node. A single failover cluster node is no longer a potential bottleneck, because a SOFS can support as many clients as all the cluster nodes can collectively facilitate.
- Nondisruptive maintenance, updates, and node failures. Fixing disk corruption issues, performing maintenance, updating, or restarting a failover cluster node don't affect the availability of a SOFS. A SOFS also provides transparent failover following a node failure.
- CSV cache. You can use this feature to allocate system memory as a write-through cache. This can improve performance for applications such as Hyper-V when accessing VHDs, especially in Virtual Desktop Infrastructure (VDI) scenarios.
- Automatic rebalancing of clients. SOFS tracks SMB client connections and redirects clients to the least utilized cluster node.
- Support for multiple SMB instances per node. The default SMB instance manages incoming SMB client traffic, while an additional SMB instance on each cluster node manages internode CSV traffic. This feature improves the scalability and reliability of CSV traffic between cluster nodes.
- Simplified management. With SOFS, you create the SOFS cluster, add the storage to CSVs, and then create file shares. You don't have to create several clustered file servers, each using separate cluster disks, and then design placement rules to ensure a balanced load on all cluster nodes.

## Implement SOFS for VMs

Before you implement SOFS, you need to set up a Windows Server failover cluster, consisting of two or more nodes with the File Services role installed. The cluster must host share storage accessible via CSVs. At that point, you can use Failover Cluster Manager to create a File Server clustered role using the Scale-Out File Server for application data server type. As part of the configuration, you need to provide a name that will serve as the Client Access Point for the file server, which clients will use to access its shares.

> [!NOTE]
> The clustered file server role emulates a Windows-based server, so its name, just as the name of any Windows computer, can't exceed 15 characters.

After you create the File Server role, you need to add to it highly available shares. You can use Failover Cluster Manager for this purpose. When creating shares, choose the SMB Share – Applications profile, which is optimized for Hyper-V VM files and SQL Server database files. After this is completed, you can deploy new or migrate existing VMs such that their disk and configuration files reside on the newly created shares.

## Demonstration

The following videos demonstrate how to:

- Implement SOFS by using graphical tools.
- Implement SOFS by using Windows PowerShell.

The main steps in the process are:

1. Create AD DS environment. Create a single-domain Active Directory Domain Services (AD DS) forest including three domain member servers with the third server containing four data disk each.
1. Create a Windows Server failover cluster by using Windows PowerShell. Use the first two domain member servers to create a two-node cluster.
1. Set up an iSCSI target. Use the third domain member servers to set up an iSCSI target.
1. Set up iSCSI storage. On the third domain member server, create an iSCSI virtual disk and make it available to iSCSI initiators on the cluster nodes.
1. Set up iSCSI Initiator. Configure iSCIS initiators on the cluster nodes to set up shared storage.
1. Configure CSV. Use Failover Cluster Manager to configure CSV.
1. Create a highly available File Server role by using Failover Cluster Manager or Windows PowerShell.

    Use Failover Cluster Manager to configure a Scale-Out File Server to host an application data share.
    >[!VIDEO https://www.microsoft.com/videoplayer/embed/RE4MJKz]

    Use Windows PowerShell to configure an existing failover cluster that uses Cluster Shared Volumes as a Scale-Out File Server and configure an additional IP address resource to bring the Scale-Out File Server online.
    >[!VIDEO https://www.microsoft.com/videoplayer/embed/RE4MJKB]