Azure virtual machine scale sets provide a scalable way to run applications on a set of virtual machines (VMs). The VMs in this type of scale set all have the same configuration and run the same applications. As demand grows, the number of VMs running in the scale set increases. As demand slackens, excess VMs can be shut down. Virtual machine scale sets are ideal for scenarios that include compute workloads, big-data workloads, and container workloads. 

In our example scenario, your customers use one of the company's websites to manage and check the status of their shipments. Because the website is accessed globally, the load is sometimes difficult to predict at any particular time of day. Additionally, loading might vary seasonally, with December being busy because of the holidays at the end of the year. You decide to use a virtual machine scale set to handle the fluctuating load while maintaining a low response time for customer requests.

In this unit, you'll explore the features of virtual machine scale sets. By the end of this unit, you'll be able to describe how a scale set works. You'll understand how a scale set supports scale-out and scale-up scenarios. You'll see how to use autoscaling and schedule-based scaling to adjust the resources available to a scale set.

## What is a virtual machine scale set?

Virtual machine scale sets in Azure are designed to allow you to deploy and manage many load-balanced VMs. Virtual machine scale sets are intelligent enough to automatically scale up or down the number of VM instances. A scale set can also change the size of VM instances.

The criteria used to activate the upscale or downscale can depend on a customized schedule or actual demand and usage. Scale sets apply the same configuration to a group of VMs simultaneously. They don't require you to manually configure instances individually.

A scale set uses a load balancer to distribute requests across the VM instances. It uses a health probe to determine the availability of each instance. The health probe *pings* the instance. If the instance responds, the scale set knows the instance is still available. If the ping fails or times out, the scale set knows the instance is unavailable and doesn't send requests to it.

Virtual machine scale sets support both Linux and Windows VMs in Azure. However, keep in mind that you're limited to running 1,000 VMs on a single scale set.

If you deal with large workloads whose demand varies and is unpredictable, scale sets are a great solution. Because virtual machine scale sets offer identical VMs scaled and load-balanced in response to demand, they automatically provide a highly available environment.

## Scaling options for scale sets

Scale sets are designed for cost-effectiveness. New VM instances are created only when needed. A scale set can scale VMs either horizontally or vertically.

### What is horizontal scaling?

*Horizontal scaling* is the process of adding or removing several VMs in a scale set.

Sometimes you might need to add or remove machines in a scale set, depending on demand. For example, you might not need to run some machines during periods of the week or day when demand is low. You could manually adjust the number of VMs in a scale set by increasing or decreasing the instance count. But in many cases, it's better to automatically add or remove VMs by using rules. The rules are based on metrics. They ensure that the right number of VMs are added, depending on the demand or schedule. 

### What is vertical scaling?

*Vertical scaling* is the process of adding resources such as memory, CPU power, or disk space to VMs.

In contrast to horizontal scaling, where new, identically sized VMs are added to or removed from a scale set, vertical scaling focuses on increasing the size of the VMs in the scale set.  

For example, you might want to reduce the CPU performance of a group of VMs in a scale set.  In this case, you might not necessarily need to remove an entire group of machines. In scale sets, you create rules based on metrics. These rules automatically trigger an increase in the sizes of the VMs.  

Vertical scaling typically requires rebooting the affected VMs in the scale set. This process can lead to temporary degraded performance across the scale set while the VMs restart.

## Scaling a scale set

Virtual machine scale sets address the need to quickly create and manage VMs for a fluctuating workload. You can configure two types of scaling for a scale set:

- **Scheduled scaling**: You can proactively schedule the scale set to deploy one or *N* number of additional instances to accommodate a spike in traffic and then scale back down when the spike ends.

- **Autoscaling**: If the workload is variable and can't always be scheduled, you can use metric-based threshold scaling. Autoscaling horizontally scales out based on node usage. It then scales back in when the resources return to a baseline.

Both of these options address the requirement to scale while managing associated costs. The following examples describe scenarios where you might use different types of scaling.

### Scheduled scaling

Suppose you're part of the DevOps team for a large food delivery company. Friday night is typically your busiest time. Conversely, 7 AM on Wednesday is generally your quietest time. 

Azure charges based on the consumption of resources, so don't run services you don't need. If you need 100 web servers to meet your demand on a Friday night, you're happy to pay for them. But if you need only two servers on a Wednesday morning, you don't want to pay for the 98 idle servers. To manage your costs while fulfilling operational requirements, consider using scheduled scaling.

### Autoscaling

Suppose you're on the DevOps team for a popular footwear company. As a product launch approaches, you think you'll see significant demand for your service. However, the demand spike might be unpredictable and hard to quantify. You want your service to meet demand by scaling horizontally as current resources are used. 

For this scenario, use metrics-based autoscaling. This type of autoscaling scales out your infrastructure as demand rises. It scales back in when demand declines.

## Reducing costs by using Spot virtual machines

Azure Spot Virtual Machines allows you to take advantage of our unused capacity at a significant cost savings. At any point in time when Azure needs the capacity back, the Azure infrastructure will evict Azure Spot Virtual Machines. Therefore, Azure Spot Virtual Machines are great for workloads that can handle interruptions like batch processing jobs, dev/test environments, large compute workloads, and more.

The amount of available capacity can vary based on size, region, time of day, and more. When deploying Azure Spot Virtual Machines, Azure will allocate the VMs if there is capacity available, but there is no SLA for these VMs. An Azure Spot Virtual Machine offers no high availability guarantees. At any point in time when Azure needs the capacity back, the Azure infrastructure will evict Azure Spot Virtual Machines with 30 seconds notice.

When Azure needs the computing power again, you'll receive a notification about the VM that will be removed from your scale set. If you need to clean up or gracefully exit code on your VM, you can use Azure Scheduled Events to react to the notification within the VM. You can also make the scale set try to create another VM to replace the one that's being removed. The creation of the new VM is, however, not guaranteed.

With Azure Spot Virtual Machines, you can specify two kinds of removal through setting an eviction policy:

- **Deallocate** policy (default): The VM is stopped. The processing and memory resources are deallocated. Disks are left intact and data is kept. You're charged for the disk space while the VM isn't running.  
- **Delete** policy: The entire VM is removed, including all of the underlying disks,so you will not continue to be charged for storage. 

Azure Spot Virtual Machines are useful for workloads that run with interruptions or when you need larger VMs at a much-reduced cost. Just keep in mind that you can't control when a VM might be removed.
