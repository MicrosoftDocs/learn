[Azure Site Recovery](/azure/site-recovery/site-recovery-overview) provides BCDR features for your applications in Azure, on-premises, and in other cloud providers. The service offers plans to help automate your disaster recovery. You can define how your virtual machines are failed over, and the order in which they're restarted after successful failover.

### Things to consider when using Site Recovery

Azure Site Recovery provides a simple BCDR solution with management support from the Azure portal. Set up and manage replication, fail over, and failback for your virtual machines from a single location.

Let's review some of the many capabilities of Azure Site Recovery.

| Feature | Description |
| --- | --- |
| **Replicate Azure virtual machines** | Set up disaster recovery of your Azure virtual machines, and fail over from a primary region to a secondary region. |
| **Replicate on-premises virtual machines** | Replicate your on-premises virtual machines and physical servers to Azure, or to a secondary on-premises datacenter. |
| **Replicate workloads** | Replicate any workload running on supported Azure virtual machines, on-premises Hyper-V and VMware virtual machines, and Windows or Linux physical servers. |
| **Automate BCDR tasks** | Automate your BCDR tasks and further reduce your recovery time objective. You can use Azure Site Recovery to set up automatic periodic test failovers, and monitor the overall effectiveness of the recovery process. |
| **Maintain data resilience** | Orchestrate replication without intercepting app data by using Azure Site Recovery. When failover occurs, Azure virtual machines are created based on the replicated data. When you replicate to Azure, data is stored in Azure Storage, and you gain the resilience provided by that service. |
| **Meet RTO and RPO targets** | Keep the RTO and RPO goals within the defined organizational limits. Azure Site Recovery provides continuous replication for Azure virtual machines and VMware virtual machines, and replication frequency as low as 30 seconds for Hyper-V. |
| **Maintain consistent apps after failover** | By using app-consistent snapshots, you can replicate from specific recovery points. These snapshots capture disk data, data in memory, and all in process transactions. |
| **Test without disruption** | Run disaster recovery tests without affecting ongoing replication. |
| **Run flexible failovers** | Execute planned failovers for expected outages with no data loss. Run unplanned failovers with minimal data loss, and fail back to your primary site when it's available again. |
| **Customize recovery plans** | Create recovery plans so you can customize and sequence the failover and recovery of your multi-tier apps running on multiple virtual machines. Group virtual machines together in a recovery plan, and add scripts and manual actions as needed. Integrate recovery plans with Azure Automation runbooks. |
| **Integrate with BCDR technologies** | Integrate Azure Site Recovery with other BCDR technologies. Use Site Recovery to protect the SQL Server backend of your corporate workloads. Because of its native support for SQL Server AlwaysOn, you can manage the failover of availability groups. |
| **Access Azure Automation integration** | Download from the Azure Automation library and integrate app-specific scripts with Azure Site Recovery. |

## Use Azure Site Recovery with Azure Backup

Let's examine how you can implement Azure Site Recovery with Azure Backup for a BCDR solution.

Suppose you have an on-premises environment with a Hyper-V host server for hosting virtual machines. You want to back up all the files and folders in your virtual machine to Azure. You also want to protect any workloads running on your virtual machine and keep them running if the virtual machine fails. Azure Backup and Site Recovery can be used together in a single solution.

:::image type="content" source="../media/site-recovery.png" alt-text="Diagram that shows a BCDR solution with Azure Site Recovery and Azure Backup." border="false":::

In this scenario, Azure Backup periodically backs up the files and folders on your Windows machine to Azure. This process ensures they data is secure and retrievable even if the whole on-premises environment stops functioning. Separately, Azure Site Recovery is used to protect your running workloads and keep them running. Because Site Recovery can replicate frequently, the RTO for your workloads can be reduced.