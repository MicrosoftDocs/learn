

Contoso can use Azure virtual machine scale sets to provide a scalable way to run their applications on a set of VMs. The VMs in Azure virtual machine scale set all have the same configuration and run the same applications. As demand grows, the number of VMs running in the scale set can increase. As demand slackens, excess VMs can be shut down. Virtual machine scale sets are ideal for scenarios that include compute and big-data workloads.

For example, at Contoso, IT provides a customer-facing website using a VM running IIS. Contoso's customers access this website to review the status of their orders. Because this website is accessed globally, it can be difficult to predict the load on the website at any particular time during the day. In addition, there might also be seasonal variations. Therefore, IT staff at Contoso decide to implement a virtual machine scale set. This implementation should help to handle the fluctuating workload.

> [!TIP]
> If you have large workloads where demand varies and is unpredictable, scale sets are a great solution. And because virtual machine scale sets offer identical VMs scaled and load-balanced in response to demand, they automatically provide a highly available environment.

## What is a virtual machine scale set?

Azure virtual machine scale sets enable you to deploy and manage multiple load-balanced, identical VMs. These VMs have the same configurations. Virtual machine scale sets can respond to increases and decreases in demand by changing the number of VM instances, and also by changing the size of VM instances.

> [!NOTE]
> The criteria used to activate the necessary upscale or downscale depends on a customized schedule or actual demand and usage.

A scale set uses a load balancer to distribute requests across the VM instances and a health probe to verify the availability of each instance. If the instance responds to the health probe, the scale set knows the instance is still available. Otherwise, the scale set knows the instance is unavailable.

> [!NOTE]
> Virtual machine scale sets support both Linux and Windows VMs in Azure.

## Scaling options for scale sets

Scale sets are designed for cost-effectiveness. Azure only creates new VM instances as needed. Azure can scale VMs either horizontally or vertically, as described in the following table.

|Scale type|Description|
|----|----|
|Horizontal|The process of adding or removing VMs in a scale set. Depending on demand, you might need to add or remove machines in a scale set. For example, on weekends, demand might be low, so you might want to run fewer VMs. Although you could manually adjust the number of VMs in a scale set, in many cases it's better to automatically change the number of VMs by using rules. In addition to a schedule, you can base these rules on metrics and help to ensure that the correct number of VMs are added, depending on the demand.|
|Vertical|The process of increasing resource in your VMs, such as CPU, memory, or disk space. Vertical scaling focuses on increasing the size of the VMs in the scale set instead of adding additional VMs. For example, during busier periods with increased demand, you might want to increase the number of CPUs that each VM in a virtual machine scale set has. Again, rules are used to make the changes automatically based on metrics.|

> [!CAUTION]
> Vertical scaling requires restarting the affected VMs in the scale set. This might lead to temporary degraded performance across the scale set during the restart.
