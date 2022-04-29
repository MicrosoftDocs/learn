Site Recovery helps ensure business continuity by keeping business apps and workloads running during outages. Site Recovery replicates workloads running on physical and virtual machines (VMs) from a primary site to a secondary location. When an outage occurs at your primary site, you fail over to secondary location, and access apps from there. After the primary location is running again, you can fall back to it.

:::image type="content" source="../media/site-recovery-scenarios-388c71fd.png" alt-text="Two regions are connected by Traffic Manager. Region 1 is failing over to Region 2.":::


## Replications scenarios

 -  Replicate Azure VMs from one Azure region to another.
 -  Replicate on-premises VMware VMs, Hyper-V VMs, physical servers (Windows and Linux), Azure Stack VMs to Azure.
 -  Replicate AWS Windows instances to Azure.
 -  Replicate on-premises VMware VMs, Hyper-V VMs managed by System Center VMM, and physical servers to a secondary site.

## Features

 -  Using Site Recovery, you can set up and manage replication, failover, and failback from a single location in the Azure portal.
 -  Replication to Azure eliminates the cost and complexity of maintaining a secondary datacenter.
 -  Site Recovery orchestrates replication without intercepting application data. When you replicate to Azure, data is stored in Azure storage, with the resilience that it provides. When failover occurs, Azure VMs are created, based on the replicated data.
 -  Site Recovery provides continuous replication for Azure VMs and VMware VMs, and replication frequency as low as 30 seconds for Hyper-V.
 -  You can replicate using recovery points with application-consistent snapshots. These snapshots capture disk data, all data in memory, and all transactions in process.
 -  You can run planned failovers for expected outages with zero-data loss, or unplanned failovers with minimal data loss (depending on replication frequency) for unexpected disasters. You can easily fall back to your primary site when it's available again.
 -  Site Recovery integrates with Azure for simple application network management, including reserving IP addresses, configuring load-balancers, and integrating Azure Traffic Manager for efficient network switchovers.

> [!NOTE]
> Are you considering using Azure Site Recovery and are you interested in any of these specific features? Which one is most important to you?
