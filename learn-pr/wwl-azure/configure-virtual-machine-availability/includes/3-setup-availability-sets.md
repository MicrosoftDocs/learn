An **Availability Set** is a logical feature used to ensure that a group of related VMs are deployed so that they aren't all subject to a single point of failure and not all upgraded at the same time during a host operating system upgrade in the datacenter. VMs placed in an availability set should perform an identical set of functionalities and have the same software installed.

Azure ensures that the VMs you place within an Availability Set run across multiple physical servers, compute racks, storage units, and network switches. If a hardware or Azure software failure occurs, only a subset of your VMs are impacted. Your application stays up and continues to be available to your customers.

Availability Sets are an essential capability when you want to build reliable cloud solutions. Keep these general principles in mind.

 -  For redundancy, configure multiple virtual machines in an Availability Set.
 -  Configure each application tier into separate Availability Sets.
 -  Combine a Load Balancer with Availability Sets.
 -  Use managed disks with the virtual machines.

You create Availability Sets through the Azure portal in the disaster recovery section. Also, you can build Availability Sets using Resource Manager templates. scripting, or API tools.

:::image type="content" source="../media/availability-sets-4e3b2af6.png" alt-text="Screenshot of the create an availability set in the portal.":::


## Service Level Agreements (SLAs)

 -  For all Virtual Machines that have two or more instances deployed across two or more Availability Zones in the same Azure region, we guarantee you will have Virtual Machine Connectivity to at least one instance at least 99.99% of the time.
 -  For all Virtual Machines that have two or more instances deployed in the same Availability Set, we guarantee you will have Virtual Machine Connectivity to at least one instance at least 99.95% of the time.
 -  For any Single Instance Virtual Machine using premium storage for all Operating System Disks and Data Disks, we guarantee you will have Virtual Machine Connectivity of at least 99.9%.

> [!NOTE]
> You can create a virtual machine and an Availability Set at the same time. A VM can only be added to an Availability Set when it is created. To change the Availability Set, you need to delete and then recreate the virtual machine.
