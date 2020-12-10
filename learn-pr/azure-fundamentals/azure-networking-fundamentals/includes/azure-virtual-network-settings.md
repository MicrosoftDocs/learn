You can create and configure Azure Virtual Network instances from the Azure portal, Azure PowerShell on your local computer, or Azure Cloud Shell.

### Create a virtual network

When you create an Azure virtual network, you configure a number of basic settings. You'll have the option to configure advanced settings, such as multiple subnets, distributed denial of service (DDoS) protection, and service endpoints.

:::image type="content" source="../media/create-virtual-network.png" alt-text="Screenshot of the Azure portal showing an example of the Create virtual network pane fields.":::

You'll configure the following settings for a basic virtual network:

- **Network name**

    The network name must be unique in your subscription, but it doesn't need to be globally unique. Make the name a descriptive one that's easy to remember and identified from other virtual networks.

- **Address space**

    When you set up a virtual network, you define the internal address space in Classless Interdomain Routing (CIDR) format. This address space needs to be unique within your subscription and any other networks that you connect to.

    Let's assume you choose an address space of 10.0.0.0/24 for your first virtual network. The addresses defined in this address space range from 10.0.0.1 to 10.0.0.254. You then create a second virtual network and choose an address space of 10.0.0.0/8. The addresses in this address space range from 10.0.0.1 to 10.255.255.254. Some of the addresses overlap and can't be used for the two virtual networks.

    But you can use 10.0.0.0/16, with addresses that range from 10.0.0.1 to 10.0.255.254, and 10.1.0.0/16, with addresses that range from 10.1.0.1 to 10.1.255.254. You can assign these address spaces to your virtual networks because there's no address overlap.

    > [!NOTE]
    > You can add address spaces after you create the virtual network.

- **Subscription**

    This option only applies if you have multiple subscriptions to choose from.

- **Resource group**

    Like any other Azure resource, a virtual network needs to exist in a resource group. You can either select an existing resource group or create a new one.

- **Location**

    Select the location where you want the virtual network to exist.

- **Subnet**

    Within each virtual network address range, you can create one or more subnets that partition the virtual network's address space. Routing between subnets will then depend on the default traffic routes. You also can define custom routes. Alternatively, you can define one subnet that encompasses all the virtual networks' address ranges.

    > [!NOTE]
    > Subnet names must begin with a letter or number and end with a letter, number, or underscore. They may contain only letters, numbers, underscores, periods, or hyphens.

- **DDoS protection**

    You can select either Basic or Standard DDoS protection. Standard DDoS protection is a premium service. For more information on Standard DDoS protection, see [Azure DDoS protection Standard overview](https://docs.microsoft.com/azure/virtual-network/ddos-protection-overview?azure-portal=true).

- **Service endpoints**

    Here, you enable service endpoints. Then you select from the list which Azure service endpoints you want to enable. Options include Azure Cosmos DB, Azure Service Bus, Azure Key Vault, and so on.

After you've configured these settings, select **Create**.

### Define additional settings

After you create a virtual network, you can then define further settings. These include:

- **Network security group**

    Network security groups have security rules that enable you to filter the type of network traffic that can flow in and out of virtual network subnets and network interfaces. You create the network security group separately. Then you associate it with the virtual network.

- **Route table**

    Azure automatically creates a route table for each subnet within an Azure virtual network and adds system default routes to the table. You can add custom route tables to modify traffic between virtual networks.

You can also amend the service endpoints.

![Screenshot of the Azure portal showing an example pane for editing virtual network settings.](../media/virtual-network-additional-settings.png)

### Configure virtual networks

After you've created a virtual network, you can change any further settings on the **Virtual network** pane in the Azure portal. Alternatively, you can use PowerShell commands or commands in Cloud Shell to make changes.

![Screenshot of the Azure portal showing an example pane for configuring a virtual network.](../media/configure-virtual-network.png)

You can then review and change settings in further subpanes. These settings include:

- **Address spaces**: You can add additional address spaces to the initial definition.
- **Connected devices**: Use the virtual network to connect machines.
- **Subnets**: You can add additional subnets.
- **Peerings**: Link virtual networks in peering arrangements.

You can also monitor and troubleshoot virtual networks. Or, you can create an automation script to generate the current virtual network.

Virtual networks are powerful and highly configurable mechanisms for connecting entities in Azure. You can connect Azure resources to one another or to resources you have on-premises. You can isolate, filter, and route your network traffic. Azure allows you to increase security where you feel you need it.
