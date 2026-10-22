For shared directories in highly available SAP systems, Microsoft recommends managed NFS storage through NFS on Azure Files or Azure NetApp Files rather than VM-hosted NFS clusters.

VM-hosted NFS storage using Distributed Replicated Block Device (DRBD) with Pacemaker clustering on SUSE remains a documented alternative. Microsoft is de-emphasizing these NFS cluster reference architectures. For more information, see [High availability for NFS on Azure VMs on SUSE Linux Enterprise Server](/azure/sap/workloads/high-availability-guide-suse-nfs).

Red Hat Gluster Storage reached end of life at the end of 2024. Don't use GlusterFS on RHEL for new SAP deployments. Use NFS on Azure Files or Azure NetApp Files instead, as described in [GlusterFS on Azure VMs on Red Hat Enterprise Linux for SAP NetWeaver](/azure/sap/workloads/high-availability-guide-rhel-glusterfs).

Managed NFS storage is available in the form of Azure NetApp Files. The Azure NetApp Files service is an enterprise-class, high-performance, metered file storage service. Azure NetApp Files supports a wide range of workloads and is highly available by default. You can select service and performance levels and set up snapshots through the service.

For more information, see [What is Azure NetApp Files](/azure/azure-netapp-files/azure-netapp-files-introduction).
