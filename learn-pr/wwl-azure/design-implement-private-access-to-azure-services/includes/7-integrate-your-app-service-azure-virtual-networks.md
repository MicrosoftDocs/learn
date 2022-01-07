## **Virtual network integration for Azure services**

Integrating Azure services to an Azure virtual network enables private access to the service from virtual machines or compute resources in the virtual network. You can integrate Azure services in your virtual network with the following options:

 -  Deploying dedicated instances of the service into a virtual network. The services can then be privately accessed within the virtual network and from on-premises networks.
 -  Using Private Link to access privately a specific instance of the service from your virtual network and from on-premises networks.
 -  You can also access the service using public endpoints by extending a virtual network to the service, through Service Endpoints. Service Endpoints allow service resources to be secured to the virtual network.

### Azure VNet Limits

There are certain limits around the number of Azure resources you can deploy. Most Azure networking limits are at the maximum values. However, you can increase certain networking limits as specified on the [VNet limits page](/azure/azure-resource-manager/management/azure-subscription-service-limits).

## Configure App Service for regional VNET integration

With Azure Virtual Network (VNets), you can place many of your Azure resources in a non-internet-routable network. The VNet Integration feature enables your apps to access resources in or through a VNet. VNet Integration doesn't enable your apps to be accessed privately.

Azure App Service has two variations on the VNet Integration feature:

 -  The multitenant systems that support the full range of pricing plans except Isolated.
 -  The App Service Environment, which deploys into your VNet and supports Isolated pricing plan apps.

The VNet Integration feature is used in multitenant apps. If your app is in App Service Environment, then it's already in a VNet and doesn't require use of the VNet Integration feature to reach resources in the same VNet.

VNet Integration gives your app access to resources in your VNet, but it doesn't grant inbound private access to your app from the VNet. Private site access refers to making an app accessible only from a private network, such as from within an Azure virtual network. VNet Integration is used only to make outbound calls from your app into your VNet. The VNet Integration feature behaves differently when it's used with VNet in the same region and with VNet in other regions. The VNet Integration feature has two variations:

 -  Regional VNet Integration: When you connect to Azure Resource Manager virtual networks in the same region, you must have a dedicated subnet in the VNet you are integrating with.
 -  Gateway-required VNet Integration: When you connect to VNet in other regions or to a classic virtual network in the same region, you need an Azure Virtual Network gateway provisioned in the target VNet.

The VNet Integration features:

 -  Require a Standard, Premium, PremiumV2, PremiumV3, or Elastic Premium pricing plan.
 -  Support TCP and UDP.
 -  Work with Azure App Service apps and function apps.

There are some things that VNet Integration does not support, like:

 -  Mounting a drive.
 -  Active Directory integration.
 -  NetBIOS.

Gateway-required VNet Integration provides access to resources only in the target VNet or in networks connected to the target VNet with peering or VPNs. Gateway-required VNet Integration doesn't enable access to resources available across Azure ExpressRoute connections or work with Service Endpoints.

Regardless of the version used, VNet Integration gives your app access to resources in your VNet, but it doesn't grant inbound private access to your app from the VNet. Private site access refers to making your app accessible only from a private network, such as from within an Azure VNet. VNet Integration is only for making outbound calls from your app into your VNet. Follow the steps below to learn how VNet integration is enabled.

## Configure the virtual network for integration with App Service

Go to the **Networking** UI in the App Service portal. Under **VNet Integration**, select **Click here to configure**.

Select **Add VNet**.

:::image type="content" source="../media/vnet-integration-416e7c79.png" alt-text="Select VNet Integration" lightbox="../media/vnet-integration-416e7c79.png":::


The drop-down list contains all of the Azure Resource Manager virtual networks in your subscription in the same region. Underneath that is a list of the Resource Manager virtual networks in all other regions. Select the VNet you want to integrate with.

:::image type="content" source="../media/vnet-integration-configuration-15c78756.png" alt-text="Select the VNet" lightbox="../media/vnet-integration-configuration-15c78756.png":::


