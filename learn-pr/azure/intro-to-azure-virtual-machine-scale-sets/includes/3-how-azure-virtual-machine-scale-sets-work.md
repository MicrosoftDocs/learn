Azure Virtual Machine Scale Sets let you create and manage a group of load balanced VMs. The capacity or number of VM instances can automatically increase or decrease in response to a schedule that you configure or when performance metrics you define are reached. All VM instances in a virtual machine scale set have the same configuration and run the same applications.

Virtual machine scale sets provide high availability to your applications. Virtual machine scale sets let you centrally manage, configure, and update a large number of VMs. With virtual machine scale sets, you can build large-scale services for areas such as compute, big data, and container workloads.

Scale sets are designed for cost-effectiveness. New VM instances are created only when needed and are removed when no longer required. You can also configure scale sets to scale VMs either horizontally or vertically.

- **Horizontal scaling** is the process of adding or removing VMs in a scale set.

   In the uniform orchestration configuration, when new instances are required, those instances are generated from a template image to ensure that all VM instances have the same configuration and applications. Azure Virtual Machine Scale Sets limit you to running a maximum of 1,000 VMs in a single scale set.
- **Vertical scaling** is the process of adding resources such as memory, CPU power, or disk space to VMs in a scale set.

   In horizontal scaling, new, identically sized VMs in the uniform orchestration configuration are added to or removed from a scale set. In contrast, vertical scaling focuses on increasing the size and capacity of the VMs in the scale set. For example, by increasing the processor core count and speed. Vertical scaling typically requires rebooting the affected VMs in the scale set.

## Scaling a scale set

Virtual machine scale sets address the need to quickly create and manage VMs for fluctuating workloads. You can configure two types of scaling for a scale set:

- **Scheduled scaling:** You can proactively schedule the scale set to deploy one or *N* number of extra instances to accommodate a spike in traffic, then scale back down when the spike ends.

- **Autoscaling:** If the workload is variable and can’t always be scheduled, you can use metric-based threshold scaling. Autoscaling horizontally scales out based on node usage. It then scales back in when the resources return to a baseline.

Autoscaling is based on a set of scale conditions, rules, and limits. A scale condition combines time and a set of scale rules. If the current time falls within the period defined in the scale condition, the condition's scale rules are evaluated. The results of this evaluation determine whether to add or remove instances in the scale set.

The scale condition also defines the limits of scaling for the maximum and minimum number of instances. Limiting the maximum number of metrics lets you restrict the number of VMs that are created so that an unplanned traffic surge doesn’t automatically leave you with unexpected subscription charges.

You can base the autoscale on:

- **Schedule:** Use this approach if you know you have an increased workload on a specified date or period of time. Schedule-based scaling specifies a start and end time and the number of instances to add to the scale set.

- **Metrics:** Adjust scaling by monitoring performance metrics associated with the scale set. When these metrics exceed a specified threshold, the scale set can automatically start new virtual machine instances. When the metrics indicate that the extra resources are no longer required, the scale set can stop any excess instances.

These metrics are commonly used to monitor a virtual machine scale set:

- **Percentage CPU:** This metric indicates the CPU usage across all instances. A high value shows that instances are becoming CPU-bound, which could delay the processing of client requests.

- **Inbound flows and outbound flows:** These metrics show how fast network traffic is flowing into and out of virtual machines in the scale set.

- **Disks read operations/sec and disk write operations/sec:** These metrics show the volume of disk I/O across the scale set.

- **Data disk queue depth:** This metric shows how many I/O requests are waiting to be serviced for only the data disks on the virtual machines.

A virtual machine scale set can contain many scale conditions. Each matching scale condition is acted on. A scale set can also contain a default scale condition that's used if no other scale conditions match the current time and performance metrics.

The default scale condition is always active. It contains no scale rules, effectively acting like a null scale condition that doesn't scale in or out. However, you can modify the default scale condition to set a default instance count, or you can add a pair of scale rules that scale out and back in again.

## Scale sets with Azure Spot instances

A virtual machine scale set comprised of Azure Spot instance VMs lets you use Azure compute resources at cost savings of up to 80 percent. The global Azure infrastructure frequently has underused compute resources available. A scale set using spot instances lets you save money by using this underused compute capability.

> [!NOTE]
> When you use these VMs, keep in mind that they're temporary. Availability depends on size, region, time of day, and so on. These VMs have no SLA.

When Azure needs the computing power again, you get a notification about the VM that's removed from your scale set. Using spot instances in scale sets is useful for workloads that run with interruptions, or when you need larger VMs at a much-reduced cost. Just keep in mind that you can't control when a VM might be removed.

## How virtual machine scale sets are different from manual VM pools

Scale sets are built from virtual machines. With scale sets, the management and automation layers are provided to run and scale your applications. Prior to the availability of virtual machine scale sets, organizations often manually created and managed individual VMs, or integrated existing tools to build a similar level of automation.

This table outlines the benefits of scale sets compared to manually managing multiple VM instances.

| Scenario | Manual group of VMs | Virtual machine scale set |
|---|---|---|
| **Add extra VM instances** | Manual process to create, configure, and ensure compliance | Automatically create from central configuration |
| **Traffic balancing and distribution** | Manual process to create and configure Azure Load Balancer or Application Gateway | Can automatically create and integrate with Azure Load Balancer or Application Gateway |
| **High availability and redundancy** | Manually create Availability Set or distribute and track VMs across Availability Zones | Automatic distribution of VM instances across Availability Zones or Availability Sets |
| **Scaling of VMs** | Manual monitoring and Azure Automation | Autoscale based on host metrics, in-guest metrics, Application Insights, or schedule
