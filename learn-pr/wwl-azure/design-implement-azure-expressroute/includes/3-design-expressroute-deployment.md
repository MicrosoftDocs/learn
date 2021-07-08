ExpressRoute enables us to connect on Premises to Azure services seamlessly. Before you learn about SKU's, let's explore the various connectivity models in ExpressRoute.

## **ExpressRoute SKUs and Tiers**

Azure ExpressRoute has three different circuit SKUs: [Local](/azure/expressroute/expressroute-faqs), Standard, and [Premium](/azure/expressroute/expressroute-faqs). The way you are charged for your ExpressRoute usage varies between these three SKU types. 

- **Local SKU** - With Local SKU, you are automatically charged with an Unlimited data plan. 
- **Standard and Premium SKU** - You can select between a Metered or an Unlimited data plan. All ingress data are free of charge except when using the Global Reach add-on. 

> [!Important] 
>
> Based on requirements of workloads and data plan, selection of SKU types can help optimize cost and budget.

### Choose a SKU model

SKU models have been discussed previously as Local, Standard and Premium. It is a good practice to estimate costs before using Azure ExpressRoute.

Use the [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator/) to estimate costs before you create an Azure ExpressRoute circuit.

- On the left, select **Networking**, then select **Azure ExpressRoute** to begin.
- Select the appropriate Zone depending on your peering location. 
- Then select the SKU, Circuit Speed, and the Data Plan you would like an estimate for.
- In the Additional outbound data transfer, enter an estimate in GB of how much outbound data you might use over the course of a month.
- Lastly, you can add the Global Reach Add-on to the estimate.

The following screenshot shows the cost estimation by using the calculator:

![Azure - capacity calculator cost estimate](../media/capacity-calculator-cost-estimate.png)

 

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

- Through additional service providers
- Datacenter providers
- National Research and Education networks (NERN)
- System integrators

## Choose the right ExpressRoute Circuit and billing model

Microsoft offers various Express Route options depending on the desired bandwidth of this private connection between the customer on premises network and the selected Azure region. Typically, enterprises need to evaluate their current usage and determine how much data they use monthly to start with. 

The next step is to figure out which of the available ExpressRoute is the best choice depending upon the requirements of the Enterprise keeping in mind the budget and SLA requirements.

When you deploy ExpressRoute, you must choose between the Local, Standard and Premium SKUs. All these options are available in a metered version, where you pay per used GB and an unlimited option.

The other option is the ExpressRoute Direct, connecting your network to the closest Microsoft edge node which then connects to the Microsoft Global Network, to connect to other customers offices or factories and any Azure Region. The usage of the Microsoft Global Network is charged on top of the of the ExpressRoute Direct.

Please refer to the [Express Route pricing](https://azure.microsoft.com/pricing/details/expressroute/) for details on metered and unlimited data plan based on the bandwidth.

you can purchase ExpressRoute circuits for a wide range of bandwidths. The supported bandwidths are listed as followed. Be sure to check with your connectivity provider to determine the bandwidths they support.

50 Mbps

100 Mbps

200 Mbps

500 Mbps

1 Gbps

2 Gbps

5 Gbps

10 Gbps

 

### Choose a billing model

Azure ExpressRoute runs on Azure infrastructure that accrues costs along with ExpressRoute when you deploy the new resource. It is important to understand that additional infrastructure might accrue cost. You need to manage that cost when you make changes to deployed resources.

Costs that typically accrue with ExpressRoute:-

**ExpressRoute**

When you create an ExpressRoute circuit, you might choose to create an ExpressRoute gateway to link your virtual networks to the circuit. ExpressRoute Gateways are charged at an hourly rate plus the cost of an ExpressRoute circuit. See [ExpressRoute pricing](https://azure.microsoft.com/pricing/details/expressroute) and select ExpressRoute Gateways to see rates for different gateway SKUs.

Inbound data transfer is included in the monthly cost of the ExpressRoute circuit for all three SKUs. Outbound data transfer is only included for an unlimited data plan. For a Metered data plan, outbound data transfer is charged per GB used based on the zone number of the [peering location](/azure/expressroute/expressroute-locations-providers).

**ExpressRoute Direct**

ExpressRoute Direct has a monthly port fee that includes the circuit fee for Local and Standard SKU ExpressRoute circuits. For Premium SKU circuits, there is an extra circuit fee. Outbound data transfer is charged per GB used depending on the zone number of the peering location. The outbound data charge only applies to Standard and Premium SKUs.

**ExpressRoute Global Reach**

ExpressRoute Global Reach is an add-on you can enable for ExpressRoute and ExpressRoute Direct to link ExpressRoute circuits together. Inbound and outbound data transfer is charged per GB used depending on the zone number of the peering location.

### Evaluate implications of changing SKUs after deployment

If you have an ExpressRoute gateway after deleting the ExpressRoute circuit, you will still be charged for the cost until you delete it.