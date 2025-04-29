
A [Network Security Group (NSG)](/azure/virtual-network/network-security-groups-overview) in Azure allows you to filter network traffic to and from Azure resources in an Azure virtual network. 

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=748c6bdf-7cee-4d80-9140-7ecb4426bb2c]

## Characteristics of network security groups

Let's look at the characteristics of network security groups.

- A network security group contains a list of security rules that allow or deny inbound or outbound network traffic.

- A network security group can be associated to a subnet or a network interface.

- A network security group can be associated multiple times.

- You create a network security group and define security rules in the Azure portal.

## NSG security rules

A network security group contains security rules that allow or deny inbound or outbound network traffic to Azure resources. For each rule, you can specify source and destination, port, and protocol. A network security group contains zero, or as many rules as desired, within Azure subscription limits. Each rule has these properties.

- Azure defines default **inbound** security rules for your network security group. These rules deny all inbound traffic except traffic from your virtual network and Azure load balancers. 

- Azure defines default **outbound** security rules for your network security group. These rules only allow outbound traffic to the internet and your virtual network. 

Each network security group and its defined security rules are evaluated independently. Azure processes the conditions in each rule defined for each virtual machine in your configuration. - Effective security rules view is a feature in Azure Network Watcher that you can use to view the aggregated inbound and outbound rules applied to a network interface. It provides visibility into security and admin rules applied to a network interface.

- For inbound traffic, Azure first processes network security group security rules for any associated subnets and then any associated network interfaces.

- For outbound traffic, the process is reversed. Azure first evaluates network security group security rules for any associated network interfaces followed by any associated subnets.

:::image type="content" source="../media/effective-security-rules.png" alt-text="Screenshot of the Network Watcher effective rules page.":::


> [!TIP]
> Learn more about network security groups in the [Configure network security groups](/training/modules/configure-network-security-groups/) module.