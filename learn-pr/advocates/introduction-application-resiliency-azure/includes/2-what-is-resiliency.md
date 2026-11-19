Resiliency is the ability of a system to recover from failures and continue to function. You implement resiliency to avoid application failures and to ensure that if a failure occurs, the application can rely on underlying services to return to a fully functioning state. The level of resiliency an application requires depends on its importance to the organization. A business-critical application that takes customer orders over the internet requires a higher level of resiliency than an application that tracks leave requests.

## Resilient services in Azure

Azure includes built-in resiliency services that you can implement to make your application more resilient to failures. These services include:

- Availability Sets provide a logical grouping of VMs that allows Azure to understand how your application is built in order to deliver redundancy and availability.  
- Availability Zones protect your applications and data from datacenter failures. You can distribute the VMs belonging to one tier across multiple availability zones within a region.
- Azure Load Balancer distributes inbound traffic according to rules and health probes. You can distribute incoming client traffic using load balancers.
- Azure Traffic Manager enables you to distribute traffic optimally to services across global Azure regions while providing high availability and responsiveness.
- Azure Site Recovery allows you to replicate virtual machines to another Azure region for business continuity and disaster recovery needs.
- Azure Backup service provides simple, secure, and cost-effective solutions to back up your data and recover it from the Microsoft Azure cloud.
- Geo Replication for Azure SQL Database allows the application to perform quick disaster recovery of individual databases in case of a regional disaster or large-scale outage.  
- Locally redundant storage (LRS) keeps redundant copies in a single physical datacenter. It protects against local hardware failures, but not the loss of that datacenter.
- Zone-redundant storage (ZRS) synchronously replicates data across availability zones in the primary region, providing resilience to a zone failure.
- Geo-redundant storage (GRS) adds asynchronous replication to a secondary region for protection against regional disasters.
- Geo-zone-redundant storage (GZRS) combines zone redundancy in the primary region with asynchronous replication to a secondary region.

> [!IMPORTANT]
> Durability, or retaining data, is different from availability, or being able to access it. GRS and GZRS can lose recent, unreplicated writes during an unplanned regional failover, and secondary-region access normally requires failover. Where supported, read-access variants provide a read-only secondary endpoint.

For supported services, regions, and access options, see [Azure Storage redundancy](/azure/storage/common/storage-redundancy).

## Shared responsibility model

Resiliency is a shared responsibility between Microsoft and the customer. Your responsibilities depend on the services you use:

- In an on-premises deployment, you manage the entire stack, from physical infrastructure to applications, and plan its failure recovery.
- With infrastructure as a service (IaaS), Microsoft operates the physical infrastructure and virtualization platform. You manage the guest operating system, applications, and workload configuration.
- With platform as a service (PaaS), Microsoft also manages the underlying operating system and platform. You remain responsible for your application and for selecting and configuring the service's reliability capabilities.
- With software as a service (SaaS), the provider operates the application. You still define your availability and recovery requirements and manage customer-controlled configuration and data responsibilities.

> [!IMPORTANT]
> A managed service doesn't make every reliability capability automatic. Verify which responsibilities apply to each service, and configure and test your workload accordingly.

For more information, see [Shared responsibility for reliability](/azure/reliability/concept-shared-responsibility).

## Design your applications to be resilient

You can leverage the following model when designing your applications for resiliency:

- Define your resiliency requirements based on business needs.
- Design the application for resiliency. Start with an architecture that follows proven practices and then identify the possible failure points in that architecture.
- Implement strategies to detect and recover from failures.
- Test the implementation by simulating faults and triggering forced failovers.
- Deploy the application into production using a reliable and repeatable process.
- Monitor the application to detect failures. By monitoring the system, you can gauge the health of the application and respond to incidents if necessary.
- Respond if there are failures that require manual intervention.

You'll learn more about parts of this model throughout the rest of this module.
