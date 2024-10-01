Azure Site Recovery orchestrates and automates the replication of Azure VMs between regions. You can replicate on-premises VMs and physical servers to Azure, Azure VMs to on-premises VMs, and on-premises machines to a secondary datacenter. On-premises VMs can be hosted in and replicated from Hyper-V or VMware virtualization solutions. You can use Azure Site Recovery to migrate VMs from other environments (such as on-premises infrastructure) to Azure.

Because Azure Site Recovery is built natively into Azure, you can use it to run disaster-recovery drills to test your Business continuity and disaster recovery (BCDR) solutions without affecting your production workloads. Disaster-recovery drills help you test if your disaster-recovery settings are correctly configured. The drills help validate the replication strategy for your environment without losing data, experiencing downtime, or compromising your production environment.

You can use Azure Site Recovery to seamlessly protect your virtual machine (VM) instances in Azure by mirroring the source VM configuration to a secondary Azure region. All of the resources in your source region are mirrored by creating required or associated resource groups, storage accounts, virtual networks, and availability sets.

## Failover and failback

There are two terms that you should understand when working with Azure Site Recovery:

- **Failover**: A failover occurs when operations are transferred from your primary location to your secondary location, which often happens after a service outage at the primary location. For example, a service outage due to a scheduled downtime or a catastrophic failure.
- **Failback**: A failback occurs when operations are restored from your secondary location to your primary location. Typically, when the cause of the service outage is alleviated.

Azure Site Recovery allows you to perform a failback after performing a failover. For example, if the primary location has a scheduled outage, you can fail over to the secondary location during the outage, and then fail back the workload to the primary location once the scheduled outage is completed.

:::image type="content" source="../media/before-and-after-failover.png" alt-text="Diagram showing before and after a failover.":::
