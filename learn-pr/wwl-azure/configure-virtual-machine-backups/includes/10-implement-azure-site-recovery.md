
Azure Site Recovery helps ensure business continuity by keeping business applications and workloads running during outages. Site Recovery replicates workloads running on physical and virtual machines from a primary site to a secondary location. When an outage occurs at your primary site, Site Recovery implements a failover to the secondary location to allow continued access to your applications. After the primary location is running again, you can resume application access on the primary machine.

The following illustration that shows two regions connected by Azure Traffic Manager. Azure Site Recovery is implemented to enable failover from region 1 to region 2.

:::image type="content" source="../media/site-recovery-scenarios-388c71fd.png" alt-text="Illustration that shows an implementation of Azure Site Recovery to enable failover from region 1 to region 2." border="false":::

### Things to know about Azure Site Recovery

Azure Site Recovery supports many configurations and complements various Azure services. You can implement Site Recovery to back up your virtual machines and physical machines in the following scenarios:

- Replicate Azure virtual machines from one Azure region to another

- Replicate on-premises VMware virtual machines, Hyper-V virtual machines, physical servers (Windows and Linux), and Azure Stack virtual machines to Azure

- Replicate AWS Windows instances to Azure

- Replicate on-premises VMware virtual machines, Hyper-V virtual machines managed by System Center VMM, and physical servers to a secondary site

### Things to consider when using Site Recovery

There are many benefits to implementing Azure Site Recovery. As you review the following features, consider how the service can support your business requirements.

| Feature | Description |
| --- | --- |
| **Consolidated management** | Set up and manage replication, failover, and failback from a single location in the Azure portal. |
| **Reduced cost and complexity** | Replicate to Azure to eliminate the cost and complexity of maintaining a secondary datacenter. |
| **Replication resilience** | Orchestrate replication without intercepting your app data and gain the resilience of Azure Storage. When failover occurs, Azure virtual machines are created, based on the replicated data. |
| **Continuous replication** | Access continuous replication for Azure virtual machines and VMware virtual machines, and replication frequency as low as 30 seconds for Hyper-V. |
| **Snapshot recovery points** | Replicate by using recovery points with app-consistent snapshots that capture disk data, all data in memory, and all transactions in process. |
| **Failover and easy fall back** | Run planned failovers for expected outages with zero-data loss. Run unplanned failovers with minimal data loss depending on replication frequency. Easily fall back to your primary site when it's available again.
| **Integration** | Integrate with Azure for simple application network management, including reserving IP addresses, configuring load-balancers, and integrating Azure Traffic Manager for efficient network switchovers. |