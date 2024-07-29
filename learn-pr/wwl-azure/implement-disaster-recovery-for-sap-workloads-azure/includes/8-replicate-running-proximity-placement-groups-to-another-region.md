proximity placement groups is an Azure Virtual Machine logical grouping capability that you can use to decrease the inter-virtual machine network latency associated with your applications. When the virtual machines are deployed within the same proximity placement group, they're physically located as close as possible to each other. Proximity placement groups are useful to address the requirements of latency-sensitive workloads.

## Disaster recovery with proximity placement groups

In a typical scenario, you have your virtual machines running in a proximity placement group to avoid the network latency between the various tiers of your application. While this can provide your application optimal network latency, you would like to protect these applications using Site Recovery for any region-level failure. Site Recovery replicates the data from one region to another Azure region and brings up the machines in disaster recovery region in an event of failover.

## Considerations

- It's best to failover/failback the virtual machines into a proximity placement group. However, if virtual machine is unable to be brought up inside proximity placement during failover/failback, then failover/failback still happens, and virtual machines are created outside of a proximity placement group.
- When an Availability Set is pinned to a proximity placement group and during failover/failback virtual machines in the availability set have an allocation constraint, then the virtual machines are created outside of both the availability set and proximity placement group.
- This functionality is currently available via PowerShell and supports any Azure Virtual Machine using Managed Disks. Site Recovery for proximity placement groups isn't supported for unmanaged disks.
- Azure Site Recovery doesn't support failback from managed disks for Hyper-V to Azure scenarios. As such, failback from a proximity placement group in Azure to Hyper-V isn't supported.

## Proximity placement groups with zonal deployments

It's important to provide a reasonably low network latency between the SAP application tier and the database tier. In most situations, a zonal deployment alone fulfills this requirement. For a limited set of scenarios, a zonal deployment alone might not meet the application latency requirements. Such situations require virtual machine placement as close as possible and enable reasonably low network latency, an Azure proximity placement group can be defined for such an SAP system.

Avoid bundling several SAP production or nonproduction systems into a single proximity placement group. Avoid bundles of SAP systems because the more systems you group in a proximity placement group, the higher the chances:

- That you require a virtual machine type that isn't available under the network spine into which the proximity placement group was assigned to.
- That resources of nonmainstream VMs, like M-Series VMs, could eventually be unfulfilled when you need to expand the number of VMs into a proximity placement group over time.

Based on improvements deployed by Microsoft into the Azure regions to reduce network latency within an Azure availability zone, the deployment guidance when using proximity placement groups for zonal deployments changed as illustrated in the following image:

:::image border="false" type="content" source="../media/vm-ppg-zone-animated.gif" alt-text="Diagram showing changes in the deployment guidance when using proximity placement groups for zonal deployments.":::

For more information, see [Proximity placement groups](/azure/sap/workloads/proximity-placement-scenarios#proximity-placement-groups-with-zonal-deployments).
