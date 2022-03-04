Proximity Placement Groups is an Azure Virtual Machine logical grouping capability that you can use to decrease the inter-VM network latency associated with your applications. When the VMs are deployed within the same proximity placement group, they are physically located as close as possible to each other. Proximity placement groups are useful to address the requirements of latency-sensitive workloads.

## Disaster recovery with Proximity Placement Groups

In a typical scenario, you may have your virtual machines running in a proximity placement group to avoid the network latency between the various tiers of your application. While this can provide your application optimal network latency, you would like to protect these applications using Site Recovery for any region-level failure. Site Recovery replicates the data from one region to another Azure region and brings up the machines in disaster recovery region in an event of failover.

## Considerations

 -  The best effort will be to failover/failback the virtual machines into a proximity placement group. However, if VM is unable to be brought up inside Proximity Placement during failover/failback, then failover/failback will still happen, and virtual machines will be created outside of a proximity placement group.
 -  If an Availability Set is pinned to a Proximity Placement Group and during failover/failback VMs in the availability set have an allocation constraint, then the virtual machines will be created outside of both the availability set and proximity placement group.
 -  This functionality is currently available via PowerShell and supports any Azure VM using Managed Disks. Site Recovery for Proximity Placement Groups is not supported for unmanaged disks.
 -  Azure Site Recovery does not support failback from managed disks for Hyper-V to Azure scenarios. As such, failback from a Proximity Placement Group in Azure to Hyper-V is not supported.
