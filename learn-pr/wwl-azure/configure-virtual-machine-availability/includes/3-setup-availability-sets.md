An availability set is a logical feature you can use to ensure a group of related virtual machines are deployed together. The grouping helps to prevent a single point of failure from affecting all of your machines. The grouping ensures that not all of the machines are upgraded at the same time during a host operating system upgrade in the datacenter. 

### Things to know about availability sets

Let's review some characteristics of availability sets.

- All virtual machines in an availability set should perform the identical set of functionalities.

- All virtual machines in an availability set should have the same software installed.

- Azure ensures that virtual machines in an availability set run across multiple physical servers, compute racks, storage units, and network switches.

   If a hardware or Azure software failure occurs, only a subset of the virtual machines in the availability set are affected. Your application stays up and continues to be available to your customers.

- You can create a virtual machine and an availability set at the same time.

   A virtual machine can only be added to an availability set when the virtual machine is created. To change the availability set for a virtual machine, you need to delete and then recreate the virtual machine.

- You can build availability sets by using the Azure portal, Azure Resource Manager (ARM) templates, scripting, or API tools.

- Microsoft provides robust Service Level Agreements (SLAs) for Azure virtual machines and availability sets. For details, see [SLA for Azure Virtual Machines](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_9/).

> [!NOTE]
> Adding your virtual machines to an availability set won't protect your applications from operating system or application-specific failures.
> You'll need to explore other disaster recovery and backup techniques to provide application-level protection.

### Things to consider when using availability sets

Availability sets are an essential capability when you want to build reliable cloud solutions. In your planning for availability sets, keep the following general principles in mind:

- **Consider redundancy**. To achieve redundancy in your configuration, place multiple virtual machines in an availability set.

- **Consider separation of application tiers**. Each application tier exercised in your configuration should be located in a separate availability set. The separation helps to mitigate single point of failure on all machines.

- **Consider load balancing**. For high availability and network performance, create a load-balanced availability set by using Azure Load Balancer. Load Balancer distributes incoming traffic across working instances of services that are defined in your load-balanced availability set.

- **Consider managed disks**. You can use Azure managed disks with your Azure virtual machines in availability sets for block-level storage.