If the VNet is in the same region, either create a new subnet or select an empty preexisting subnet.

To select a VNet in another region, you must have a VNet gateway provisioned with point to site enabled.

To integrate with a classic VNet, instead of selecting the **Virtual Network** drop-down list, select **Click here to connect to a Classic VNet**. Select the classic virtual network you want. The target VNet must already have a Virtual Network gateway provisioned with point-to-site enabled.

:::image type="content" source="../media/vnet-details-e19017ad.png" alt-text="Select Classic VNet":::


During the integration, your app is restarted. When integration is finished, you will see details on the VNet you're integrated with.

## Associate the App Service with the virtual network

Using regional VNet Integration enables your app to access:

 -  Resources in a VNet in the same region as your app.
 -  Resources in VNets peered to the VNet your app is integrated with.
 -  Service Endpoint secured services.
 -  Resources across Azure ExpressRoute connections.
 -  Resources in the VNet you are integrated with.
 -  Resources across peered connections, which include Azure ExpressRoute connections.

**Private Endpoints**

When you use VNet Integration with VNets in the same region, you can use the following Azure networking features:

Network security groups (NSGs): You can block outbound traffic with an NSG that is placed on your integration subnet. The inbound rules do not apply because you can't use VNet Integration to provide inbound access to your app.

Route tables (UDRs): You can place a route table on the integration subnet to send outbound traffic where you want.

By default, your app routes only RFC1918 traffic into your VNet. If you want to route all your outbound traffic into your VNet, use the following steps to add the WEBSITE\_VNET\_ROUTE\_ALL setting in your app:

1.  Go to the Configuration UI in your app portal. Select New application setting.
2.  Enter WEBSITE\_VNET\_ROUTE\_ALL in the Name box and enter 1 in the Value box.

:::image type="content" source="../media/vnet-integration-app-setting-6e6a7148.png" alt-text="Provide application setting":::


3.  Select OK.
4.  Select Save.

When you route all your outbound traffic into your VNet, it's subject to the NSGs and UDRs that are applied to your integration subnet. When WEBSITE\_VNET\_ROUTE\_ALL is set to 1, outbound traffic is still sent from the addresses that are listed in your app properties, unless you provide routes that direct the traffic elsewhere.

Regional VNet integration can't use port 25.

## Specify networking settings for application, including DNS and routing

**Service Endpoints**

Regional VNet Integration enables you to reach Azure services that are secured with Service Endpoints. To access a Service Endpoint-secured service, you must do the following:

Configure regional VNet Integration with your web app to connect to a specific subnet for integration.

Go to the destination service and configure Service Endpoints against the integration subnet.

**Network security groups**

You can use network security groups to block inbound and outbound traffic to resources in a VNet. An app that uses regional VNet Integration can use a network security group to block outbound traffic to resources in your VNet or the internet. To block traffic to public addresses, you must have the application setting WEBSITE\_VNET\_ROUTE\_ALL set to 1. The inbound rules in an NSG don't apply to your app because VNet Integration affects only outbound traffic from your app.

To control inbound traffic to your app, use the Access Restrictions feature. An NSG that is applied to your integration subnet is in effect regardless of any routes applied to your integration subnet. If WEBSITE\_VNET\_ROUTE\_ALL is set to 1 and you do not have any routes that affect public address traffic on your integration subnet, all your outbound traffic is still subject to NSGs assigned to your integration subnet. When WEBSITE\_VNET\_ROUTE\_ALL is not set, NSGs are only applied to RFC1918 traffic.

**Routes**

You can use route tables to route outbound traffic from your app to wherever you want. By default, route tables only affect your RFC1918 destination traffic. When you set WEBSITE\_VNET\_ROUTE\_ALL to 1, all your outbound calls are affected. Routes that are set on your integration subnet will not affect replies to inbound app requests. Common destinations can include firewall devices or gateways.

