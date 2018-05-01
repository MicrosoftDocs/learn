You can use Azure virtual machine scale sets to create and manage a group of identical, load-balanced VMs. The number of VM instances can automatically increase or decrease in response to demand or a defined schedule. Scale sets provide high availability to your applications, and they help you centrally manage, configure, and update a large number of VMs. With virtual machine scale sets, you can build large-scale services for areas such as compute, big data, and container workloads.

To provide redundancy and improved performance, applications are typically distributed across multiple instances. Customers might access your application through a load balancer that distributes requests to one of the application instances. If you need to perform maintenance or update an application instance, your customers must be distributed to another available application instance. To keep up with additional customer demand, you might need to increase the number of application instances that run your application.

Azure virtual machine scale sets provide the management capabilities for applications that run across many VMs, automatic scaling of resources, and load balancing of traffic. Scale sets provide the following key benefits:

- Help you easily create and manage multiple VMs
- Provide high availability and application resiliency
- Allow your application to automatically scale as resource demand changes
- Work at large scale


## Differences between virtual machines and scale sets
Scale sets are built from virtual machines. With scale sets, the management and automation layers are provided to run and scale your applications. You can instead manually create and manage individual VMs, or integrate existing tools to build a similar level of automation. The following table outlines the benefits of scale sets compared to manually managing VM instances.

| Scenario                           | Manual group of VMs                                                                    | Virtual machine scale set |
|------------------------------------|----------------------------------------------------------------------------------------|---------------------------|
| Adding more VM instances        | Manual process to create, configure, and ensure compliance                             | Automatic creation from a central configuration |
| Traffic balancing and distribution | Manual creation and configuration by using Azure Load Balancer or Azure Application Gateway      | Automatic creation and integration by using Load Balancer or Application Gateway |
| High availability and redundancy   | Manual process to create an availability set or to distribute and track VMs across availability zones | Automatic distribution of VM instances across availability zones or availability sets |
| Scaling of VMs                     | Manual monitoring and use of Azure Automation                                                 | Autoscale based on host metrics, in-guest metrics, Azure Application Insights, or schedule |

There is no additional cost for scale sets. You pay for only the underlying compute resources such as the VM instances, the load balancer, or managed disk storage. The management and automation features, such as autoscale and redundancy, incur no additional charges over the use of VMs.