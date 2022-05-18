You need to deploy your network infrastructure in a hub-spoke configuration for your resources. Additionally, your internal HR department wants to host a new internal HR system that shouldn't be accessible from the internet. The system should be accessible to everyone in the company, whether they work at headquarters or in a satellite office.

In this exercise, you'll deploy your network infrastructure, and then create a new virtual network to host the servers for your company's new HR system.

![Diagram showing adding a new HR spoke to the network.](../media/4-adding-spoke.svg)

## Set up environment

This deployment will create the Azure network resources matching the preceding diagram. With these resources in place, you can add the new HR virtual network.

First, create the virtual networks and subnets for your server resources. Run the following command:

```azurecli
az deployment group create \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --template-uri https://raw.githubusercontent.com/MicrosoftDocs/mslearn-hub-and-spoke-network-architecture/master/azuredeploy.json
```

## Create a new spoke in your virtual network

You can create a virtual network with the Azure portal, Azure CLI, or Azure PowerShell. Let's do the rest of this exercise through the Azure portal.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) by using the same account you used to activate the sandbox.

1. In the upper left of the Azure portal, select **Create a Resource**. The **Create a resource** pane appears.

1. In the search box, enter **Virtual Network**, press <kbd>Enter</kbd>. The **Virtual Network-Create** pane appears.

1. To start configuring the virtual network, select **Create**. The **Create virtual network** pane appears.

## Configure the virtual network settings

The resource creation experience on the portal is a wizard that walks you through the initial configuration for the virtual network.

1. To create the virtual network, on the **Basics** tab, enter the following values for each setting.

    | Setting | Value  |
    |---------|---------|
    | **Project details** |
    | Subscription    | Concierge Subscription |
    | Resource group  | From the dropdown list, select <rgn>[sandbox resource group name]</rgn> |
    | **Instance details** |
    | Name  | HRappVnet    |
    | Region  | Choose a location close to you. |

1. Select **Next : IP Addresses**. Enter the following values for each setting.

    | Setting | Value  |
    |---------|---------|
    | **IPv4 address space** | Replace the default address with **10.10.0.0/16** in the text box. |
    | Subnet name          | Select **default**. The **Edit subnet** pane displays. Enter the following values for each setting. |

    | Setting | Value  |
    |---------|---------|
    | Subnet name | HRsystems |
    | Subnet address range | 10.10.1.0/24 |

1. Select **Save**.

1. Back on the **Create virtual network** pane, select **Next : Security**. Enter the following values for each setting.

    | Setting | Value  |
    |---------|---------|
    | DDoS Protection Standard | **Disable**  |
    | Firewall               | **Disable**  |

1. Select **Review + create**. After validation passes, to start provisioning the virtual network, select **Create**.

1. After deployment successfully completes, select **Go to resource**. Your virtual network called **HRappVnet** pane appears.

## Configure the hub virtual network peering

Now that you've created the third spoke, you need to configure the virtual network peering between the hub and spokes.

1. Go to the **Home** page of the portal. Select **All resources**. The **All resources** pane appears.

    You should see the **HubVNet**, **WebVNet**, **QuoteVNet**, and **HRappVnet** virtual networks.

1. Select **HubVNet**. The **HubVnet** pane appears.

1. In the middle menu pane, under **settings**, select **Peerings**. The **Peerings** pane for your HubVnet pane appears.

1. On the top menu bar, select **Add**. The **Add peering** pane appears for your HubVnet.

