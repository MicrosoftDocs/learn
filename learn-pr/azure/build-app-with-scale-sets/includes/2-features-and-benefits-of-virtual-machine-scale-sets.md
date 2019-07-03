A virtual machine scale set provides a platform for hosting highly scalable applications. Each virtual machine has the same configuration, and work is load-balanced evenly across all machines in the scale set. You can scale a virtual machine scale set manually, but it's more common to use autoscaling. You autoscale based on a schedule, or by using metrics that indicate how heavily resources are currently being used.

In the example scenario, the shipping company wants to use a virtual machine scale set to handle the fluctuating load while maintaining a low response time for customer requests.

In this unit, you'll explore the features of virtual machine scale sets. By the end of this unit, you'll be able to:

- Explain horizontal versus vertical scaling.
- Describe the virtual machine scale set offerings, including scheduled and metrics-based autoscaling.
- Explain the low-priority scale set offering.
- Describe when to use the different kinds of autoscaling.

## What is a virtual machine scale set?

Virtual machine scale sets in Azure are designed to allow you to have many load-balanced, identical virtual machines running with the same configurations. Virtual machine scale sets are clever enough to automatically scale up or down the amount, or size, of virtual machine instances running – depending on actual demand and usage. You use scale sets to scale up and down automatically based on a customized schedule.  Scale sets can also apply the same configuration to a group of virtual machines simultaneously, rather than having to manually configure each one individually. You can have up to 1,000 virtual machines running on a single scale set.

Scale sets are great candidates when you're dealing with large workloads that have varying and unpredictable demand.  Because virtual machine scale sets offer identical virtual machines scaled and load-balanced appropriately in response to demand, they automatically provide a highly available environment.  

Virtual machine scale sets are supported for both Linux virtual machines and Windows virtual machines in Azure.

## Autoscale for different use cases using scale sets

Scale sets help you become cost effective because they create new virtual machine instances only when they're needed.  There are two ways a virtual machine scale set can scale – horizontal scaling, and vertical scaling. Horizontal scaling adds more virtual machines to a scale set, but vertical scaling adds more resources (memory, CPU power, disk space) to the virtual machines.

Sometimes, you may need to add or remove a number of the machines in a scale set, depending on demand. It might be that you don't need to run some of these machines during quieter periods of the week or day when there's less demand. You manually adjust the number of virtual machines in a scale set by increasing or decreasing the instance count. However, in many cases, it's a good idea to create rules that automatically add or remove virtual machines. These rules are based on metrics – they ensure that the right number of virtual machines are added, depending on the demand or schedule.  This process of adding or removing a number of virtual machines is called horizontal scaling.

In contrast to horizontal scaling, where new identical size virtual machines are added or removed from a  scale set to meet demand, vertical scaling is more focused on increasing the size of the actual virtual machines in the scale sets to meet performance demand.  For example, you might want to reduce the CPU performance of a group of virtual machines in a scale set.  In this case, you may not necessarily need an entire group of machines to be removed. In scale sets, you create rules based on metrics that automatically trigger an increase in the sizes of the VMs.  Vertical scaling typically requires rebooting the affected virtual machines in the scale set. This process can lead to a temporary degradation in performance across the scale set while the virtual machines are restarted.

You trigger autoscaling based either on a schedule or on actual usage. Below are examples of when you might employ both types of autoscale triggering.

**Use case 1**

You're part of the DevOps team for a large food delivery company.  Friday night is typically your busiest time, and conversely, 7AM on a Wednesday is generally your quietest time. Azure charges based on consumption of resources,  so don't run services you're not going to need. If you require 100 web servers to meet your demand on a Friday night, you're happy to pay. However, if you only need two servers on a Wednesday morning, you don't want to pay for the additional 98 idle servers. To manage your costs while fulfilling operational requirements, you might look to use scheduled autoscaling.

**Use case 2**

You're on the DevOps team for a popular footwear company.  There's a product launch coming up and you believe there will be a significant demand for your service. However, the nature of the spike in demand might be unpredictable and hard to quantify.   You want the service to meet demand by scaling horizontally as the current resources are used. Use metrics-based autoscaling for this scenario. This type of autoscaling scales out your infrastructure as demand rises, and scales back in when it declines.

## Reduce costs using low-priority scale sets

With a low-priority virtual machine scale set, you can use Azure compute at reduced cost savings of up to 80 percent.  The global Azure infrastructure frequently has underused compute resources available. A low-priority scale set has virtual machines that are provisioned through this underused compute capability.

When this computing power is needed again by Azure, you'll receive a notification that a specific virtual machine will be removed from your scale set by Azure. You use webhooks and other mechanisms to respond to this notification. You can also instruct the scale set to create another VM to replace the one that's being removed.

In a low-priority scale set, you specify two kinds of removal:

- **Delete** – the entire virtual machine is removed, including all of the underlying disks.

- **Deallocate** – the virtual machine is halted, and the processing and memory resources are deallocated. Disks are left intact so the data is kept. You're charged for the disk space while the virtual machine isn't running.  

Low-priority scale sets are useful for workloads that run with interruptions – but remember that you can't control when a virtual machine might be removed. Low-priority scale sets are also a great way to try using larger virtual machines at a much more reduced cost.
