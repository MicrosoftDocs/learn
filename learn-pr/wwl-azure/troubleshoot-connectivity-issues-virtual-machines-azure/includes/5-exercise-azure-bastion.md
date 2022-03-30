You’ve been contacted by one of the teams you support. The team is having problems connecting to their VM using Bastion. In this exercise you'll see how to troubleshoot the Azure Bastion Service.

Bastion is not supported in the Learn sandbox environment. Watch the video at the end to view this exercise. If you'd like to follow along in your own subscription, you can use the following steps.

> [!IMPORTANT]
> You need your own [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true) to complete the exercises in this module. If you don't have an Azure subscription, you can still read along.

## Check that Bastion has been deployed

1. In the Azure portal, in the search box, type **Bastions**.

   :::image type="content" source="../media/check-bastion-setup.png" alt-text="A screenshot showing the Bastion service being searched for and then selected.":::

1. From the results, under **Services**, click **Bastions**.

1. You should see the Bastion service listed.

:::image type="content" source="../media/bastion-list.png" alt-text="A screenshot showing the list of created Azure Bastions.":::
    > [!NOTE]
    > If there isn’t any Bastion services listed, create one.

## Check if there’s a private DNS zone

1. In the Azure portal, in the search box, type **private dns**.

   :::image type="content" source="../media/private-dns-zones.png" alt-text="A screenshot of the Azure portal, searching for private dns, and selecting Private DNS zones.":::

1. From the results, under **Services**, click **Private DNS zones**.

   :::image type="content" source="../media/no-private-dns-zones.png" alt-text="A screenshot showing that no private DNS zones are being used.":::
1. You shouldn’t see any private DNS zones.

1. If there are any zones listed, check that they don’t end in **azure.com** or **core.windows.net**.

:::image type="content" source="../media/invalid-private-dns-zone.png" alt-text="Screenshot showing a private DNS zone that will cause connection problems for Azure Bastion":::
## Check if AzureBastionSubnet is using a Network Security Group correctly

1. In the Azure portal, in the search box, type **Bastions**.

1. From the results, under **Services**, click **Bastions**.

1. Select the Bastion you are troubleshooting.

   :::image type="content" source="../media/azure-bastion-subnet-link.png" alt-text="A screenshot showing the Virtual network/subnet link on the Bastion pane.":::

1. In the top right, click the **Virtual network/subnet** link.

   :::image type="content" source="../media/virtual-network-subnets.png" alt-text="A screenshot of the subnets menu highlighted on the virtual network pane. With the AzureBastionSubnet selected..":::

1. Under **Settings**, click **Subnets**, and then click **AzureBastionSubnet**.

:::image type="content" source="../media/azure-bastion-subnet-settings-nsg.png" alt-text="A screenshot showing that the AzureBastionSubnet has no Network Security Group associated with it.":::

    > [!NOTE]
    > If Azure Bastion has a **Network security group** associated with the subnet, you need to check that it has all the inbound and outbound rules created.

## Run the Connection Troubleshoot tool to check for issues

1. In the Azure portal, in the search box, type **Bastions**.

1. From the results, under **Services**, click **Bastions**.

1. Select the Bastion you are troubleshooting.

1. Under **Monitoring**, click **Connection Troubleshoot**.

1. Under **Virtual machine**, select the VM you are trying to connect to.

1. Select your **Preferred IP Version**.

1. In the **Destination port**, if you want to use **RDP**, enter **3389**, if you want to use **SSH**, enter **22**.

1. Click **Check**.

:::image type="content" source="../media/connection-troubleshooting-wizard.png" alt-text="A screenshot of the Azure Bastion connection troubleshooting wizard.":::

    If you’ve resolved all the possible connection issues, the connection troubleshoot wizard should return a status of reachable.

:::image type="content" source="../media/troubleshooot-results.png" alt-text="A screenshot of the connection troubleshoot results, showing the stats as reachable":::

You can watch the following video to see all the steps above:

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4RYRS]
