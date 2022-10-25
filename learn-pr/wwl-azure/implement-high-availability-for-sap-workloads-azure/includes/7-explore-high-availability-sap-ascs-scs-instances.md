Azure VMs require additional provisions to implement operating system-dependent clustering capabilities.

## High-availability architecture for an SAP ASCS/SCS instance on Windows (single-SID configuration)

You can use a Windows Server Failover Clustering (WSFC) solution to protect the SAP ASCS/SCS instance. The solution has two variants:

- Cluster the SAP ASCS/SCS instance by using clustered shared disks. Such disks can be implemented by using third-party solutions, such as SIOS DataKeeper. For more information regarding this configuration, see [Cluster an SAP ASCS/SCS instance on a Windows failover cluster by using a cluster shared disk in Azure](/azure/virtual-machines/workloads/sap/sap-high-availability-guide-wsfc-shared-disk).
- Cluster the SAP ASCS/SCS instance by using file share. SAP recently modified the Central Services deployment pattern to access the **/sapmnt** global directories via a UNC path. A highly available UNC **/sapmnt** share can be implemented by using Windows Server Failover Cluster with Scale Out File Server (SOFS) and the Storage Spaces Direct (S2D) feature in Windows Server 2016. For more information regarding this configuration, see [Cluster an SAP ASCS/SCS instance on a Windows failover cluster by using a file share in Azure](/azure/virtual-machines/workloads/sap/sap-high-availability-guide-wsfc-file-share).

## High-availability architecture for an SAP ASCS/SCS instance on Linux (single-SID configuration)

This architecture requires the use of Linux clustering (Pacemaker with STONITH) and a highly available NFS share, which can be provisioned by using Azure VMs in a separate cluster, Azure NetApp Files, or Red Hat GlusterFS. For more information, see:

- [High availability for SAP NetWeaver on Azure VMs on SUSE Linux Enterprise Server for SAP applications](/azure/virtual-machines/workloads/sap/high-availability-guide-suse)
- [High availability for SAP NetWeaver on Azure VMs on SUSE Linux Enterprise Server with Azure NetApp Files for SAP applications](/azure/virtual-machines/workloads/sap/high-availability-guide-suse-netapp-files)
- [Azure Virtual Machines high availability for SAP NetWeaver on Red Hat Enterprise Linux](/azure/virtual-machines/workloads/sap/high-availability-guide-rhel)

## High-availability architecture for an SAP ASCS/SCS instance on Windows (multi-SID configuration)

Currently, multi-SID is supported only with WSFC. Multi-SID is supported using file share and shared disk. For more information, see:

- [SAP ASCS/SCS instance multi-SID high availability with Windows Server Failover Clustering and shared disk on Azure](/azure/virtual-machines/workloads/sap/sap-ascs-ha-multi-sid-wsfc-shared-disk)
- [SAP ASCS/SCS instance multi-SID high availability with Windows Server Failover Clustering and file share on Azure](/azure/virtual-machines/workloads/sap/sap-ascs-ha-multi-sid-wsfc-file-share)
