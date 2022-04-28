After you've created an Azure virtual network, you can connect that network to SAP HANA on Azure (Large Instances). Create an Azure ExpressRoute gateway on the virtual network. This gateway enables you to link the virtual network to the ExpressRoute circuit that connects to the customer tenant on the HANA Large Instance stamp.

> [!NOTE]
> This step can take up to 30 minutes to complete. The new gateway is created in the designated Azure subscription and then connected to the specified Azure virtual network.

If a gateway already exists, check whether it's an ExpressRoute gateway or not. If it is not an ExpressRoute gateway, delete the gateway, and re-create it as an ExpressRoute gateway.

Use either the Azure portal or PowerShell to create an ExpressRoute VPN gateway connected to your virtual network.

 -  If you use the Azure portal, add a new Virtual Network Gateway, and then select **ExpressRoute** as the gateway type.
 -  If you use PowerShell, first download and use the latest Az PowerShell.

SAP HANA on Azure (Large Instances) supports only HighPerformance or UltraPerformance gateway SKUs. For HANA Large Instances of the Type II class SKU, you must use the UltraPerformance Gateway SKU.

## Link virtual networks

The Azure virtual network now has an ExpressRoute gateway. Use the authorization information provided by Microsoft to connect the ExpressRoute gateway to the SAP HANA Large Instances ExpressRoute circuit. You can connect by using the Azure portal or PowerShell. Make sure to use a connection-specific AuthGUID. The AuthGUID is specific for every virtual network and its gateway. If you want to add another Azure virtual network, you need to get another AuthID for your ExpressRoute circuit that connects HANA Large Instances into Azure from Microsoft.

When running the PowerShell script, you can use the ExpressRouteGatewayBypass parameter, which enables ExpressRoute FastPath. This functionality, added in May 2019, reduces network latency between your HANA Large Instance units and Azure VMs.

To connect the gateway to more than one ExpressRoute circuit associated with your subscription, you might need to run this step more than once. For example, you're likely going to connect the same virtual network gateway to the ExpressRoute circuit that connects the virtual network to your on-premises network.

## Apply ExpressRoute FastPath to existing HANA Large Instance ExpressRoute circuits

So far we have explored how to connect a new ExpressRoute circuit that got created with a HANA Large Instance deployment to an Azure ExpressRoute gateway of one of your Azure virtual networks. However, many customers already have their ExpressRoute circuits set up and have their virtual networks connected to HANA Large Instances. As the new ExpressRoute FastPath is reducing network latency, it is recommended that they apply the change to use this functionality. You can use the same procedure referenced in the previous section to change an existing ExpressRoute Circuit. In this case, you also have to use the ExpressRouteGatewayBypass parameter if you want to enable the ExpressRoute FastPath functionality.

## ExpressRoute Global Reach

If you want to enable Global Reach in one or both of the following two scenarios:

 -  HANA System Replication without any additional proxies or firewalls
 -  Copying backups between HANA Large Instance units in two different regions to perform system copies or system refreshes

You need to consider that:

 -  You need to provide an address space range of a /29 address space. That address range may not overlap with any of the other address space ranges that you used so far connecting HANA Large Instances to Azure and may not overlap with any of your IP address ranges you used somewhere else in Azure or on-premise.
 -  There is a limitation on the ASNs (Autonomous System Number) that can be used to advertise your on-premises routes to HANA Large Instances. Your on-premises must not advertise any routes with private ASNs in the range of 65000 – 65020 or 65515.
 -  For scenarios involving direct access from on-premises to HANA Large Instances, account for the cost of the circuit that connects on-premises networks to Azure.

To have one or both of the scenarios implemented in your deployment, raise a request with Azure support. You will need to include the following information in order for Microsoft to be able to route and execute your request:

 -  **Service**: SAP HANA Large Instance
 -  **Problem type**: Configuration and Setup
 -  **Problem subtype**: My problem is not listed above
 -  **Subject**: 'Modify my Network - add Global Reach'
 -  **Details**: 'Add Global Reach to HANA Large Instance to HANA Large Instance tenant'' or 'Add Global Reach to on-premise to HANA Large Instance tenant.'
 -  **Additional details for the HANA Large Instance to HANA Large Instance tenant case**: You need to define the two Azure regions where the two tenants to connect are located AND you need to submit the /29 IP address range
 -  **Additional details for the on-premise to HANA Large Instance tenant case**: You need to define the Azure Region where the HANA Large Instance tenant is deployed you want to connect to directly. Additionally, you need to provide the Auth GUID and Circuit Peer ID that you received when you established your ExpressRoute circuit between on-premise and Azure. Additionally, you need to name your ASN. The last deliverable is a /29 IP address range for ExpressRoute Global Reach.

> [!NOTE]
> If you want to have both cases handled, you need to supply two different /29 IP address ranges that do not overlap with any other IP address range used so far.
