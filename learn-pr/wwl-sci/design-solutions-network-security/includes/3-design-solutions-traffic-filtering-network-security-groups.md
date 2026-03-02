Network security groups (NSGs) are the primary mechanism for filtering traffic between Azure resources in a virtual network. Each NSG contains security rules that allow or deny traffic based on source, destination, port, protocol, and direction. As a security architect, you design NSG-based filtering solutions that enforce least-privilege access at the network layer, aligning with MCSB v2 control NS-1 (Establish network segmentation boundaries) and Zero Trust principles.

## Understand how NSGs evaluate traffic

Before designing NSG rules, you need to understand how Azure evaluates them. NSGs are stateful—if you allow inbound traffic on a port, the response traffic is automatically permitted without a separate outbound rule. Azure evaluates rules using a five-tuple match: source IP, source port, destination IP, destination port, and protocol. Rules are processed in priority order, where lower priority numbers are evaluated first (100 is evaluated before 200). Processing stops at the first matching rule.

This "first match wins" behavior is fundamental to your design. Place your most specific allow rules at lower priority numbers and broader deny rules at higher numbers. You can assign priorities between 100 and 4096, with Azure's default rules occupying 65000 and above.

## Design NSG association strategy

You can associate an NSG with a subnet, a network interface (NIC), or both. The processing order depends on traffic direction:

- **Inbound traffic.** Azure evaluates the subnet NSG first, then the NIC NSG. Traffic must be allowed by both to reach the virtual machine.
- **Outbound traffic.** Azure evaluates the NIC NSG first, then the subnet NSG. Traffic must be allowed by both to leave the virtual network.
- **Intra-subnet traffic.** The subnet NSG evaluates traffic between VMs in the same subnet. The default `AllowVNetInBound` rule permits this traffic, so you must add explicit deny rules if you need to block communication between VMs within a subnet.

> [!TIP]
> For optimal security configuration, associate your NSG with either the subnet or the network interface, but avoid both at the same time. When NSGs are applied at multiple levels, rules can conflict with each other, leading to unexpected traffic filtering that's difficult to troubleshoot.

For most designs, subnet-level association is the preferred approach because it applies consistent filtering to all resources in the subnet and simplifies rule management. Use NIC-level NSGs only when individual VMs within the same subnet require different filtering rules.

## Design rules around default security rules

Azure automatically creates default rules in every NSG that you can't remove but can override with higher-priority custom rules. Understanding these defaults shapes your design:

**Inbound defaults:**

| Priority | Name | Action |
|---|---|---|
| 65000 | AllowVNetInBound | Allow traffic within the virtual network |
| 65001 | AllowAzureLoadBalancerInBound | Allow health probes from Azure Load Balancer |
| 65500 | DenyAllInBound | Deny all other inbound traffic |

**Outbound defaults:**

| Priority | Name | Action |
|---|---|---|
| 65000 | AllowVnetOutBound | Allow traffic within the virtual network |
| 65001 | AllowInternetOutBound | Allow outbound traffic to the internet |
| 65500 | DenyAllOutBound | Deny all other outbound traffic |

The `DenyAllInBound` default blocks all inbound traffic not explicitly allowed, which aligns with a deny-by-default design. However, the `AllowInternetOutBound` default permits all outbound internet access. In a security-focused design, override this default with explicit deny rules and allow only the outbound destinations your workloads require. For centralized outbound control, route traffic through Azure Firewall where you can filter by fully qualified domain name (FQDN).

## Simplify rules with service tags

[Service tags](/azure/virtual-network/service-tags-overview) represent groups of IP address prefixes for Azure services. Microsoft manages the IP ranges and automatically updates service tags as addresses change, eliminating the need to track individual IPs in your rules.

Use service tags in place of specific IP addresses when designing rules that control traffic to or from Azure services. For example, instead of maintaining a list of Azure Storage IP addresses, use the `Storage` service tag. Key service tags for security-focused designs include:

