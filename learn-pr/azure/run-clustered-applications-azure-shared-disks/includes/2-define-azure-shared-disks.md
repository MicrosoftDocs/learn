Suppose you want to migrate many servers that are running clustered workloads from your on-premises network to Azure. You can create Azure shared disks and attach them to multiple virtual machines (VMs) simultaneously.

Azure shared disks offer shared cloud-based block storage. This shared storage supports both Windows-based and Linux-based clustered applications.

Azure displays a shared disk as a logical unit number (LUN) to the target VM, which uses it as direct-attached storage.

Applications that use Azure shared disks use a SCSI persistent reservation (SCSI PR) standard to enable failover from one node to another. VMs in the cluster can read or write to their attached disk, based on the chosen reservation of the clustered application that uses SCSI PR.

> [!NOTE]
> SCSI PR is an industry standard that applications running on on-premises system area networks (SANs) use.

You use Azure shared disks to run clustered databases, parallel file systems, persistent container volumes, and machine-learning applications.

## Features of Azure shared disks

An Azure shared disk is created as a *managed disk*. A managed disk is a virtual hard disk for which Azure manages all required physical infrastructure. Because Azure takes care of the underlying complexity, managed disks are easy to use. You simply set up and attach them to VMs.

Azure shared disks are available on the following disk types: 

- Ultra Disks. These disks deliver high throughput, high I/O operations per second (IOPS), and consistent low latency disk storage for Azure infrastructure as a service (IaaS) VMs. By using Ultra Disks, you can dynamically change a disk's performance without restarting your VMs. Ultra Disks have the fastest performance on Azure along with low submillisecond latencies. They're scalable to 64 tebibytes (TiB).
- Premium SSD v2 offers higher performance than Premium SSD while also generally being less costly. You can individually tweak the performance of Premium SSD v2 at any time, allowing your workloads to be more cost efficient.
- Premium SSD (P15 and greater). Premium SSDs are backed by solid-state drives (SSDs). They deliver high-performance, low-latency disk support for VMs that are running I/O-intensive workloads.
- Standard SSDs are optimized for workloads that need consistent performance at lower IOPS levels than Premium SSD or Premium SSD v2.

For Premium SSD and Standard SSD, the disk size defines the number of maximum shares, which can't be more than 10. For each disk, a *maxShares* value represents the maximum number of nodes that can simultaneously share the disk.

Ultra Disks and Premium SSD v2 don't have size restrictions. The maximum value for the *maxShares* setting is 5.

> [!NOTE]
> You can share Azure shared disks only as data disks and not as OS disks.

## Use-case scenarios for Azure shared disks

Azure shared disks offer the flexibility to migrate on-premises clustered environments that run on Windows or Linux. Applications that run on Windows Server instances can use the failover cluster service to control the Azure shared disks' read and write operation.

### A failover cluster scenario

In a failover cluster scenario, you use multiple VMs to access an Azure shared disk. One of the VMs acts as a primary node and reads and writes to the disk. The other VMs act as secondary nodes. If the primary node loses access to the disk, the secondary nodes can take over the read and write operations. A common use-case scenario that uses a failover cluster with active-passive mode is а clustered database such as a SQL Server failover cluster instance (FCI).

To help you understand how shared disks work, let's examine the following step-by-step example:

1. The clustered application that runs on the VMs uses the SCSI PR protocol to register its intent to read or write to disk. In this step, each VM reads information on the target about existing reservations and registrations.
1. One application instance on VM1 takes an exclusive reservation to write to the disk.
1. After that reservation is enforced, only VM1 can write to the disk. This action prevents other VMs from writing to the disk at the same time.
1. If the application instance on VM1 goes down, VM2 issues a *preempt and abort* command and assumes disk control.
1. The reservation to write is now enforced on the VM2, and other VMs can't write to the disk.
1. The applications that were running on VM1 now fail over to VM2.

:::image type="content" source="../media/02-diagram-for-failover-clustering-using-shared-disk.png" alt-text="Diagram that shows how failover clustering works with shared disks on Azure." border="true":::

### SQL Server failover cluster instance

You can create a SQL Server FCI by using two or more Windows Azure VMs. To achieve high availability, use Premium SSDs that support availability sets and proximity placement groups. Alternatively, you can use Ultra Disks that include support for availability zones. You should use Azure shared disks to store SQL Server FCI data directories. You can also implement striping across multiple shared disks if you create a shared storage pool. 

> [!NOTE]
> Availability sets and proximity placement groups aren't required to implement a SQL Server FCI with a shared disk. They're used to increase the availability and performance of the SQL Server FCI.

