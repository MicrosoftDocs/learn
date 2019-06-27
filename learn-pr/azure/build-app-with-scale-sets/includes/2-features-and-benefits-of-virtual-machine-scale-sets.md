In this unit, you'll explore the features of virtual machine scale sets. By the end of this unit, you'll be able to:

- Understand the virtual machine scale set offerings, including scheduled and autoscaling.
- Understand horizontal-vs-vertical scaling.
- Understand the low-priority scale set offering.
- Understand when to use the different kinds of autoscaling. 



## What is a virtual machine scale set 

Virtual machine scale sets in Azure are designed to make it possible for you to have many load balanced, identical virtual machines running with the same configurations. Virtual machine scale sets are clever enough to automatically scale up or down the amount, or size of virtual machine instances running, depending on the actual demand and usage. Scale sets also let you scale up and down automatically based on a customized schedule.  In addition, with scale sets you are able to apply configurations to a group of virtual machines simultaneously rather than having to manually apply those configurations on an individual level on each virtual machine. You can have up to a thousand virtual machines running on a single scale set. 

Scale sets are great candidates for when you're dealing with large workloads with varying and unpredictable demand.  Because virtual machine scale sets offer identical virtual machines scaled and load balanced appropriately in response to demand, they automatically provide an environment that is highly available.  

Virtual machine scale sets are supported for both Linux virtual machines and Windows virtual machines in Azure. 



## Autoscale for different use cases using scale sets

Scale sets can help you become cost effective because they are clever enough to allow you to scale to meet demand when it is needed.  There are two ways a virtual machine scale set can scale. These are horizontal scaling, and vertical scaling. 

Sometimes, you may need to add or remove a number of the machines in a scale set depending on demand. It may be the case that you do not need to run some of these machines during quieter periods of the week or day where there is less demand. In these cases it would be a good idea  to create rules that automatically remove a number of virtual machines that are not needed during this period. These rules based on metrics also can ensure that the right number of virtual machines are added depending on the demand or schedule.  The process of adding or removing a number of virtual machines in this way is referred to as horizontal scaling. 

In contrast to horizontal scaling where new identical size virtual machines are added or removed from a  scale set to meet demand, vertical scaling is more focused on increasing the size of the actual virtual machines in the scale sets to meet performance demand.  For example, in some cases you may want to decrease the CPU performance of a group of virtual machines in a scale set.  In this case you may not necessarily need an entire group of machines to be removed. In scale sets, you can create rules based on metrics that automatically trigger an increase in the sizes of the VMs.  Vertical scaling typically requires reboots on the affected virtual machines in the scale set. 

Autoscaling can be triggered based on a schedule or based on actual usage. Below are examples of when you might employ both types of autoscale triggering. 

**Use case 1**

Suppose you are part of the DevOps team for a large food delivery company.  Friday night is typically your busiest time, and conversely, 7 am on a Wednesday generally is your quietest time, which dictates different requirements for your computational resources. Azure charges based upon consumption of resources,  as such you don't want to have services running which you don't need. If you need one hundred web servers to meet your demand on a Friday night, you are happy to pay for this requirement. However, if you only need two servers to fulfill your requirement on a Wednesday morning - you don't want to have to pay for the additional 98 servers. To optimize spend while fulfilling your operational requirements, you look to use a scheduled Azure Virtual Machine Set.

**Use case 2**

Suppose you are on the DevOps team for a popular footwear company.  You have a product launch approaching and believe there will be a significant demand for your service, but the nature of the spike in demand may be unpredictable and hard to quantify.   You want the service to meet the demand by organically horizontally scaling as the current resource is utilized. For this, you look to use metrics-based autoscaling, to scale out your infrastructure as demand rises, and to scale in when that demand reduces. 



## Reduce costs using low-priority scale sets 

With a low-priority virtual machine scale set, you can use Azure compute at reduced costs savings of up to 80%.  Azure so large, that it can have underused compute. A low-priority scale set has virtual machines that are provisioned through this underused compute capability. 

Once this compute is needed again by Azure, you will receive a notification to tell you that a specific virtual machine will be removed from your scale set by Azure for use. You can use webhooks and other mechanisms to respond to this, and also instruct the scale set to create another VM to replace the one that was removed from the scale set.  Removal can be of two kinds: 

- Delete - here the entire virtual machine is removed, including all of the underlying disks.

- Deallocated - the virtual machine is simply deallocated, the disks are left intact and so the data is retained.  

This is a good feature that can be used for workloads that can work with interruptions. You do not have any control of when a virtual machine might be removed. It is also a great way to try bigger sized virtual machines at a much more reduced cost for a while.  This feature is currently in preview. 



