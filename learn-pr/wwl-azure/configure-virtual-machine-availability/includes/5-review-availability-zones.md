Availability Zones is a high-availability offering that protects your applications and data from datacenter failures.

:::image type="content" source="../media/availability-zones-26abc45c.png" alt-text="Three availability zones are connected, making an Azure region.":::


## Considerations

 -  Availability Zones are unique physical locations within an Azure region.
 -  Each zone is made up of one or more datacenters equipped with independent power, cooling, and networking.
 -  To ensure resiliency, there’s a minimum of three separate zones in all enabled regions.
 -  The physical separation of Availability Zones within a region protects applications and data from datacenter failures.
 -  Zone-redundant services replicate your applications and data across Availability Zones to protect from single-points-of-failure.
 -  With Availability Zones, Azure offers industry best 99.99% VM uptime SLA.

## Implementation

An Availability Zone in an Azure region is a combination of a fault domain and an update domain. For example, if you create three or more VMs across three zones in an Azure region, your VMs are effectively distributed across three fault domains and three update domains. The Azure platform recognizes this distribution across update domains to make sure that VMs in different zones are not updated at the same time. Build high-availability into your application architecture by colocating your compute, storage, networking, and data resources within a zone and replicating in other zones.

Azure services that support Availability Zones fall into two categories:

 -  **Zonal services**. Pins the resource to a specific zone (for example, virtual machines, managed disks, Standard IP addresses).
 -  **Zone-redundant services**. Platform replicates automatically across zones (for example, zone-redundant storage, SQL Database).

> [!NOTE]
> To achieve comprehensive business continuity on Azure, build your application architecture using the combination of Availability Zones with Azure region pairs.