### SAP ASCS/SCS

SAP application servers use clustered shared disks to place SAP ASCS/SCS and SAP global host files. You can deploy SAP applications on both Windows and Linux.

Windows Server failover clustering with Azure VMs requires more configuration steps. When you build a cluster, you need to set up several IP addresses and virtual host names for the SAP ASCS/SCS instance. You can deploy both single and multiple security identifier (SID) options for SAP ASCS/SCS. You can use only Premium SSDs as Azure shared disks for an SAP ASCS/SCS instance.

### File servers

File servers for general use can use the shared disk to enable high availability for the file service role. You can also use the Scale-Out File Server features deployed on a Windows Server failover cluster, which uses Azure shared disks in active-active mode. Cluster witness resources are stored on Azure shared disks. All file shares are simultaneously online on all nodes.

Use an Azure Resource Manager template (ARM template) to deploy a [Windows Server 2019 Scale-Out File Server cluster with Azure shared disks](https://github.com/robotechredmond/301-shared-disk-sofs).

### Distributed applications with multi-read or multi-write requirements

The clustered application running on multiple VMs can access the Azure shared disk using the strategy of "Write Once Read Many". One VM has an exclusive reservation to write to the shared disk by using SCSI persistent reservation. Meanwhile, other VMs can read concurrently from the disk. Only one node writes results to the disk for all cluster nodes.

The following diagram illustrates another common clustered workload. It consists of several nodes that read a disk's data for running parallel processes.

:::image type="content" source="../media/02-diagram-for-model-training-for-machine-learning-using-shared-disk.png" alt-text="Diagram for model training for machine learning using shared disk." border="true":::

> [!NOTE]
> You can also enable a multiple-write scenario. However, this scenario requires that applications can write.

### Clustering on Linux

Linux clusters can use cluster managers such as Pacemaker with support for common clustered file systems, such as *ocfs2* and *gf2*.

The following Linux clusters support Azure shared disks:

- SUSE Linux Enterprise Server (SLES) for SAP
- Ubuntu 18.04 and later
- Red Hat Enterprise Linux (RHEL) developer preview on any RHEL 8 version
- Oracle Enterprise Linux

### SLES for SAP

Use SLES distribution with Azure shared disks to create either of the following:

- An active/passive network file system (NFS) server.
- An active/active Oracle Cluster File System version 2 (OCFS2) cluster file system.

You control access to the shared disk by using SCSI PR or by using STONITH block device (SBD). The clustering on SLES uses a watchdog for device reset. You can also implement the watchdog on an Azure shared disk.

For detailed information about creating SLES for SAP, see [Azure shared disks with “SLES for SAP/SLE HA 15 SP2”](https://www.suse.com/c/azure-shared-disks-excercise-w-sles-for-sap-or-sle-ha/).

### Ubuntu high availability

Ubuntu clusters use Pacemaker as a cluster manager that runs on top of the Corosync Cluster Engine. Control the consistency among various cluster resources by using one of the following fencing options:

- SCSI PR
- SBD

Similar to SLES, a small Linux kernel model called *softdog* controls access to the shared disk. You can deploy both an active/passive and an active/active cluster. However, for the active/active cluster, a distributed lock manager (DLM) is also necessary.

### RHEL cluster using shared disks

You can use a shared disk as a shared block storage for an RHEL high availability cluster. Clustered applications running on RHEL highly available VMs access the same storage device on each server in a cluster through Global File System 2 (GFS2). Use Pacemaker for cluster management, Corosync for member communications, and STONITH for fencing and data integrity. 

For detailed information about creating an RHEL cluster with shared disks, see the Red Hat Enterprise Linux documentation for either [RHEL 7.9](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/deploying_red_hat_enterprise_linux_7_on_public_cloud_platforms/configuring-rhel-high-availability-on-azure_cloud-content) or [RHEL 8.3+](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/deploying_red_hat_enterprise_linux_8_on_public_cloud_platforms/configuring-rhel-high-availability-on-azure_cloud-content).

### Use Azure shared disks on containers

Applications that are running in Azure Kubernetes Service (AKS) can use persistent storage on Azure shared disks. The manifest YAML file should contain a *devicePath* setting instead of *mountPaths*. This setting enables the container instances to use the mounted file system.

> [!NOTE]
> The shared disk feature supports only raw block devices. Kubernetes applications should manage coordination and control of writes, reads, locks, caches, mounts, and fencing on the shared disk that's exposed as a raw block device.
