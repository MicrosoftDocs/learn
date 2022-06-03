Organization and enterprise application workloads have recovery time
objective (RTO) and recovery point objective (RPO) requirements.
Effective business continuity and disaster recovery (BCDR) design
provides platform-level capabilities that meet these requirements. To
design BCDR capabilities, capture platform disaster recovery (DR)
requirements.

#### Design considerations

Consider the following factors when designing BCDR for application
workloads:

##### Application and data availability requirements:

-   RTO and RPO requirements for each workload

-   Support for active-active and active-passive availability patterns

##### BCDR as a service for platform-as-a-service (PaaS) services:

-   Native DR and high-availability (HA) feature support

-   Geo-replication and DR capabilities for PaaS services

##### Support for multiregion deployments for failover, with component
proximity for performance.

##### Application operations with reduced functionality or degraded
performance during an outage.

##### Workload suitability for Availability Zones or availability sets:

-   Data sharing and dependencies between zones

-   Availability Zones compared to availability sets impact on update
    domains

-   Percentage of workloads that can be under maintenance simultaneously

-   Availability Zones support for specific virtual machine (VM)
    stock-keeping units (SKUs)

-   For example, Azure Ultra Disk Storage requires using Availability
    Zones

##### Consistent backups for applications and data:

-   VM snapshots

-   Azure Backup Recovery Services vaults

-   Subscription limits restricting the number of Recovery Services
    vaults and the size of each vault

##### Network connectivity if a failover occurs:

-   Bandwidth capacity planning for Azure ExpressRoute

-   Traffic routing during a regional, zonal, or network outage

##### Planned and unplanned failovers:

-   IP address consistency requirements, and the potential need to
    maintain IP addresses after failover and failback

-   Maintaining engineering DevOps capabilities

-   Azure Key Vault DR for application keys, certificates, and secrets

#### Design recommendations

The following design practices support BCDR for application workloads:

-   Employ Azure Site Recovery for Azure-to-Azure VM DR scenarios

Site Recovery uses real-time replication and recovery automation to
replicate workloads across regions. Built-in platform capabilities for
VM workloads meet low RPO and RTO requirements. You can use Site
Recovery to run recovery drills without affecting production workloads.
You can also use Azure Policy to enable replication and to audit VM
protection.

-   Use native PaaS DR capabilities

Built-in PaaS features simplify both design and deployment automation
for replication and failover in workload architectures. Organizations
that define service standards can also audit and enforce the service
configuration through Azure Policy.

-   Use Azure-native backup capabilities

Azure Backup and PaaS-native backup features remove the need for
third-party backup software and infrastructure. As with other native
features, you can set, audit, and enforce backup configurations with
Azure Policy to ensure compliance with organization requirements.

-   Use multiple regions and peering locations for ExpressRoute connectivity

A redundant hybrid network architecture can help ensure uninterrupted
cross-premises connectivity if an outage affects an Azure region or
peering provider location.

-   Avoid using overlapping IP address ranges for production and DR sites.

Production DR networks that use the same classless interdomain routing
blocks require a failover process that can complicate and delay
application failover. When possible, plan for a BCDR network
architecture that provides concurrent connectivity to all sites.

### Overview of the reliability pillar

Reliability ensures applications can meet the commitments made to
customers. Architecting resiliency into an application frameworks
ensures workloads are available and can recover from failures at any
scale.

Building for reliability includes ensuring a highly available
architecture and recovering from failures such as data loss, major
downtime, or ransomware incidents

To assess the reliability of a workloads using the tenets found in
the [Microsoft Azure Well-Architected
Framework](/azure/architecture/framework/),
reference the [Microsoft Azure Well-Architected
Review] (/assessments/?id=azure-architecture-review&mode=pre-assessment).

Required Media From, if possible:[https://docs.microsoft.com/azure/architecture/framework/resiliency/overview](/azure/architecture/framework/resiliency/overview)

In traditional application development, there has been a focus on
increasing the mean time between failures (MTBF). This effort was spent
trying to prevent the system from failing. In cloud computing, a
different mindset is required because of several factors:

-   Distributed systems are complex, and a failure at one point can potentially cascade throughout the system

-   Costs for cloud environments are kept low through commodity hardware, so occasional hardware failures should be expected

-   Applications often depend on external services, which may become temporarily unavailable or throttle high-volume users

-   Today's users expect an application to be available 24/7 without ever going offline

These factors mean that cloud applications must be designed to expect
occasional failures and recover from them. Azure has many resiliency
features already built into the platform. For example:

-   Azure Storage, SQL Database, and Cosmos DB provide built-in data replication across availability zones and regions

-   Azure managed disks are automatically placed in different storage scale units to limit the effects of hardware failures

-   Virtual machines (VMs) are spread across several fault domains in an availability set. A *fault domain* is a group of VMs that share a common power source and network switch. Spreading VMs across fault domains limits the impact of physical hardware failures, network outages, or power interruptions

-   Availability Zones are physically separate locations within each Azure region. Each zone comprises one or more data centers equipped with independent power, cooling, and networking infrastructure. With availability zones, one can design and operate applications and databases that automatically transition between zones without interruption, ensuring resiliency if one zone is affected. For more information, go to [Regions and Availability Zones in Azure](/azure/availability-zones/az-overview).

