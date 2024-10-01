#### Overview of Azure Site Recovery

Azure Site Recovery is a service that helps ensure business continuity by replicating workloads from a primary site to a secondary location.


> [!Video https://www.youtube.com/embed/94LDYjBhz5c]

Suppose you work for a large e-commerce company that relies heavily on its online platform to generate revenue. One day, a major storm hits the region where your primary data center is located, causing a power outage and rendering your website inaccessible. This outage results in significant financial losses and damages your company's reputation. To prevent such incidents in the future, you decide to implement Azure Site Recovery. By replicating your workloads to a secondary location, you can ensure that your applications remain accessible. You can continue serving your customers and minimize the impact on your business.

The following illustration shows two regions connected by Azure Traffic Manager. Azure Site Recovery is implemented to enable failover from region 1 to region 2.

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