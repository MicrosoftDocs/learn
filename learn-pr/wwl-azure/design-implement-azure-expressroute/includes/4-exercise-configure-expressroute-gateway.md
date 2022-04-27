> [!NOTE]
> To complete this exercise, you will need a Microsoft Azure subscription. If you don't already have one, you can sign up for a free trial at [https://azure.com/free](https://azure.com/free) .

## Deploy ExpressRoute gateways

To connect your Azure virtual network and your on-premises network via ExpressRoute, you must create a virtual network gateway first. A virtual network gateway serves two purposes: to exchange IP routes between the networks and to route network traffic.

**Gateway types**

When you create a virtual network gateway, you need to specify several settings. One of the required settings, '-GatewayType', specifies whether the gateway is used for ExpressRoute, or VPN traffic. The two gateway types are:

 -  **VPN** \- To send encrypted traffic across the public Internet, you use the gateway type 'VPN'. This is also referred to as a VPN gateway. Site-to-Site, Point-to-Site, and VNet-to-VNet connections all use a VPN gateway.
 -  **ExpressRoute** \- To send network traffic on a private connection, you use the gateway type 'ExpressRoute'. This is also referred to as an ExpressRoute gateway and is the type of gateway used when configuring ExpressRoute.

Each virtual network can have only one virtual network gateway per gateway type. For example, you can have one virtual network gateway that uses -GatewayType VPN, and one that uses -GatewayType ExpressRoute.

In this exercise, you will:

 -  Task 1: Create the VNet and gateway subnet
 -  Task 2: Create the virtual network gateway

## Task 1: Create the VNet and gateway subnet

1.  On any Azure portal page, in **Search resources, services and docs**, enter virtual network, and then select **Virtual networks** from the results.
2.  On the Virtual networks page, select **+Create**.
3.  On the Create virtual networks pane, on the **Basics** tab, use the information in the following table to create the VNet:
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Virtual Network Name
      :::column-end:::
      :::column:::
        CoreServicesVNet
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Resource Group
      :::column-end:::
      :::column:::
        ContosoResourceGroup
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Location
      :::column-end:::
      :::column:::
        East US
      :::column-end:::
    :::row-end:::
    
4.  Select **Next : IP addresses**.
5.  On the **IP Addresses** tab, in **IPv4 address space**, remove the default and enter 10.20.0.0/16, and then select **+ Add subnet**.
6.  In the Add subnet pane, use the information in the following table to create the subnet:
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Gateway Subnet name
      :::column-end:::
      :::column:::
        GatewaySubnet
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Gateway Subnet address space
      :::column-end:::
      :::column:::
        10.20.0.0/27
      :::column-end:::
    :::row-end:::
    
7.  And then select **Add**.
8.  On the Create virtual network page, select **Review + Create**.
    
    :::image type="content" source="../media/add-gateway-subnet.png" alt-text="Azure portal - add gateway subnet" lightbox="../media/add-gateway-subnet.png":::
    
9.  Confirm that the VNet passes the validation and then select **Create**.

> [!NOTE]
> If you are using a dual stack virtual network and plan to use IPv6-based private peering over ExpressRoute, click Add IP6 address space and input IPv6 address range values.

## Task 2: Create the virtual network gateway

1.  On any Azure portal page, in **Search resources, services and docs (G+/)**, enter virtual network gateway, and then select **Virtual network gateways** from the results.
2.  On the **Create virtual network gateway** page, use the information in the following table to create the gateway:
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Project details**
      :::column-end:::
      :::column:::
        
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Resource Group
      :::column-end:::
      :::column:::
        ContosoResourceGroup
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Instance details**
      :::column-end:::
      :::column:::
        
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Name
      :::column-end:::
      :::column:::
        CoreServicesVnetGateway
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Region
      :::column-end:::
      :::column:::
        East US
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Gateway type
      :::column-end:::
      :::column:::
        ExpressRoute
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        SKU
      :::column-end:::
      :::column:::
        Standard
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Virtual network
      :::column-end:::
      :::column:::
        CoreServicesVNet
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Public IP address**
      :::column-end:::
      :::column:::
        
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Public IP address
      :::column-end:::
      :::column:::
        Create new
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Public IP address name
      :::column-end:::
      :::column:::
        CoreServicesVnetGateway-IP
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Public IP address SKU
      :::column-end:::
      :::column:::
        Basic
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Assignment
      :::column-end:::
      :::column:::
        Not configurable
      :::column-end:::
    :::row-end:::
    
3.  Select **Review + Create**.
4.  Confirm that the Gateway configuration passes validation and then select **Create**.
5.  When the deployment is complete, select **Go to Resource**.

> [!NOTE]
> It can take up to 45 minutes to deploy a Gateway.

Congratulations! You have successfully created a Virtual network, a gateway subnet, and an ExpressRoute Gateway.
