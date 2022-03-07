Microsoft Azure is made up of datacenters located around the globe. These datacenters are organized and made available to end users by region. A [region](https://azure.microsoft.com/global-infrastructure/regions/) is a geographical area on the planet containing at least one, but potentially multiple datacenters. The datacenters are in close proximity and networked together with a low-latency network.

A few examples of regions are *West US*, *Canada Central*, *West Europe*, *Australia East*, and *Japan West*. Azure is generally available in 60+ regions and available in 140 countries.

:::image type="content" source="../media/azure-regions-a31968fe.png" alt-text="A map of the earth has all of the current Microsoft Azure regions marked.":::


## Things to know about regions

 -  Azure has more global regions than any other cloud provider.
 -  Regions provide customers the flexibility and scale needed to bring applications closer to their users.
 -  Regions preserve data residency and offer comprehensive compliance and resiliency options for customers.
 -  For most Azure services, when you deploy a resource in Azure, you choose the region where you want your resource to be deployed.
 -  Some services or virtual machine features are only available in certain regions, such as specific virtual machine sizes or storage types.
 -  Some global Azure services that do not require you to select a region. These services include Azure Active Directory, Microsoft Azure Traffic Manager, and Azure DNS.
 -  Each Azure region is paired with another region within the same geography, together making a regional pair. The exception is Brazil South, which is paired with a region outside its geography.

> [!NOTE]
> View the latest [Azure regions map.](https://azure.microsoft.com/global-infrastructure/regions/)

## Things to know about regional pairs

 -  **Physical isolation**. Azure prefers at least 300 miles of separation between datacenters in a regional pair, although this isn't practical or possible in all geographies. Physical datacenter separation reduces the likelihood of natural disasters, civil unrest, power outages, or physical network outages affecting both regions at once.
 -  **Platform-provided replication**. Some services such as Geo-Redundant Storage provide automatic replication to the paired region.
 -  **Region recovery order**. During a broad outage, recovery of one region is prioritized out of every pair. Applications that are deployed across paired regions are guaranteed to have one of the regions recovered with priority.
 -  **Sequential updates**. Planned Azure system updates are rolled out to paired regions sequentially (not at the same time). Rolling updates minimizes downtime, reduces bugs, and logical failures in the rare event of a bad update.
 -  **Data residency**. A region resides within the same geography as its pair (except for Brazil South) to meet data residency requirements for tax and law enforcement jurisdiction purposes.

> [!NOTE]
> View the complete list of [region pairs](/azure/best-practices-availability-paired-regions#what-are-paired-regions).
