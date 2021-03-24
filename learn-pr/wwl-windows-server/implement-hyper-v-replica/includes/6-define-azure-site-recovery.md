As the Contoso Windows Server administrator, you need a solution to reduce or eliminate the costs and administrative overhead of a secondary or tertiary site for disaster recovery purposes. One such solution is Azure Site Recovery.

## Overview of Azure Site Recovery

Azure Site Recovery (Site Recovery) is a BCDR solution that can replicate VMs (on-premises or cloud based) and physical servers to Microsoft Azure or to a second site. Site Recovery keeps business apps and workloads running during outages. When an outage occurs at your primary site, workloads on a primary site can failover to secondary location and access apps from that site. After the primary site is running again, you can failover back to the primary VM in the primary site, and resume accessing apps from the primary site.

Site Recovery is a hybrid product that mixes onsite and cloud automation. While your primary site might be on-premises. or in a Microsoft or third-party cloud, the secondary site can be:

- On-premises in the same datacenter.
- In a geographically separate private datacenter.
- In Azure.

Site Recovery is used to replicate on-premises server loads to Azure or a secondary datacenter, and because it can provide orchestrated failover, you can use it in various scenarios such as those in the following table.

|Scenario|Description|
|---|---|
|Disaster recovery|Servers replicate to a secondary location and can fail over if the primary location becomes unavailable, such as in a disaster. Site Recovery can control and orchestrate failover, ensuring that at the secondary location, the workload VMs are orchestrated to start in a specific order and, if necessary, additional preparation tasks are performed.|
|Physical workload migration to Azure|Physical servers that run Windows or Linux operating systems can be virtualized and moved to Azure. Many servers are already virtualized, but if you're still running a physical server, use Site Recovery to virtualize it.|
|Cloud bursting|Configure a private cloud and a public cloud to manage peaks in IT demand by leveraging capacity in Azure temporarily when workload demands exceed on-premises capacity. You can bring the services back to the private cloud when demand stabilizes. You can use Azure scalability to eliminate long and costly procurement cycles for more hardware.|
|DevTest|Replicate workloads to Azure for testing purposes so that you don't need to buy and maintain an onsite test environment. You can safely test with replicated live data without affecting users or production environments.|
|Analytics and reporting|Replicate workloads to run reports, check applications' health, and improve performance. You can analyze production workloads by running compute-intensive diagnostics without affecting users. You can understand where performance issues occur by removing infrastructure variables through cloud replication.|

### Benefits of using Site Recovery

Site Recovery provides many benefits, including:

- It's workload and application agnostic. This means that you can use Site Recovery to protect all kinds of workloads, including Windows or Linux environments.
- It has near-synchronous replication, with recovery point objectives (RPOs) as low as 30 seconds. This meets the needs of most critical business apps so you can keep recovery time objectives (RTOs) and RPOs within organizational limits.
- It provides testing without disruption so that your organization doesn't need to buy and maintain an onsite test environment. You can safely test with replicated live data without affecting users or production environments.
- It has *Recovery plans* that enable you to customize and sequence the failover and recovery of applications running on multiple VMs. For example, you can include external scripts and manual actions in the plan.
- It can integrate and leverage other Azure services such as:
  - *Azure Automation*, which provides production-ready, application-specific scripts that can be downloaded and integrated with recovery plans.
  - *Azure Networking*, which  can simplify application network requirements such as managing static IP addresses to remove the need to change the TCP/IP settings of VMs that fail over between the primary and secondary locations, configure load-balancing, and integration with Azure Traffic Manager for low RTOs network switch overs.
  - *Azure Storage* can provide additional storage options including availability sets and availability zones to add further protection and efficiencies to the Site Recovery process.
- It provides integration with other BCDR technologies. For example, you can use Site Recovery to protect the SQL Server backend of corporate workloads. Site Recovery natively supports SQL Server AlwaysOn, which is used to manage availability groups' failover.

### Types of failover available

Azure Site Recovery uses the Hyper-V Replica feature to protect VMs on Hyper-V servers or in VMM clouds. Therefore, Site Recovery provides the same types of failover as **Hyper-V Replica**, but with Site Recovery, you can further automate and orchestrate the failover of multiple VMs. Site Recovery supports the following failover types:

- Test failover
- Planned failover
- Unplanned failover