- **AzureActiveDirectory.** Traffic to Microsoft Entra ID for authentication
- **AzureMonitor.** Traffic to Log Analytics, Application Insights, and Azure Monitor
- **Sql.** Traffic to Azure SQL Database and Azure Synapse Analytics
- **Storage.** Traffic to Azure Storage accounts
- **AzureKeyVault.** Traffic to Azure Key Vault for secrets management

Service tags also support regional scoping. For example, `Storage.WestUS` narrows the allowed range to only Azure Storage IP addresses in the West US region. Use regional tags when your workloads access services in a specific region, reducing the allowed IP range to the minimum necessary.

## Design role-based filtering with application security groups

[Application security groups (ASGs)](/azure/virtual-network/application-security-groups) let you group virtual machines by application role and use those groups as sources or destinations in NSG rules. This approach aligns your network security rules with your application architecture rather than managing individual IP addresses.

Consider a three-tier application with web, logic, and database tiers. You create three ASGs—`AsgWeb`, `AsgLogic`, and `AsgDb`—and assign each VM's network interface to the appropriate group. Your NSG rules then reference these groups:

| Priority | Source | Destination | Port | Action | Purpose |
|---|---|---|---|---|---|
| 100 | Internet | AsgWeb | 80, 443 | Allow | Web traffic from internet |
| 110 | AsgLogic | AsgDb | 1433 | Allow | Business logic to database |
| 120 | Any | AsgDb | 1433 | Deny | Block all other database access |

This design ensures that only the logic tier can reach the database tier, regardless of how many VMs you add to each group. When you scale out by adding new VMs, you assign them to the appropriate ASG—no rule changes are needed.

> [!IMPORTANT]
> All network interfaces assigned to an application security group must exist in the same virtual network. You can't add network interfaces from different virtual networks to the same ASG.

## Use augmented security rules for complex environments

Augmented security rules let you combine multiple IP addresses, ranges, service tags, and port ranges in a single rule. In large environments with many IP ranges, augmented rules significantly reduce the total number of rules you need to manage. For example, a single rule can specify multiple source IP ranges and multiple destination ports, replacing what would otherwise require dozens of individual rules.

There are [limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-resource-manager-virtual-networking-limits) to the number of addresses, ranges, and ports you can specify per rule and per NSG. Plan your rule design within these limits and use augmented rules strategically to stay within them.

## Integrate with Security Admin Rules

As covered in the previous unit on network segmentation, Azure Virtual Network Manager [Security Admin Rules](/azure/virtual-network-manager/concept-security-admins) are evaluated **before** NSG rules. This evaluation order means your central security team can enforce organization-wide guardrails—like blocking inbound RDP (3389) or SSH (22) from the internet—that individual application teams can't override through their NSG configurations. Design your NSG rules with the understanding that Security Admin Rules act as the first layer of evaluation, and NSG rules provide workload-specific filtering within those guardrails.

## Monitor traffic filtering decisions

Designing NSG rules is only effective when you can verify and monitor how they filter traffic. Azure provides several tools for this purpose:

- **Virtual network flow logs.** Record all IP traffic flowing through a virtual network, including which NSG or Security Admin Rule allowed or denied each flow. Virtual network flow logs replace the older NSG flow logs (retiring September 30, 2027) and provide broader coverage, including traffic through VPN gateways, ExpressRoute gateways, and Application Gateways.
- **Traffic Analytics.** Processes flow log data to provide insights into traffic patterns, top talkers, security threats, and bandwidth consumption across your network.
- **IP flow verify.** An Azure Network Watcher capability that tests whether a specific packet is allowed or denied to or from a VM, identifying which NSG rule is responsible. Use this tool to troubleshoot connectivity issues.
- **Effective security rules.** Shows the aggregate of all NSG rules applied to a network interface, including default rules and rules from both subnet and NIC-level NSGs. Review effective rules to verify that your intended filtering is in place.
