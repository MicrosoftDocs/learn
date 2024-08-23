We will explore site recovery in the following three scenarios:

- SQL Server disaster recovery
- Oracle disaster recovery
- Azure Site Recovery

## SQL Server disaster recovery

To facilitate disaster recovery when using SQL Server, you can configure Always On availability group on Azure Virtual Machines in different regions, as described at [Configure a SQL Server Always On availability group across different Azure regions](/azure/azure-sql/virtual-machines/windows/availability-group-manually-configure-multiple-regions). Another commonly used configuration that provides disaster recovery capabilities is log shipping.

## Oracle disaster recovery

Oracle Data Guard is supported for disaster recovery purposes. To achieve automatic failover in Data Guard, your need to use Fast-Start Failover (FSFA). The Observer (FSFA) triggers the failover. If you don't use FSFA, you can only use a manual failover configuration.

## Azure Site Recovery

Azure Site Recovery Services is a comprehensive Disaster Recovery suite that orchestrates Disaster Recovery (DR) failover and failback of on-premises resources. Azure Site Recovery can orchestrate Enterprise-2-Enterprise (E2E) scenarios and Enterprise-2-Cloud (E2C) scenarios. Site Recovery exceeds the capabilities of most on-premises disaster recovery solutions, and at a lower total cost of ownership (TCO) than competing solutions.

You can use Site Recovery to implement a disaster recovery solution in the following scenarios:

- SAP systems running in one Azure datacenter that replicate to another Azure datacenter (Azure-to-Azure disaster recovery).
- SAP systems running on VMware (or physical) servers on-premises that replicate to a disaster recovery site in an Azure datacenter (VMware-to-Azure disaster recovery).
- SAP systems running on Hyper-V on-premises that replicate to a disaster recovery site in an Azure datacenter (Hyper-V-to-Azure disaster recovery).

The solution relies on the following foundation services:

- Azure ExpressRoute or Azure VPN Gateway.
- At least one Active Directory domain controller and DNS server, running in Azure.

Azure Site Recovery has been tested and integrated with SAP applications. With Site Recovery, you can:

- Enable protection of SAP NetWeaver and non-NetWeaver production applications that run on-premises by replicating components to Azure.
- Enable protection of SAP NetWeaver and non-NetWeaver production applications that run on Azure by replicating components to another Azure datacenter.
- Simplify cloud migration by using Site Recovery to migrate your SAP deployment to Azure.
- Simplify SAP project upgrades, testing, and prototyping by creating a production clone on-demand for testing SAP applications.

The following mechanisms should be implemented to protect individual tiers of the SAP deployment:

| **SAP tiers**                     | **Recommendation**               |
|-----------------------------------|----------------------------------|
| SAP Web Dispatcher pool           | Replicate using Site Recovery    |
| SAP Application server pool       | Replicate using Site Recovery    |
| SAP Central Services cluster      | Replicate using Site Recovery    |
| Active Directory virtual machines | Use Active Directory replication |
| SQL Database servers              | Use SQL Always On replication    |

To use Azure Site Recovery to automatically build out a fully replicated production site of your original, you must run customized deployment scripts. Typically, Site Recovery first deploys the virtual machines in availability sets, then runs scripts to add resources such as load balancers. For SAP deployments, specifics are service dependent:

- **SAP Web Dispatcher pool**: The Web Dispatcher component is used as a load balancer for SAP traffic among the SAP application servers. To achieve high availability for the Web Dispatcher component, Azure load balancer is used to implement the parallel Web Dispatcher setup in a round-robin configuration for HTTP(S) traffic distribution among the available Web Dispatchers in the balancer pool. Effectively, virtual machines will be replicated using Azure Site Recovery(ASR) and automation scripts will be used to configure load balancer on the disaster recovery region.
- **SAP Application servers pool**: To manage logon groups for ABAP application servers, the SMLG transaction is used. It uses the load balancing function within the message server of the Central Services to distribute workload among SAP application servers pool for SAPGUIs and RFC traffic. Effectively, virtual machines will be replicated using Azure Site Recovery without the need for provisioning of a load balancer.
- **SAP Central Services cluster**: Central Services runs on virtual machines in the application tier. The Central Services is a potential single point of failure (SPOF) when deployed to a single virtual machine. To implement a high availability solution, either a shared disk cluster or a file share cluster can be used to configure virtual machines for a shared disk cluster, use Windows Server Failover Cluster. Cloud Witness is recommended as a quorum witness. Azure Site Recovery doesn't replicate the cloud witness therefore it's recommended to deploy the cloud witness in the disaster recovery region. To support the failover cluster environment, SIOS DataKeeper Cluster Edition performs the cluster shared volume function by replicating independent disks owned by the cluster nodes. Azure doesn't natively support shared disks and therefore requires solutions provided by SIOS. Another way to handle clustering is to implement a file share cluster. SAP recently modified the Central Services deployment pattern to access the **/sapmnt** global directories via a UNC path. However, it's still recommended to ensure that the **/sapmnt** UNC share is highly available. This can be done on the Central Services instance by using Windows Server Failover Cluster with Scale Out File Server (SOFS) and the Storage Spaces Direct (S2D) feature in Windows Server 2016. Currently, Azure Site Recovery support only crash consistent point replication of virtual machines using storage spaces direct and Passive node of SIOS DataKeeper.

When relying on Azure Site Recovery to implement disaster recovery for SAP deployments across Azure regions, use the following sequence of steps:

1. Replicate virtual machines
2. Design a recovery network
3. Replicate a domain controller
4. Replicate database tier
5. Perform a test failover
6. Perform a failover

> [!NOTE]
> At the time of authoring this content, ASR doesn't yet support the replication of the Accelerated Network configuration setting in Azure Virtual Machines.
