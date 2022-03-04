The virtual machine sizes supported on Azure Stack Hub are a subset of those supported on Azure. Azure imposes resource limits along many vectors to avoid overconsumption of resources (server local and service-level). Without imposing some limits on tenant consumption, the tenant experiences will suffer when other tenants overconsume resources. For networking egress from the virtual machine, there are bandwidth caps in place on Azure Stack Hub that match Azure limitations. For storage resources on Azure Stack Hub, storage IOPS limits avoid basic over consumption of resources by tenants for storage access.

## Virtual machine placement

The Azure Stack Hub placement engine places tenant virtual machines across the available hosts. Azure Stack Hub uses two considerations when placing virtual machines. One, is there enough memory on the host for that virtual machine type? And two, are the virtual machines a part of an availability set or are they virtual machine scale sets?

To achieve high availability of a multi-virtual machine production workload in Azure Stack Hub, virtual machines (VMs) are placed in an availability set that spreads them across multiple fault domains. A fault domain in an availability set is defined as a single node in the scale unit. Azure Stack Hub supports having an availability set with a maximum of three fault domains to be consistent with Azure. Virtual machines placed in an availability set will be physically isolated from each other by spreading them as evenly as possible over multiple fault domains (Azure Stack Hub nodes). If there's a hardware failure, virtual machines from the failed fault domain will be restarted in other fault domains. If possible, they'll be kept in separate fault domains from the other virtual machines in the same availability set. When the host comes back online, virtual machines will be rebalanced to maintain high availability.

Virtual machine scale sets use availability sets on the back end and make sure each virtual machine scale set instance is placed in a different fault domain. This means they use separate Azure Stack Hub infrastructure nodes. For example, in a four-node Azure Stack Hub system, there may be a situation where a virtual machine scale set of three instances will fail at creation due to the lack of the four-node capacity to place three virtual machine scale set instances on three separate Azure Stack Hub nodes. In addition, Azure Stack Hub nodes can be filled up at varying levels before trying placement.

## Consideration for total number of virtual machines (VMs)

There's a new consideration for accurately planning Azure Stack Hub capacity. There's a limit on the total number of virtual machines that can be created. This limit is intended to be temporary to avoid solution instability. The source of the stability issue at higher numbers of virtual machines is being addressed but a specific timeline for remediation hasn't been determined.

There's now a per-server limit of 60 virtual machines with a total solution limit of 700. For example, an eight-server Azure Stack Hub virtual machine limit would be 480 (8 \* 60). For a 12 to 16 server Azure Stack Hub solution, the limit would be 700. This limit has been created keeping all the compute capacity considerations in mind, such as the resiliency reserve and the CPU virtual-to-physical ratio that an operator would like to maintain on the stamp.

If the virtual machine scale limit is reached, the following error codes are returned as a result: `VMsPerScaleUnitLimitExceeded, VMsPerScaleUnitNodeLimitExceeded`.

## Azure Stack Hub memory

Azure Stack Hub is designed to keep virtual machines running that have been successfully provisioned. For example, if a host is offline because of a hardware failure, Azure Stack Hub will attempt to restart that virtual machine on another host. A second example during patching and updating of the Azure Stack Hub software. If there's a need to reboot a physical host, an attempt is made to move the virtual machines executing on that host to another available host in the solution.

This virtual machine management or movement can only be achieved if there's reserved memory capacity to allow for the restart or migration to occur. A portion of the total host memory is reserved and unavailable for tenant virtual machine placement.

You can review a pie chart in the administrator portal that shows the free and used memory in Azure Stack Hub. The following diagram shows the physical memory capacity on an Azure Stack Hub scale unit in the Azure Stack Hub:

:::image type="content" source="../media/compute-capacity-image-1-805ff521.png" alt-text="Physical memory capacity on an Azure Stack Hub scale unit":::


Used memory is made up of several components. The following components consume the memory in the use section of the pie chart:

 -  **Host OS usage or reserve**: The memory used by the operating system (OS) on the host, virtual memory page tables, processes that are running on the host OS, and the Spaces Direct memory cache. Since this value is dependent on the memory used by the different Hyper-V processes running on the host, it can fluctuate.
 -  **Infrastructure services**: The infrastructure virtual machines that make up Azure Stack Hub. This entails ~31 virtual machines that take up 242 GB + (4 GB x \# of nodes) of memory. The memory utilization of the infrastructure services component may change as we work on making our infrastructure services more scalable and resilient.
 -  **Resiliency reserve**: Azure Stack Hub reserves a portion of the memory to allow for tenant availability during a single host failure and during patch and update to allow for successful live migration of virtual machines.
 -  **Tenant virtual machines**: The tenant virtual machines created by Azure Stack Hub users. In addition to running virtual machines, memory is consumed by any virtual machines that have landed on the fabric. This means that virtual machines in "Creating" or "Failed" state, or virtual machines shut down from within the guest, will consume memory. However, virtual machines that have been deallocated using the stop deallocated option from portal/powershell/cli won't consume memory from Azure Stack Hub.
 -  **Value-add resource providers (RPs)**: virtual machines deployed for the value-add RPs like SQL, MySQL, App Service, and so on.

The best way to understand memory consumption on the portal is to use the [Azure Stack Hub Capacity Planner](https://aka.ms/azstackcapacityplanner) to see the impact of various workloads. The following calculation is the same one used by the planner.

This calculation results in the total available memory that can be used for tenant virtual machine placement. This memory capacity is for the entirety of the Azure Stack Hub scale unit.

Available memory for virtual machine placement = total host memory - resiliency reserve - memory used by running tenant virtual machines - Azure Stack Hub Infrastructure Overhead <sup>1</sup>

Resiliency reserve = **H + R \* ((N-1) \* H) + V \* (N-2)**

Where:

 -  **H** = Size of singl- server memory
 -  **N** = Size of Scale Unit (number of servers)
 -  **R** = The operating system reserve for OS overhead, which is .15 in this formula<sup>2</sup>
 -  **V** = Largest virtual machine in the scale unit

<sup>1</sup> Azure Stack Hub Infrastructure overhead = 242 GB + (4 GB x \# of nodes). Approximately 31 virtual machines are used to host Azure Stack Hub's infrastructure and, in total, consume about 242 GB + (4 GB x \# of nodes) of memory and 146 virtual cores. The rationale for this number of virtual machines is to satisfy the needed service separation to meet security, scalability, servicing, and patching requirements. This internal service structure allows for the future introduction of new infrastructure services as they're developed.

<sup>2</sup> Operating system reserve for overhead = 15% (.15) of node memory. The operating system reserve value is an estimate and will vary based on the physical memory capacity of the server and general operating system overhead.

The value V, largest virtual machine in the scale unit, is dynamically based on the largest tenant virtual machine memory size. For example, the largest virtual machine value could be 7 GB or 112 GB or any other supported virtual machine memory size in the Azure Stack Hub solution. Changing the largest virtual machine on the Azure Stack Hub fabric will result in an increase in the resiliency reserve and also to the increase in the memory of the virtual machine itself.
