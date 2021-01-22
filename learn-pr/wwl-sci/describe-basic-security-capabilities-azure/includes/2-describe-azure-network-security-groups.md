In today’s modern work environment, where more users are working remotely from home, managing access to assets and resource on your Azure virtual network (VNet) is essential.

Here, you’ll learn how Azure network security groups can automatically allow or deny traffic to your cloud-based resources and assets.

An Azure virtual network is similar to the network you’d find in your organization. It enables different Azure resources, for instance, an Azure virtual machine (VM), to securely communicate with other VNets, the internet, or your on-premises network.  A VNet can be divided into multiple subnetworks (subnets), each with specific resources assigned to them. You can secure the resources within a subnet using network security groups.

## Network security groups

Network security groups (NSGs) let you allow or deny network traffic to and from Azure resources that exist in your Azure virtual network; for example, a virtual machine. When you've created an NSG, it can be associated with multiple subnets or network interfaces in your VNet. An NSG can contain zero or more rules that define how the traffic is filtered.

NSG security rules are evaluated by priority using five information points: source, source port, destination, destination port, and protocol to either allow or deny the traffic. As a guideline, you shouldn't create two security rules with the same priority and direction.

:::image type="content" source="../media/2-virtual-network.png" alt-text="Diagram showing a simplified virtual network with two subnets each with a dedicated virtual machine resource, the first subnet has a network security group and the second subnet doesn't.":::

In the above, highly simplified, diagram you can see an Azure virtual network with two subnets that are connected to the internet, and each subnet has a virtual machine.  Subnet 1 has an NSG assigned to it that's filtering inbound and outbound access to VM1, which needs a higher level of access. In contrast, VM2 could represent a public-facing machine that doesn't require an NSG.

## Inbound and outbound security rules

As you’ve seen, an NSG controls access to resources on your virtual network and any subnets. An NSG is made up of one or more inbound or outbound security rules. For each rule, you can specify a source and destination, port, protocol, and the required action if it's triggered. As previously mentioned, the rules are processed based on their priority. By default, Azure creates a series of rules to provide a baseline level of security. You can't remove the default rules, but you can override them by creating new rules with higher priorities.

Each rule specifies one or more of the following properties:

- **Name**: Every NSG rule needs to have a unique name that describes its purpose. For example, AdminAccessOnlyFilter.
- **Priority**: A number between 100 and 4096. Rules are processed in priority order, with lower numbers processed before higher numbers. When traffic matches a rule, processing stops. This means that any other rules with a lower priority (higher numbers) won't be processed.
- **Source or destination**: Specify either individual IP address or an IP address range, service tag (a group of IP address prefixes from a given Azure service), or application security group. Specifying a range, a service tag, or application security group, enables you to create fewer security rules.
- **Protocol**: What network protocol will the rule check? The protocol can be any of: TCP, UDP, ICMP or Any.
- **Direction**: Whether the rule should be applied to inbound or outbound traffic.
- **Port range**: You can specify an individual or range of ports. For example, you could specify 80 or 10000-10005. Specifying ranges enables you to create fewer security rules. You can't specify multiple ports or port ranges in the same security rule in NSGs created through the classic deployment model.
- **Action**: Finally, you need to decide what will happen when this rule is triggered.

There are limits to the number of security rules you can create in an NSG. Use Azure NSGs to automatically allow or deny traffic to your cloud-based resources and assets.
