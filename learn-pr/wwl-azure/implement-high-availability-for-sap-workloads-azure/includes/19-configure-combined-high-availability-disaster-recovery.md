Microsoft doesn't share any information about geographical distances between the facilities that host different Azure Availability Zones in an Azure region. Still, some customers are using zones for a combined HA and DR configuration that promises a recovery point objective (RPO) of zero. This means that you shouldn't lose any committed database transactions even for a disaster recovery.

Microsoft recommends the Availability Zone configuration only in certain circumstances. For example, you might use it when data can't leave the Azure region for security or compliance reasons.

The following considerations apply:

- You're either assuming there's a significant distance between the facilities hosting an Availability Zone or you're forced to stay within a certain Azure region. Availability sets can't be deployed in Azure Availability Zones. So, in this case, you have one update and fault domain for your application layer. That's because it's only deployed in one zone. This configuration is slightly less desirable than the reference architecture, which suggests that you deploy the application layer in an Azure availability set.
- When you use this architecture, you need to monitor the status closely, and try to keep the active DBMS and SAP Central Services instances in the same zone as your deployed application layer. If there's a failover of SAP Central Service or the DBMS instance, you want to make sure that you can manually fail back into the zone with the SAP application layer deployed as quickly as possible.
- You should have production application instances pre-installed in the VMs that run the active QA application instances.
- If there's a zone failure, shut down the QA application instances and start the production instances instead. You need to use virtual names for the application instances to make this work.
- For the load balancers of the failover clusters of SAP Central Services and the DBMS layer, you need to use the Standard SKU Azure load balancer. The Basic load balancer doesn't work across zones.
- The Azure virtual network that you deployed to host the SAP system, together with its subnets, is stretched across zones. You don't need separate virtual networks for each zone.
- For all virtual machines you deploy, you need to use Azure Managed Disks. Unmanaged disks aren't supported for zonal deployments.
- Azure Premium Storage and Ultra SSD storage don't support any type of storage replication across zones. The application (DBMS or SAP Central Services) must replicate important data.
- The same is true for the shared sapmnt directory, which is a shared disk (Windows), a CIFS share (Windows), or an NFS share (Linux). You need to use a technology that replicates these shared disks or shares between the zones. These technologies are supported:

  - For Windows, a cluster solution that uses SIOS DataKeeper, as documented in Cluster an SAP ASCS/SCS instance on a Windows failover cluster by using a cluster shared disk in Azure.
  - For SUSE Linux, an NFS share that's built as documented in High availability for NFS on Azure VMs on SUSE Linux Enterprise Server.
- Currently, the solution that uses Microsoft Scale-Out File Server isn't supported across zones.
- The third zone is used to host the SBD device in case you build a SUSE Linux Pacemaker cluster or other application instances
