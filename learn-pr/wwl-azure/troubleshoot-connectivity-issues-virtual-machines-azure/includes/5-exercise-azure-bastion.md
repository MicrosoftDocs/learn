You’ve been contacted by one of the teams you support. The team is having problems connecting to their VM using Bastion. In this exercise you’ll see how to troubleshoot the Azure Bastion Service.

If you'd like to follow along in your own subscription, you may.

## Check that Bastion has been deployed

1. In the Azure portal, in the search box, type **Bastions**.

    ![A screenshot showing the Bastion service being searched for and then selected.](../media/5-checking-bastion-setup.png)

1. From the results, under **Services**, click **Bastions**.

1. You should see the Bastion service listed.

    ![A screenshot showing the list of created Azure Bastions](../media/5-bastion-list.png)

    > **NOTE**:
    > If there isn’t any Bastion services listed, create one.

## Check if there’s a private DNS zone

1. In the Azure portal, in the search box, type **private dns**.

    ![A screenshot of the Azure portal, searching for private dns, and selecting Private DNS zones.](../media/5-private-dns-zones.png)

1. From the results, under **Services**, click **Private DNS zones**.

    ![A screenshot showing that no private DNS zones are being used.](../media/5-no-private-dns-zones.png)

1. You shouldn’t see any private DNS zones.

1. If there are any zones listed, check that they don’t end in **azure.com** or **core.windows.net**.

    ![Screenshot showing a private DNS zone that will cause connection problems for Azure Bastion.](../media/5-invalid-private-dns-zone.png)

## Check if AzureBastionSubnet is using a Network Security Group correctly

1. In the Azure portal, in the search box, type **Bastions**.

1. From the results, under **Services**, click **Bastions**.

1. Select the Bastion you are troubleshooting.

    ![A screenshot showing the Virtual network/subnet link on the Bastion pane.](../media/5-azurebastionsubnet-link.png)

1. In the top right, click the **Virtual network/subnet** link.

    ![A screenshot of the subnets menu highlighted on the virtual network pane. With the AzureBastionSubnet selected.](../media/5-virtual-network-subnets.png)

1. Under **Settings**, click **Subnets**, and then click **AzureBastionSubnet**.

    ![A screenshot showing that the AzureBastionSubnet has no Network Security Group associated with it.](../media/5-azurebastionsubnet-settings-nsg.png)

    > **NOTE**:
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

    ![A screenshot of the Azure Bastion connection troubleshooting wizard.](../media/5-connection-troubleshooting-wizard.png)

    If you’ve resolved all the possible connection issues, the connection troubleshoot wizard should return a status of reachable.

    ![A screenshot of the connection troubleshoot results, showing the stats as reachable.](../media/5-troubleshooot-results.png)

You can watch the video to see all the steps above.
[!VIDEO https://www.microsoft.com/videoplayer/embed/mod08-bastion-exercise-final.mp4]
