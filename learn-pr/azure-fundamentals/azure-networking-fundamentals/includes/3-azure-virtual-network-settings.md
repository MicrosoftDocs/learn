You can create and configure Azure virtual networks from the Azure portal, Azure PowerShell, Azure CLI, Azure Cloud Shell or an ARM template.

### Create a virtual network

When you create an Azure virtual network, you configure several basic settings. You can also configure advanced settings, such as multiple subnets, distributed denial of service (DDoS) protection, Bastion host, Azure firewall, service endpoints, and use of a NAT gateway.

Configure the following settings for a basic virtual network:

:::image type="content" source="../media/create-virtual-network-286df13c.png" alt-text="Screenshot of the Azure portal showing an example of the Create virtual network pane fields.":::

- **Subscription** This option only applies if you have multiple subscriptions to choose from.
- **Resource group** Like any other Azure resource, a virtual network needs to exist in a resource group. You can either select an existing resource group or create a new one.
- **Network name** The network name must be unique in your subscription, but it doesn't need to be globally unique. Make the name a descriptive one that's easy to remember and identified from other virtual networks.
- **Region** Select the region where you want the virtual network to exist.

:::image type="content" source="../media/create-virtual-network-ip-address-286df13c.png" alt-text="Screenshot of the Azure portal showing the IP address page of create virtual network.":::

- **Address space** When you set up a virtual network, you define the internal address space in Classless Interdomain Routing (CIDR) format. This address space needs to be unique within your subscription and any other networks that you connect to. Let's assume you choose an address space of 10.0.0.0/24 for your first virtual network. The addresses defined in this address space range from 10.0.0.1 to 10.0.0.254. You then create a second virtual network and choose an address space of 10.0.0.0/8. The addresses in this address space range from 10.0.0.1 to 10.255.255.254. Some of the addresses overlap and can't be used for the two virtual networks. But you can use 10.0.0.0/16, with addresses that range from 10.0.0.1 to 10.0.255.254, and 10.1.0.0/16, with addresses that range from 10.1.0.1 to 10.1.255.254. You can assign these address spaces to your virtual networks because there's no address overlap.

   > [!NOTE]
   > You can add address spaces after you create the virtual network.

- **Subnet** Within each virtual network address range, you can create one or more subnets that partition the virtual network's address space. Routing between subnets then depends on the default traffic routes. You also can define custom routes. Alternatively, you can define one subnet that encompasses all the virtual networks' address ranges.

   > [!NOTE]
   > Subnet names must begin with a letter or number and end with a letter, number, or underscore. They may contain only letters, numbers, underscores, periods, or hyphens.

- **Service endpoints** Here, you enable service endpoints. Then you select from the list which Azure service endpoints you want to enable. Options include Azure Cosmos DB, Azure Service Bus, Azure Key Vault, and so on.
- **NAT gateway** A NAT gateway is a fully managed and highly resilient Network Address Translation (NAT) service. You can configure a subnet to use a static outbound IP address when accessing the internet. For more information about NAT gateway, see [Azure Virtual Network NAT overview](/azure/virtual-network/nat-gateway/nat-overview)

:::image type="content" source="../media/create-virtual-network-security-286df13c.png" alt-text="Screenshot of the Azure portal showing the security page of create virtual network.":::

- **BastionHost** You can select to enable or disable Azure Bastion in your virtual network. Azure Bastion service provides secure and seamless RDP/SSH connectivity to your virtual machines directly in the Azure portal over TLS. For more information on Azure Bastion, see [Azure Bastion overview](/azure/bastion/bastion-overview).
- **DDoS Protection Standard** You can select to enable or disable Standard DDoS protection. The Standard DDoS protection is a premium service. For more information on DDoS Protection, see [Azure DDoS protection overview](/azure/virtual-network/ddos-protection-overview).
- **Firewall** You can enable or disable Azure Firewall. Azure Firewall service is managed cloud-based network security service that protects your Azure Virtual Network resources. For more information on Azure Firewall, see [Azure Firewall overview](/azure/firewall/overview)

After you've configured these settings, select **Review + Create** and then select **Create** when validation is passed.

### Define additional settings

After you create a virtual network, you can then define further settings. These settings include:

- **Network security group** Network security groups have security rules that enable you to filter the type of network traffic that can flow in and out of virtual network subnets and network interfaces. You create the network security group separately. Then you associate it with each subnet in the virtual network.
- **Route table** Azure automatically creates a route table for each subnet within an Azure virtual network and adds system default routes to the table. You can add custom route tables to modify traffic between subnets and virtual networks.
- **Subnet Delegation** You can designate the subnet to be used by a dedicate service.

You can also amend the service endpoints and NAT gateway configuration.

:::image type="content" source="../media/virtual-network-additional-settings-faff6cec.png" alt-text="Screenshot of the Azure portal showing an example pane for editing virtual network settings.":::

### Configure virtual networks

After you've created a virtual network, you can change any further settings on the **Virtual network** pane in the Azure portal. Alternatively, you can use PowerShell commands or commands in Cloud Shell to make changes.

:::image type="content" source="../media/configure-virtual-network-9d0515c5.png" alt-text="Screenshot of the Azure portal showing an example pane for configuring a virtual network.":::

You can then review and change settings in further subpanes. These settings include:

- **Address spaces**: You can add more address spaces to the initial definition.
- **Connected devices**: View a list of all connected host in the virtual network.
- **Subnets**: You can add more subnets.
- **DDos protection**: You can enable or disable the Standard DDos protection plan.
- **Firewall**: Configure firewall settings with Azure Firewall service for the virtual network.
- **Security**: Provides security recommendation you can apply to your virtual network.
- **Network Manager**: View connectivity and security admin configuration the virtual network is associated to.
- **DNS servers**: Configure the internal or external DNS servers that the resources in the virtual network use.
- **Peerings**: Link virtual networks in peering arrangements.
- **Service endpoints**: Enable service endpoints and apply them to multiple subnets.
- **Private endpoints**: View a list of private endpoints enabled in a subnet.

You can also monitor and view metrics to troubleshoot your virtual networks.

Virtual networks are powerful and highly configurable mechanisms for connecting entities in Azure. You can connect Azure resources to one another or to resources you have on-premises. You can isolate, filter, and route your network traffic. Azure allows you to increase security where you feel you need it.
