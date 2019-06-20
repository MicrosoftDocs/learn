Recall that our company processes video content on Windows VMs. A new city has contracted us to process their traffic cameras, but it's a model we've not worked with before. We need to create a new Windows VM and install some proprietary codecs so we can begin processing and analyzing their images.

> [!NOTE]
> Make sure you activate the sandbox before you continue.

## Create a Spoke Virtual Network in the portal

You can create a virtual network (Vnet) with the Azure portal, Azure CLI, Azure PowerShell, in your code, or alongside creating other resources, such as a VM. The easiest approach is to use the portal as you will be walked through the required properties and be provided with hints and help messages during the creation of the Vnet.

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. Click **Create a Resource** in the upper left corner of the Azure portal

1. In the search box, enter **Virtual Network** and then click on the link with the same title in the presented list.

1. Click the **Create** button to start configuring the Vnet.

## Configure the Vnet settings

The resource creation experience through the portal is in a "wizard" format to walk you through the initial configuration for the Vnet. For this exercise please use the suggested resource properties below:

|Property Name | Field Property  |
|---------|---------|
|Name     | spokeprod2vnet         |
|Address Space     | 10.10.0.0/16        |
|Subscription     | Concierge Subscription (default)        |
|Resource Group     |  **Select Existing**       |
|Subnet - Name     |   lrnworkload      |
|Subnet - Address Range     |   10.10.0.0/16      |
|DDoS Protection     |   Basic      |
|Service Endpoints     |   Disabled      |
|Firewall     |   Disabled      |

![Image showing vnet creation blade](../media/4-create-vnet.png)

1. You need to fill in all the required options (tagged with a red star), it's important to the properties suggested to ensure the Vnet configuration can be completed later in this exercise:

1. To start provisioning the Vnet click the **Create** button at the bottom.
 
> [!NOTE]
> The Vnet will take a couple of minutes to provision

## Configure the Hub Vnet peering

Now you have created the second spoke virtual network you need to configure the Vnet peering between the hub and spokes.

1. In the left hand resources menu click on **Virtual Networks**. You should see the hubVnet, spokeprod1Vnet and spokeprod2Vnet virtual networks.

1. Click on the **hubVnet**.

1. Click on the **Peerings** blade in the left hand side settings menu.

1. On the Peerings blade, Click the **Add** button, fill in the fields using the following properties:

|Property Name | Field Property  |
|---------|---------|
|Name of Peering     | gwPeering_hubVnet_spokeProd2Vnet      |
|Peer Details     | Resource Manager        |
|Subscription     | Concierge Subscription (default)        |
|Virtual Network     |  spokeprod2vnet       |
|Configure virtual network access settings     |   Enabled      |
|Configure forwarded traffic settings     |   Enabled      |
|Configure gateway transit settings     |   True      |
|Configure Remote Gateways settings     |   False      |

1. Click the **OK** button to create the peering.

1. Close the hubVnet blade.

You have now peered the hub virtual network to the spoke virtual network. In the configuration you have allowed traffic to be forwarded from the hub to the spoke using a VPN gateway.

## Configure the Spoke vnet peering

Now the hub is connected to the new spoke you need to configure the spoke vnet peering to complete the loop. The peering on the hubvnet has a status of **initiated** with a note **At least one peering is in an initiated state. Navigate to the peer virtual network to complete the initiation**.

1. In the left hand resources menu click on **Virtual Networks**. You should see the hubVnet, spokeprod1Vnet and spokeprod2Vnet virtual networks.

1. Click on the **spokeprod2Vnet**.

1. Click on the **Peerings** blade in the left hand side settings menu.

1. On the Peerings blade, Click the **Add** button, fill in the fields using the following properties:

|Property Name | Field Property  |
|---------|---------|
|Name of Peering     | gwPeering_spokeProd2Vnet_hubVnet      |
|Peer Details     | Resource Manager        |
|Subscription     | Concierge Subscription (default)        |
|Virtual Network     |  hubVnet       |
|Configure virtual network access settings     |   Enabled      |
|Configure forwarded traffic settings     |   Enabled      |
|Configure gateway transit settings     |   False      |
|Configure Remote Gateways settings     |   True      |

1. Click the **OK** button to create the peering.

1. Close the **spokeprod2Vnet** blade.

You have now peered the hub and spoke vnets. The configuration has opened the communication channel to forward traffic to the spoke from the hub and for the spoke to receive traffic originating from the VPN gateway.

## Create a Network Security Groups (NSG) for the virtual network

Each network needs to be secured and have the traffic flow to it defined, you'll create a network security group to configure this.

1. Click **Create a Resource** in the upper left corner of the Azure portal

1. In the search box, enter **Network security group** and then click on the link with the same title in the presented list.

1. Click the **Create** button to start configuring the Vnet.

1. Give the NSG a name similar to **spokeprod2-nsg**, select the existing resource group and location.

1. Click the **Create** button to provision the NSG.

1. Close.

You have now created an NSG that can be assigned to each of the vnets at the moment though they are not associated.

## Associate the NSGs to your vnets

You need to associate the NSGs to each vnet.

1. Click **All services** in the upper left corner of the Azure portal

1. In the search box, enter **Network security group**, click the **star** to the right hand side of the service to add it to the toolbar. Now select, **Network security groups**.

1. In the **Network security groups** blade, you should see the NSGs you created.

1. Select the NSG you created for the hub (**hub-nsg**).

1. Select the **Subnets** side menu.

1. On the **Subnets** blade select **Associate**.

1. Select the **spokeprod2vnet** virtual network.

1. Select the **lrnworkload** Subnet.

1. Click the **OK** button to associate the NSG with the spokeprod2 vnet.

1. Close the **hub-nsg** blade.

1. Repeat the steps for the **spokeprod2-nsg** you created earlier ensuring to associate it with the **spokeprod2vnet** vnet.

## Configure NSG rule to stop spoke outbound internet traffic

You have a security requirement to meet for the VM application to be hosted on the SpokeProd2Vnet, there is to be no outbound internet traffic from the spoke. You'll now configure the NSG rule to meet this requirement so the VM can be provisioned.

1. In the left hand resources menu click on **Network security groups**.

1. Click the **spokeprod2-nsg**.

1. Select the **Outbound security rules** side menu.

1. In the **Outbound security rules** blade, click the **Add** button.

|Property Name | Field Property  |
|---------|---------|
|Source     | Any      |
|Source port ranges     | *        |
|Destination     | Service Tag        |
|Destination Service Tag     |  Internet       |
|Destination port ranges     |   8080      |
|Protocol     |   Any      |
|Action     |   Deny      |
|Priority     |   100      |
|Name     |   BlockP8080      |

1. Click the **OK** button to add the rule.

You have now blocked outbound internet access from the spoke on port 8080.

In this scenario you've created a spoke Azure Virtual Network and then peered it with an existing hub Virtual Network. You then secured the traffic from this spoke by blocking outbound internet access on port 8080 whilst still ensuring it can connect to the hub. In the next unit you'll learn about how to secure your Azure networks.