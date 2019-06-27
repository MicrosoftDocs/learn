In the previous unit you set up a hub and spoke virtual data centre in Azure for your company. Those commands created a hub and spoke, and connected them together. 

Your internal HR department has informed you they need to host a new internal HR system, that shouldn't be accessible from the external internet. It should be accessible to everyone in the company, wether they work at the headquarters and satellite offices.

In this exercise, you'll create a new virtual network to host the servers for your company's new HR system.

## Create a new spoke in your virtual network

You can create a virtual network (VNet) with the Azure portal, Azure CLI, Azure PowerShell, in your code, or alongside creating other resources, such as a VM. The easiest approach is to use the portal as you will be walked through the required properties and be provided with hints and help messages during the creation of the VNet.

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. Select **Create a Resource** in the upper left corner of the Azure portal

1. In the search box, enter **Virtual Network** and then click on the link with the same title in the list.

1. Select the **Create** to start configuring the VNet.

## Configure the VNet settings

The resource creation experience on the portal is a wizard to walk you through the initial configuration for the VNet.

![Image showing VNet creation blade](../media/4-create-VNet.png)

1. Use the values below to create the virtual network:

|Property Name | Field Property  |
|---------|---------|
|Name                   | **spokeProd3Vnet**         |
|Address Space          | **10.10.0.0/16**        |
|Subscription           | **Concierge Subscription (default)**     |
|Resource Group         | **<rgn>[sandbox resource group name]</rgn>**   |
|Subnet - Name          | **HRworkload**      |
|Subnet - Address Range | **10.10.0.0/16**      |
|DDoS Protection        | **Basic**      |
|Service Endpoints      | **Disabled**      |
|Firewall               | **Disabled**      |

1. To start provisioning the VNet select **Create**.
 
> [!NOTE]
> The VNet will take a couple of minutes to provision

## Configure the Hub VNet peering

Now you have created the third spoke you need to configure the VNet peering between the hub and spokes.

1. In the left-hand resources menu, select **Virtual Networks**. You should see the **hubVNet**, **spokeProdVNet**, **spokeProd2VNet**, and **spokeProd3Vnet** VNets.

1. Select on the **hubVNet**.

1. Select on the **Peerings** blade in the left-hand side settings menu.

1. On the Peerings blade, select **Add**, fill in the fields using the following properties:

|Property Name | Field Property  |
|---------|---------|
|Name of the peering from hubVnet to spokeProd3Vnet     | **gwPeering_hubVNet_spokeProd3VNet**      |
|Peer Details     | **Resource Manager**        |
|Subscription     | **Concierge Subscription (default)**        |
|Virtual Network     |  **spokeprod3VNet**       |
|Name of the peering from spokeProd3Vnet to hubVnet     | **gwPeering_spokeProd3VNet_hubVNet**      |
|Allow virtual network access from hubVnet to spokeProd3Vnet  |   **Enabled**  |
|Allow virtual network access from spokeProd3Vnet to hubVnet  |   **Enabled**  |
|Allow forwarded traffic from spokeProd3Vnet to hubVnet  |   **Disabled**     |
|Allow forwarded traffic from hubVnet to spokeProd3Vnet  |   **Disabled**     |
|Configure Remote Gateways settings         |   **False**    |

1. Select **OK** to create the peering.

1. Close the hubVNet blade.

You've now peered the hub virtual network to the spoke virtual network. You've allowed traffic to be forwarded from the hub to the spoke using a VPN gateway in the configuration.

## Create a Network Security Groups (NSG) for the virtual network

You'll create a network security group to configure each network security and define its  traffic flow.

1. Select **Create a Resource** in the upper left corner of the Azure portal

1. In the search box, enter **Network security group** and then select the link with the same title in the list.

1. Select **Create** to start configuring the VNet.

1. Enter **spokeprod3-nsg** for the name, then select the existing resource group and location.

1. Select **Create** to provision the NSG.

You have now created an NSG that can be assigned to each of the VNets at the moment though they are not associated.

## Associate the NSGs to the new HR VNet

You need to associate the NSGs to each VNet.

1. Select **All services** in the upper left corner of the Azure portal.

1. In the search box, enter **Network security group**, select the **star** to the right-hand side of the service to add it to the toolbar. Now select, **Network security groups**.

1. In the **Network security groups** blade, you should see the NSGs you created.

1. Select the NSG you created for the hub, **hub-nsg**.

1. Select the **Subnets** side menu.

1. On the Subnets blade, select **Associate**.

1. Select the **spokeprod3VNet** virtual network.

1. Select the **HRworkload** Subnet.

1. Select **OK** to associate the NSG with the spokeprod2 VNet.

1. Close the **hub-nsg** blade.

1. Repeat the steps for the **spokeprod3-nsg** you created earlier ensuring to associate it with the **spokeprod3VNet** VNet.

## Configure NSG rule to stop spoke outbound internet traffic

You have a security requirement to meet for HR application to be hosted on the **SpokeProd3VNet**, there is to be no outbound internet traffic from the spoke as only internal employees need access. You'll now configure the NSG rule to meet this requirement.

1. In the left-hand resources menu select **Network security groups**.

1. Select the **spokeprod3-nsg**.

1. Select the **Outbound security rules** side menu.

1. In the **Outbound security rules** blade, select **Add**.

|Property Name | Field Property  |
|---------|---------|
|Source             | Any  |
|Source port ranges | *    |
|Destination        | Service Tag     |
|Destination Service Tag |  Internet  |
|Destination port ranges |  80        |
|Protocol  | Any      |
|Action    | Deny     |
|Priority  | 100      |
|Name      | Block_80 |

1. Select **Add** to add the rule.

You have now blocked outbound internet access from the spoke on port 80.

In this scenario, you've created a spoke Azure Virtual Network and then peered it with an existing hub Virtual Network. You then secured the traffic from this spoke by blocking outbound internet access on port 80 whilst still ensuring it can connect to via the hub.