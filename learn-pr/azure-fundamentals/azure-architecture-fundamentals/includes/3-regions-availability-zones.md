In the previous unit, you learned about Azure resources and resource groups. Resources are created in regions, which are different geographical locations around the globe that contain Azure datacenters.

Azure is made up of datacenters located around the globe. When you use a service or create a resource such as an SQL database or virtual machine (VM), you're using physical equipment in one or more of these locations. These specific datacenters aren't exposed to users directly. Instead, Azure organizes them into regions. As you'll see later in this unit, some of these regions offer availability zones, which are different Azure datacenters within that region.

## Azure regions

A *region* is a geographical area on the planet that contains at least one but potentially multiple datacenters that are nearby and networked together with a low-latency network. Azure intelligently assigns and controls the resources within each region to ensure workloads are appropriately balanced.

When you deploy a resource in Azure, you'll often need to choose the region where you want your resource deployed.

> [!IMPORTANT]
> Some services or VM features are only available in certain regions, such as specific VM sizes or storage types. There are also some global Azure services that don't require you to select a particular region, such as Azure Active Directory, Azure Traffic Manager, and Azure DNS.

A few examples of regions are West US, Canada Central, West Europe, Australia East, and Japan West. Here's a view of all the available regions as of June 2020.

<br>:::image type="content" source="../media/regions-small-be724495.png" alt-text="Global map of available Azure regions as of June 2020.":::


### Why are regions important?

Azure has more global regions than any other cloud provider. These regions give you the flexibility to bring applications closer to your users no matter where they are. Global regions provide better scalability and redundancy. They also preserve data residency for your services.

### Special Azure regions

Azure has specialized regions that you might want to use when you build out your applications for compliance or legal purposes. A few examples include:

- **US DoD Central, US Gov Virginia, US Gov Iowa and more:** These regions are physical and logical network-isolated instances of Azure for U.S. government agencies and partners. These datacenters are operated by screened U.S. personnel and include extra compliance certifications.
- **China East, China North, and more:** These regions are available through a unique partnership between Microsoft and 21Vianet, whereby Microsoft doesn't directly maintain the datacenters.

Regions are what you use to identify the location for your resources. There are two other terms you should also be aware of: *geographies* and *availability zones*.

## Azure availability zones

You want to ensure your services and data are redundant so you can protect your information if there's a failure. When you host your infrastructure, setting up your own redundancy requires that you create duplicate hardware environments. Azure can help make your app highly available through availability zones.

### What is an availability zone?

Availability zones are physically separate datacenters within an Azure region. Each availability zone is made up of one or more datacenters equipped with independent power, cooling, and networking. An availability zone is set up to be an *isolation boundary*. If one zone goes down, the other continues working. Availability zones are connected through high-speed, private fiber-optic networks.

:::image type="content" source="../media/availability-zones-5c3c490c.png" alt-text="Diagram showing three datacenters connected in a single Azure region representing an availability zone.":::


### Supported regions

Not every region has support for availability zones. For an updated list, see [Regions that support availability zones in Azure](/azure/availability-zones/az-region?azure-portal=true).

### Use availability zones in your apps

By co-locating your compute, storage, networking, and data resources within a zone and replicating them in other zones. You can use availability zones to run mission-critical applications and build high-availability into your application architecture. Keep in mind that there could be a cost to duplicating your services and transferring data between zones.

Availability zones are primarily for VMs, managed disks, load balancers, and SQL databases. The following categories of Azure services support availability zones:

- **Zonal services**: You pin the resource to a specific zone (for example, VMs, managed disks, IP addresses).
- **Zone-redundant services**: The platform replicates automatically across zones (for example, zone-redundant storage, SQL Database).  
- **Non-regional services**: Services are always available from Azure geographies and are resilient to zone-wide outages and region-wide outages.

Check the documentation to determine which elements of your architecture you can associate with an availability zone.

## Azure region pairs

Availability zones are created by using one or more datacenters. There's a minimum of three zones within a single region. It's possible that a disaster could cause an outage large enough to affect even two datacenters, so Azure also creates *region pairs*.

### What is a region pair?

Each Azure region is always paired with another region within the same geography (such as US, Europe, or Asia) at least 300 miles away. This approach allows for the replication of resources (such as VM storage) across a geography to help reduce the likelihood of interruptions due to catastrophic events. For example, events such as natural disasters, civil unrest, power outages, or physical network outages that affect multiple zones at once. If a region in a pair was affected by a natural disaster, services would automatically failover to the other region in its region pair.

Examples of region pairs in Azure are West US paired with East US and SouthEast Asia paired with East Asia.

:::image type="content" source="../media/region-pairs-d9eb9728.png" alt-text="Diagram showing relationship between geography, region pair, region, and datacenter.":::

Because the pair of regions is directly connected and far enough apart to be isolated from regional disasters, you can use them to provide reliable services and data redundancy. Some services offer automatic geo-redundant storage by using region pairs.

More advantages of region pairs:

- If an extensive Azure outage occurs, one region out of every pair is prioritized to make sure at least one is restored as quickly as possible for applications hosted in that region pair.
- Planned Azure updates are rolled out to paired regions one region at a time to minimize downtime and risk of application outage.
- Data continues to reside within the same geography as its pair (except for Brazil South) for tax- and law-enforcement jurisdiction purposes.

Having a broadly distributed set of datacenters allows Azure to provide a high guarantee of availability.
