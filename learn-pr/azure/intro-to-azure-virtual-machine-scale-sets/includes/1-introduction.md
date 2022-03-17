You're responsible for many production applications at Adatum, a company that designs and builds recreational submarines. Currently, Adatum has several three-tier applications that run on IaaS virtual machines that have been migrated from on-premises datacenters that are hosted across various Azure virtual networks. You want to determine if Azure virtual machine scale sets might be useful in resolving the following performance and cost challenges:

- One application regularly exceeds processor loads for as long as two hours. During this time, the application is frustrating and non-responsive. The application functions normally when client traffic returns to normal.
- Another application has regular traffic spikes on Friday evenings and lulls on Wednesday mornings. You’d like to ensure that the required instances are available to address increases and decreases in demand.
- You want to ensure that no matter how much client load is placed on applications, no more than 50 instances are deployed in a scale set to control costs.
- You have one application on a single virtual machine (VM) that doesn't experience variance in utilization and doesn't have an architecture that lets it be load balanced.
- You have one application on a single VM that is only used during business hours by a limited number of people.

Azure virtual machine scale sets let you create and manage a group of load balanced VMs. The number of VM instances can automatically increase or decrease in response to demand or a defined schedule.

Scale sets provide high availability to your applications, and you can centrally manage, configure, and update a large number of VMs. With virtual machine scale sets, you can build large-scale services for areas such as compute, big data, and container workloads.

This module explains what Azure virtual machine scale sets do, how they work, and when you should choose to use Azure virtual machine scale sets as a solution to meet your organization's needs.

## Learning objectives

In this module, you'll:

- Learn what Azure virtual machine scale sets are and the functionality they provide
- Determine whether Azure virtual machine scale sets meet the needs of your organization
- Understand the difference between using virtual machine scale sets and scaling up individual instances

## Prerequisites

Understanding of basic networking and virtual machine compute concepts
