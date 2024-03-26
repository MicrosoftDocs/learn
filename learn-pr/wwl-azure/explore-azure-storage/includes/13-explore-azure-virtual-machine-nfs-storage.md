Highly available Azure VM NFS storage for SAP workloads can be implemented by using Distributed Replicated Block Device (DRBD) with Pacemaker clustering on Azure VMs running SUSE and by using GlusterFS clustering on RHEL. Details of both implementations are described later.

Managed NFS storage is available in the form of Azure NetApp Files. The Azure NetApp Files service is an enterprise-class, high-performance, metered file storage service. Azure NetApp Files supports a wide range of workloads and is highly available by default. You can select service and performance levels and set up snapshots through the service. Microsoft has tested SAP file shares with Azure NetApp Files for application-level high availability and plans to provide support for SAP HANA in the near future, after Azure NetApp Files is certified by SAP.

For more information, see [What is Azure NetApp Files](/azure/azure-netapp-files/azure-netapp-files-introduction).
