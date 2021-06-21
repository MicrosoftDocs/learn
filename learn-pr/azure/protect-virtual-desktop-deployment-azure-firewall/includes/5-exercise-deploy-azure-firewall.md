
In this unit, you'll create the firewall in its own virtual network. Then you peer that virtual network with the virtual network used by your Azure Virtual Desktop.

## Create a virtual network and subnet for Azure Firewall

Create a virtual network that'll acts as the central connectivity point or hub for Azure Firewall.  

1. In the [Azure portal](https://portal.azure.com?azure-portal=true), search for and select **Virtual networks**.
1. Select **+ New**.
1. Enter the following information.

    |Field |Value  |
    |---------|---------|
    |Subscription     | Your subscription        |
    |Resource group    | learn-firewall-rg        |
    |Name    |   firewallVNet      | 
    |Region     | Same region as your resource group      |

1. Select the **IP Addresses** tab.
1. Under **Subnet name**, select **default**.
1. Enter the following information for the subnet.

    |Field |Value |
    |---------|---------|
    |Name    |  AzureFirewallSubnet    |
    |Address range     |   10.1.0.0/24      |

    Leave the rest of the values as they are.
1. Select **Save**.
1. Select **Review + create** > **Create**.
1. After the deployment is complete, select **Go to resource**.

## Peer virtual networks

Connect the hub virtual network with the virtual network used by the host pool by peering them.

1. In the **firewallVNet**, on the left-hand side, select **Peerings**.
1. Select **+ Add**.
1. Enter the following information.

    |Field |Value |
    |---------|---------|
    |Peering link name    |  firewallVNet-hostVNet   |
    |Remote Peering link name     |   remote-firewallVNet-hostVNet      |
    |Subscription     | Your subscription        |
    |Virtual network    | hostVNet       |

    Use the default values for the rest of the fields.

## Deploy Azure Firewall

Now that you have the virtual networks created and peered, deploy Azure Firewall.

1. In the Azure portal, search for and select **Firewalls**.
1. Select **+ Add** to create a firewall.
1. Enter the following table to configure the firewall.

   |Field |Value  |
   |---------|---------|
   |Subscription     |Select your subscription|
   |Resource group     |learn-firewall-rg |
   |Name     |learn-fw|
   |Region     |Select the same location that you used previously|
   |Firewall management|Use Firewall rules (classic) to manage this firewall|
   |Choose a virtual network     |Use existing: firewallVNet|
   |Public IP address     |Add new<br>Name:  fw-pip|

    Use the default values for the rest of the fields.

1. Select **Review + create** > **Create**.
1. Wait a few minutes for the firewall to deploy.

## Check your work

At this point, you have a Firewall deployed within it's own virtual network and you've peered that virtual network with the host pool virtual network. Let's take a look at the firewall to copy the private and public IP addresses. You need those IP addresses in the next exercise unit.

1. After the deployment is complete, select **Go to resource**.
1. In the center pane, you see **Provisioning state: Succeeded**.
:::image type="content" source="../media/5-firewall-overview-page.png" alt-text="Screenshot that shows the status and ip addresses for the firewall.":::
1. From the right-hand side of the center pane, copy the **Firewall private IP** address.
1. Next to **Firewall public IP**, select **fw-pip**.
1. Copy the **IP address**.
