This deployment architecture is called active/active because you deploy your active SAP application servers across two or three zones. The SAP Central Services instance that uses enqueue replication will be deployed between two zones. The same is true for the DBMS layer, which will be deployed across the same zones as SAP Central Service.

When considering this configuration, you need to find the two Availability Zones in your region that offer cross-zone network latency that's acceptable for your workload and your synchronous DBMS replication. You also want to be sure the delta between network latency within the zones you selected, and the cross-zone network latency isn't too large. This is because you don't want large variations, depending on whether a job runs in-zone with the DBMS server or across zones, in the running times of your business processes or batch jobs. Some variations are acceptable, but not factors of difference.

The following considerations apply for this configuration:

 -  You treat the Azure Availability Zones as fault and update domains for all the VMs because availability sets can't be deployed in Azure Availability Zones.
 -  For the load balancers of the failover clusters of SAP Central Services and the DBMS layer, you need to use the Standard SKU Azure load balancer. The Basic load balancer won't work across zones.
 -  The Azure virtual network that you deployed to host the SAP system, together with its subnets, is stretched across zones. You don't need separate virtual networks for each zone.
 -  For all virtual machines you deploy, you need to use Azure Managed Disks. Unmanaged disks aren't supported for zonal deployments.
 -  Azure Premium Storage and Ultra SSD storage don't support any type of storage replication across zones. The application (DBMS or SAP Central Services) must replicate important data.
 -  The same is true for the shared sapmnt directory, which is a shared disk (Windows), a CIFS share (Windows), or an NFS share (Linux). You need to use a technology that replicates these shared disks or shares between the zones. These technologies are supported:
    
     -  For Windows, a cluster solution that uses Storage Spaces Direct-based Scale Out File Server (SOFS) that provides a highly available share or SIOS DataKeeper, which emulates a highly available shared disk.
     -  For SUSE Linux, an NFS share. To provide a highly available NFS share, SAP NetWeaver requires an NFS server. The NFS server can be provisioned by using Azure VMs in a separate cluster, Azure NetApp Files, or Red Hat GlusterFS.
 -  Currently, the solution that uses Microsoft Scale-Out File Server is not supported across zones.
 -  The third zone is used to host the SBD device in case you build a SUSE Linux Pacemaker cluster or additional application instances.
 -  To achieve run time consistency for critical business processes, you can try to direct certain batch jobs and users to application instances that are in-zone with the active DBMS instance by using SAP batch server groups, logon groups, or RFC groups. However, if a zonal failover occurs, you would need to manually move these groups to instances running on VMs that are in-zone with the active DB VM.
 -  You might want to deploy dormant dialog instances in each of the zones. This is to enable an immediate return to the former resource capacity if a zone used by part of your application instances is out of service.
