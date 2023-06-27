Azure provides three main options to enhance availability for IaaS deployments:

- Availability Sets

- Availability Zones

- Azure Site Recovery

All three of these options are external to the virtual machine (VM) and don't know what kind of workload is running inside of it.

## Availability sets

Availability sets provide uptime against Azure-related maintenance and single points of failure in a single data center. This was one of the first availability features introduced into the Azure platform, and effectively it can be thought of as anti-affinity rules for your VMs. This means if you had two SQL Server VMs in an availability set or log shipping pair, they would be guaranteed to never run on the same physical server.

Availability sets are separated into both fault domains and update domains to support both updates to the underlying Azure Infrastructure. Fault domains are sets of servers within a data center, which use the same power source and network There can be up to three fault domains in a data center as depicted in the image below by FD 0, 1, and 2. Update domains, denoted by UD in the image below, indicate groups of virtual machines and underlying physical hardware that can be rebooted at the same time. Different update domains ensure separation.

:::image type="content" source="../media/module-77-high-availability-final-01.png" alt-text="Fault Domains and Update Domains":::

Availability sets and zones don't protect against in-guest failures, such as an OS or RDBMS crash; which is why you need to implement additional solutions such as AGs or FCIs to ensure you meet RTOs and RPOs. Both availability sets and zones are designed to limit the impact of environmental problems at the Azure level such as datacenter failure, physical hardware failure, network outages, and power interruptions.

For a multi-tier application, you should put each tier of the application into its own availability set. For example, if you were building a web application that has a SQL Server backend along with Active Directory Domain Services (AD DS), you would create an availability set for each tier (web, database, and AD DS).

Availability sets are not the only way to separate IaaS VMs. Azure also provides Availability Zones, but the two can't be combined. You can pick one or the other.

## Availability zones

Availability zones account for data center-level failure in Azure. Each Azure region consists of many data centers with low latency network connections between them. When you deploy VM resources in a region that supports Availability Zones, you have the option to deploy those resources into Zone 1, 2, or 3. A zone is a unique physical location, that is, a data center, within an Azure region.

Zone numbers are logical representations. For example, if two Azure subscribers both deploy a VM into Zone 1 in their own subscriptions, that doesn't mean those VMs exist in the same physical Azure data center. Additionally, because of the distance there can be some additional latency introduced into zonal deployments. You should test the latency between your VMs to ensure that the latency meets performance targets. In most cases round-trip latency will be less than 1 millisecond, which supports synchronous data movement in features like availability groups. You can also deploy Azure SQL Database into Availability Zones.

## Azure Site Recovery

Azure Site Recovery provides enhanced availability for VMs at the Azure level and can work with VMs hosting SQL Server. Azure Site Recovery replicates a VM from one Azure region to another to create a disaster recovery solution for that VM. As noted earlier, this feature does not know that SQL Server is running in the VM and knows nothing about transactions. While Azure Site Recovery may meet RTO, it may not meet RPO since it isn't accounting for where data is inside SQL Server. Azure Site Recovery has a stated monthly RTO of two hours. While most database professionals may prefer to use a database-based method for disaster recovery, Azure Site Recovery works well if it meets your RTO and RPO needs.