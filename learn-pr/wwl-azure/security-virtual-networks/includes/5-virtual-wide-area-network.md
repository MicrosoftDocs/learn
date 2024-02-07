A Virtual WAN connects to your resources in Azure over an IPsec/IKE (IKEv1 and IKEv2) VPN connection. This type of connection requires a VPN device located on-premises that has an externally facing public IP address assigned to it.<br>

:::image type="content" source="../media/site-to-site-diagram-a352d3e7.png" alt-text="Diagram showing a site to site virtual wide area network connection.":::


## Prerequisites

 -  Verify that you have an Azure subscription. If you don't already have an Azure subscription, you can activate your MSDN subscriber benefits or sign up for a free account.
 -  Decide the IP address range that you want to use for your virtual hub private address space. This information is used when configuring your virtual hub. A virtual hub is a virtual network that is created and used by Virtual WAN. It's the core of your Virtual WAN network in a region. The address space range must conform to certain rules.<br>
     -  The address range that you specify for the hub can't overlap with any of the existing virtual networks that you connect to.<br>
     -  The address range can't overlap with the on-premises address ranges that you connect to.
     -  If you're unfamiliar with the IP address ranges located in your on-premises network configuration, coordinate with someone who can provide those details for you.

## Azure portal or Azure PowerShell<br>

You can use either the Azure portal or Azure PowerShell cmdlets to create a site-to-site connection to Azure Virtual WAN. The Cloud Shell is a free interactive shell that has common Azure tools pre-installed and configured to use with your account.

To open Cloud Shell, just select **Open Cloud Shell** from the upper-right corner of a code block. You can also open Cloud Shell on a separate browser tab by going to **https://shell.azure.com/powershell**. Select **Copy** to copy the blocks of code, paste them into Cloud Shell, and select the Enter key to run them.<br>

You can also install and run the Azure PowerShell cmdlets locally on your computer. PowerShell cmdlets are updated frequently. If you haven't installed the latest version, the values specified in the instructions may fail. To find the versions of Azure PowerShell installed on your computer, use the `Get-Module -ListAvailable Az cmdlet`.<br>

## Sign in<br>

If you're using **Azure Cloud Shell** you'll automatically be directed to sign into your account after you open Cloud Shell. You don't need to run `Connect-AzAccount`. Once signed in, you can still change subscriptions if necessary by using `Get-AzSubscription`and `Select-AzSubscription`.

If you're running PowerShell locally, open the PowerShell console with elevated privileges and connect to your Azure account. The Connect-AzAccount cmdlet prompts you for credentials. After you authenticate, it downloads your account settings so that they're available to Azure PowerShell. You can change subscription by using `Get-AzSubscription`and `Select-AzSubscription -SubscriptionName "Name of subscription"`.<br>

## Create a virtual WAN

Before you can create a virtual wan, you have to create a resource group to host the virtual wan or use an existing resource group. Use one of the following examples.

This example creates a new resource group named **TestRG** in the **East US** location. If you want to use an existing resource group instead, you can modify the `$resourceGroup = Get-AzResourceGroup -ResourceGroupName "NameofResourceGroup"`command, and then complete the steps in this exercise using your own values.<br>

1. Create a resource group.

**Azure PowerShell**

`New-AzResourceGroup -Location "East US" -Name "TestRG"`

2. Create the virtual wan using the `New-AzVirtualWan`cmdlet.

**Azure PowerShell**

`$virtualWan = New-AzVirtualWan -ResourceGroupName TestRG -Name TestVWAN1 -Location "East US"`

## Create the hub and configure hub settings

A hub is a virtual network that can contain gateways for site-to-site, ExpressRoute, or point-to-site functionality. Create a virtual hub with `New-AzVirtualHub`. This example creates a default virtual hub named Hub1 with the specified address prefix and a location for the hub.

**Azure PowerShell**

`$virtualHub = New-AzVirtualHub -VirtualWan $virtualWan -ResourceGroupName "TestRG" -Name "Hub1" -AddressPrefix "10.1.0.0/16" -Location "westus"`

## Create a site-to-site VPN gateway

In this section, you create a site-to-site VPN gateway in the same location as the referenced virtual hub. When you create the VPN gateway, you specify the scale units that you want. It takes about 30 minutes for the gateway to create.

1. If you closed Azure Cloud Shell or your connection timed out, you may need to declare the variable again for $virtualHub.

**Azure PowerShell**

`$virtualHub = Get-AzVirtualHub -ResourceGroupName "TestRG" -Name "Hub1"`

2. Create a VPN gateway using the `New-AzVpnGateway` cmdlet.

**Azure PowerShell**

`New-AzVpnGateway -ResourceGroupName "TestRG" -Name "vpngw1" -VirtualHubId $virtualHub.Id -VpnGatewayScaleUnit 2`