If you want to route all outbound traffic on-premises, you can use a route table to send all outbound traffic to your ExpressRoute gateway. If you do route traffic to a gateway, be sure to set routes in the external network to send any replies.

Border Gateway Protocol (BGP) routes also affect your app traffic. If you have BGP routes from something like an ExpressRoute gateway, your app outbound traffic is affected. By default, BGP routes affect only your RFC1918 destination traffic. When WEBSITE\_VNET\_ROUTE\_ALL is set to 1, all outbound traffic can be affected by your BGP routes.

**Azure DNS private zones**

After your app integrates with your VNet, it uses the same DNS server that your VNet is configured with. By default, your app won't work with Azure DNS private zones. To work with Azure DNS private zones, you need to add the following app settings:

WEBSITE\_DNS\_SERVER with value 168.63.129.16

WEBSITE\_VNET\_ROUTE\_ALL with value 1

These settings send all your outbound calls from your app into your VNet and enable your app to access an Azure DNS private zone. With these settings, your app can use Azure DNS by querying the DNS private zone at the worker level.

**Private Endpoints**

If you want to make calls to [Private Endpoints](/azure/app-service/networking/private-endpoint), then you must make sure that your DNS lookups resolve to the Private Endpoint. You can enforce this behavior in one of the following ways:

 -  Integrate with Azure DNS private zones. When your VNet doesn't have a custom DNS server, this is done automatically.
 -  Manage the Private Endpoint in the DNS server used by your app. To do this you must know the Private Endpoint address and then point the endpoint you are trying to reach to that address using an A record.
 -  Configure your own DNS server to forward to Azure DNS private zones.

## Configure Azure Kubernetes Service (AKS) for regional VNET integration

In many environments, you have defined virtual networks and subnets with allocated IP address ranges. These virtual network resources are used to support multiple services and applications. To provide network connectivity, AKS clusters can use kubenet (basic networking) or Azure CNI (advanced networking).

With kubenet, only the nodes receive an IP address in the virtual network subnet. Pods can't communicate directly with each other. Instead, User Defined Routing (UDR) and IP forwarding is used for connectivity between pods across nodes. By default, UDRs and IP forwarding configuration is created and maintained by the AKS service, but you have to the option to bring your own route table for custom route management. You could also deploy pods behind a service that receives an assigned IP address and load balances traffic for the application. The following diagram shows how the AKS nodes receive an IP address in the virtual network subnet, but not the pods:

:::image type="content" source="../media/kunenet-overview-2c08edda.png" alt-text="diagram shows how the AKS nodes receive an IP address in the virtual network subnet, but not the pods":::


### Limitations &amp; considerations for kubenet

 -  An additional hop is required in the design of kubenet, which adds minor latency to pod communication.
 -  Route tables and user-defined routes are required for using kubenet, which adds complexity to operations.
 -  Direct pod addressing isn't supported for kubenet due to kubenet design.
 -  Unlike Azure CNI clusters, multiple kubenet clusters can't share a subnet.
 -  Features **not supported on kubenet** include:
    
     -  [Azure network policies](/azure/aks/use-network-policies), but Calico network policies are supported on kubenet
     -  [Windows node pools](/azure/aks/windows-faq)
     -  [Virtual nodes add-on](/azure/aks/virtual-nodes)

The choice of which network plugin to use for your AKS cluster is usually a balance between flexibility and advanced configuration needs. The following considerations help outline when each network model may be the most appropriate.

Use kubenet when:

 -  You have limited IP address space.
 -  Most of the pod communication is within the cluster.
 -  You don't need advanced AKS features such as virtual nodes or Azure Network Policy. Use [Calico network policies](https://docs.projectcalico.org/v3.9/security/calico-network-policy).

Use Azure CNI when:

 -  You have available IP address space.
 -  Most of the pod communication is to resources outside of the cluster.
 -  You don't want to manage user defined routes for pod connectivity.
 -  You need AKS advanced features such as virtual nodes or Azure Network Policy. Use [Calico network policies](https://docs.projectcalico.org/v3.9/security/calico-network-policy).
