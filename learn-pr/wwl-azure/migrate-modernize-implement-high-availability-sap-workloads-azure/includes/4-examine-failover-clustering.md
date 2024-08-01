High availability of SAP workloads relies either on the high availability features built into the workload or on a failover cluster implemented on the operating system level. A failover cluster is a group of independent servers that work together to increase the availability of applications and services. If a node failure occurs, the cluster performs node arbitration, and depending on the outcome, transfers the workload to one of the remaining nodes.

Windows Server Failover Clustering is the service providing high availability in Windows Server. Windows Server Failover Clustering relies on the quorum construct to avoid split-brain scenarios. There are several different quorum modes, including node majority, node and disk majority, node and file share majority, and disk only. The recommended choice is Cloud Witness (introduced in Windows Server 2016). When using earlier versions of Windows, you need to choose either node majority, or node and file share (you can implement a highly available file share in Azure by using a Storage Spaces Direct cluster). Shared locally attached disks aren't natively supported on Azure VMs. Optionally you can resort to third-party solutions, such as SIOS DataKeeper, which emulate shared disks by synchronously replicating local disks across clustered Azure VMs.

## STONITH Block Devices

Pacemaker is the cluster resource manager facilitating high availability on Linux servers. Pacemaker relies on an external STONITH component to handle node arbitration. STONITH is a fencing mechanism that prevents cluster file corruption by shutting down a failed node. It also applies Corosync to facilitate inter-node communication. There are two ways to set up the STONITH component in Azure. You can either use a fencing agent, which takes care of restarting a failed node via the Azure APIs or you can use an SBD (STONITH Block Device).

The SBD requires at least one more virtual machine that acts as an iSCSI target server. These iSCSI target servers can however be shared with other Pacemaker clusters. The advantage of using an SBD is a faster failover time and, if you're using SBDs on-premises, doesn't require any changes on how you operate the pacemaker cluster. You can use up to three SBDs for a Pacemaker cluster to allow an SBD to become unavailable, for example during OS patching of the iSCSI target server. If you want to use more than one SBD per Pacemaker, make sure to deploy multiple iSCSI target servers and connect one SBD from each iSCSI target server. We recommend using either one SBD or three. Pacemaker isn't able to automatically fence a cluster node if you only configure two SBDs and one of them isn't available. If you want to be able to fence when one iSCSI target server is down, you must use three SBDs and therefore three iSCSI target servers.

## High availability set up in SUSE using the STONITH

- Operating System: **SLES 12 SP1 for SAP**
- HANA Version: **HANA 2.0 SP1**
- Server Names: **sapprdhdb95** (node1) and **sapprdhdb96** (node2)
- STONITH Device: **iSCSI based STONITH device**

To set up the end-to-end HA using STONITH, the following steps need to be followed:

1. Identify the SBD.
1. Initialize the SBD on both the nodes.
1. Configure the cluster.

     - Package installation
     - Set up the cluster - `ha-cluster-init` command, or use the yast2 wizard, **only on the Primary node**.
1. Set up the Softdog Watchdog on **both** nodes.
1. Join the node to the cluster.
1. Validate the cluster.
1. Configure the cluster properties and resources:

     - Cluster bootstrap
     - STONITH Device
     - The Virtual IP Address
1. Test the failover process.

For a detailed step-by-step guide, refer to [High availability set up in SUSE using the STONITH device](/azure/virtual-machines/workloads/sap/ha-setup-with-fencing-device).

If you don't want to deploy other Azure VMs, you can use the Azure Fence agent. When using the Azure Fence Agent, consider setting the `skipShutdown` flag to forcefully skip the power off command graceful shutdown period. When the skipShutdown flag isn't set, a failover can take between 10 to 15 minutes.

## Virtual server names

High availability and disaster recovery configurations rely on virtual server names assigned to clustered SAP components. This facilitates automatic failover of the clustered component between cluster nodes. When using operating system-level clustering solutions in Azure, such virtual names typically point to a frontend IP address of a load balancer that distributes incoming connections to cluster nodes.
