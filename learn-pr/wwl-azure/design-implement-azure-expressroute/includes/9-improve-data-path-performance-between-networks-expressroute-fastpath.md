
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

While FastPath supports most configurations, it does not support the following features:

 -  UDR on the gateway subnet: This UDR has no impact on the network traffic that FastPath sends directly from your on-premises network to the virtual machines in Azure virtual network.
 -  VNet Peering: If you have other virtual networks peered with the one that is connected to ExpressRoute, the network traffic from your on-premises network to the other virtual networks (i.e., the so-called "Spoke" VNets) will continue to be sent to the virtual network gateway. The workaround is to connect all the virtual networks to the ExpressRoute circuit directly.
 -  Basic Load Balancer: If you deploy a Basic internal load balancer in your virtual network or the Azure PaaS service you deploy in your virtual network uses a Basic internal load balancer, the network traffic from your on-premises network to the virtual IPs hosted on the Basic load balancer will be sent to the virtual network gateway. The solution is to upgrade the Basic load balancer to a Standard load balancer.
 -  Private Link: If you connect to a private endpoint in your virtual network from your on-premises network, the connection will go through the virtual network gateway.

### Configure ExpressRoute FastPath

To enable FastPath, connect a virtual network to an ExpressRoute circuit using the Azure portal.

This section shows you how to create a connection to link a virtual network to an Azure ExpressRoute circuit using the Azure portal. The virtual networks that you connect to your Azure ExpressRoute circuit can either be in the same subscription or be part of another subscription.

**Prerequisites**

 -  Review the routing requirements, and workflows before you begin configuration.
 -  You must have an active ExpressRoute circuit.
 -  Follow the instructions to create an ExpressRoute circuit and have the circuit enabled by your connectivity provider.
 -  Ensure that you have Azure private peering configured for your circuit.
 -  Ensure that Azure private peering gets configured and establishes BGP peering between your network and Microsoft for end-to-end connectivity.
 -  Ensure that you have a virtual network and a virtual network gateway created and fully provisioned. A virtual network gateway for ExpressRoute uses the GatewayType 'ExpressRoute', not VPN.
 -  You can link up to 10 virtual networks to a standard ExpressRoute circuit. All virtual networks must be in the same geopolitical region when using a standard ExpressRoute circuit.
 -  A single VNet can be linked to up to 16 ExpressRoute circuits. Use the following process to create a new connection object for each ExpressRoute circuit you are connecting to. The ExpressRoute circuits can be in the same subscription, different subscriptions, or a mix of both.
 -  If you enable the ExpressRoute premium add-on, you can link virtual networks outside of the geopolitical region of the ExpressRoute circuit. The premium add-on will also allow you to connect more than 10 virtual networks to your ExpressRoute circuit depending on the bandwidth chosen.
 -  To create the connection from the ExpressRoute circuit to the target ExpressRoute virtual network gateway, the number of address spaces advertised from the local or peered virtual networks needs to be equal to or less than **200**. Once the connection has been successfully created, you can add additional address spaces, up to 1,000, to the local or peered virtual networks.

**Connect a VNet to a circuit - same subscription**

> [!NOTE]
> BGP configuration information will not appear if the layer 3 provider configured your peering. If your circuit is in a provisioned state, you should be able to create connections.

1.  To create a connection Ensure that your ExpressRoute circuit and Azure private peering have been configured successfully. Your ExpressRoute circuit should look like the following image:

    :::image type="content" source="../media/express-route-circuit-ba06fb75.png" alt-text="Azure portal - ExpressRoute circuit provisioned for private peering":::


2.  You can now start provisioning a connection to link your virtual network gateway to your ExpressRoute circuit. Select **Connection** &gt; **Add** to open the **Add connection** page.

    :::image type="content" source="../media/add-connection-3d903613.png" alt-text="Azure portal - Add a connection":::


