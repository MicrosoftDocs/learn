In an existing Azure deployment, the on-premises network is typically connected via ExpressRoute or VPN, which is also used for SAP RISE/ECS managed workloads.

## ExpressRoute connectivity back to on-premises

With an existing customer Azure deployment, the on-premises network is already connected through ExpressRoute (ER) or VPN. The same on-premises network path is typically used for SAP RISE/ECS managed workloads. The preferred architecture is to use existing ER/VPN Gateways in the customer’s network for this purpose, with the connected SAP RISE virtual network seen as a spoke network connected to the customer’s virtual network hub.

:::image type="complex" source="../media/sap-rise-on-premises.png" alt-text="Diagram of S A P RISE / E C S as spoke network peered to customer's virtual network hub and on-premises.":::
   This diagram shows a typical S A P customer's hub and spoke virtual networks. Connects to on-premises with a connection. Cross tenant virtual network peering connects S A P RISE virtual network to customer's hub network. The virtual network peering has remote gateway transit enabled, enabling S A P RISE virtual network to be accessed from on-premises.
:::image-end:::

With this architecture, central policies and security rules governing network connectivity to customer workloads also apply to SAP RISE/ECS managed workloads. The same on-premises network path is used for both the customer's virtual network and the SAP RISE/ECS virtual network.

If there's currently no Azure to on-premises connectivity, contact your SAP representative for details of which connections models are possible for the RISE workload. If SAP RISE/ECS establishes on-premises connection within RISE directly, such on-premises connections are available only for reaching the SAP managed virtual network. Such dedicated ExpressRoute or VPN connection within SAP RISE can't be used to access the customer's own Azure virtual networks.

> [!NOTE]
> A virtual network can [only have one gateway](/azure/virtual-network/virtual-network-peering-overview.#gateways-and-on-premises-connectivity), local or remote. With virtual network peering established between SAP RISE using remote gateway transit, no gateways can be added in the SAP RISE/ECS virtual network. It isn't possible to combine virtual network peering with remote gateway transit together with another virtual network gateway in the SAP RISE/ECS virtual network.

## Azure Virtual WAN with SAP RISE managed workloads

Azure Virtual WAN hub can be used for the same purpose as a hub and spoke network architecture with connectivity to both SAP RISE/ECS virtual network and on-premises. The SAP RISE workload is a spoke network connected to the Virtual WAN network hub. Both connection options to SAP RISE described earlier (virtual network peering and VPN VNet-to-VNet) are available with Azure Virtual WAN.

The Virtual WAN network hub is deployed and managed by the customer in their own subscription. The customer entirely manages the on-premises connection and routing through the Virtual WAN network hub, with access to the SAP RISE peered spoke virtual network.
