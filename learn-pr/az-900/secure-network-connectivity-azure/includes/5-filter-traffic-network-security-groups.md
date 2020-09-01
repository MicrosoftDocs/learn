While Azure Firewall and Azure DDoS Protection can help control what traffic can come from outside sources, Tailwind Traders would also like to understand how to protect their internal networks on Azure. Doing so will give them an extra layer of defence against attacks.

In this part, you examine network security groups.

## What are network security groups?

A [network security group](https://docs.microsoft.com/azure/virtual-network/security-overview#network-security-groups?azure-portal=true) (NSG) enables you to filter network traffic to and from Azure resources within an Azure Virtual Network (VNet). You can think of network security groups like an internal firewall. An NSG can contain multiple inbound and outbound security rules that enable you to filter traffic to and from resources by source and destination IP address, port, and protocol.

## How do I specify network security groups rules?

A network security group can contain as many rules as you need, within Azure subscription limits. Each rule specifies these properties:

| Property | Description|
| --- | --- |
| Name | A unique name for the NSG. |
| Priority | A number between 100 and 4096. Rules are processed in priority order, with lower numbers processed before higher numbers. |
| Source or Destination | An single IP address or IP address range, service tag, or application security group. |
| Protocol | TCP, UDP, or Any.|
| Direction | Whether the rule applies to inbound or outbound traffic. |
| Port Range | A single port or range of ports. |
| Action | Allow or Deny. |

When you create a network security group, Azure creates a series of default rules to provide a baseline level of security. You cannot remove the default rules, but you can override them by creating new rules with higher priorities.
