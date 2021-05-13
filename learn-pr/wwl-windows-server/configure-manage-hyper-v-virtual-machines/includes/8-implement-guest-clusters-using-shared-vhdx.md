Contoso has some business-critical applications that must be highly available. To make an application or service highly available, you must deploy it in an environment that provides redundancy for all the components that the application requires. To provide high availability for VMs and the services hosted within VMs, your options for clustering  are to:

- Implement VMs as a clustered role, called *host clustering*.
- Implement clustering inside VMs, called *guest clustering*.

## Host clustering

By using host clustering, you can configure a failover cluster when you use the Hyper-V host servers. When you configure host clustering for Hyper-V, you configure the VM as a highly available resource.

You implement failover clustering protection at the host server–level. This means that the guest OS and applications that run within the VM don't have to be cluster-aware; however, the VM is still highly available.

Some examples of cluster–unaware applications are a print server or a proprietary, network-based application such as an accounting application. Should the host node that controls the VM unexpectedly become unavailable, the secondary host node takes control and restarts or resumes the VM as quickly as possible. Additionally, you could move the VM from one node in the cluster to another in a controlled manner. For example, you could move the VM from one node to another while updating the host management Windows Server OS.

The applications or services that are running on a VM don't have to be compatible with failover clustering, and they don't have to be aware that the VM is clustered. Because failover is at the VM-level, there are no dependencies on software that's installed on the VM.

## Guest clustering

You configure guest failover clustering similarly to physical-server failover clustering, except that the cluster nodes are VMs. In this scenario, you create two or more VMs and install and implement failover clustering within the guest operating systems. The application or service is then able to take advantage of high availability between the VMs. Because you implement failover clustering within the guest OS of each VM node, you can put the VMs on a single host. This is a quick and cost-effective configuration in a test or staging environment.

For production environments, however, you can protect an application or service more robustly if you deploy the VMs on separate failover clustering–enabled Hyper-V host computers. With failover clustering implemented at both the host and VM levels, you can restart the resource regardless of whether the node that fails is a VM or a host. Such high-availability configurations are considered optimal for VMs that are running mission-critical applications in a production environment.

You should consider several factors when implementing guest clustering:

- The application or service must be failover cluster–aware. This includes any of the Windows Server services that are cluster-aware, in addition to any applications such as clustered Microsoft SQL Server and Microsoft Exchange Server.
- Hyper-V VMs in Windows Server can use Fibre Channel–based connections to shared storage, or you can implement Internet SCSI (iSCSI) connections from the VMs to the shared storage. You can also use the shared VHD feature to provide shared storage for VMs.

You should deploy multiple network adapters on the host computers and the VMs. If you're using this method to connect to storage, ideally, you should dedicate a network connection to the iSCSI connection, to the private network between the hosts, and to the network connection that the client computers use.

### Benefits of guest clustering

Besides the traditional benefits of virtualization, deploying a clustered application (known as a *clustered role*) inside a VM provides the following additional benefits:

- Proactive health monitoring of the clustered roles.
- Application mobility.
- Protection from host failure.

## Deploy a guest cluster by using a shared VHD

You can deploy a guest failover cluster that uses shared .vhdx files on a Hyper-V failover cluster in both of the following scenarios:

- Scenario 1: Hyper-V failover cluster using CSVs on block-level storage.
In this scenario, all VM files, including the shared .vhdx files, are stored on a CSV that's configured as shared storage for a Hyper-V failover cluster.

- Scenario 2: Hyper-V failover cluster using file-based storage in a separate SOFS. This scenario uses Server Message Block (SMB) file-based storage as the location of the shared .vhdx files. You must deploy a SOFS and create an SMB file share as the storage location. You also need a separate Hyper-V failover cluster.

:::image type="content" source="../media/m23-csv-vs-file-based-storage.png" alt-text="Diagram of CSV-based storage versus file-based storage." border="false":::

### Steps for deploying a guest cluster by using a shared VHD

The following are the steps for deploying a guest cluster by using a shared VHD.

1. Configure the physical servers by using either of the following scenarios:
    1. Scenario 1: Create a Hyper-V failover cluster that uses CSV:
        1. Create a Hyper-V failover cluster with at least two nodes.
        1. Add storage to the CSV where you want to store the VM files.
    1. Scenario 2: Create a Hyper-V failover cluster that uses file-based storage in a separate SOFS:
        1. Create a Hyper-V failover cluster with at least two nodes.
        1. Deploy a SOFS.
1. Create the VMs from one of the Hyper-V cluster nodes and then use the VM to create the guest failover cluster.
    1. Create the virtual machine configuration files and the virtual hard disk that is used for the operating system.
    1. when creating the VMs point to store virtual machine in a different location and then point to the shared storage location, such as CSV or SMB File share on SOFS.
1. Create a VHD to share.
    1. Create a VHD of the type `SharedDrive`. Enable sharing by selecting the .vhdx or VHD Set format, and ensure it's not a differencing disk.
    1. Choose a location for the VHD according to the Scenario you are using:
        1. Scenario 1 (where the shared storage is a CSV disk): Enter the path to place the VHD as follows: `C:\ClusterStorage\VolumeX`, where `C:\` represents the system drive, and **X** represents the desired CSV volume number.
        1. Scenario 2 (where the shared storage is an SMB file share): Enter the path to place the VHD as follows: `\\ServerName\ShareName`, where **ServerName** represents the client access point for the SOFS, and **ShareName** represents the name of the SMB file share.
1. Add the shared VHD to each VM that will use the shared .vhdx file. This can be done in **Hyper-V Manager** or by using **Cluster Manager**.
1. Create the guest cluster:
    1. On one of the VMs, confirm that the shared .vhdx file is visible as a disk. Bring the disk online, initialize the disk, and then create and format the volume.
    1. Create the guest cluster by adding the VMs as cluster nodes. When you create the cluster, add all eligible storage. (The shared .vhdx files will be added as available storage.)
    1. After the failover cluster is created, verify that the storage was added. To do this, open **Failover Cluster Manager**, expand the cluster name, expand **Storage**, and then select **Disks**.
