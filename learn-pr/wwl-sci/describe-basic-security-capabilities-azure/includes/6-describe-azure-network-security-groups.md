
Network security groups (NSGs) let you filter network traffic to and from Azure resources in an Azure virtual network; for example, a virtual machine. An NSG consists of rules that define how the traffic is filtered. You can associate only one network security group to each virtual network subnet and network interface in a virtual machine. The same network security group, however, can be associated to as many different subnets and network interfaces as you choose. 

In the highly simplified diagram that follows, you can see an Azure virtual network with two subnets that are connected to the internet, and each subnet has a virtual machine.  Subnet 1 has an NSG assigned to it that's filtering inbound and outbound access to VM1, which needs a higher level of access. In contrast, VM2 could represent a public-facing machine that doesn't require an NSG.

:::image type="content" source="../media/2-virtual-network.png" alt-text="Diagram showing a simplified virtual network with two subnets each with a dedicated virtual machine resource, the first subnet has a network security group and the second subnet doesn't.":::

## Inbound and outbound security rules

An NSG is made up of inbound and outbound security rules. NSG security rules are evaluated by priority using five information points: source, source port, destination, destination port, and protocol to either allow or deny the traffic. By default, Azure creates a series of rules, three inbound and three outbound rules, to provide a baseline level of security. You can't remove the default rules, but you can override them by creating new rules with higher priorities.

Each rule specifies one or more of the following properties:

- **Name**: Every NSG rule needs to have a unique name that describes its purpose. For example, AdminAccessOnlyFilter.
- **Priority**: Rules are processed in priority order, with lower numbers processed before higher numbers. When traffic matches a rule, processing stops. This means that any other rules with a lower priority (higher numbers) won't be processed.
- **Source or destination**: Specify either individual IP address or an IP address range, service tag (a group of IP address prefixes from a given Azure service), or application security group. Specifying a range, a service tag, or application security group, enables you to create fewer security rules.
- **Protocol**: What network protocol will the rule check? The protocol can be any of: TCP, UDP, ICMP or Any.
- **Direction**: Whether the rule should be applied to inbound or outbound traffic.
- **Port range**: You can specify an individual or range of ports. Specifying ranges enables you to be more efficient when creating security rules. 
- **Action**: Finally, you need to decide what will happen when this rule is triggered.

The screenshot that follows shows the default inbound rules and outbound, which are included in all NSGs.

:::image type="content" source="../media/network-security-group-rules-inline.png" lightbox="../media/network-security-group-rules-expanded.png" alt-text="Screenshot showing the default inbound and outbound rules for an Azure network security group.":::

Descriptions for the default inbound rules are as follows:.

- AllowVNetInBound - The AllowVNetInBound rule is processed first as it has the lowest priority value. Recall that rules with the lowest priority value get processed first. This rule allows traffic from a source with the VirtualNetwork service tag to a destination with the VirtualNetwork service tag on any port, using any protocol.  If a match is found for this rule, then no other rules are processed.  If no match is found, then the next rule gets processed.

- AllowAzureLoadBalancerInBound - The AllowAzureLoadBalancerInBound rule is processed second, as its priority value is higher than the AllowVNetInBound rule.  This rule allows traffic from a source with the AzureLoadBalancer service tag to a destination with the AzureLoadBalancer service tag on any port to any IP address on any port, using any protocol. If a match is found for this rule, then no other rules are processed.  If no match is found, then the next rule gets processed.

- DenyAllInBound - The last rule in this NSG is the DenyAllInBound rule.  This rule denies all traffic from any source IP address on any port to any other IP address on any port, using any protocol.  

In summary, any virtual network subnet or network interface card to which this NSG is assigned will only allow inbound traffic from an Azure Virtual Network or an Azure load balancer (as defined by their respective service tags).  All other inbound network traffic is denied. You can't remove the default rules, but you can override them by creating new rules with higher priorities (lower priority value).

### What is the difference between Network Security Groups (NSGs) and Azure Firewall?
Now that you've learned about both Network Security Groups and Azure Firewall, you may be wondering how they differ, as they both protect Virtual Network resources.  The Azure Firewall service complements network security group functionality. Together, they provide better "defense-in-depth" network security. Network security groups provide distributed network layer traffic filtering to limit traffic to resources ***within*** virtual networks in each subscription. Azure Firewall is a fully stateful, centralized network firewall as-a-service, which provides network and application-level protection ***across*** different subscriptions and virtual networks.