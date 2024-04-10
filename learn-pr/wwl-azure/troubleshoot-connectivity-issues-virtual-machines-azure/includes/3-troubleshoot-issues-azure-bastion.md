There are three main categories of issues you might see when troubleshooting Azure Bastion.

## Deployment

First, you go to the Azure VM where you're having trouble deploying Azure Bastion.

:::image type="content" source="../media/navigate-bastion-connection.png" alt-text="A screenshot showing how to use Azure Bastion to connect to an Azure VM.":::

In the Azure portal, on the left navigation pane, select **Virtual machines**, then select the machine you're troubleshooting. Select **Connect** from the top of the pane, then select **Bastion**.

:::image type="content" source="../media/bastion-screenshot.png" alt-text="A screenshot that shows the Azure Bastion options":::

You should see the options to create an Azure Bastion Service. If you don't, check that you have met these prerequisites:

- You have the correct access to the VM—at a minimum, you need reader access to the VM, NIC, private IP address of the VM, and the virtual network.

- You have an active Azure subscription with enough credit.

- You have enough public IP address left in your subscription's quota.

Step 1 has been completed for you because you're creating the Azure Bastion Service from a VM.

For step 2, you can accept the defaults and create a new subnet named AzureBastionSubnet. The wizard will create the subnet with these attributes:

:::image type="content" source="../media/azure-bastion-subnet-settings.png" alt-text="A screenshot of the AzureBastionSubnet subnet settings.":::

Step 3 allows you to select the tier, basic or standard. You can then create or use a public IP address to connect to the Azure Bastion Service. Finally, accept the Microsoft supplied defaults to create the service.

:::image type="content" source="../media/deploy-bastion.png" alt-text="A screenshot of the Bastion creation wizard, showing how to select the Standard Tier, public IP address name, and the Create Azure Bastion using the defaults button.":::

## Connectivity

To begin resolving connection issues between your Azure Bastion Service and a VM, check the VM is running.

The VM doesn't need to have a public IP address, but it must be in a virtual network that supports IPv4. Currently, IPv6-only environments aren't supported.

Azure Bastion can't work with VMs that are in an Azure Private DNS zone with **core.windows.net** or **azure.com** in the suffixes. This isn't supported because it could allow overlaps with internal endpoints. Azure Private DNS zones in national clouds are also unsupported.

If the connection to the VM is working but you can't sign in, check if it is domain-joined. If the VM is domain-joined, you'll need to specify the credentials in the Azure portal using the **username@domain** format, instead of **domain\username**. This won't resolve the issues if the VM is Microsoft Entra joined only—this kind of authentication isn't supported.

In the earlier section you'll note that, by default, the AzureBastionSubnet isn't assigned an NSG. If your organization needs an NSG, you should ensure that it's configured correctly:

Inbound rules

:::image type="content" source="../media/inbound.png" alt-text="A screenshot of inbound rules in the Azure portal showing port 443 over TCP with these sources: Internet, GatewayManager, and AzureLoadBalancer. For port 8080 and 5701 over Any protocol, the source is VirtualNetwork." lightbox="../media/inbound.png":::

Outbound rules

:::image type="content" source="../media/outbound.png" alt-text="A screenshot of outbound rules in the Azure portal showing port 22 and 3389 over Any protocol with the destination VirtualNetwork. Port 443 over TCP with the destination AzureCloud. Port 8080 and 5701 over Any protocol with the destination VirtualNetwork. Port 80 over Any protocol—source is Internet." lightbox="../media/outbound.png":::

## Access

If your users are having access issues, check that they have roles that grant them read access to all these resources:

- The virtual machine

- The NIC

- The Azure Bastion Service and AzureBastionSubnet

- If it's a peered network, the virtual network

If all these resources are correct and the user is still seeing a black screen when they try to connect with Azure Bastion, there's likely a network connectivity issue between the user's web browser and Azure Bastion.