3.  Enter a name for the connection and then select **Next: Settings >**.

    :::image type="content" source="../media/create-connection-basic-9e210444.png" alt-text="Azure portal - Create connection basics tab":::


4.  Select the gateway that belongs to the virtual network that you want to link to the circuit and select **Review + create**. Then select **Create** after validation completes.

    :::image type="content" source="../media/create-connection-settings-5e5bf3ff.png" alt-text="Azure portal - Create connection settings tab - specify ERGW virtual network gateway":::


5.  After your connection has been successfully configured, your connection object will show the information for the connection.

    :::image type="content" source="../media/connection-object-c2c46f5e.png" alt-text="Azure portal - verify connection i successful":::


**Administration - About circuit owners and circuit users**

The 'circuit owner' is an authorized Power User of the ExpressRoute circuit resource. The circuit owner can create authorizations that can be redeemed by 'circuit users'. Circuit users are owners of virtual network gateways that are not within the same subscription as the ExpressRoute circuit. Circuit users can redeem authorizations (one authorization per virtual network).

The circuit owner has the power to modify and revoke authorizations at any time. Revoking an authorization results in all link connections being deleted from the subscription whose access was revoked.

**Circuit owner operations**

**To create a connection authorization**

The circuit owner creates an authorization, which creates an authorization key to be used by a circuit user to connect their virtual network gateways to the ExpressRoute circuit. An authorization is valid for only one connection.

> [!NOTE]
> Each connection requires a separate authorization.

1.  In the ExpressRoute page, select **Authorizations** and then type a **name** for the authorization and select **Save**.

    :::image type="content" source="../media/authorization-ea88e96f.png" alt-text="Azure portal - configure authorization":::


2.  Once the configuration is saved, copy the **Resource ID** and the **Authorization Key**.

    :::image type="content" source="../media/authorization-key-a8f3cdc7.png" alt-text="Azure portal - configure authorization showing resource Id and Authorization key":::


3.  To delete a connection authorization

You can delete a connection by selecting the Delete icon for the authorization key for your connection.

:::image type="content" source="../media/delete-authorization-key-eb398439.png" alt-text="Azure portal - delete authorization key only":::


If you want to delete the connection but retain the authorization key, you can delete the connection from the connection page of the circuit.

:::image type="content" source="../media/delete-connection-owning-circuit-d3fe783f.png" alt-text="Azure portal - delete connection owning circuit":::


**Circuit user operations**

The circuit user needs the resource ID and an authorization key from the circuit owner.

To redeem a connection authorization

1.  Select the + Create a resource button. Search for Connection and select Create.

    :::image type="content" source="../media/create-new-resources.png" alt-text="Azure portal - create new connection" lightbox="../media/create-new-resources.png":::

2.  Make sure the Connection type is set to **ExpressRoute**. Select the Resource group and Location, then select **OK** in the Basics page.

    >[!Note]
    > The location must match the virtual network gateway location you are creating the connection for.

    :::image type="content" source="../media/connection-basics-f709aea2.png" alt-text="Azure portal - create connection basics tab":::


3.  In the **Settings** page, Select the Virtual network gateway and check the **Redeem authorization** check box. Enter the Authorization key and the Peer circuit URI and give the connection a name. Select **OK**.

    > [!Note] 
    > The Peer Circuit URI is the Resource ID of the ExpressRoute circuit (which you can find under the Properties Setting pane of the ExpressRoute Circuit).

    :::image type="content" source="../media/connection-settings-4ed83727.png" alt-text="Azure portal - create connection settings tab":::


4.  Review the information in the **Summary** page and select **OK**.

    :::image type="content" source="../media/connection-summary-56e92204.png" alt-text="Azure portal - create connection summary":::


**Clean up resources**

1. You can delete a connection and unlink your VNet to an ExpressRoute circuit by selecting the **Delete** icon on the page for your connection.

    :::image type="content" source="../media/delete-connection-cf82781a.png" alt-text="Azure portal - delete connection":::