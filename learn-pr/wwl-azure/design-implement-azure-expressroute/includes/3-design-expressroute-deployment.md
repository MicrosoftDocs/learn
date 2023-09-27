
ExpressRoute enables us to connect on Premises to Azure services seamlessly. lets review some design decisions you will make before deploying an ExpressRoute circuit.

## **ExpressRoute circuit SKUs**

Azure ExpressRoute has three different circuit SKUs: [Local](/azure/expressroute/expressroute-faqs), Standard, and [Premium](/azure/expressroute/expressroute-faqs). The way you are charged for your ExpressRoute usage varies between these three SKU types.

 -  **Local SKU** \- With Local SKU, you are automatically charged with an Unlimited data plan.
 -  **Standard and Premium SKU** \- You can select between a Metered or an Unlimited data plan. All ingress data are free of charge except when using the Global Reach add-on.

> [!Important]
>
> Based on requirements of workloads and data plan, selection of SKU types can help optimize cost and budget.

### Explore pricing based on ExpressRoute SKU

SKU models have been discussed previously as Local, Standard and Premium. It is a good practice to estimate costs before using Azure ExpressRoute as the price might affect your design decisions.

Use the [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator/) to estimate costs before you create an Azure ExpressRoute circuit.

1.  On the left, select **Networking**, then select **Azure ExpressRoute** to begin.
2.  Select the appropriate Zone depending on your peering location.
3.  Then select the SKU, Circuit Speed, and the Data Plan you would like an estimate for.
4.  In the Additional outbound data transfer, enter an estimate in GB of how much outbound data you might use over the course of a month.
5.  Lastly, you can add the Global Reach Add-on to the estimate.

## Choose a peering location

Peering location is of importance when working with ExpressRoute.

> [!Note]
>
> Azure regions and ExpressRoute locations are two distinct and different concepts, understanding the difference between the two is critical to exploring Azure hybrid networking connectivity.

**Azure regions**

Azure regions are global datacenters where Azure compute, networking and storage resources are located. When creating an Azure resource, a customer needs to select a resource location. The resource location determines which Azure datacenter (or availability zone) the resource is created in.

**ExpressRoute locations (Peering locations)**

ExpressRoute locations (sometimes referred to as peering locations or meet-me-locations) are co-location facilities where Microsoft Enterprise Edge (MSEE) devices are located. ExpressRoute locations are the entry point to Microsoft's network – and are globally distributed, providing customers the opportunity to connect to Microsoft's network around the world. These locations are where ExpressRoute partners and ExpressRoute Direct customers issue cross connections to Microsoft's network. You would have access to Azure services across all regions within a geopolitical region if you connected to at least one ExpressRoute location within the geopolitical region.

**Azure regions to ExpressRoute locations within a geopolitical region.**

The following link provides a list of [Azure regions to ExpressRoute locations](/azure/expressroute/expressroute-locations) within a geopolitical region. This page is kept up to date with the latest ExpressRoute locations and providers.

**ExpressRoute connectivity providers**

The following link list's locations by service provider. This page is kept up to date with the latest available providers by location, see [Service providers by location](/azure/expressroute/expressroute-locations-providers).

**Connectivity through Exchange providers**

If your connectivity provider is not listed in previous sections, you can still create a connection. Several connectivity providers are already connected to Ethernet exchanges.

**Connectivity through satellite operators**

If you are remote and do not have fiber connectivity or want to explore other connectivity options, you can check the following satellite operators.

Additional Connectivity options:

 -  Through additional service providers
 -  Datacenter providers
 -  National Research and Education networks (NERN)
 -  System integrators

## Choose the right ExpressRoute circuit and billing model

Microsoft offers various Express Route options depending on the desired bandwidth of this private connection between the customer on premises network and the selected Azure region. Typically, enterprises need to evaluate their current usage and determine how much data they use monthly to start with.

The next step is to figure out which of the available ExpressRoute is the best choice depending upon the requirements of the Enterprise keeping in mind the budget and SLA requirements.

When you deploy ExpressRoute, you must choose between the Local, Standard and Premium SKUs. The Standard and Premium SKU are available in a metered version, where you pay per used GB and an unlimited option.

The other option is the ExpressRoute Direct, connecting your network to the closest Microsoft Edge node which then connects to the Microsoft Global Network, to connect to other customers offices or factories and any Azure Region. The usage of the Microsoft Global Network is charged on top of the ExpressRoute Direct.

Please refer to the [Express Route pricing](https://azure.microsoft.com/pricing/details/expressroute/) for details on metered and unlimited data plan based on the bandwidth.

You can purchase ExpressRoute circuits for a wide range of bandwidths. The supported bandwidths are listed as follows. Be sure to check with your connectivity provider to determine the bandwidths they support.

50 Mbps

100 Mbps

200 Mbps

500 Mbps

1 Gbps

2 Gbps

5 Gbps

10 Gbps

### Choose a billing model

You can pick a billing model that works best for you. Choose between the billing models listed as followed.

 -  **Unlimited data**. Billing is based on a monthly fee; all inbound and outbound data transfer is included free of charge.
 -  **Metered data**. Billing is based on a monthly fee; all inbound data transfer is free of charge. Outbound data transfer is charged per GB of data transfer. Data transfer rates vary by region.
 -  **ExpressRoute premium add-on**. ExpressRoute premium is an add-on to the ExpressRoute circuit. The ExpressRoute premium add-on provides the following capabilities:
    
     -  Increased route limits for Azure public and Azure private peering from 4,000 routes to 10,000 routes.
     -  Global connectivity for services. An ExpressRoute circuit created in any region (excluding national clouds) will have access to resources across every other region in the world. For example, a virtual network created in West Europe can be accessed through an ExpressRoute circuit provisioned in Silicon Valley.
     -  Increased number of VNet links per ExpressRoute circuit from 10 to a larger limit, depending on the bandwidth of the circuit.