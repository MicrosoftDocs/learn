Azure Site Recovery orchestrates replication and recovery for supported Azure VMs between Azure regions, supported zonal Azure VMs between availability zones in the same region, and supported on-premises Hyper-V VMs, VMware VMs, and physical servers to Azure. For workloads that originally ran on-premises, return from Azure depends on the platform's supported failback workflow.

Windows Server Hyper-V Replica is a separate option for directly replicating Hyper-V VMs between on-premises sites. Don't assume that its management and orchestration are provided through Azure Site Recovery.

For a planned, permanent move of servers to Azure, Microsoft recommends Azure Migrate. Use Site Recovery primarily for disaster recovery, where replication, drills, failover, and a supported return workflow are the goals.

Site Recovery supports disaster-recovery drills through test failover. A test failover creates test VMs from replicated data while production and replication continue. Use an isolated non-production network with suitable test dependencies, validate the application, and clean up the test failover afterward. This lets you assess recovery readiness without deliberately switching production to the recovery site.

Site Recovery replicates protected VM disks and orchestrates recovery in a target Azure region. When you enable replication, you configure target resources such as the resource group, virtual network, VM size, and availability settings. Site Recovery can create some resources or use resources that you've prepared.

It doesn't reproduce your entire application environment. Prepare target network security groups, load balancers, public IP addresses, DNS, identity services, and other application dependencies as needed. Plan how users will reach the recovered application, and include those changes in your recovery procedures.

## Check suitability and prerequisites

Before choosing Site Recovery, check that your source platform, operating system, disks, and VM configuration are supported for the intended replication scenario.

You also need a Recovery Services vault, a replication policy, the scenario-specific replication components, suitable connectivity, and permissions to create and manage recovery resources. For cross-region Azure VM recovery, create the Recovery Services vault in a supported region other than the source region.

Prepare target networking and application dependencies, confirm target VM sizes and subscription quotas, and assess whether capacity reservations are appropriate. Enabling replication doesn't itself reserve compute capacity. Complete initial replication and a successful test failover before relying on the recovery design.

### Choose the failure boundary

Cross-region replication and zone-to-zone replication address different failure boundaries. Zone-to-zone recovery can protect a supported VM that already runs in an availability zone by replicating it to another zone in the same region. Availability is limited to supported regions and VM configurations, so check the zone-to-zone support requirements separately.

> [!IMPORTANT]
> Zone-to-zone recovery doesn't provide a recovery location outside the region. It isn't a substitute for Adatum's Australia East-to-Australia Southeast design when the requirement is recovery from an Australia East regional outage. For zone-to-zone recovery, a Recovery Services vault can be in the same region or another supported region, but placing the vault elsewhere doesn't move the replicated workload data out of its region.

## Failover and failback

There are two terms that you should understand when working with Azure Site Recovery:

- **Failover**: A failover occurs when operations are transferred from your primary location to your secondary location, which often happens after a service outage at the primary location. For example, a service outage due to a scheduled downtime or a catastrophic failure.
- **Failback**: A failback occurs when operations are restored from your secondary location to your primary location. Typically, when the cause of the service outage is alleviated.

For supported return scenarios, Azure Site Recovery allows you to fail back after a failover. For example, if the primary location has a scheduled outage, you can fail over to the secondary location during the outage, and then use the platform's failback workflow to return once the primary location is ready.

:::image type="content" source="../media/before-and-after-failover.png" alt-text="Diagram that shows an on-premises web and database application failing over to Azure.":::

The example assumes SQL Server 2022 running on a guest operating system supported by Site Recovery. Prepare application connectivity and DNS routing separately from VM replication.
