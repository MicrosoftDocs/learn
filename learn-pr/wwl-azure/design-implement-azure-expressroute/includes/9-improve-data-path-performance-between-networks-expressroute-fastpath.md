


ExpressRoute virtual network gateway is designed to exchange network routes and route network traffic. FastPath is designed to improve the data path performance between your on-premises network and your virtual network. When enabled, FastPath sends network traffic directly to virtual machines in the virtual network, bypassing the gateway.

**Circuits**

FastPath is available on all ExpressRoute circuits.

**Gateways**

FastPath still requires a virtual network gateway to be created to exchange routes between virtual network and on-premises network.

### Gateway requirements for ExpressRoute FastPath

To configure FastPath, the virtual network gateway must be either:

 -  Ultra-Performance
 -  ErGw3AZ

> [!IMPORTANT]
> If you plan to use FastPath with IPv6-based private peering over ExpressRoute, make sure to select ErGw3AZ for SKU. Note that this is only available for circuits using ExpressRoute Direct.

**Limitations**

While FastPath supports most configurations, it doesn't support the following features:

 -  UDR on the gateway subnet: This UDR has no impact on the network traffic that FastPath sends directly from your on-premises network to the virtual machines in Azure virtual network.
 -  Private Link: If you connect to a private endpoint in your virtual network from your on-premises network, the connection goes through the virtual network gateway.

### Configure ExpressRoute FastPath

Review the routing requirements, and workflows before you begin configuration.

 -  You must have an active ExpressRoute circuit.
 -  Follow the instructions to create an ExpressRoute circuit and have the circuit enabled by your connectivity provider.
 -  Ensure that you have Azure private peering configured for your circuit.
 -  Ensure that Azure private peering gets configured and establishes BGP peering between your network and Microsoft for end-to-end connectivity.
 -  Ensure that you have a virtual network and a virtual network gateway created and fully provisioned. A virtual network gateway for ExpressRoute uses the GatewayType 'ExpressRoute'.
 -  You can link up to 10 virtual networks to a standard ExpressRoute circuit. All virtual networks must be in the same geopolitical region when using a standard ExpressRoute circuit.
 -  A single virtual network can be linked to up to 16 ExpressRoute circuits. Use the following process to create a new connection object for each ExpressRoute circuit you're connecting to. The ExpressRoute circuits can be in the same subscription, different subscriptions, or a mix of both.
 -  If you enable the ExpressRoute premium add-on, you can link virtual networks outside of the geopolitical region of the ExpressRoute circuit. The premium add-on allows you to connect more than 10 virtual networks to your ExpressRoute circuit depending on the bandwidth chosen.
 -  To create the connection from the ExpressRoute circuit to the target ExpressRoute virtual network gateway, the number of address spaces advertised from the local or peered virtual networks needs to be equal to or less than **200**. Once the connection is successfully created, you can add other address spaces, up to 1,000, to the local or peered virtual networks.