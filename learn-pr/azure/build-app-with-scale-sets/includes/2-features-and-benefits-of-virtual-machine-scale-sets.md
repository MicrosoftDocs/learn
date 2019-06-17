<!--Introductory paragraph topic sentence

Summary: A sentence that helps the learner prepare for the upcoming content. This makes sure to set the learner's expectations about what they're going to accomplish.

Scenario sub-task

Summary: A couple of sentences that specifies which section of the overall module scenario will be covered in this unit.

Task the learner will learn to accomplish

Summary: A sentence that describes the content the learner will know by the end of the unit.
 
Optional image](./media/optional-image.png)-->

## [Chunk title]

Required explanatory paragraph

<!--Explanatory paragraph-->

<!--Explanatory paragraph-->

<!--[Optional image](./media/optional-image.png)-->

## [Chunk title]

Required explanatory paragraph

<!--Optional explanatory paragraph-->

<!--Optional explanatory paragraph-->

<!--[Optional image](./media/optional-image.png)-->

## [Chunk title]

Required explanatory paragraph

<!--Optional explanatory paragraph-->

<!--Optional explanatory paragraph-->

<!--[Optional image](./media/optional-image.png)-->

## [Chunk title]

Required explanatory paragraph

<!--Optional explanatory paragraph-->

<!--Optional explanatory paragraph-->

<!--[Optional image](./media/optional-image.png)-->

<!-- Optional knowledge check -->

## Notes from design doc
**Features and benefits of virtual machine scale sets**

In this unit, you'll explore the features of virtual machine scale sets. By the end of this unit, you'll be able to:

*   Understand the virtual machine scale set offerings, including scheduled and autoscaling.
*   Understand Horizontal-vs-Vertical scaling.
*   Understand the Low-Priority Scale Set offering.

Cover the following points:

*   What is an virtual machine scale set (virtual machine scale set)

    *   A scale set is a group of identically configured virtual machines for horizontal scaling within Azure
    *   It can be used to provide a Highly Available environment while introducing the potential for scaling to meet planned and unplanned demand.
    *   Horizontal scaling is deploying multiple matching instances of a server to achieve load balancing and load sharing.  This differs from Vertical sharing, which is increasing the physical amount of CPU and memory on the VM and typically require outage in the form of a reboot.
    *   Virtual machine scale sets address the need to quickly create and manage the VMs for a workload, which fluctuates in load. This can be achieved via:

    *   A scheduled configuration. When you know there will be a spike in demand, you can proactively schedule the scale set to deploy one or N number of additional instances to fulfill the spike in traffic and then scale back down once the spike ends.
    *   Autoscaling.  Where the workload is variable, and not always able to be scheduled, you can employ metric based threshold scaling.  This will horizontally scale out based upon node utilization,  then scale back in when the resources have returned to a baseline level.
    *   Both these options address the requirement to scale while managing the costs associated with that.
    *   Supported on both Windows platform and Linux
*   Use case 1

    *   Suppose you are a DevOps for a large food delivery company.  Friday night is typically your busiest time, and conversely, 7 am on a Wednesday generally is your quietest time, which dictates different requirements for your computational resources. As Azure charges based upon consumption of resources,  as such you don't want to have services running which you don't need. If you need 100 hundred web servers to meet your demand on a Friday night, you are happy to pay for this requirement. However, if you only need two servers to fulfill your requirement on a Wednesday morning - you don't want to have to pay for the additional 98 servers. To optimize spend while fulfilling your operational requirements, you look to use a scheduled Azure Virtual Machine Set.
*   Use case 2

    *   Suppose you are a DevOps for a popular footwear company.  You have a product launch approaching and believe there will be a significant demand for your service, but the nature of the spike in demand may be unpredictable and hard to quantify.   You want the service to meet the demand by organically horizontally scaling as the current resource is utilized. For this, you look to use metrics-based autoscaling, to scale out your infrastructure as demand rises, and to scale in when that demand reduces.
*   What is a 'Low Priority' virtual machine scale set

    *   Offers the opportunity for significant cost savings by utilizing compute power of unutilized capacity within Azure without any availability guarantees.
    *   This is a pets-vs-cattle outlook, where this is the cattle outlook of employing a herd of instances to achieve your desired workload.
    *   It offers two options: Deallocation or Delete. Deallocate will retain the data, in case you wished to bring back up the VM to complete its workload
    *   This feature is currently in preview and is designed for workloads, which can handle interruption, as instances can be evicted at any time.
