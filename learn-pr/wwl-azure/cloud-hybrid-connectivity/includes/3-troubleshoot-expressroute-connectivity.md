ExpressRoute works over a private fiber-optic connection to provide a fast connection to Azure than would otherwise be possible over the internet. In this unit, you will learn how to troubleshoot issues you might encounter with ExpressRoute connectivity.

The following diagram shows connectivity between your network (Customer network) and Azure (Microsoft Datacenter):

:::image type="content" source="../media/3-connectivity.png" alt-text="connectivity between your network (Customer network) and Azure (Microsoft Datacenter)":::

Before you can use ExpressRoute, you must have an active Microsoft Azure account.

If you also want to connect to Microsoft 365 services, you will need at least one Microsoft 365 account. However, Microsoft 365 is optimized for connecting over the internet, so is only recommended for specific cases.

You will also need to work with a service provider to manage the private connection.

| Subscription required| Microsoft Azure only| Microsoft Azure and Microsoft 365|
| :--- | :--- | :--- |
| Microsoft Azure account| Recommended | Recommended|
| Microsoft 365| **Not Recommended**| Recommended|

## Gateways and SKUs

ExpressRoute uses a virtual gateway to connect your Azure virtual network with your on-premises network.

A virtual network gateway is two or more VMs that are a deployed to a **gateway subnet**. The gateway VMs contain routing tables and run specific gateway services.

There are two types of gateway—VPN and ExpressRoute. VPN gateways send encrypted traffic across the internet. ExpressRoute gateways send traffic across a private, unencrypted connection. When configuring the gateway, you need to specify the type as: **ExpressRoute**.

Each virtual network can have one gateway for each type, so you can configure:

- A virtual network gateway for VPN traffic: type **Vpn**.

- A virtual network gateway for ExpressRoute traffic: type **ExpressRoute**.

You can also configure the gateway SKU that you want to use. SKUs refer to the bandwidth that is allocated to the gateway. A higher gateway SKU allows more CPUs and network bandwidth throughput. ExpressRoute gateways support the following SKUs:

- Standard

- HighPerformance

- UltraPerformance

- ErGw1Az

- ErGw2Az

- ErGw3Az

To upgrade a gateway SKU, you can use the following PowerShell cmdlet:

```powershell
Resize-AzVirtualNetworkGateway

```

Alternatively, change the configuration in the **Azure portal virtual network gateway** configuration blade. The following upgrades are supported:

- Standard to High Performance

- Standard to Ultra Performance

- High Performance to Ultra Performance

- ErGw1Az to ErGw2Az

- ErGw1Az to ErGw3Az

- ErGw2Az to ErGw3Az

- Default to Standard

The following downgrades are supported:

- High Performance to Standard

- ErGw2Az to ErGw1Az

If the upgrade or downgrade you require is not supported, delete and recreate the gateway.

Before you can create an ExpressRoute gateway, you must establish a gateway subnet that contains the IP addresses for the subnet.

In the Azure portal, select your virtual network, select **Subnets**, and then select **Create Gateway Subnet**. When you configure the IP address range for your gateway subnet, a configuration with an ExpressRoute gateway and a VPN gateway coexisting will need a large gateway subnet. You should also ensure that the gateway subnet contains enough IP addresses to include future additional configurations. Microsoft recommends a gateway subnet of /27 or larger (/27, /26 and so on).

- The gateway subnet is used for ExpressRoute only. Do not assign anything else to the gateway subnet.

- It must be named **GatewaySubnet**.

- User-defined routes with a 0.0.0.0/0 destination are not supported.

- NSGs on the GatewaySubnet are not supported.

- Set the [BGP Route Propagation](/azure/virtual-network/virtual-networks-udr-overview) to **Enabled**. If this is set to **Disabled**, the gateway will not function.

When you create your virtual network gateway, gateway VMs are deployed to the gateway subnet and configured with the required ExpressRoute gateway settings.

> [!NOTE]
> It can take up to 45 minutes for the gateway to be created and ready for use.

