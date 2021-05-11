Suppose you want to migrate many servers running clustered workloads in your on-premises network to Azure. You can create Azure shared disks and attach to multiple VMs simultaneously.

## What are Azure shared disks?

Azure shared disks offer shared cloud-based block storage. This shared storage supports both Windows-based and Linux-based clustered applications.
Azure displays a shared disk as a logical unit number (LUN) to the target VM, which uses it as direct-attached storage.
Applications that use Azure shared disks use a SCSI persistent reservation (SCSI PR) standard to enable failover from one node to another. VMs in the cluster can read or write to their attached disk, based on the chosen reservation of the clustered application using SCSI PR.

> [!Note]
> SCSI PR is an industry standard that applications running on SANs on-premises use.

Use Azure shared disks to run clustered databases, parallel file systems, persistent container volumes, and machine-learning applications.

## Features of Azure shared disks

An Azure shared disk is created as a managed disk. A managed disk is a virtual hard disk for which Azure manages all required physical infrastructure. Because Azure takes care of the underlying complexity, managed disks are easy to use. Just provision them and attach them to VMs.

Azure shared disks are available on the following disk types: 

- Premium SSDs (P15 and greater). Premium SSDs are backed by solid-state drives (SSDs). They deliver high-performance, low-latency disk support for VMs running I/O-intensive workloads.
- Ultra Disks. These disks deliver high throughput, high I/O operations per second (IOPS), and consistent low latency disk storage for Azure infrastructure as a service (IaaS) VMs. Ultra Disks enable dynamically changing a disk's performance without restarting VMs. Ultra Disks have the fastest performance on Azure along with low sub-millisecond latencies. They're scalable to 64 tebibyte (TiB) in size.

For Premium SSDs, the disk size defines the number of maximum shares, which can't be more than ten. For each disk, a  **maxShares**  value represents the maximum number of nodes that can simultaneously share the disk.
Ultra Disks don't have size restrictions. Five is the maximum value for the **maxShares** setting.

> [!Note]
> You can share Azure shared disks only as data disks and not as OS disks.

## Use-case scenarios for Azure shared disks

Azure shared disks offers the flexibility to migrate on-premises clustered environments that run on Windows or Linux. Applications that run on Windows Server can use the Failover Cluster service to control the read and write operation on the Azure shared disks.

### Failover Cluster 

In a failover-cluster scenario, use multiple VMs to access a Azure shared disk. One of the VMs acts as a primary node and reads and writes to the disk. The other VMs act as secondary nodes. If the primary node loses access to the disk, the secondary nodes can take over the read and write operations. A common use-case scenario using failover cluster with active-passive mode is а clustered database like SQL Failover Cluster Instance (FCI).

Let's examine the following example to understand how a shared disk works:

1. The clustered application that run on the VMs use the SCSI PR protocol to register its intent to read or write to disk. In this step, every VM will read information on the target about existing reservations and registrations.
2. One application instance on VM1 takes exclusive reservation to write to the disk.
3. Once that reservation is enforced, only VM1 can write to the disk. This prevents other VMs from write to the disk at the same time.
4. If the application instance on VM1 goes down,  VM2 issues a **preempt and abort** command and assumes disk control.
5. The reservation to write is now enforced on the VM2 and other VMs can't write to the disk.
6. Applications that were running on VM1 will now fail over on VM2.

:::image type="content" source="../media/02_diagram_for_failover_clustering_using_shared_disk.PNG" alt-text="Diagram_for_failover_clustering_using_shared_disk.PNG" border="true":::

### SQL Failover Cluster Instance (FCI).

Create SQL Server failover cluster instance (FCI) using two or more Windows Azure VMs. Use Premium SSDs that support availability sets and proximity placement groups (to achieve high availability). Or use Ultra disks that include support for availability zones. You should use Azure shared disks to store FCI data directories. You can also implement striping across multiple shared disks if you create a shared storage pool. 

> [!Note]
> Availability sets and proximity placement groups are not required to implement SQL FCI with shared disk. They are used to increase the availability and performance of the SQL FCI.

### SAP ASCS/SCS

SAP application servers use clustered shared disks to place SAP ASCS/SCS and SAP global host files. You can deploy SAP applications on both Windows and Linux.

