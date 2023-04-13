Azure Virtual Machine Scale Sets provide a scalable way to run applications on a set of VMs. When deployed in the uniform orchestration configuration, the VMs in this type of scale set all have the same configuration and run the same applications.

- As demand grows, the number of VMs running in the scale set increases.
- As demand goes down, excess VMs can be shut down.

Virtual machine scale sets are ideal for scenarios that include compute workloads, big-data workloads, and container workloads.

> [!NOTE]
> Scale sets configured to use Flexible orchestration may use a mix of virtual machine types, and can leverage Spot and on-demand VMs in the same set. This module focuses on scale sets that use uniform orchestration.

Virtual machine scale sets are intelligent enough to automatically scale up or down the number of VM instances. A scale set can also change the size of VM instances. The criteria used to activate the upscaling or downscaling can depend on a customized schedule, or on actual demand and usage. Scale sets using uniform orchestration apply the same configuration to a group of VMs simultaneously. They don't require you to manually configure instances individually.

A scale set uses a load balancer to distribute requests across the VM instances. It uses a health probe to determine the availability of each instance by pinging each instance.

- If the instance responds, the scale set knows the instance is still available.
- If the ping fails or times out, the scale set knows the instance is unavailable and doesn't send requests to it.

Virtual Machine Scale Sets support both Linux and Windows VMs in Azure. If you deal with large workloads with varying and unpredictable demands, scale sets are a great solution. Because virtual machine scale sets in uniform orchestration configuration offer identical VMs scaled and load-balanced in response to demand, they automatically provide a highly available environment.