## Determine whether an ExpressRoute circuit is operational

In the Azure portal, view existing ExpressRoute circuits by selecting **All services** > **Networking** > **ExpressRoute** circuits from the left menu.

:::image type="content" source="../media/3-expressroute-circuits.png" alt-text="Screenshot of Expressroute circuits settings":::

All ExpressRoute circuits created in the subscription will appear here.

:::image type="content" source="../media/3-expressroute-circuit-list.png" alt-text="Screenshot of Expressroute circuits list":::

To make the circuit operational, you must send the service key to the service provider. Each service key is specific to one circuit. Select the relevant circuit, and on the **Overview** page find the service key field for your provider.

:::image type="content" source="../media/3-service-key-field.png" alt-text="Screenshot of service key field":::

The **Provider status** displays the state of provisioning on the service-provider side.

**Circuit status** displays the state of provisioning on the Microsoft side.

When you create a new ExpressRoute circuit, the circuit is in the following state:

Provider status: **Not provisioned** Circuit status: **Enabled**

The circuit changes when the service provider is provisioning it for you:

Provider status: **Provisioning** Circuit status: **Enabled**

The ExpressRoute circuit is operational when it is in the following state:

Provider status: **Provisioned** Circuit status: **Enabled**

You can also check the provisioning status using the Azure PowerShell cmdlet:

```powershell
Get-AzExpressRouteCircuit -ResourceGroupName "Test-Resource" -Name "Test-Circuit"

```

The output shows both the circuit provisioning state, and the service provider provisioning state.

