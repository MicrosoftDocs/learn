Resource redundancy is the central theme in highly available infrastructure solutions. For enterprises that have a less stringent SLA, single-instance Azure VMs offer an uptime SLA. In a distributed installation of the SAP application, the base installation is replicated to achieve high availability and disaster recovery. For each layer of the architecture, the high availability and disaster recovery design varies.

High availability of SAP workloads on Azure VMs can be analyzed in two different contexts:

**High availability of SAP workloads**– which, in case of NetWeaver-based deployments, comprises of: 

* SAP application servers

* SAP ASCS/SCS instance

* DBMS server

**High availability capabilities of Azure infrastructure**, which includes:

* Azure VM restart capability (playing particularly important role in single-VM scenarios)

* High availability of compute (VMs), network, and storage, based on:

     * Availability Sets

     * Availability Zones

It is important to note that these two contexts complement each other, so your design should combine benefits provided by each of them.

## Deployment scenarios
**Single-SID deployment with two clusters**

* One dedicated cluster is used for the SAP ASCS/SCS instance.

* One dedicated cluster is used for the DBMS instance.

* SAP Application Server instances are deployed in their own dedicated VMs.

**Single-SID deployment with a single cluster**

* One dedicated cluster is used for both the SAP ASCS/SCS instance and the DBMS.

* SAP Application Server instances are deployed in own dedicated VMs

**Multi-SID deployment**

* One dedicated cluster is used for both the SAP ASCS/SCS SID1 instance and the SAP ASCS/SCS SID2 instance (one cluster).

* One dedicated cluster is used for DBMS SID1, and another dedicated cluster is used for DBMS SID2 (two clusters).

* SAP Application Server instances for the SAP system SID1 have their own dedicated VMs.

* SAP Application Server instances for the SAP system SID2 have their own dedicated VMs.

## High availability of SAP application servers
You usually don't need a specific high-availability solution for the SAP Application Servers. You can achieve high availability by redundancy. To implement it, you can simply install individual application servers on separate Azure VMs. You should have at least two SAP application instances installed in two instances of Azure VMs. You should place all virtual machines that host SAP Application Server instances in the same Azure availability set. An Azure availability set ensures that:

* **Each Azure VM belongs to a different upgrade domain**: this ensures that the Hyper-V hosts hosting these virtual machines aren't updated at the same time during planned maintenance events that require a temporary downtime.

* **Each Azure VM belongs to a different fault domain**: this ensures that virtual machines are deployed such that a localized rack-level failure does not affects the availability of all Azure VMs.

## High availability of SAP ASCS/SCS instances


Azure VMs require additional provisions to implement operating system-dependent clustering capabilities. 

* **High-availability architecture for an SAP ASCS/SCS instance on Windows (single-SID configuration)**: You can use a Windows Server Failover Clustering (WSFC) solution to protect the SAP ASCS/SCS instance. The solution has two variants:

    * Cluster the SAP ASCS/SCS instance by using clustered shared disks. Such disks can be implemented by using third-party solutions, such as SIOS DataKeeper. 

    * Cluster the SAP ASCS/SCS instance by using file share. SAP recently modified the Central Services deployment pattern to access the /sapmnt global directories via a UNC path. A highly available UNC /sapmnt share can be implemented by using Windows Server Failover Cluster with Scale Out File Server (SOFS) and the Storage Spaces Direct (S2D) feature in Windows Server 2016. 

* **High-availability architecture for an SAP ASCS/SCS instance on Linux (single-SID configuration)**. This architecture requires the use of Linux clustering (Pacemaker with STONITH) and a highly available NFS share, which can be provisioned by using Azure VMs in a separate cluster, Azure NetApp Files, or Red Hat GlusterFS. For more information, refer to:

    * High availability for SAP NetWeaver on Azure VMs on SUSE Linux Enterprise Server for SAP applications [https://docs.microsoft.com/azure/virtual-machines/workloads/sap/high-availability-guide-SUSE](https://docs.microsoft.com/azure/virtual-machines/workloads/sap/high-availability-guide-suse) 

    * High availability for SAP NetWeaver on Azure VMs on SUSE Linux Enterprise Server with Azure NetApp Files for SAP applications [https://docs.microsoft.com/azure/virtual-machines/workloads/sap/high-availability-guide-SUSE-netapp-files](https://docs.microsoft.com/azure/virtual-machines/workloads/sap/high-availability-guide-suse-netapp-files) 

    * Azure Virtual Machines high availability for SAP NetWeaver on Red Hat Enterprise Linux [https://docs.microsoft.com/azure/virtual-machines/workloads/sap/high-availability-guide-rhel](https://docs.microsoft.com/azure/virtual-machines/workloads/sap/high-availability-guide-rhel) 

* **High-availability architecture for an SAP ASCS/SCS instance on Windows (multi-SID configuration)**: Currently, multi-SID is supported only with WSFC. Multi-SID is supported using file share and shared disk. For more information, refer to:

    * SAP ASCS/SCS instance multi-SID high availability with Windows Server Failover Clustering and shared disk on Azure [https://docs.microsoft.com/azure/virtual-machines/workloads/sap/sap-ascs-ha-multi-sid-wsfc-shared-disk](https://docs.microsoft.com/azure/virtual-machines/workloads/sap/sap-ascs-ha-multi-sid-wsfc-shared-disk) 

    * SAP ASCS/SCS instance multi-SID high availability with Windows Server Failover Clustering and file share on Azure [https://docs.microsoft.com/azure/virtual-machines/workloads/sap/sap-ascs-ha-multi-sid-wsfc-file-share](https://docs.microsoft.com/azure/virtual-machines/workloads/sap/sap-ascs-ha-multi-sid-wsfc-file-share) 


