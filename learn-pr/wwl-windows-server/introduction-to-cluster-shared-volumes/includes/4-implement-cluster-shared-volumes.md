While implementation of CSV is straightforward, you should first carefully plan for it to optimize its performance and resiliency.

## Plan for CSV

To use CSV, your storage and disks must satisfy the following requirements:

- File system format and disk configuration. A disk or storage space for a CSV volume must use a basic disk in either NTFS or ReFS format. When using storage spaces, you can use configure a simple space, a mirror space, or a parity space.
- Physical Disk cluster resources. CSV volume relies on the Physical Disk resource type. To create Physical Disk resource type, you need to add a disk or storage space to cluster storage.

Additional planning considerations include:

- The number and size of Logical Unit Numbers (LUNs) and volumes. You should consult your storage vendor for guidance.
- The number and size of VMs (for VM deployments). While there are no limitations on the number of VMs per volume, you should consider aggregate I/O requirements when deciding on the optimal number.
- Cluster networks. Cluster networks should allow for the potential increase in network traffic to the coordinator node during I/O redirection.

## Implement CSV

The CSV feature is enabled by default in Failover Clustering. To add a disk to CSV, you must first include it in the Available Storage group of the cluster. Before you can add storage to the CSV, the corresponding disk must be available as shared storage to the cluster. When you create a failover cluster, all the existing shared disks are automatically added to the cluster. At that point, you can add them to CSV. If you add more disks to the shared storage afterwards, you must first add the storage to the cluster and then add the storage to the CSV. You can perform all these tasks by using Failover Cluster Manager or Windows PowerShell cmdlets.

As a best practice, you should configure CSVs before you make any VMs highly available. However, you can convert from standard shared disk access to CSVs after deployment. The following considerations apply:

- If you decide to convert a shared disk to CSV, keep in mind that the corresponding drive letter or mount point is automatically removed. This means that you must recreate all VMs that reside on the shared storage. If you must retain the same virtual machine settings, consider exporting the VMs, switching to CSV, and then importing the VMs. Alternatively, you can use storage migration to move virtual machines temporarily to another location until you switch the volume to CSV.
- You can't add shared storage to CSV if it is in use. If you have a running virtual machine that is using a cluster disk, you must shut down the virtual machine, and then add the disk to CSV.

## Demonstration

The following video demonstrates how to:

- Identify implementation prerequisites for CSV.
- Provision CSV.

The main steps in the process are:

1. Create AD DS environment. Create a single-domain AD DS forest including three domain member servers with the third server containing four data disks each.
1. Create a Windows Server failover cluster by using Windows PowerShell. Use the first two domain member servers to create a two-node cluster.
1. Set up an iSCSI target. Use the third domain member servers to set up an iSCSI target.
1. Set up iSCSI storage. On the third domain member server, create an iSCSI virtual disk and make it available to iSCSI initiators on the cluster nodes.
1. Set up iSCSI Initiator. Configure iSCSI initiators on the cluster nodes to set up shared storage.
1. Configure CSV. Use Failover Cluster Manager to configure CSV.

 > [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4MBcx]

---



---