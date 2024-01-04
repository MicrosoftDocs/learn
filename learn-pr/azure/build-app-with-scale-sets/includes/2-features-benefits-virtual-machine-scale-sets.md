Azure Virtual Machine Scale Sets provide a scalable way to run applications on a set of virtual machines (VMs). The VMs in a scale set can all have the same configuration and run the same applications or have different configurations and run different applications. As demand grows, the number of VMs that run in the scale set increases. As demand shrinks, excess VMs can be removed. Virtual Machine Scale Set is ideal for scenarios that include compute workloads, big-data workloads, and container workloads.

In our example scenario, your customers use one of the company's websites to manage and check the status of their shipments. Because the website is accessed globally, the load is sometimes difficult to predict at any particular time of day. Additionally, loading might vary seasonally, with December being busy because of the holidays at the end of the year. You decide to use a Virtual Machine Scale Set to handle the fluctuating load while maintaining a low response time for customer requests.

In this unit, you explore the features of Virtual Machine Scale Sets. By the end of this unit, you can describe how a scale set works. You learn how a scale set supports scale-out and scale-up scenarios and learn how to use autoscaling and schedule-based scaling to adjust the resources available to a scale set.

## What is a Virtual Machine Scale Set?

Virtual Machine Scale Sets in Azure are designed to allow you to deploy and manage many load-balanced VMs. Virtual Machine Scale Sets are intelligent enough to automatically scale up or down the number of VM instances.

The criteria used to activate the upscale or downscale can depend on a customized schedule or actual demand and usage. Scale sets can apply the same configuration to a group of VMs simultaneously. They don't require you to manually configure instances individually if you don't want to.

A scale set uses a load balancer to distribute requests across the VM instances. It uses a health probe or the Application Health Extension to determine the availability of each instance. The health probe or Application Health Extension *pings* the instance. If the instance responds, the scale set knows the instance is still available. If the ping fails or times out, the scale set knows the instance is unavailable and doesn't send requests to it.

Virtual Machine Scale Sets support both Linux and Windows VMs in Azure and can run up to 1,000 VMs on a single scale set.

If you deal with large workloads whose demand varies and is unpredictable, scale sets are a great solution. Virtual Machine Scale Sets offer virtual machines that can scale in response to demand and are load-balanced. They automatically provide a highly available environment.

## Scaling options for scale sets

Scale sets are designed for cost effectiveness. New VM instances are created only when needed.

Sometimes you might need to add or remove machines in a scale set, depending on demand. For example, you might not need to run some machines during periods of the week or day when demand is low. You could manually adjust the number of VMs in a scale set by increasing or decreasing the instance count. In many cases, it's better to automatically add or remove VMs by using rules. The rules are based on metrics. They ensure that the right number of VMs are added, depending on the demand or schedule.

## Scaling a scale set

Virtual Machine Scale Sets address the need to quickly create and manage VMs for a fluctuating workload. You can configure two types of scaling for a scale set:

- **Scheduled scaling**: You can proactively schedule the scale set to deploy one or more instances to accommodate a spike in traffic and then scale back down when the spike ends.

- **Autoscaling**: If the workload is variable and can't always be scheduled, you can use metric-based threshold scaling. Autoscaling scales out based on node usage. It then scales back in when the resources return to a baseline.

Both of these options address the requirement to scale while managing associated costs. The following examples describe scenarios where you might use different types of scaling.

### Scheduled scaling

Suppose you're part of the DevOps team for a large food delivery company. Friday night is typically your busiest time. Conversely, 7 AM on Wednesday is generally your quietest time.

Azure charges based on the consumption of resources, so don't run services you don't need. If you need 100 web servers to meet your demand on a Friday night, you're happy to pay for them. But if you need only two servers on a Wednesday morning, you don't want to pay for the 98 idle servers. To manage your costs while fulfilling operational requirements, consider using scheduled scaling.

### Autoscaling

Suppose you're on the DevOps team for a popular footwear company. As a product launch approaches, you think you see significant demand for your service. However, the demand spike might be unpredictable and hard to quantify. You want your service to meet demand by scaling horizontally as current resources are used.

For this scenario, you can use metrics-based autoscaling. This type of autoscaling scales out your infrastructure as demand rises. It scales back in when demand declines.

## Reducing costs by using Spot virtual machines

Azure Spot Virtual Machines allows you to take advantage of our unused capacity at a significant cost savings. At any time when Azure needs the capacity back, the Azure infrastructure evicts Azure Spot Virtual Machines. Therefore, these virtual machines are great for workloads that can handle interruptions like batch processing jobs, dev/test environments, and large compute workloads.

The amount of available capacity can vary based on size, region, time of day, and other factors. When it deploys Azure Spot Virtual Machines, Azure allocates the VMs if there's capacity available, but there's no SLA for these VMs. An Azure Spot Virtual Machine offers no high-availability guarantees. At any point in time when Azure needs the capacity back, the Azure infrastructure evicts Azure Spot Virtual Machines with 30-seconds notice.

When Azure needs the computing power again, you receive a notification about the VM Azure removes from your scale set. If you need to clean up or gracefully exit code on your VM, you can use Azure Scheduled Events to react to the notification within the VM. You can also make the scale set try to create another VM to replace the one that's being removed. The creation of the new VM is, however, not guaranteed.

With Azure Spot Virtual Machines, you can specify two kinds of removal through setting an eviction policy:

- **Deallocate** policy (default): The VM is stopped. The processing and memory resources are deallocated. Disks are left intact and data is kept. You're charged for the disk space while the VM isn't running.  
- **Delete** policy: The entire VM is removed, including all of the underlying disks, so you aren't charged for storage.

Azure Spot Virtual Machines is useful for workloads that run with interruptions or when you need larger VMs at a much-reduced cost. Just keep in mind that you can't control when a VM might be removed.
