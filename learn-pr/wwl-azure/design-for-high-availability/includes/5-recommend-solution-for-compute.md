

Microsoft Azure global infrastructure is designed and constructed at every layer to deliver the highest levels of redundancy and resiliency to its customers. Azure infrastructure is composed of geographies, regions, and Availability Zones, which limit the blast radius of a failure and therefore limit potential impact to customer applications and data. The Azure Availability Zones construct was developed to provide a software and networking solution to protect against datacenter failures and to provide increased high availability (HA) to our customers.

## Design with Azure Availability Zones

Availability Zones are unique physical locations within an Azure region. Each zone is made up of one or more datacenters with independent power, cooling, and networking. The physical separation of Availability Zones within a region limits the impact to applications and data from zone failures, such as large-scale flooding, major storms and superstorms, and other events that could disrupt site access, safe passage, extended utilities uptime, and the availability of resources. Availability Zones and their associated datacenters are designed such that if one zone is compromised, the services, capacity, and availability are supported by the other Availability Zones in the region.

Availability Zones can be used to spread a solution across multiple zones within a region, allowing for an application to continue functioning when one zone fails. With Availability Zones, Azure offers industry best 99.99% [Virtual Machine (VM) uptime service-level agreement (SLA)](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_9/). Zone-redundant services replicate your services and data across Availability Zones to protect from single points of failure.

:::image type="content" source="../media/azure-availability-zones.png" alt-text="Diagram showing availability zones within an Azure region.":::



With Availability Zones, Azure offers industry best 99.99% VM uptime SLA. The full [Azure SLA](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_9/) explains the guaranteed availability of Azure as a whole.

The following diagram illustrates the different levels of HA offered by a single VM, Availability Sets, and Availability Zones.

:::image type="content" source="../media/virtual-machine-availability.png" alt-text="Diagram showing the different levels of high availability offered by a single VM, Availability Sets, and Availability Zones.":::

 

Using a VM workload as an example, a single VM has an SLA of 99.9%. This means the VM will be available 99.9% of the time. Within a single datacenter, the use of Availability Sets can increase the level of SLA to 99.95% by protecting a set of VMs, ensuring they will not all be on the same hardware. Within a region, VM workloads can be distributed across Availability Zones to increase the SLA to 99.99%. For more information, refer to [Availability options for VMs in Azure](/azure/virtual-machines/availability).

Azure services supporting Availability Zones fall into two categories: zonal services and zone redundant services. Customer workloads can be categorized to utilize either architecture scenario to meet application performance and durability requirements.

With zonal architecture, a resource can be deployed to a specific, self-selected Availability Zone to achieve more stringent latency or performance requirements. Resiliency is self-architected by replicating applications and data to one or more zones within the region. You can choose specific Availability Zones for synchronous replication, providing high availability, or asynchronous replication, providing backup or cost advantage. You can pin resources-for example, virtual machines, managed disks, or standard IP addresses-to a specific zone, allowing for increased resilience by having one or more instances of resources spread across zones.

With zone-redundant architecture, the Azure platform automatically replicates the resource and data across zones. Microsoft manages the delivery of high availability, since Azure automatically replicates and distributes instances within the region.

A failure to a zone affects zonal and zone-redundant services differently. In the case of a zone failure, the zonal services in the failed zone become unavailable until the zone has recovered. By architecting your solutions to use replicated VMs in zones, you can protect your applications and data from a zone becoming unavailable-for example, due to a power outage. If one zone is compromised, replicated apps and data are instantly available in another zone.

Zonal architecture applies to a specific resource, typically an infrastructure as a service (IaaS) resource, like a VM or managed disk, as illustrated. For example, zonal load balancer, VM, managed disks, virtual machine scale sets.

In the illustration, each VM and load balancer (LB) are deployed to a specific zone.

:::image type="content" source="../media/zonal-architecture.png" alt-text="Diagram showing each VM and load balancer are deployed to a specific zone.":::



With zone-redundant services, the distribution of the workload is a feature of the service and is handled by Azure. Azure automatically replicates the resource across zones without requiring your intervention. ZRS, for example, replicates the data across three zones so a zone failure does not impact the HA of the data.

The following illustration is of a zone-redundant load balancer.

:::image type="content" source="../media/zone-redundant-load-balancer.png" alt-text="Diagram showing a zone redundant load balancer.":::


For a list of Azure services that support Availability Zones, per Azure region, refer to the [Availability Zones documentation](/azure/availability-zones/az-overview).

 

Would you recommend Tailwind use Zonal or Zone redundant architecture for their workloads? Why would you recommend one over the other? 

