Azure virtual machine scale set provides a scalable way to run applications on a set of virtual machines. The virtual machines in this type of scale set all have the same configuration, and run the same applications. As demand grows, the number of virtual machines running in the scale set increases. As demand slackens off, excess virtual machines can be shut down. Azure virtual machine scale sets are ideal for scenarios that include compute, big data, and container workloads. 

You can scale a virtual machine scale set manually, but it's more common to use autoscaling. You autoscale based on a schedule, or by using metrics that indicate how heavily resources are currently being used.

In the example scenario, customers can create, view, and manage orders at any time, although the load varies throughout the working day. As the website is accessed globally, it is sometimes difficult to predict exactly what the load is likely to be at any particular time of day. Additionally, loading might vary seasonally, with December being a particular busy time due to the holidays at the end of the year. Therefore, the shipping company decides to use a virtual machine scale set to handle the fluctuating load while maintaining a low response time for customer requests.

In this unit, you'll explore the features of virtual machine scale sets. By the end of this unit, you'll be able to describe how a scale set works. You'll understand how a scale set supports scale out and scale up scenarios. You'll see how you can use autoscaling and schedule-based scaling to adjust the resources available to a scale set.

## What is a virtual machine scale set?

Virtual machine scale sets in Azure are designed to allow you to deploy and manage many load-balanced, identical virtual machines running with the same configurations. Virtual machine scale sets are intelligent enough to automatically scale up or down the total number of virtual machine instances. A scale set can also change the size of virtual machine instances.

The criteria used to activate up or downscale can depend on actual demand and usage, or on a customized schedule. Scale sets apply the same configuration to a group of virtual machines simultaneously, rather than requiring that you manually configure each instance individually.

A scale set uses a load-balancer to distribute requests across the virtual machine instances. A scale set uses a health probe  to determine the availability of each instance. The health probe *pings* the instance. If the instance responds, the scale set knows the instance is still available. If the ping fails or times out, the scale set knows the instance is unavailable. The scale set will avoid sending requests to this instance.

Virtual machine scale sets support both Linux and Windows virtual machines in Azure. However, keep in mind that you are limited to 1,000 virtual machines running on a single scale set.

Scale sets are great candidates when you're dealing with large workloads that have varying and unpredictable demand. Because virtual machine scale sets offer identical virtual machines scaled and load-balanced in response to demand, they automatically provide a highly available environment.

## Scaling options for scale sets

Scale sets are designed for cost-effectiveness. New virtual machine instances are only created when needed. There are two ways a scale set can scale virtual machines;  **horizontal scaling** and **vertical scaling**.

### What is horizontal scaling?

Horizontal scaling adds more virtual machines to a scale set.

Sometimes, you may need to add or remove a number of the machines in a scale set, depending on demand. It might be that you don't need to run some of these machines during quieter periods of the week or day when there's less demand. You manually adjust the number of virtual machines in a scale set by increasing or decreasing the instance count. However, in many cases, it's a good idea to create rules that automatically add or remove virtual machines. These rules are based on metrics – they ensure that the right number of virtual machines are added, depending on the demand or schedule.  This process of adding or removing a number of virtual machines is called horizontal scaling.

### What is vertical scaling?

Vertical scaling adds more resources such as memory, CPU power, or disk space to the virtual machines.

In contrast to horizontal scaling, where new identical size virtual machines are added or removed from a  scale set to meet demand, vertical scaling is more focused on increasing the size of the actual virtual machines in the scale sets to meet performance demand.  For example, you might want to reduce the CPU performance of a group of virtual machines in a scale set.  In this case, you may not necessarily need an entire group of machines to be removed. In scale sets, you create rules based on metrics that automatically trigger an increase in the sizes of the VMs.  Vertical scaling typically requires rebooting the affected virtual machines in the scale set. This process can lead to a temporary degradation in performance across the scale set while the virtual machines are restarted.

## Scaling a scale-set

Virtual machine scale sets address the need to quickly create and manage the virtual machines for a fluctuating workload. You can configure two types of scaling for a scale-set:

- **Scheduled**. When you know there will be a spike in demand, you can proactively schedule the scale set to deploy one or *N* number of additional instances to fulfill the spike in traffic and then scale back down once the spike ends.

- **Autoscale**. Where the workload is variable, and not always able to be scheduled, you can employ metric based threshold scaling. This will horizontally scale-out based upon node utilization, then scale back in when the resources have returned to a baseline level.

Both these options address the requirement to scale while managing the costs associated with that. The following examples describe scenarios where you might employ the different types of scaling.

### Scheduled scaling

Suppose you're part of the DevOps team for a large food delivery company. Friday night is typically your busiest time, and conversely, 7AM on a Wednesday is generally your quietest time. Azure charges based on consumption of resources, so don't run services you're not going to need. If you require 100 web servers to meet your demand on a Friday night, you're happy to pay for them. However, if you only need two servers on a Wednesday morning, you don't want to pay for the additional 98 idle servers. To manage your costs while fulfilling operational requirements, you might look to use scheduled autoscaling.

### Autoscaling

Suppose you're on the DevOps team for a popular footwear company. There's a product launch coming up and you believe there will be a significant demand for your service. However, the nature of the spike in demand might be unpredictable and hard to quantify. You want the service to meet demand by scaling horizontally as the current resources are used. Use metrics-based autoscaling for this scenario. This type of autoscaling scales out your infrastructure as demand rises, and scales back in when it declines.

## Reduce costs using low-priority scale sets

A low-priority virtual machine scale set allows you to use Azure compute at reduced cost savings of up to 80 percent. The global Azure infrastructure frequently has underused compute resources available. A low-priority scale set has virtual machines that are provisioned through this underused compute capability.

When you use these virtual machines, you have to keep in mind that they are temporary and availability depends on size, region, time of day, and so on. There is also no SLA for these virtual machines.

When this computing power is needed again by Azure, you'll receive a notification that a specific virtual machine will be removed from your scale set. If you need to perform clean-up or gracefully exit code on your virtual machine, you can use Azure scheduled events to react to this notification within the virtual machine. You can also instruct the scale set to try and create another virtual machine to replace the one that's being removed. The creation of the new virtual machine is, however, not guaranteed.

In a low-priority scale set, you specify two kinds of removal:

- **Delete** – the entire virtual machine is removed, including all of the underlying disks.

- **Deallocate** – the virtual machine is halted, and the processing and memory resources are deallocated. Disks are left intact so the data is kept. You're charged for the disk space while the virtual machine isn't running.  

Low-priority scale sets are useful for workloads that run with interruptions or when you need to use larger virtual machines at a much-reduced cost. However, you have to keep in mind that you can't control when a virtual machine might be removed.