Windows Server failover clustering with Azure VMs requires additional configuration steps. When you build a cluster, you need to set up several IP addresses and virtual host names for the SAP ASCS/SCS instance. You can deploy both single and multiply security identifier (SID) options for SAP ASCS/SCS. You can only use  Premium SSDs as an Azure shared disk for an SAP ASCS/SCS instance.

### File server

File server for general use, can use the shared disk to enable high availability for the file service role. 
You can also use Scale-out File Server deployed on Windows Server Failover Cluster, which uses Azure shared disks in active-active mode. Cluster Witness resources are stored on Azure shared disk. All file shares are simultaneously online on all nodes.

Use the following Azure Resource Manager (ARM) template to deploy [Windows Server 2019 Scale-Out File Server (SOFS) Cluster with Azure Shared Disk.](https://github.com/robotechredmond/301-shared-disk-sofs)

### Distributed applications with multi-read or multi-write requirements

The clustered application running on multiple VMs can access the Azure shared disk using the strategy of "Write Once Read Many". One VM has an exclusive reservation to write to the shared disk by using SCSI persistent reservation. Meanwhile, other VMs can read concurrently from the disk. Only one node writes results to the disk for all cluster nodes.

The following diagram illustrates another common clustered workload. It consists of several nodes that read a disk's data for running parallel processes:

:::image type="content" source="../media/02_diagram_for_model_training_for_machine_learning_using_shared_disk.PNG" alt-text="Diagram_for_model_training_for_machine_learning_using_shared_disk." border="true":::

> [!Note]
> You can also enable a multiple-write scenario. However, this scenario requires that applications can write.

### Clustering on Linux

Linux clusters can leverage cluster managers such as Pacemaker with support for common clustered file systems, such as **ocfs2** and **gf2**.
The following Linux clusters support Azure shared disks:

- SUSE Linux Enterprise server (SLES) for SAP.
- Ubuntu 18.04 and later.
- RHEL developer preview on any RHEL 8 version.
- Oracle Enterprise Linux.

### SLES for SAP

Use SLES distribution with Azure shared disk to create either an:

- Active-Passive network file system (NFS) server.
- Active-Active Oracle Cluster File System version 2 (OCFS2) cluster file system.

Control access to the shared disk by using SCSI PR or using STONITH block device (SBD). The clustering on SLES uses a watchdog for device reset. You also can implement the watchdog on an Azure shared disk.
For detailed steps about how to create SLES for SAP, refer to [Azure Shared Disks with “SLES for SAP / SLE HA 15 SP2”](https://www.suse.com/c/azure-shared-disks-excercise-w-sles-for-sap-or-sle-ha/).

### Ubuntu high availability

Ubuntu clusters use Pacemaker as a cluster manager that runs on top of the Corosync Cluster Engine. Control the consistency among different cluster resources by using one of the following fencing options:

- SCSI PR
- SBD

Similar to SLES, a small Linux kernel model, called *softdog*, controls access to the shared disk. You can deploy both an Active/Passive and Active/Active cluster. However, for the Active/Active cluster, a distributed lock manager (DLM) also is necessary.

### RHEL cluster using shared disks

You can use shared disk as a shared block storage for RHEL high availability cluster. Clustered applications running on RHEL highly available VMS, access the same storage device on each server in a cluster through Global File System 2 (GFS2).Use Pacemaker for cluster management, corosync for member communications, and STONITH for fencing and data integrity. 

For detailed steps about how to create RHEL cluster refer to [Deploying RHEL on public cloud platforms](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html-single/deploying_red_hat_enterprise_linux_8_on_public_cloud_platforms/index?lb_target=production#azure-configuring-shared-block-storage_configuring-rhel-high-availability-on-azure).

### Use Azure shared disk on containers

Applications running in Azure Kubernetes Service (AKS) can use persistent storage on Azure shared disks. The manifest YAML file should contain **devicePath** setting instead of **mountPaths**. This enables the container instances to use the mounted file system.

> [!Note]
> The shared disk feature supports only raw block devices. Kubernetes applications should manage coordination and control of writes, reads, locks, caches, mounts, and fencing on the shared disk that is exposed as a raw block device.
