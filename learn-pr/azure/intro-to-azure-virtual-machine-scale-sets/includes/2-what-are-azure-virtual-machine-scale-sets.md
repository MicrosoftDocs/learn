Azure Virtual Machine Scale Sets provide a scalable way to run applications on a set of VMs.

Virtual Machine Scale Sets support two orchestration modes. Flexible orchestration, the recommended mode for new deployments, manages standard Azure VMs and supports identical or mixed VM configurations. Uniform orchestration is optimized for identical instances managed as a group. Choose the orchestration mode when creating the scale set; you can't change it in place afterward.

Flexible orchestration supports up to 1,000 VMs in a scale set; some VM-size and fault-domain configurations have lower limits. Supported instance counts depend on the orchestration mode and configuration. Check the current limits for the image source and placement configuration you plan to use. For more information, see [Orchestration modes for Virtual Machine Scale Sets](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-orchestration-modes).

When deployed, the VMs in a scale set can all have the same configuration and run the same applications or have different configurations and run different applications.

With autoscale configured to respond to demand:

- As demand grows, the number of VMs running in the scale set increases.
- As demand goes down, the number of VMs running in the scale set decreases.

Virtual Machine Scale Sets are ideal for scenarios that include compute workloads, big-data workloads, and container workloads.

Virtual Machine Scale Sets support horizontal scaling: scaling out adds VM instances, and scaling in removes them. You can change the instance count manually, or configure Azure Monitor autoscale to change it according to metrics or a schedule. Autoscale also requires a VM scaling profile: the configuration template used to create new instances. This is different from the autoscale profiles that define rules, schedules, and capacity limits. Vertical scaling, also called scaling up or down, changes the capacity of an individual VM, such as its size, rather than the number of instances. Scale sets can apply the same configuration to a group of VMs simultaneously. They don't require you to manually configure instances individually if you don't want to.

For workloads that receive network requests, you can integrate a scale set with Azure Load Balancer or Application Gateway to distribute traffic. With Standard Load Balancer, health probes determine which instances can receive new connections. When a probe marks an instance unhealthy, the load balancer stops sending new connections to it; established TCP connections can continue.

Separately, the Application Health extension reports application health for scale-set operations such as configured automatic repairs and rolling upgrades. It doesn't control load-balancer traffic routing.

> [!NOTE]
> For these health-dependent scale-set operations, Flexible orchestration uses the Application Health extension. Uniform orchestration supports either that extension or a load-balancer health probe. A Flexible scale set can still use load-balancer probes for traffic routing. Configuring a health signal doesn't, by itself, enable automatic repairs or an upgrade policy.

Virtual Machine Scale Sets support Linux and Windows VMs. They can help applications remain available by distributing multiple VM instances across fault domains or availability zones, and can scale to meet changing demand when autoscale is configured.

> [!NOTE]
> Availability depends on your application design and deployment configuration. Fault-domain distribution helps protect against localized hardware failures. To protect against an availability-zone outage, deploy instances across multiple availability zones and design the application to continue operating with a zone unavailable. A scale set whose instances are all in one zone doesn't provide that zone-outage protection.
