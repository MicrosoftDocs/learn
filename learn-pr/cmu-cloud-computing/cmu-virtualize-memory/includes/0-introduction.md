The next resource we will examine, with respect to virtualization, is memory. Memory virtualization should ring a bell; specifically, it is very closely related to the OS concept of virtual memory! As such, we will begin our discussion by recalling virtual memory concepts and then discuss memory virtualization as an extension of these techniques. VMware has pioneered some interesting and clever techniques in the realm of memory reclamation from guest OSs, which will also be covered in this module. 

## Learning objectives

In this module, you will:

- Identify how most general-purpose OSs support virtual memory.
- Discuss the one-level page mapping between virtual and physical addresses.
- Identify the difference between one-level page mapping, as provided in traditional OSs, and two-level page mapping, as provided in system memory virtualization.
- Discuss multiple-level page mapping as implied by various virtualized environments, such as native and user-mode hosted virtualized systems.
- Define memory overcommitment, and discuss the benefits it provides to virtualized systems.
- Describe what reclamation techniques are and why they are needed.
- Explain memory ballooning in VMware ESXi as an example of a reclamation technique.

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
