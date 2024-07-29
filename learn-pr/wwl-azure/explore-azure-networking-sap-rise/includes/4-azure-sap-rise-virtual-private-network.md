A virtual network to virtual network (VNet-to-VNet) connection provides a fast and reliable link between Azure and SAP RISE virtual private network (VPN) gateways.

## VPN - virtual network to virtual network

As an alternative to virtual network peering, VPN connections can be established between VPN gateways, deployed both in the SAP RISE/ECS Azure subscription and a customer's own Azure subscription. You can establish a [VNet-to-VNet connection](/azure/vpn-gateway/vpn-gateway-howto-vnet-vnet-resource-manager-portal) between these two VPN gateways, enabling fast communication between the two virtual networks. The respective networks and gateways can reside in different Azure regions.

:::image type="complex" source="../media/sap-rise-virtual-private-network.png" alt-text="Diagram of S A P RISE / E C S V P N connection to customer virtual network.":::
   This diagram shows a typical S A P customer's hub and spoke virtual networks. V P N gateway located in S A P RISE virtual network connects through vnet-to-vnet connection into gateway contained in customer's hub virtual network.
:::image-end:::

While virtual network peering is the typical and recommended deployment model, a VPN VNet-to-VNet can potentially simplify a complex virtual peering between customer and SAP RISE/ECS virtual networks. The VPN Gateway acts as the only point of entry into the customer’s network, with central team management and security. Network throughput is limited by the chosen gateway SKU on both sides. To address resiliency requirements, ensure that [zone-redundant virtual network gateways](/azure/vpn-gateway/about-zone-redundant-vnet-gateways) are used for such connections.

Network Security Groups are in both the customer and SAP virtual networks, identical to the peering architecture, for communication to SAP NetWeaver and SAP S/4HANA ports. For details of how to set up the VPN connection and which settings should be used, contact your SAP representative.
