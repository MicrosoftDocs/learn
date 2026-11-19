Azure Virtual Machine Scale Sets let you create and manage a group of load balanced VMs. The capacity or number of virtual machine (VM) instances can automatically increase or decrease in response to a schedule that you configure or when performance metrics you define are reached. VM instances in a Virtual Machine Scale Set can have the same configuration or different configurations.

Virtual Machine Scale Sets provide high availability and scale to your applications. Virtual Machine Scale Sets let you centrally manage, configure, and update a large number of VMs. With Virtual Machine Scale Sets, you can build large-scale services for areas such as compute, big data, and container workloads.

Scale sets are designed for cost-effectiveness, scalability, and reliability. New VM instances are created only when needed and are removed when no longer required. When new instances are required, those instances are generated from a template image to configure the instances and the applications. Azure Virtual Machine Scale Sets allow you to run up to 1,000 VMs in a single scale set.

## Scaling a scale set

Virtual Machine Scale Sets help you create and manage VMs for fluctuating workloads. Two common ways to configure automatic scaling are:

- **Scheduled autoscale:** Use fixed-date or recurring profiles to provide capacity for predictable changes in demand.
- **Metric-based autoscale:** Use performance-metric rules to scale out or in as the workload changes.

You can combine these approaches by configuring metric rules within scheduled profiles.

Autoscaling uses scale conditions, also called profiles. Azure Monitor selects one applicable profile for the current date and time, then evaluates that profile's capacity limits and any metric-based scale rules to determine whether to add or remove VM instances.

Each autoscale profile defines the minimum and maximum number of VM instances. Limiting the maximum instance count constrains autoscale-driven expansion and helps control costs. This limit applies to VM instances, not to the number of metrics.

You can base the autoscale on:

- **Schedule:** Schedule-based autoscale selects a profile for a particular period. Configure a fixed total instance count, or minimum and maximum instance counts with metric-based rules, for that period. For example, you could target 10 instances during business hours and 2 outside business hours. For each fixed-count profile, set its minimum, maximum, and default instance counts to the same target value; no metric rules are needed. This sets a total count rather than adding that many VMs.

  Fixed-date profiles specify start and end dates and times. Recurring profiles take effect on a weekly schedule, and the start of the next applicable profile ends the previous recurring period. Configure the return to off-hours capacity as well as the increase. In the portal, specifying a recurring schedule's end time schedules a return to the default profile.

- **Metrics:** Metric-based autoscale evaluates configured performance-metric rules. Scale-out creates additional VM instances. When the scale-in conditions are met, scale-in deletes VM instances selected according to the scale-in policy and applicable instance protections; it doesn't simply stop those instances for later restart.

> [!IMPORTANT]
> Design the application to tolerate instance removal. Preserve required state and arrange for in-progress work to finish, be handed off, or be retried safely. Scale-in selection doesn't guarantee that the selected VM is idle, and application draining doesn't happen automatically merely because autoscale is enabled.

These metrics are commonly used to monitor a Virtual Machine Scale Set:

- **Percentage CPU:** This metric indicates the CPU usage across all instances. A high value shows that instances are becoming CPU-bound, which could delay the processing of client requests.

- **Inbound flows and outbound flows:** These metrics count the current network flows into and out of the virtual machines. They measure flow counts, not network throughput.

- **Disk read operations/sec and disk write operations/sec:** These metrics show the volume of disk I/O across the scale set.

- **Data disk queue depth:** This metric shows how many I/O requests are waiting to be serviced for only the data disks on the virtual machines.

An autoscale setting can contain multiple profiles, but only one applies at a time. Azure Monitor checks fixed-date profiles first, recurring profiles next, and the default profile when no scheduled profile applies. It uses the first applicable profile. Metric rules are evaluated within that profile; a rule that doesn't trigger doesn't cause Azure Monitor to select a different profile.

The default profile can contain scale-out and scale-in rules. Even a profile without metric rules can change the instance count to enforce its minimum and maximum capacity.

> [!NOTE]
> The default profile and a profile's default instance count are different concepts. If Azure Monitor can't read the resource metric and the current capacity is below the default instance count, autoscale scales out to that count. It doesn't scale in to the default count when current capacity is higher. The default instance count isn't a scheduled target.

## Scale sets with Azure Spot instances

A Virtual Machine Scale Set comprised of Azure Spot instance VMs lets you use Azure compute resources at cost savings of up to 80 percent. In the global Azure infrastructure, underused compute resources frequently become available. A scale set using spot instances lets you save money by using this underused compute capability.

> [!NOTE]
> When you use these VMs, keep in mind that they're temporary. Availability depends on size, region, time of day, and so on. These VMs have no SLA.

Azure can evict Spot VMs when it needs capacity or when the Spot price exceeds your configured maximum. With the default Deallocate eviction policy, evicted instances remain stopped-deallocated and their retained disks continue to incur charges. The Delete eviction policy removes the evicted VM instances instead.

> [!IMPORTANT]
> Applications can opt in to Azure Scheduled Events for best-effort eviction notifications up to 30 seconds before eviction. Don't depend on receiving a full 30-second warning or on replacement Spot capacity being available. Use Spot VMs only for workloads that can tolerate interruptions.

## How Virtual Machine Scale Sets are different from manual VM pools

Scale sets are built from virtual machines. With scale sets, the management and automation layers are provided to run and scale your applications. Before the availability of Virtual Machine Scale Sets, organizations often manually created and managed individual VMs, or integrated existing tools to build a similar level of automation.

This table outlines the benefits of scale sets compared to manually managing multiple VM instances.

| Scenario | Manual group of VMs | Virtual Machine Scale Sets |
|---|---|---|
| **Add extra VM instances** | Manual process to create, configure, and ensure compliance | Automatically create from central configuration |
| **Traffic balancing and distribution** | Manual process to create and configure Azure Load Balancer or Application Gateway | Can automatically create and integrate with Azure Load Balancer or Application Gateway |
| **High availability and redundancy** | Manually create Availability Set or distribute and track VMs across Availability Zones | Automatic distribution of instances across fault domains and, when configured for multiple zones, across Availability Zones |
| **Scaling of VMs** | Manual monitoring and Azure Automation | Autoscale based on host metrics, in-guest metrics, Application Insights, or schedule
