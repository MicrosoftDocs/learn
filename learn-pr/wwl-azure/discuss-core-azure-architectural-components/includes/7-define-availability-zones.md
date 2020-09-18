## Availability Zones

You want to ensure your services and data are redundant so you can protect your information in case of failure. When you are hosting your infrastructure, this requires creating duplicate hardware environments. Azure can help make your app highly available through Availability Zones.

[Availability zones](https://docs.microsoft.com/azure/availability-zones/az-overview?azure-portal=true) are physically separate locations within an Azure region that use availability sets to provide additional fault tolerance.

![Conceptual graphic containing a box entitled Azure region and within that box re three separate pictures of Availability zones, each with arrows point to the other two so show connectivity.](../media/availability-zone-1.png)

> [!TIP]
> The list of supported regions is expanding - check the documentation for the latest information.

## Availability Zone features

+ Each availability zone is an isolation boundary containing one or more datacenters equipped with independent power, cooling, and networking. 

+ If one availability zone goes down, the other continues working. 

+ The availability zones are typically connected to each other through very fast, private fiber-optic networks.

+ Availability zones allow customers to run mission-critical applications with high availability and low-latency replication.

+ Availability zones are offered as a service within Azure, and to ensure resiliency, there’s a minimum of three separate zones in all enabled regions.

✔️ Regions that support Availability Zones include *Central US*, *North Europe*, *SouthEast Asia*, and more.

### Use Availability Zones in your apps

You can use Availability Zones to run mission-critical applications and build high-availability into your application architecture by co-locating your compute, storage, networking, and data resources within a zone and replicating in other zones. Keep in mind that there could be a cost to duplicating your services and transferring data between zones.

Availability Zones are primarily for VMs, managed disks, load balancers, and SQL databases. Azure services that support Availability Zones fall into two categories:

- **Zonal services** – you pin the resource to a specific zone (for example, virtual machines, managed disks, IP addresses)
- **Zone-redundant services** – platform replicates automatically across zones (for example, zone-redundant storage, SQL Database).

✔️ Check the documentation to determine which elements of your architecture you can associate with an Availability Zone.