3. Once your VPN gateway is created, you can view it using the following example.

**Azure PowerShell**

`Get-AzVpnGateway -ResourceGroupName "TestRG" -Name "vpngw1"`

## Create a site and connections

In this section, you create sites that correspond to your physical locations and the connections. These sites contain your on-premises VPN device endpoints, you can create up to 1000 sites per virtual hub in a virtual WAN. If you have multiple hubs, you can create 1000 per each of those hubs.

1. Set the variable for the VPN gateway and for the IP address space that is located on your on-premises site. Traffic destined for this address space is routed to your local site. This is required when BGP isn't enabled for the site.

**Azure PowerShell**

`$vpnGateway = Get-AzVpnGateway -ResourceGroupName "TestRG" -Name "vpngw1"`

`$vpnSiteAddressSpaces = New-Object string[] 2`

`$vpnSiteAddressSpaces[0] = "192.168.2.0/24"`

`$vpnSiteAddressSpaces[1] = "192.168.3.0/24"`

2. Create links to add information about the physical links at the branch including metadata about the link speed, link provider name, and the public IP address of the on-premises device.

**Azure PowerShell**

`$vpnSiteLink1 = New-AzVpnSiteLink -Name "TestSite1Link1" -IpAddress "15.25.35.45" -LinkProviderName "SomeTelecomProvider" -LinkSpeedInMbps "10"`

`$vpnSiteLink2 = New-AzVpnSiteLink -Name "TestSite1Link2" -IpAddress "15.25.35.55" -LinkProviderName "SomeTelecomProvider2" -LinkSpeedInMbps "100"`

3. Create the VPN site, referencing the variables of the VPN site links you just created.

If you closed Azure Cloud Shell or your connection timed out, redeclare the virtual WAN variable:<br>

**Azure PowerShell**

`$virtualWan = Get-AzVirtualWAN -ResourceGroupName "TestRG" -Name "TestVWAN1"`

4. Create the VPN site using the `New-AzVpnSite` cmdlet.

5. Create the site link connection. The connection is composed of two active-active tunnels from a branch/site to the scalable gateway.

**Azure PowerShell**

`$vpnSiteLinkConnection1 = New-AzVpnSiteLinkConnection -Name "TestLinkConnection1" -VpnSiteLink $vpnSite.VpnSiteLinks[0] -ConnectionBandwidth 100`

`$vpnSiteLinkConnection2 = New-AzVpnSiteLinkConnection -Name "testLinkConnection2" -VpnSiteLink $vpnSite.VpnSiteLinks[1] -ConnectionBandwidth 10`

## Connect the VPN site to a hub

Connect your VPN site to the hub site-to-site VPN gateway using the New-AzVpnConnection cmdlet.

1. Before running the command, you may need to redeclare the following variables:

**Azure PowerShell**

`$virtualWan = Get-AzVirtualWAN -ResourceGroupName "TestRG" -Name "TestVWAN1"`

`$vpnGateway = Get-AzVpnGateway -ResourceGroupName "TestRG" -Name "vpngw1"`

`$vpnSite = Get-AzVpnSite -ResourceGroupName "TestRG" -Name "TestSite1"`

2. Connect the VPN site to the hub.

**Azure PowerShell**

`New-AzVpnConnection -ResourceGroupName $vpnGateway.ResourceGroupName -ParentResourceName $vpnGateway.Name -Name "testConnection" -VpnSite $vpnSite -VpnSiteLinkConnection @($vpnSiteLinkConnection1, $vpnSiteLinkConnection2)`

## Connect a VNet to your hub

The next step is to connect the hub to the VNet. If you created a new resource group for this exercise, you typically won't already have a virtual network (VNet) in your resource group. The steps below help you create a VNet if you don't already have one. You can then create a connection between the hub and your VNet.

### Create a virtual network

You can use the following example values to create a VNet. Make sure to substitute the values in the examples for the values you used for your environment.

1. Create a VNet.

**Azure PowerShell**

`$vnet = @{`

`Name = 'VNet1'`

`ResourceGroupName = 'TestRG'`

`Location = 'eastus'`

`AddressPrefix = '10.21.0.0/16'`

`}`

`$virtualNetwork = New-AzVirtualNetwork @vnet`

2. Specify subnet settings.

**Azure PowerShell**

`$subnet = @{`

`Name = 'Subnet-1'`

`VirtualNetwork = $virtualNetwork`

`AddressPrefix = '10.21.0.0/24'`

`}`

`$subnetConfig = Add-AzVirtualNetworkSubnetConfig @subnet`

3. Set the VNet.

**Azure PowerShell**

`$virtualNetwork | Set-AzVirtualNetwork`

### Connect a VNet to a hub

### Configure VPN device
