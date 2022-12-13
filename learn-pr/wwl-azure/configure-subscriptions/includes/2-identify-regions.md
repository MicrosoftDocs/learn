Microsoft Azure is made up of datacenters located around the globe. These datacenters are organized and made available to end users by region. A [region](https://azure.microsoft.com/global-infrastructure/regions/) is a geographical area on the planet containing at least one, but potentially multiple datacenters. The datacenters are in close proximity and networked together with a low-latency network. A few examples of regions are West US, Canada Central, West Europe, Australia East, and Japan West.

### Things to know about regions

Here are some points to consider about regions:

- Azure is generally available in more than 60 regions in 140 countries.

- Azure has more global regions than any other cloud provider.

- Regions provide you with the flexibility and scale needed to bring applications closer to your users.

- Regions preserve data residency and offer comprehensive compliance and resiliency options for customers.

### Things to know about regional pairs

Most Azure regions are paired with another region within the same geography to make a _regional pair_ (or _paired regions_). Regional pairs help to support always-on availability of Azure resources used by your infrastructure. The following table describes some prominent characteristics of paired regions:

| Characteristic | Description |
| --- | --- |
| **Physical isolation** | Azure prefers at least 300 miles of separation between datacenters in a regional pair. This principle isn't practical or possible in all geographies. Physical datacenter separation reduces the likelihood of natural disasters, civil unrest, power outages, or physical network outages affecting both regions at once. |
| **Platform-provided replication** | Some services like Geo-Redundant Storage provide automatic replication to the paired region. |
| **Region recovery order** | During a broad outage, recovery of one region is prioritized out of every pair. Applications that are deployed across paired regions are guaranteed to have one of the regions recovered with priority. |
| **Sequential updates** | Planned Azure system updates are rolled out to paired regions sequentially (not at the same time). Rolling updates minimizes downtime, reduces bugs, and logical failures in the rare event of a bad update. |
| **Data residency** | Regions reside within the same geography as their enabled set (except for the Brazil South and Singapore regions). |

### Things to consider when using regions and regional pairs

You've reviewed the important considerations about regions and regional pairs. Now think about how you might implement regions in your organization.

- **Consider resource and region deployment**. Plan the regions where you want to deploy your resources. For most Azure services, when you deploy a resource in Azure, you choose the region where you want your resource to be deployed.

- **Consider service support by region**. Research region and service availability. Some services or Azure Virtual Machines features are available only in certain regions, such as specific Virtual Machines sizes or storage types.

- **Consider services that don't require regions**. Identify services that don't need region support. Some global Azure services that don't require you to select a region. These services include Azure Active Directory, Microsoft Azure Traffic Manager, and Azure DNS.

- **Consider exceptions to region pairing**. Check the Azure website for current region availability and exceptions. If you plan to support the Brazil South region, note this region is paired with a region outside its geography. The Singapore region also has an exception to standard regional pairing.

- **Consider benefits of data residency**. Take advantage of the benefits of data residency offered by regional pairs. This feature can help you meet requirements for tax and law enforcement jurisdiction purposes.

## Find regions for your business geography

Visit the Azure global infrastructure website to find supported regions for your business geography. You can search by country name or by Microsoft product. A list of supported region pairs and exceptions is also available.

:::image type="content" source="../media/azure-geographies.png" alt-text="Screenshot of the Azure global infrastructure and Azure geographies website." border="false":::

| By geography | By product | Paired regions |
|--- | --- | --- |
| Search [Azure regions](https://azure.microsoft.com/global-infrastructure/geographies/#geographies) by geography. | Search [Azure products](https://azure.microsoft.com/global-infrastructure/services/) by region or geography. | Search for [paired regions](/azure/best-practices-availability-paired-regions#azure-cross-region-replication-pairings-for-all-geographies) and exceptions. |
| :::image type="content" source="../media/regions-select-by-geography.png" alt-text="Screenshot that shows how to search for available regions by geographic location." lightbox="../media/regions-select-by-geography-expanded.png" border="false"::: | :::image type="content" source="../media/regions-select-by-product.png" alt-text="Screenshot that shows how to find products available according to region or geographic location." lightbox="../media/regions-select-by-product-expanded.png" border="false"::: | :::image type="content" source="../media/search-region-pairs.png" alt-text="Screenshot that shows how to search for regional pairs." lightbox="../media/search-region-pairs-expanded.png" border="false"::: |