In today’s modern work environment, where more users are home and working remotely, managing access to assets and resource on your Azure Virtual Network is essential.

Here, you’ll learn how Azure network security groups can automatically allow or deny traffic to your cloud-based resources and assets.

An Azure Virtual Network (VNet) is similar to the network you’d find in your organization. It enables different Azure resources, for instance, an Azure Virtual Machine (VM) to securely communicate with other VNets, the Internet, or your on-premises network.  A VNet can be divided into multiple subnetworks (subnets), each with specific resources assigned to them. You can secure the resources within a subnet using network security groups.

## Network security groups

Network security groups (NSG) let you allow or deny network traffic to and from Azure resources that exist in your Azure Virtual Network, for example, a virtual machine. Once you've created an NSG, it can be associated with multiple subnets or network interfaces (NIC) in your VNet. An NSG can contain zero or more rules that define how the traffic will be filtered.

NSG security rules are evaluated by priority using five information points: source, source port, destination, destination port, and protocol to either allow or deny the traffic. As a rule, you shouldn't create two security rules with the same priority and direction.

:::image type="content" source="../media/2-virtual-network.png" alt-text="Diagram showing a simplified virtual network with two subnets each with a dedicated virtual machine resource, the first subnet has a network security group and the second subnet doesn't.":::

In the above, highly simplified, diagram you can see an Azure Virtual Network with two subnets that are connected to the Internet, and each subnet has a virtual machine.  Subnet 1 has a network security group assigned to it, which is filtering inbound and outbound access to VM1, which needs a higher level of access. Whereas VM2 could represent a public-facing machine, which doesn't require an NSG.

## Inbound and outbound security rules

As you’ve seen an NSG controls access to resources on your virtual network and any subnets. An NSG is made up of one or more inbound or outbound security rules. For each rule you can specify a source and destination, port, protocol, and the desired action if it's triggered. As previously mentioned, the rules are processed based on their priority. By default, Azure creates a series of default rules to provide a baseline level of security. You can't remove the default rules, but you can override them by creating new rules with higher priorities.

Each rule specifies one or more of the following properties:

- **Name**: Every NSG rule needs to have a unique name that should describe its purpose. For example, AdminAccessOnlyFilter.
- **Priority**: A number between 100 and 4096. Rules are processed in priority order, with lower numbers processed before higher numbers. Once traffic matches a rule, processing stops, this means that any other rules with a lower priority (higher numbers) won't be processed.
- **Source or destination**: Specify either Individual IP address or IP address range, service tag (a group if IP address prefixes from a given Azure service), or application security group. Specifying a range, a service tag, or application security group, enables you to create fewer security rules.
- **Protocol**: What network protocol will the rule check. The protocol can be any of these: TCP, UDP, ICMP or Any.
- **Direction**: Whether the rule should be applied to inbound or outbound traffic.
- **Port Range**: You can specify an individual or range of ports. For example, you could specify 80 or 10000-10005. Specifying ranges enables you to create fewer security rules. You can't specify multiple ports or port ranges in the same security rule in network security groups created through the classic deployment model.
- **Action**: Finally, you need to decide

There are limits to the number of security rules you can create in a network security group. Use Azure network security groups to automatically allow or deny traffic to your cloud-based resources and assets.
