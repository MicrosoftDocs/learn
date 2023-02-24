
The VPN gateway settings that you chose are critical to creating a successful connection for your virtual network. There are several parameters to specify for a VPN gateway in the Azure portal. 

### Things to consider when creating a VPN gateway

Let's take a closer look at considerations for configuring the VPN gateway settings.

:::image type="content" source="../media/create-virtual-gateways-fc2fd022.png" alt-text="Screenshot that shows how to configure a VPN gateway in the Azure portal." lightbox="../media/create-virtual-gateways-expanded.png":::

#### Project details

- **Subscription**: Use the drop-down menu to select the Subscription to use for creating the virtual network gateway resource.

- **Resource group**: Use the drop-down menu to select the resource group for the virtual network gateway resource.

#### Instance details

- **Name**: Provide a name to identify your VPN gateway.

- **Region**: Use the drop-down menu to select the Azure region (and Subscription) location for the VPN gateway. The location is where the resources you deploy to this virtual network gateway will reside.

- **Gateway type**: Select the type of gateway to create, **VPN** (Azure VPN gateway) or **ExpressRoute** (Azure ExpressRoute).

- **VPN type**: Select the type of VPN to create, **Route-based** or **Policy-based**. The type of VPN you choose depends on the make and model of your VPN device, and the kind of VPN connection you intend to create. In the next unit, we examine the options for this parameter setting in detail.

   - Route-based VPN gateways are the most common. Typical scenarios include point-to-site, inter-virtual network, or multiple site-to-site connections. Select route-based when your virtual network coexists with an Azure ExpressRoute gateway, or if you need to use the IKEv2 protocol.
   
   - Policy-based VPN gateways support only the IKEv1 protocol.

- **SKU**: Use the drop-down menu to select a gateway SKU. Review SKU options in the [Determine gateway SKU and generation](/azure/vpn-gateway/vpn-gateway-about-vpngateways#gwsku) unit.

   Your choice affects the number of VPN tunnels you can have and the Aggregate Throughput Benchmark. The benchmark value is based on measurements of multiple tunnels aggregated through a single gateway. The throughput isn't guaranteed due to internet traffic conditions and your application behavior. 

- **Generation**: Use the drop-down menu to select the gateway generation, **Generation1** or **Generation2**. Generation2 offers improved performance and SLA for the same price as Generation1. 

   - Generation1 supports Basic and VpnGw1 SKUs, along with most other SKUs supported in Generation2. 
   
   - Generation2 supports most SKUs available in Generation1, along with VpnGw4 and VpnGw5.

   > [!Note]
   > You can't change generations or SKUs across generations. 

- **Virtual network**: Use the drop-down menu to select an existing virtual network for the VPN gateway, or select **Create virtual network** to cofigure a new virtual network. Keep in mind that a virtual network can't be associated with more than one gateway. The virtual network sends and receives traffic through the VPN gateway. 

#### IP address

In the Azure portal, you can view the IP address assigned to the VPN gateway. Your gateway should appear as a connected device.