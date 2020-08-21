[Network Security Groups (NSG)](https://docs.microsoft.com/azure/virtual-network/security-overview#network-security-groups?azure-portal=true) allow you to filter network traffic to and from Azure resources in an Azure virtual network. You can think of them like an internal firewall. An NSG can contain multiple inbound and outbound security rules that enable you to filter traffic to and from resources by source and destination IP address, port, and protocol.

<div style="background:yellow;">
TODO: Needs an architecture diagram.
</div>


**Network security rule properties**

A network security group can contain as many rules as you  need, within Azure subscription limits. Each rule specifies the following properties:

| Property| Explanation| 
| --- | --- |
| Name |Unique name of the Network Security Group (NSG). |
| Priority | A number between 100 and 4096. Rules are processed in priority order, with lower numbers processed before higher numbers. |
| Source or Destination| Individual IP address or IP address range, service tag, or application security group. |
| Protocol | TCP, UDP, or Any.|
| Direction| Whether the rule applies to inbound or outbound traffic. |
| Port Range | An individual port or range of ports. |
| Action | Allow or Deny. |

When you create a network security group, Azure creates a series of default rules to provide a baseline level of security. You cannot remove the default rules, but you can override them by creating new rules with higher priorities.

