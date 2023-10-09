 You can deploy an active/passive architecture for the SAP application layer to reduce the delta between the network latency within one zone and the latency of cross-zone network traffic. You define an active zone, which is the zone where you deploy the complete application layer and where you attempt to run both the active DBMS and the SAP Central Services instance. With such a configuration, you need to make sure you don't have extreme run time variations, depending on whether a job runs in-zone with the active DBMS instance or not, in business transactions and batch jobs

The following considerations apply for this configuration:

- Availability sets can't be deployed in Azure Availability Zones. So, in this case, you have one update and fault domain for your application layer because it's only deployed in one zone. This configuration is slightly less desirable than the reference architecture, which suggests that you deploy the application layer in an Azure availability set.
- When you use this architecture, you need to monitor the status closely, and try to keep the active DBMS and SAP Central Services instances in the same zone as your deployed application layer. If failover of SAP Central Service or the DBMS instance occurs, you want to make sure that you can manually fail back into the zone with the SAP application layer deployed as quickly as possible.
- For the load balancers of the failover clusters of SAP Central Services and the DBMS layer, you need to use the Standard SKU Azure load balancer. The Basic load balancer doesn't work across zones.
- The Azure virtual network that you deployed to host the SAP system, together with its subnets, is stretched across zones. You don't need separate virtual networks for each zone.
- For all virtual machines you deploy, you need to use Azure Managed Disks. Unmanaged disks aren't supported for zonal deployments.
- Azure Premium Storage and Ultra SSD storage don't support any type of storage replication across zones. The application (DBMS or SAP Central Services) must replicate important data.
- The same is true for the shared sapmnt directory, which is a shared disk (Windows), a CIFS share (Windows), or an NFS share (Linux). You need to use a technology that replicates these shared disks or shares between the zones. These technologies are supported:

  - For Windows, a cluster solution that uses SIOS DataKeeper, as documented in Cluster an SAP ASCS/SCS instance on a Windows failover cluster by using a cluster shared disk in Azure.
  - For SUSE Linux, an NFS share that's built as documented in High availability for NFS on Azure VMs on SUSE Linux Enterprise Server.

Currently, the solution that uses Microsoft Scale-Out File Server, isn't supported across zones.

- The third zone is used to host the SBD device in case you build a SUSE Linux Pacemaker cluster or another application instances.
- You should deploy dormant VMs in the passive zone (from a DBMS point of view) so you can start application resources if there's a zone failure.

> [!NOTE]
> Azure Site Recovery is currently unable to replicate active VMs to dormant VMs between zones.

- You should invest in automation that allows you, if there's a zone failure, to automatically start the SAP application layer in the second zone.
