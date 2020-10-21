One possible solution to Tailwind Traders' lack of physical servers is through the use of virtual machines (VMs).

:::row:::
  :::column span="3":::

With Azure Virtual Machines, you can create and use VMs in the cloud. VMs provide infrastructure as a service (IaaS) in the form of a virtualized server and can be used in many ways. Just like a physical computer, you can customize all of the software running on the VM. VMs are an ideal choice when you need:

- Total control over the operating system (OS).
- The ability to run custom software.
- To use custom hosting configurations.

An Azure VM gives you the flexibility of virtualization without having to buy and maintain the physical hardware that runs the VM. You still need to configure, update, and maintain the software that runs on the VM.

  :::column-end:::
  :::column:::
    :::image type="icon" source="../media/azure-vms.png" border="false":::
  :::column-end:::
:::row-end:::

You can create and provision a VM in minutes when you select a preconfigured VM image. Selecting an image is one of the most important decisions you'll make when you create a VM. An image is a template used to create a VM. These templates already include an OS and often other software, like development tools or web hosting environments.

### Examples of when to use VMs

- **During testing and development.** VMs provide a quick and easy way to create different OS and application configurations. Test and development personnel can then easily delete the VMs when they no longer need them.
- **When running applications in the cloud.** The ability to run certain applications in the public cloud as opposed to creating a traditional infrastructure to run them can provide substantial economic benefits. For example, an application might need to handle fluctuations in demand. Shutting down VMs when you don't need them or quickly starting them up to meet a sudden increase in demand means you pay only for the resources you use.
- **When extending your datacenter to the cloud.** An organization can extend the capabilities of its own on-premises network by creating a virtual network in Azure and adding VMs to that virtual network. Applications like SharePoint can then run on an Azure VM instead of running locally. This arrangement makes it easier or less expensive to deploy than in an on-premises environment.
- **During disaster recovery.** As with running certain types of applications in the cloud and extending an on-premises network to the cloud, you can get significant cost savings by using an IaaS-based approach to disaster recovery. If a primary datacenter fails, you can create VMs running on Azure to run your critical applications and then shut them down when the primary datacenter becomes operational again.

## Move to the cloud with VMs

VMs are also an excellent choice when you move from a physical server to the cloud (also known as lift and shift). You can create an image of the physical server and host it within a VM with little or no changes. Just like a physical on-premises server, you must maintain the VM. You update the installed OS and the software it runs.

## Scale VMs in Azure

You can run single VMs for testing, development, or minor tasks. Or you can group VMs together to provide high availability, scalability, and redundancy. No matter what your uptime requirements are, Azure has several features that can meet them. These features include:

- Virtual machine scale sets
- Azure Batch

[//]: # (NOTE: REMOVED THE FOLLOWING)
[//]: # (- Availability sets)
[//]: # (### What are availability sets?)
[//]: # (An **availability set** is a logical grouping of two or more VMs that help keep your application available during planned or unplanned maintenance.)
[//]: # (- A _planned maintenance event_ is when the underlying Azure fabric that hosts VMs is updated by Microsoft. A planned maintenance event is done to patch security vulnerabilities, improve performance, and add or update features. Most of the time these updates are done without any impact to the guest VMs. But sometimes VMs require a reboot to complete an update. When the VM is part of an availability set, the Azure fabric updates are sequenced so not all of the associated VMs are rebooted at the same time. VMs are put into different _update domains_. Update domains indicate groups of VMs and underlying physical hardware that can be rebooted at the same time. Update domains are a logical part of each datacenter and are implemented with software and logic.)
[//]: # (- _Unplanned maintenance events_ involve a hardware failure in the datacenter, such as a power outage or disk failure. VMs that are part of an availability set automatically switch to a working physical server so the VM continues to run. The group of virtual machines that share common hardware are in the same _fault domain_. A fault domain is essentially a rack of servers. It provides the physical separation of your workload across different power, cooling, and network hardware that support the physical servers in the datacenter server racks. In the event the hardware that supports a server rack becomes unavailable, only that rack of servers is affected by the outage.)
[//]: # (With an availability set, you get:)
[//]: # (- Up to three fault domains that each have a server rack with dedicated power and network resources)
[//]: # (- Five logical update domains which then can be increased to a maximum of 20)
[//]: # (Your VMs are then sequentially placed across the fault and update domains. The following diagram shows an example where you have six VMs in two availability sets distributed across the two fault domains and five update domains.)
[//]: # (:::image type="complex" source="../media/availability-sets.png" alt-text="Diagram showing availability sets update and fault domains that are duplicated across servers.":::)
[//]: # (Two outlines surround fault domain 1 and fault domain 2. Fault domain 1 contains a rack with virtual machine 1 inside update domain 1, virtual machine 3 inside update domain 3, and virtual machine 5 inside update domain 5. Fault domain 2 contains a rack with virtual machine 2 inside update domain 2, virtual machine 4 inside update domain 4, and virtual machine 6 as part of update domain 1. Virtual machine 1 from fault domain 1 and virtual machine 2 from fault domain 2 are part of an availability set. Virtual machine 3 and 5 from fault domain 1 and virtual machine 4 and 6 from fault domain 2 are part of a separate availability set.)
[//]: # (:::image-end:::)
[//]: # (There's no cost for an availability set. You only pay for the VMs within the availability set. We highly recommend that you place each workload in an availability set to avoid having a single point of failure in your VM architecture.)

### What are virtual machine scale sets?

Virtual machine scale sets let you create and manage a group of identical, load-balanced VMs. Imagine you're running a website that enables scientists to upload astronomy images that need to be processed. If you duplicated the VM, you'd normally need to configure an additional service to route requests between multiple instances of the website. Virtual machine scale sets could do that work for you.

Scale sets allow you to centrally manage, configure, and update a large number of VMs in minutes to provide highly available applications. The number of VM instances can automatically increase or decrease in response to demand or a defined schedule. With virtual machine scale sets, you can build large-scale services for areas such as compute, big data, and container workloads.

### What is Azure Batch?

Azure Batch enables large-scale parallel and high-performance computing (HPC) batch jobs with the ability to scale to tens, hundreds, or thousands of VMs.

When you're ready to run a job, Batch does the following:

- Starts a pool of compute VMs for you.
- Installs applications and staging data.
- Runs jobs with as many tasks as you have.
- Identifies failures.
- Requeues work.
- Scales down the pool as work completes.

There might be situations in which you need raw computing power or supercomputer-level compute power. Azure provides these capabilities.