If the **Circuit status** is stuck at **Not Enabled**, contact [Microsoft Support](https://portal.azure.com/?).

If the **Provider status** is stuck at **Not Provisioned**, contact your service provider.

## Validate the peering configuration for the circuit

Each ExpressRoute circuit can have Azure private peering, and Microsoft peering. Azure private peering is traffic to private virtual networks in Azure. Microsoft peering is traffic to public endpoints of PaaS and SaaS.

The peerings are configured by your service provider. If the peering in the portal is still blank, try using refresh to pull through the current routing configuration from your circuit.

The status of an ExpressRoute circuit peering can be checked in the Azure portal, on the ExpressRoute Circuit **Overview** page. Any ExpressRoute peerings are displayed under the **Peerings** section.

:::image type="content" source="../media/3-peerings.png" alt-text="Screenshot of Expressroute peerings":::

In the screenshot above, Azure private peering is provisioned, but Azure public and Microsoft peerings are not. A successfully provisioned peering would also have the primary and secondary point-to-point subnets listed. 

If enabling a peering fails, check if the primary and secondary subnets assigned match the configuration on the linked CE/PE-MSEE. Also check if the correct VlanId, AzureASN, and PeerASN are used on MSEEs and if these values map to the ones used on the linked CE/PE-MSEE. If MD5 hashing is chosen, the shared key should be the same on MSEE and PE-MSEE/CE pair. For security reasons, the previously configured shared key would not be displayed.

> [!NOTE]
> The **Peering Location** indicates the [physical location](/azure/expressroute/expressroute-locations) where you are peering with Microsoft. The Location property indicates where the Azure Network Resource Provider is located. It is good practice to choose a Network Resource Provider geographically close to the Peering Location of the circuit.

You can also test your private peering connectivity by counting packets arriving and leaving the Microsoft Enterprise Edge (MSEE) devices. This tool will allow you to confirm connectivity by answering the questions such as:

- Are my packets getting to Azure?

- Are they getting back to my on-premises network?

To access this diagnostic tool from the Azure portal, select your ExpressRoute circuit, and then select **Diagnose and solve problems**.

## Validate that routes are live and configured correctly

You can validate that routes are live and configurated correctly by testing peering connectivity. Count the packets arriving and leaving the Microsoft edge of your ExpressRoute circuit, on the Microsoft Enterprise Edge (MSEE) devices. This diagnostic tool works by applying an Access Control List (ACL) to the MSEE to count the number of packets that hit specific ACL rules. Using this tool will allow you to confirm connectivity by answering the questions such as:

- Are my packets getting to Azure? 
- Are they getting back to on-premises?

1. To access this diagnostic tool, select **Diagnose and solve problems** from your ExpressRoute circuit in the Azure portal.

:::image type="content" source="../media/3-diagnose-solve-problems.png" alt-text="Diagnose and solve problems from the ExpressRoute circuit in the Azure portal":::

1. Select the **Connectivity issues**, under **Common Problems**.

   :::image type="content" source="../media/3-connectivity-issues.png" alt-text="Screenshot of connectivity issues":::

1. In the dropdown for **Tell us more about the problem you're experiencing**, select **Connectivity to Azure Private, Azure Public, or Dynamics 365 services**.

   :::image type="content" source="../media/3-connectivity-azure.png" alt-text="Screenshot showing connection to Azure Private, Azure Public, or Dynamics 365 services":::

- Scroll down to the **Test your private peering connectivity** section and expand it.

   :::image type="content" source="../media/3-test-private-peering-connectivity .png" alt-text="Screenshot showing Testing of private peering connectivity":::

- Execute the [PsPing](/sysinternals/downloads/psping) test from your on-premises IP address to your Azure IP address and keep it running during the connectivity test.

- Fill out the fields of the form, making sure to enter the same on-premises and Azure IP addresses used in <!--CE: Please check - I'm not sure what step 5 refers to.-->Step 5. Select **Submit** and wait for the results. When your results are ready, review the information for interpreting them below.

   :::image type="content" source="../media/3-connectivity-test.png" alt-text="Screenshot of Connectivity test":::

You'll have two sets of results for the primary and secondary MSEE devices. Review the number of matches in and out and use the following scenarios to interpret the results:

- **You see packet matches sent and received on both MSEEs**: This indicates healthy traffic inbound to and outbound from the MSEE on your circuit. If loss is occurring either on-premises or in Azure, it's happening downstream from the MSEE.

- **If testing PsPing from on-premises to Azure (received) results show matches, but sent results show NO matches**: This indicates that traffic is getting inbound to Azure but isn't returning to on-premises. Check for return path routing issues. Check whether you are advertising the appropriate prefixes to Azure. Check if there is an UDR overriding prefixes.

- **If testing PsPing from Azure to on-premises (sent) results show NO matches, but (received) results show matches**: This indicates that traffic is getting to on-premises, but not getting back. You should work with your provider to find out why traffic isn't being routed to Azure via your ExpressRoute circuit.

- **One MSEE shows NO matches, while the other shows good matches**: This indicates that one MSEE isn't receiving or passing any traffic. Check whether it is offline, for example, BGP/ARP down.

Example:

src 10.0.0.0 dst 20.0.0.0 dstport 3389 (received): 120 matches

src 20.0.0.0 srcport 3389 dst 10.0.0.0 (sent): 120 matches

This test result has the following properties:

- IP Port: 3389

- On-premises IP Address CIDR: 10.0.0.0

- Azure IP Address CIDR: 20.0.0.0

## Reset an ExpressRoute circuit

When an operation on an ExpressRoute circuit doesn't complete successfully, the circuit might go into a "failed" state. You can reset a failed ExpressRoute circuit using Azure PowerShell. You will need the latest version of the Azure Resource Manager PowerShell cmdlets.

- Open your PowerShell console with elevated privileges and connect to your account. Use the following example to help you connect:

```powershell
Connect-AzAccount

```

- If you have multiple Azure subscriptions, check the subscriptions for the account.

```powershell
Get-AzSubscription

```

- Specify the subscription that you want to use.

```powershell
Select-AzSubscription -SubscriptionName "Replace_with_your_subscription_name"

```

- Run the following commands to reset a circuit that is in a failed state:

```powershell
$ckt = Get-AzExpressRouteCircuit -Name "ExpressRouteARMCircuit" -ResourceGroupName "ExpressRouteResourceGroup"

Set-AzExpressRouteCircuit -ExpressRouteCircuit $ckt

```

The circuit should now be reset. 

## Troubleshoot asymmetric routing issues

Asymmetric routing is when the return network traffic takes a different path from the original outgoing flow. For example, if you have an internet path and a private path that goes to the same destination. It also happens when you have multiple private paths connected to the same destination.

Traceroute is the best way to make sure that your network traffic is traversing the expected path.

When you connect through Azure ExpressRoute, you have multiple links to Microsoft. You have your existing internet connection, and the ExpressRoute connection. Traffic destined for Microsoft might go through the internet connection but return through the ExpressRoute connection. Alternatively, traffic could go through ExpressRoute but return over the internet path.

You receive more specific IP addresses from the ExpressRoute circuit. So, when traffic from your network goes to Microsoft for services offered through ExpressRoute, traffic will be routed to the ExpressRoute connection.

There are two options when solving asymmetric routing—using routing, or by using source-based NAT (SNAT).

With the routing option, advertise your public IP addresses to appropriate wide area network (WAN) links. As an example, to use the internet for authentication traffic and ExpressRoute for mail traffic would require that you don't advertise your Active Directory Federation Services (AD FS) public IP addresses over ExpressRoute. Also, be sure not to expose your on-premises AD FS server to IP addresses that the router receives over ExpressRoute. Routes received over ExpressRoute are more specific, so they make ExpressRoute the preferred path for authentication traffic to Microsoft.

To use ExpressRoute for authentication, advertise AD FS public IP addresses over ExpressRoute without NAT. This sends the traffic that originates from Microsoft through ExpressRoute to your on-premises AD FS server. The return traffic from your network that goes to Microsoft will use ExpressRoute because it's the preferred route over the internet.

Alternatively, use SNAT to prevent asymmetric routing. For example, if you want to send SMPT traffic over the internet, do not advertise the public IP address of an on-premises SMTP server through ExpressRoute.

A request originating from Microsoft that goes to your on-premises SMTP server traverses the internet. You SNAT the incoming request to an internal IP address. The return traffic from the SMTP server will go to the edge firewall (which you use for NAT) instead of through ExpressRoute, ensuring that the return traffic will take the internet path.

## Troubleshoot route filtering

When you configure peering on your ExpressRoute circuit, the Microsoft edge routers establish a pair of Border Gateway Protocol (BGP) sessions with the edge routers through your connectivity provider. At this point, no routes are advertised to your network. To enable route advertisements to your network, you must configure a route filter.

A route filter lets you identify services you want to consume. It's a list of allowed BGP community values. Once a route filter resource is defined and attached to an ExpressRoute circuit, all prefixes that map to the BGP community values get advertised to your network.

You must have authorization to consume Microsoft 365 services through ExpressRoute to attach route filters with Microsoft 365 services. If you don’t have this authorization, the operation will fail.

BGP community values associated with services accessible through Microsoft peering is available here: [ExpressRoute routing requirements](/azure/expressroute/expressroute-routing).

A route filter can have only one rule, and it must be of type **Allow**. You can associate a list of BGP community values associated with the rule.

Create a filter rule:

- To add and update rules, select the **manage rule** tab for your route filter.

  :::image type="content" source="../media/3-manage-rule.png" alt-text="Screenshot of Manage rule tab":::

- From the dropdown list, select the allowed service communities you want to connect to. Save the rule when you have finished.

  :::image type="content" source="../media/3-rule-settings.png" alt-text="Screenshot of Rule settings":::

## Troubleshoot redundant configurations

Each ExpressRoute circuit has a redundant pair of cross connections to ensure high availability. If one of the cross connections fails, you do not lose connectivity. The redundant connection provides connectivity, and high availability.

Each Azure VPN gateway is made up of two instances, both of which are in an active-standby state. When maintenance or unplanned disruption happens to the active instance, the standby instance would take over (fail over) automatically.

## Troubleshoot route updates

Network routing is the way that network traffic determines its path to reach a destination. Route tables are used to help determine routing paths by listing network topology information. If your virtual network contains a network virtual appliance (NVA), you must manually configure and update your route tables.

Azure Route Server allows you to configure, maintain, and deploy NVAs in your virtual network. Route Server also keeps virtual network address information up-to-date. Route Server eliminates the administrative overhead of maintaining route tables.

Alternatively, you can define static routes that override Azure’s default routes. Or you can add additional routes to a subnet’s route table. You produce custom routes by either creating [user-defined](/azure/virtual-network/virtual-networks-udr-overview) routes, or by exchanging [border gateway protocol](/azure/virtual-network/virtual-networks-udr-overview) (BGP) routes between your on-premises network gateway and an Azure virtual network gateway.

To troubleshoot route updates, try the following:

- Do not deploy a virtual appliance in the same subnet as the route table that routes traffic through it. This can result in routing loops, which means that traffic never leaves the subnet.

- Ensure a next hop private IP address has direct connectivity without routing through ExpressRoute Gateway or Virtual WAN. Setting the next hop to an IP address without direct connectivity results in an invalid user-defined routing configuration.

## Identify the root cause for ExpressRoute latency issues

To troubleshoot latency issues with ExpressRoute, the Azure Connectivity Toolkit includes a tool called iPerf.

You use iPerf for basic performance tests, by copying the files to a directory on the host.  To test performance, follow these steps:

1. Install the PowerShell Module.

   ```console
   (new-object Net.WebClient).DownloadString("https://aka.ms/AzureCT") | Invoke-Expression

   ```

   This command downloads the PowerShell module and installs it locally.

1. Install the supporting applications.

   ```console
   Install-LinkPerformance

   ```

   This AzureCT command installs iPerf and PSPing in a new directory, "C:\ACTTools". It also opens the Windows Firewall ports to allow ICMP and port 5201 (iPerf) traffic.

1. Run the performance test.

   First, on the remote host, you must install and run iPerf in server mode. Ensure the remote host is listening on either 3389 (RDP for Windows) or 22 (SSH for Linux) and allowing traffic on port 5201 for iPerf. If the remote host is Windows, install the AzureCT and run the Install-LinkPerformance command. The command will set up iPerf and the necessary firewall rules.

   When the remote machine is ready, open PowerShell on the local machine and start the test:

   ```powershell
   Get-LinkPerformance -RemoteHost 10.0.0.1 -TestSeconds 10

   ```

   This command runs a series of concurrent load and latency tests to help estimate the bandwidth capacity and latency of your network link.

1. Review the output of the tests.

The detailed results of iPerf tests are in individual text files in the AzureCT tools directory at "C:\ACTTools."

The PowerShell output format looks similar to:

:::image type="content" source="../media/3-powershelloutput.png" alt-text="Screenshot of PowerShell output of test":::

If the performance test doesn’t give the results you expected results, use a step-by-step process to resolve the issue.

First, challenge your assumptions. If you have a 1Gbps ExpressRoute circuit and 100ms of latency, it's not reasonable to expect the full 1Gbps of traffic, given the characteristics of TCP over high latency links.

Second, start at the edges between routing domains to try to isolate the problem to a single major routing domain. You can start at the Corporate Network, the WAN, or the Azure Network. Make sure you have reasonable cause to contact your service provider or ISP, as this is outside your control. It could delay a fix that is under your control.

When you've identified the major routing domain that appears to contain the problem, create a diagram. Seeing the area in a diagram allows you to work methodically by planning points to test. Divide the network into segments to narrow down the problem and update the diagram as you get results.

Also, don't forget to look at other layers of the OSI model. It's easy to focus on the network and layers 1-3 (Physical, Data, and Network) but the problem could be at Layer 7 in the application layer. Keep an open mind and verify assumptions.

> [!NOTE]
> Geographic latency between endpoints is the largest component of latency. Equipment latency that has, for example, physical and virtual components, and number of hops, is involved. But geography has been shown to have a greater impact on overall latency when dealing with WAN connections. Remember that the distance of the fiber run is not the straight-line or roadmap distance. Use a city distance calculator which, although inaccurate, is good enough.
