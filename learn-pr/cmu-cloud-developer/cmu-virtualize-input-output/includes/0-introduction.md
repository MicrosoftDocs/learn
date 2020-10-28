Our final segment in resource virtualization concerns I/O devices. In this respect, we can consider the VMM or hypervisor the arbiter of communication between multiple guests and the physical hardware, multiplexing the usage (in time, space, or both), depending on the actual device being shared. 

The virtualization strategy for a given I/O device type consists of two steps: 

1. Construct a virtual version of a device. 
1. Virtualize the I/O activity routed to that device.

Typical I/O devices include disks, network cards, displays, and keyboards. As discussed previously, the hypervisor might create a virtual display as a window on a physical display. In addition, a virtual disk can be created by assigning to it a fraction of the physical disk's storage capacity. After constructing virtual devices, the hypervisor ensures that each I/O operation is carried out within the bounds of the requested virtual device. For instance, if a virtual disk is allocated 100 cylinders from among 1,000 cylinders provided by a physical disk, the hypervisor guarantees that no I/O request intended for that virtual disk can access any cylinder other than the 100 assigned to it. More precisely, the disk location in the issued I/O request will be mapped by the hypervisor to only the area where the virtual disk has been allocated on the physical disk. 

Next, we cover some I/O basics and then move on to the details of I/O virtualization. We will examine the case of Xen Project, and how it handles I/O virtualization.

## Learning objectives

In this module, you will:

- Recognize how CPU and I/O devices communicate in traditional systems.
- Identify how many I/O device drivers can/should be supported per physical device for different virtualized systems, such as native and dual-mode hosted virtualized systems.
- Recognize the need for and ease of intercepting I/O requests by the hypervisor.
- Identify at which system interfaces the hypervisor can intercept I/O requests.
- Explain the pros and cons of intercepting I/O requests at different system interfaces.
- Describe the overall I/O virtualization process as applied to a network interface card.
- Review Xen Project's approach to I/O virtualization.

## Prerequisites

- Understand what cloud computing is, including cloud service models and common cloud providers.
- Know the technologies that enable cloud computing.
- Understand how cloud service providers pay for and bill for the cloud.
- Know what datacenters are and why they exist.
- Know how datacenters are set up, powered, and provisioned.
- Understand how cloud resources are provisioned and metered.
- Be familiar with the concept of virtualization.
- Know what the different types of virtualization are.
- Understand CPU virtualization.
- Understand memory virtualization.
- Understand I/O virtualization.
