You can use virtual network peering to directly connect Azure virtual networks together. When you use peering to connect virtual networks, virtual machines (VMs) in these networks can communicate with each other as if they're in the same network. 

With peered virtual networks, traffic between virtual machines is routed through the Azure network. The traffic uses only private IP addresses. It doesn't rely on internet connectivity, gateways, or encrypted connections. The traffic is always private, and it takes advantage of the high bandwidth and low latency of the Azure backbone network.

:::image type="content" source="../media/2-vnet-peering.svg" alt-text="A basic diagram of two virtual networks that are connected by virtual network peering.":::

The two types of peering connections are created in the same way:

- **Virtual network peering** connects virtual networks in the same Azure region, such as two virtual networks in North Europe.
- **Global virtual network peering** connects virtual networks that are in different Azure regions, such as a virtual network in North Europe and a virtual network in West Europe.

Virtual network peering doesn't affect or disrupt any resources that you've already deployed to the virtual networks. When you use virtual network peering, consider the key features defined in the following sections.

## Reciprocal connections

When you create a virtual network peering connection with Azure PowerShell or Azure CLI, only one side of the peering gets created. To complete the virtual network peering configuration, you'll need to configure the peering in reverse direction to establish connectivity. When you create the virtual network peering connection through the Azure portal, the configuration for both side is completed at the same time.

Think of how you'd connect two network switches together. You'd connect a cable to each switch and maybe configure some settings so that the switches can communicate. Virtual network peering requires similar connections in each virtual network. Reciprocal connections provide this functionality.

## Cross-subscription virtual network peering

You can use virtual network peering even when both virtual networks are in different subscriptions. This setup might be necessary for mergers and acquisitions, or to connect virtual networks in subscriptions that different departments manage. Virtual networks can be in different subscriptions, and the subscriptions can use the same or different Microsoft Entra tenants.

When you use virtual network peering across subscriptions, you might find that an administrator of one subscription doesn't administer the peer network's subscription. The administrator might not be able to configure both ends of the connection. To peer the virtual networks when both subscriptions are in different Microsoft Entra tenants, the administrators of each subscription must grant the peer subscription's administrator the `Network Contributor` role on their virtual network.

## Transitivity

Virtual network peering is nontransitive. Only virtual networks that are directly peered can communicate with each other. Virtual networks can't communicate with peers of their peers.

Suppose, for example, that your three virtual networks (A, B, C) are peered like this: A <-> B <-> C. Resources in A can't communicate with resources in C because that traffic can't transit through virtual network B. If you need communication between virtual network A and virtual network C, you must explicitly peer these two virtual networks.

## Gateway transit

You can connect to your on-premises network from a peered virtual network if you enable gateways transit from a virtual network that has a VPN gateway. Using gateway transit, you can enable on-premises connectivity without deploying virtual network gateways to all your virtual networks. This method can reduce the overall cost and complexity of your network. By using virtual network peering with gateway transit, you can configure a single virtual network as a hub network. Connect this hub network to your on-premises datacenter and share its virtual network gateway with peers.

To enable gateway transit, configure the **Allow gateway transit** option in the hub virtual network where you deployed the gateway connection to your on-premises network. Also configure the **Use remote gateways** option in any spoke virtual networks.

> [!NOTE]
> If you want to enable the **Use remote gateways** option in a spoke network peering, you can't deploy a virtual network gateway in the spoke virtual network.

## Overlapping address spaces

IP address spaces of connected networks within Azure, between Azure and your on-premises network can't overlap. This is also true for peered virtual networks. Keep this rule in mind when you're planning your network design. In any networks you connect through virtual network peering, VPN, or ExpressRoute, assign different address spaces that don't overlap.

:::image type="content" source="../media/2-non-overlapping-networks.svg" alt-text="Diagram of a comparison of overlapping and non-overlapping network addressing.":::

## Alternative connectivity methods

Virtual network peering is the least complex way to connect virtual networks together. Other methods focus primarily on connectivity between on-premises and Azure networks rather than connections between virtual networks.

You can also connect virtual networks together through an ExpressRoute circuit. ExpressRoute is a dedicated, private connection between an on-premises datacenter and the Azure backbone network. The virtual networks that connect to an ExpressRoute circuit are part of the same routing domain and can communicate with each other. ExpressRoute connections don't go over the public internet, so your communications with Azure services are as secure as possible.

VPNs use the internet to connect your on-premises datacenter to the Azure backbone through an encrypted tunnel. You can use a site-to-site configuration to connect virtual networks together through VPN gateways. VPN gateways have higher latency than virtual network peering setups. They're more complex and can cost more to manage.

When virtual networks are connected through both a gateway and virtual network peering, traffic flows through the peering configuration.

## When to choose virtual network peering

Virtual network peering can be a great way to enable network connectivity between services that are in different virtual networks. Because it's easy to implement and deploy, and it works well across regions and subscriptions, virtual network peering should be your first choice when you need to integrate Azure virtual networks.

Peering might not be your best option if you have [existing VPN or ExpressRoute](/azure/virtual-network/virtual-network-peering-overview#service-chaining) connections or services behind Azure Basic Load Balancers that would be accessed from a peered virtual network. In these cases, you should research alternatives.
