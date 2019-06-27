A virtual machine scale-set provides a platform for hosting highly scalable applications. Each virtual machine has the same configuration, and work is load-balanced evenly across all machines in the scale set. You can scale a virtual machine scale set manually, but a more common approach is to use autoscaling. You can autoscale based on a schedule, or by using metrics that indicate how heavily resources are currently being used.

In the example scenario, the shipping company is looking to use a virtual machine scale set to handle the fluctuating load while maintaining a low response-time for customer requests.

In this unit, you'll explore the features of virtual machine scale sets. By the end of this unit, you'll be able to:

- Understand the virtual machine scale set offerings, including scheduled and metrics-based autoscaling.
- Understand horizontal-vs-vertical scaling.
- Understand the low-priority scale set offering.
- Understand when to use the different kinds of autoscaling.

## What is a virtual machine scale set?

Virtual machine scale sets in Azure are designed to make it possible for you to have many load balanced, identical virtual machines running with the same configurations. Virtual machine scale sets are clever enough to automatically scale up or down the amount, or size of virtual machine instances running, depending on the actual demand and usage. Scale sets also let you scale up and down automatically based on a customized schedule.  In addition, with scale sets can apply the same configuration to a group of virtual machines simultaneously, rather than having to manually configure each virtual machine individually. You can have up to a thousand virtual machines running on a single scale set.

Scale sets are great candidates for when you're dealing with large workloads with varying and unpredictable demand.  Because virtual machine scale sets offer identical virtual machines scaled and load balanced appropriately in response to demand, they automatically provide an environment that is highly available.  

Virtual machine scale sets are supported for both Linux virtual machines and Windows virtual machines in Azure.

## Autoscale for different use cases using scale sets

Scale sets can help you become cost effective because they can allocate new virtual machine instances only when they're needed.  There are two ways a virtual machine scale set can scale. These are horizontal scaling, and vertical scaling. Horizontal scaling adds more virtual machines to a scale set, but vertical scaling adds more resources (memory, CPU power, disk space) to the virtual machines.

Sometimes, you may need to add or remove a number of the machines in a scale set depending on demand. It may be the case that you don't need to run some of these machines during quieter periods of the week or day where there's less demand. You can manually adjust the number of virtual machines in a scale set by increasing or decreasing the instance count. However, in many cases, it would be a good idea  to create rules that automatically add or remove virtual machines. These rules are based on metrics. They can ensure that the right number of virtual machines are added depending on the demand or schedule.  The process of adding or removing a number of virtual machines in this way is referred to as horizontal scaling.

In contrast to horizontal scaling where new identical size virtual machines are added or removed from a  scale set to meet demand, vertical scaling is more focused on increasing the size of the actual virtual machines in the scale sets to meet performance demand.  For example, in some cases you may want to reduce the CPU performance of a group of virtual machines in a scale set.  In this case, you may not necessarily need an entire group of machines to be removed. In scale sets, you can create rules based on metrics that automatically trigger an increase in the sizes of the VMs.  Vertical scaling typically requires rebooting the affected virtual machines in the scale set. This can lead to a temporary degradation in performance across the scale set while the virtual machines are restarted.

Autoscaling can be triggered based on a schedule or based on actual usage. Below are examples of when you might employ both types of autoscale triggering.

**Use case 1**

Suppose you are part of the DevOps team for a large food delivery company.  Friday night is typically your busiest time, and conversely, 7 am on a Wednesday generally is your quietest time. Azure charges based upon consumption of resources,  as such you don't want to have services running which you don't need. If you need 100 web servers to meet your demand on a Friday night, you are happy to pay for this requirement. However, if you only need two servers to fulfill your requirement on a Wednesday morning, you don't want to have to pay for the additional 98 idle servers. To optimize spend while fulfilling your operational requirements, you might look to use scheduled autoscaling.

**Use case 2**

Suppose you are on the DevOps team for a popular footwear company.  You have a product launch approaching and believe there will be a significant demand for your service, but the nature of the spike in demand may be unpredictable and hard to quantify.   You want the service to meet the demand by scaling horizontally as the current resources are utilized. Use metrics-based autoscaling in this scenario. This type of autoscaling will scale out your infrastructure as demand rises, and scale back in when that demand declines.

## Reduce costs using low-priority scale sets

With a low-priority virtual machine scale set, you can use Azure compute at reduced costs savings of up to 80%.  The global Azure infrastructure frequently has underused compute resources available. A low-priority scale set has virtual machines that are provisioned through this underused compute capability.

Once this computing power is needed again by Azure, you'll receive a notification to tell you that a specific virtual machine will be removed from your scale set by Azure. You can use webhooks and other mechanisms to respond to this notification. You can also instruct the scale set to create another VM to replace the one that is being removed from the scale set.

When you use a low-priority scale set, you can specify two kinds of removal:

- Delete. In this case the entire virtual machine is removed, including all of the underlying disks.

- Deallocate. The virtual machine is halted and the processing and memory resources are deallocated. The disks are left intact and so the data is retained. You're charged for the disk space while the virtual machine isn't running.  

Low-priority scale sets are a useful feature for workloads that can run with interruptions. Just remember that you don't have any control of when a virtual machine might be removed. Low-priority scale sets are also a great way to try using bigger sized virtual machines at a much more reduced cost.