1. Enter the following values for each setting.

    | Setting | Value  |
    |---------|---------|
    | **This virtual network** |
    | Peering link name   | *gwPeering_hubVNet_HRappVnet*. This name is the peering link name from HubvNet to HRappVnet. |
    | Traffic to remote virtual network | Allow |
    | Traffic forwarded from remote virtual network | Block traffic that originates from outside this virtual network |
    | Virtual network gateway or Route Server | None (default) |
    | **Remote virtual network** |
    | Peering link name | *gwPeering_HRappVnet_hubVNet*. This name is the peering link name from HRappVnet to HubvNet. |
    | Virtual network deployment model | **Resource manager** |
    | Subscription | Concierge Subscription |
    | Virtual network | HRappVnet |
    | Traffic to remote virtual network | Allow |
    | Traffic forwarded from remote virtual network | Block traffic that originates from outside this virtual network |
    | Virtual network gateway or Route Server | None   |

1. To create the peering, select **Add**. The **Peerings** pane reappears with your new peering.

You've now peered the hub virtual network to the spoke virtual network. You've allowed traffic to be forwarded from the hub to the spoke, by using a VPN gateway in the configuration.

## Create a network security group for the virtual network

To configure traffic flow, create a network security group.

1. Go to the **Home** page of the portal, and select **Create a resource**. The **Create a Resource** pane appears.

1. In the search box, enter **network security group**, and then select the link with the same title in the list. The **Network security group - Create** pane appears.

1. To start configuring the virtual network, select **Create**. The **Create network security group** appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value  |
    |---------|---------|
    | **Project details** |
    | Subscription    | Concierge Subscription |
    | Resource group  | From the dropdown list, select <rgn>[sandbox resource group name]</rgn> |
    | **Instance details** |
    | Name  | HRNsg    |
    | Region  | Choose the same location as you did previously for *HRappVnet*. |

1. Select **Review + create**.

1. After validation passes, to provision the network security group, select **Create**. The Overview pane for your NSG appears.

1. Select **Go to resource** and note the NSG, HRNsg.

You've created a network security group that can be assigned to each of the virtual networks.

## Associate the network security group to the new HR virtual network

Now, you associate the network security group to the virtual network.

1. Go to the **Home** page of the portal. Select **All services**.

1. In the search box, enter **Network security group**, and then select **Network security groups**. The **Network security groups** pane appears.

    You should see the network security groups you created.

1. Select the network security group you created for the spoke, **HRNsg**. The **HRNsg** pane appears.

1. In the middle menu pane, under **Settings**, select **Subnets**. The **Subnets** pane appears for your HRNsg network security group.

1. On the top menu bar, select **Associate**. The **Associate subnet** pane appears.

1. From the **Virtual network** dropdown list, select **HRappVnet**.

1. From the **Subnet** dropdown list, select **HRsystems**.

1. To associate the network security group, select **OK**. The **Subnets** pane for your HRNsg network security group reappears.

## Configure the network security group rule to stop inbound HTTP traffic

You have a security requirement to meet for the HR application to be hosted on HRappVnet. There shouldn't be any inbound HTTP traffic from the spoke, because only internal employees need access. Configure the network security group rule to meet this requirement.

1. On the **HRNsg- Subnets** pane, in the middle menu pane, under **Settings**, select **Inbound security rules**. The **Inbound security rules** pane appears for your HRNsg network security group.

1. On the top menu bar, select **Add**. The **Add inbound security rule** pane appears.

1. Enter the following values for each setting.

    | Setting | Value  |
    |---------|---------|
    | Source  | From the dropdown list, select *Any*  |
    | Source port ranges | *  |
    | Destination        | From the dropdown list, select *Service Tag* |
    | Destination service tag | *VirtualNetwork* |
    | Service | Custom |
    | Destination port ranges |  80,443  |
    | Protocol  | Any      |
    | Action    | Deny     |
    | Priority  | 100      |
    | Name      | Block-Inbound-HTTP-HTTPS |

1. To add the rule, select **Add**. The **Inbound security rules** pane reappears for your network security group.

You've now blocked inbound HTTP access from the spoke on port 80 and 443.

In this scenario, you created a spoke Azure virtual network, and then peered it with an existing hub virtual network. You then secured the traffic from this spoke by blocking inbound access on port 80 and 443, while ensuring it can connect via the hub.