## When to select virtual machine scale sets 

 

Scale sets are built from virtual machines. With scale sets, the management and automation layers are provided to run and scale your applications. You could instead manually create and manage individual VMs, or integrate existing tools to build a similar level of automation. The following table outlines the benefits of scale sets compared to manually managing multiple VM instances.

| Scenario| Group of virtual machines| Virtual machine scale sets |
| - | - | - |
| You need to add VM instances for changing workload| Manual process to create, configure, and ensure compliance| Automatically create from central configuration |
| You need to balance and distribute workloads| Manual process to create and configure Azure load balancer or Application Gateway| Can automatically create and integrate with Azure load balancer or Application Gateway |
| You need high availability and redundancy| Manually create Availability Set or distribute and track VMs across Availability Zones| Automatic distribution of VM instances across Availability Zones or Availability Sets |
| You need to monitor and then scale virtual machines| Manual monitoring and Azure Automation| Autoscale based on host metrics, in-guest metrics, Application Insights, or schedule |


 

Think back to Tailwind Traders application portfolio and where they could leverage virtual machine scale sets. Why would you recommend virtual machine scale sets over groups of VMs and for which specific applications? 

 

## Design a highly available container solution

[Azure Kubernetes Service (AKS)](/azure/aks/intro-kubernetes) is an Azure service that deploys a managed Kubernetes cluster. AKS is responsible for deploying the Kubernetes cluster and for managing the Kubernetes API server. It's important that any apps that you deploy that are based on AKS are designed to be highly available and reliable.

By default, AKS automatically provides a degree of high availability. This is achieved by using multiple nodes in a Virtual Machine Scale Set. However, these nodes can’t provide protection against Azure region failure. Consequently, you should plan to implement your AKS clusters in multiple regions.

 

> [!TIP]
> When you deploy multiple AKS clusters, choose regions where AKS is available. Always use paired regions.

 

### Consider multiple region availability

When planning to implement AKS clusters across multiple region deployments, consider the following:

- **AKS region availability**. Choose regions that are close to your users. Keep in mind that AKS is continually expanding into new regions.

- **Azure paired regions.** For your geographic area, choose two regions paired together. Also consider that:

	- AKS platform updates (planned maintenance) are serialized with a delay of at least 24 hours between paired regions.

	- Recovery efforts for paired regions are prioritized where needed.

- **Service availability**. Decide whether your paired regions should be hot/hot, hot/warm, or hot/cold. In other words, do you want to run both regions at the same time, with one region ready to start serving traffic? Or do you want to give one region time to get ready to serve traffic?

 

### Describe Azure Storage replication options

It's probable that your apps use Azure Storage for their data. Assuming they do, and that those apps are distributed across multiple AKS clusters in multiple regions, you'll need a way to synchronize storage. With Azure Storage, there are two possible options you can consider:

- Infrastructure-based asynchronous replication

- Application-based asynchronous replication

### Infrastructure-based asynchronous replication

Your apps might require persistent storage. In Kubernetes, you can use persistent volumes to persist data storage. These persistent volumes are mounted to a node VM and then exposed to the pods.

 

>[!NOTE]
>Persistent volumes follow pods even if the pods are moved to a different node inside the same cluster.

Typically, you provide a common storage point where apps write their data. This data is then replicated across regions and accessed locally, as displayed in the following graphic.

:::image type="content" source="../media/kubernetes-infrastructure-based.png" alt-text="Kubernetes replicates clusters to storage.":::


### Application-based asynchronous replication

Kubernetes currently provides no native implementation for application-based asynchronous replication. However, because containers and Kubernetes are loosely coupled, you should be able to use any traditional app or language approach to replicate storage.

Typically, the apps themselves can replicate the storage requests These requests are then written to each cluster's underlying data storage. This process is displayed in the following graphic.

:::image type="content" source="../media/kubernetes-app-based.png" alt-text="Kubernetes replicates apps to storage.":::


Consider Azure Backup or Velero

As with any app, it's important you back up the data related to your AKS clusters and their apps. When your apps consume and store data which is persisted on disks or in files, you should schedule frequent backups or take regular snapshots of that data. You can use several tools for these backup operations, including:

- Azure Disks: Azure Disks can use built-in snapshot technologies. However, your apps might need to flush writes-to-disk before the snapshot operation.

- Velero: Velero can back up persistent volumes along with additional cluster resources and configurations.

>[!NOTE]
> Velero is an open-source tool: You can use Velero to back up and restore your data. You can also use it for disaster recovery and migration of Kubernetes cluster resources and persistent volumes.
