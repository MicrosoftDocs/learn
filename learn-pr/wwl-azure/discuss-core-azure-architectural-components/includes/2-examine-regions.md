## Regions

Microsoft Azure is made up of datacenters located around the globe. These datacenters are organized and made available to end users by region. A [region](https://azure.microsoft.com/global-infrastructure/geographies?azure-portal=true) is a geographical area on the planet containing at least one, but potentially multiple datacenters that are in close proximity and networked together with a low-latency network. Azure intelligently assigns and controls the resources within each region to ensure workloads are appropriately balanced.

A few examples of regions are *West US*, *Canada Central*, *West Europe*, *Australia East*, and *Japan West*. At the time of writing this, Azure is generally available in 60 regions and available in 140 countries.

![A map of the earth has all of the current Microsoft Azure regions marked.](../media/azure-regions.png)

## Things to know about regions

+ Azure has more global regions than any other cloud provider.

+ Regions provide customers the flexibility and scale needed to bring applications closer to their users.

+ Regions preserve data residency and offer comprehensive compliance and resiliency options for customers. 

+ For most Azure services, when you deploy a resource in Azure, you choose the region where you want your resource to be deployed. 

> [!IMPORTANT]
> Some services or virtual machine features are only available in certain regions, such as specific virtual machine sizes or storage types. There are also some global Azure services that do not require you to select a particular region, such as Microsoft Azure Active Directory, Microsoft Azure Traffic Manager, and Azure DNS.

### Special Azure regions

Azure has specialized regions that you might want to use when building out your applications for compliance or legal purposes. These include:

- *US DoD Central*, *US Gov Virginia, Texas and Arizona* and more: These are physical and logical network-isolated instances of Azure for US government agencies and partners. These datacenters are operated by screened US persons and include additional compliance certifications.

- *China East*, *China North* and more: These regions are available through a unique partnership between Microsoft and 21Vianet, whereby Microsoft does not directly maintain the datacenters.

✔️ View the latest [Azure regions map.](https://azure.microsoft.com/global-infrastructure/geographies?azure-portal=true
)