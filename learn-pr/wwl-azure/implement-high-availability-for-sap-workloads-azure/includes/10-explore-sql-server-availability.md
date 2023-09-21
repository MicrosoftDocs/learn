When using SQL Server in Azure VM-based deployments for SAP, you have several different options to deploy highly available DBMS layer. Azure provides different up-time SLAs for a single VM and a pair of VMs deployed in an Azure Availability Set. The assumption is that you drive towards the up-time SLA for your production deployments that requires the deployment in Azure Availability Sets. In such a case, you need to deploy a minimum of two VMs in such an Availability Set. One VM runs the active SQL Server Instance. The other VM runs the passive Instance

## SQL Server Clustering using Windows Scale-out File Server

With Windows Server 2016, Microsoft introduced Storage Spaces Direct. Based on Storage Spaces Direct Deployment, SQL Server FCI clustering is supported. The solution requires an Azure load balancer as well to deal with the virtual IP address of the cluster resources. The SQL Server database files are stored in Storage Spaces. Hence, it's a given that you would have to deploy the Windows Storage Spaces based on Azure Premium Storage. Since this solution has been supported for not too long yet, there are no known SAP customers who use this solution in SAP production scenarios.

## SQL Server Log Shipping

Another method that provides high availability is SQL Server Log Shipping. If the VMs participating in the HA configuration have working name resolution, there's no problem, and the setup in Azure doesn't differ from an on-premises setup.

The SQL Server log shipping functionality isn't commonly used in Azure to achieve high availability within the same Azure region. However, there are some Azure-based scenarios where SAP customers successfully apply log shipping:

- Disaster Recovery scenarios between Azure regions.
- Disaster Recovery configuration between on-premises and Azure.
- Migration from on-premises to Azure. In those cases, log shipping is used to synchronize the new DBMS deployment in Azure with the existing production system on-premises. At the time of migration, production is shut down and the latest transaction log backups are transferred to the Azure DBMS deployment. Then the Azure DBMS deployment is configured as the production instance.

## Database Mirroring

Database Mirroring as supported by SAP (as per [SAP Note \#965908](https://launchpad.support.sap.com/#/notes/965908)) relies on defining a failover partner in the SAP connection string. In cross-premises scenarios, we assume that the two VMs are in the same domain and that the two SQL Server instances are running in the security context of the same domain user account. Therefore, the setup of Database Mirroring in Azure doesn't differ from a typical on-premises setup/configuration.

In cloud-only deployments, the simplest approach involves setting up both DBMS VMs (and ideally dedicated SAP VMs) in the same domain.

If the domain-based configuration isn't an option, it's possible to use certificates for the database mirroring endpoints as described at [Use Certificates for a Database Mirroring Endpoint (Transact-SQL)](/sql/database-engine/database-mirroring/use-certificates-for-a-database-mirroring-endpoint-transact-sql)

## SQL Server Always On

Always On is supported for SAP on-premises (see [SAP Note \#1772688](https://launchpad.support.sap.com/#/notes/1772688)) and in Azure. There are some special considerations around deploying the SQL Server Availability Group Listener, which in Azure needs to be configured as a front end of a load balancer.

Other considerations using an Availability Group Listener include:

- Using an Availability Group Listener is only possible with Windows Server 2012 or higher as guest OS of the VM. For Windows Server 2012 you need to make sure to apply the patch available at: [KB 2854082: Update enables SQL Server Availability Group Listeners on Windows Server 2008 R2 and Windows Server 2012-based Microsoft Azure virtual machines](https://support.microsoft.com/kb/2854082).
- For Windows Server 2008 R2, Always On needs to be used in the same manner as Database Mirroring by specifying a failover partner in the connections string (done through the SAP default.pfl parameter dbs/mss/server - see [SAP Note \#965908](https://launchpad.support.sap.com/#/notes/965908)).
- When using an Availability Group Listener, the Database VMs need to be connected to a dedicated load balancer. To avoid the scenario in which Azure assigns new IP addresses in cases where both VMs incidentally are shut down, one should assign static IP addresses to the network interfaces of those VMs in the Always On configuration.
- There are special steps required when building the WSFC cluster configuration where the cluster needs a special IP address assigned. Azure assigns the cluster name the same IP address as the node the cluster is created on. This means a manual step must be performed to assign a different IP address to the cluster.
- The Availability Group Listener is going to be created in Azure with TCP/IP endpoints, which are assigned to the VMs running the primary and secondary replicas of the Availability group.

Detailed documentation on deploying Always On with SQL Server in Azure VMs is available at:

- [Always On availability group on SQL Server on Azure VMs](/azure/azure-sql/virtual-machines/windows/availability-group-overview?view=azuresql)
- [Configure a load balancer &amp; availability group listener (SQL Server on Azure VMs)](/azure/azure-sql/virtual-machines/windows/availability-group-load-balancer-portal-configure?view=azuresql)

> [!NOTE]
> If you are configuring the Azure load balancer for the virtual IP address of the Availability Group listener, make sure that the DirectServerReturn is configured. Configuring the DirectServerReturn option will reduce the network round trip latency between the SAP application layer and the DBMS layer.

SQL Server Always On is the most commonly used high availability and disaster recovery functionality in Azure for Windows-based SAP deployments. Most customers use Always On for high availability within a single Azure region. If the deployment is restricted to two nodes only, you have two choices for connectivity:

- Using the Availability Group Listener. With the Availability Group Listener, you're required to deploy an Azure load balancer. This is usually the default method of deployment. SAP applications need to be configured to connect to the Availability Group listener rather than to a single node.
- Using the connectivity parameters of SQL Server Database Mirroring, you need to configure connectivity of the SAP applications by specifying both node names. Exact details of this mirroring configuration are documented in [SAP Note \#965908](https://launchpad.support.sap.com/#/notes/965908). By using this option, you eliminate the need for an Availability Group listener and an Azure load balancer. As a result, the network latency between the SAP application layer and the DBMS layer is lower since the incoming traffic to the SQL Server instance isn't routed through the Azure load balancer. But keep in mind that this option only works if you restrict your Availability Group to span two instances.

Quite a few customers are additionally applying the SQL Server Always On functionality for disaster recovery between Azure regions. Several customers also use the ability to perform backups from a secondary replica.
