[Azure Site Recovery](/azure/site-recovery/site-recovery-overview) is a service that provides BCDR features for your applications in Azure, on-premises, and in other cloud providers. Azure Site Recovery has plans that help automate your disaster recovery by enabling you to define how machines are failed over, and the order in which they're restarted after being successfully failed over. In this way, Azure Site Recovery helps to automate tasks and further reduce your recovery time objective. You also use Azure Site Recovery to periodically test failovers, and the overall effectiveness of the recovery process.

:::image type="content" source="../media/azure-site-recovery.png" alt-text="Virtual machine snapshots are stored in the recovery services vault.":::


 

### What can you do with Azure Site Recovery?

Site Recovery provides the capabilities described in the following table.

| **Feature**| **Details** |
| - | - |
| Simple BCDR solution| Use Site Recovery in the Azure portal to setup and manage replication, failover, and failback from a single location. |
| Azure VM replication| Setup disaster recovery of your Azure VMs, and failover from a primary region to a secondary region. |
| On-premises VM replication| Replicate on-premises VMs and physical servers to Azure, or to a secondary on-premises datacenter. |
| Workload replication| Replicate any workload running on supported Azure VMs, on-premises Hyper-V and VMware VMs, and Windows or Linux physical servers. |
| Data resilience| Orchestrate replication without intercepting app data by using Site Recovery. When failover occurs, Azure VMs are created, based on the replicated data. When you replicate to Azure, data is stored in Azure storage, with the resilience that provides. |
| RTO and RPO targets| Keep RTO and RPO within defined organizational limits. Site Recovery provides continuous replication for Azure VMs and VMware VMs, and replication frequency as low as 30 seconds for Hyper-V. |
| Keep apps consistent over failover| By using app-consistent snapshots, you can replicate using recovery points. These snapshots capture disk data, data in memory, and all in process transactions. |
| Testing without disruption| You can run disaster recovery tests, without affecting ongoing replication. |
| Flexible failovers| You can run planned failovers for expected outages with no data loss. Run unplanned failovers with minimal data loss. And fail back to your primary site when it's available again. |
| Customized recovery plans| Create recovery plans so that you can customize and sequence the failover and recovery of your multi-tier apps running on multiple VMs. You can group machines together in a recovery plan. You can then, optionally, add scripts and manual actions. You can integrate recovery plans with Azure automation runbooks. |
| BCDR integration| You can integrate Site Recovery with other BCDR technologies. For example, use Site Recovery to protect the SQL Server backend of your corporate workloads. Because of its native support for SQL Server AlwaysOn, you can manage the failover of availability groups. |
| Azure automation integration| Download, from the Azure Automation library, and integrate app-specific scripts with Site Recovery. |


### Consider using Azure Site Recover with Azure Backup

 

Here we have an on-premises environment that has a Hyper-V host server for hosting virtual machines. You want to back up all the files and folders in this virtual machine to Azure. You also want to protect any workloads running on the virtual machine and keep running them even if the virtual machine fails. Azure Backup and Site Recovery can be used together as part of a single solution.

:::image type="content" source="../media/site-recovery.png" alt-text="Azure Site Recovery and Azure Backup work together.":::


In this scenario, Azure Backup periodically backs up the files and folders on the Windows machine to Azure. This process ensures they are secure and retrievable even if the whole on-premises environment stops functioning. Separately, Site Recovery will be used to protect running workloads and keep them running. Because Site Recovery can replicate frequently, the RTO for your workloads can be reduced.