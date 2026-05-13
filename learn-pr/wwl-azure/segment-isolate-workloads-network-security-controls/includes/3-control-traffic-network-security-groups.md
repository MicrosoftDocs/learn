Network security groups (NSGs) give you precise control over which workloads can communicate with each other in Azure. Contoso's team has prioritized three segmentation goals based on the Unit 2 assessment: block web-tier virtual machines (VMs) from directly accessing the database tier on port 1433, isolate dev VMs from production workloads, and allow app-tier VMs to reach the database tier on port 1433 only. Here, you learn how to configure NSG rules to enforce these goals using a security-first, least-privilege approach.

| Step | Action |
|------|--------|
| Define segmentation goals | Identify which workloads need access and which should be blocked |
| Create NSG with deny-all baseline | Start with a deny rule to block all traffic by default |
| Add specific allow rules | Permit only documented business-critical traffic |
| Attach NSG to subnet | Apply the ruleset to all resources in the tier |
| Validate rule priority order | Ensure deny rules execute before conflicting allow rules |

## Understand NSG architecture and security-first design

An **NSG** is a list of **inbound** and **outbound** security rules that Azure evaluates in **priority** order to determine whether to allow or deny traffic. Each NSG rule specifies a source, destination, protocol, port range, and action (Allow or Deny).

NSGs can attach to subnets or individual network interface cards (NICs). Subnet attachment is the correct choice for tier-level segmentation because it affects all resources in the subnet and simplifies management. NIC-level NSGs create more complexity and can conflict with subnet NSG rules, making troubleshooting difficult.

Every NSG includes default rules that you can't remove. These defaults allow traffic within the virtual network (AllowVNetInBound at priority 65000), allow traffic from Azure's load balancer (AllowAzureLoadBalancerInBound at priority 65001), and deny all other inbound traffic (DenyAllInBound at priority 65500). Similar rules exist for outbound traffic. Custom rules with lower priority numbers execute before these defaults.

The security-first stance starts with a deny-all subnet NSG and adds only required allow rules. This approach is the opposite of the default allow-all, with and adding a deny-rule pattern that most network administrators take, but it prevents accidental exposure of workloads during configuration changes.

Priority matters because Azure evaluates rules in order from lowest to highest priority number. A deny rule at priority 100 blocks traffic before Azure evaluates the allow-rule at priority 200. This means you should reserve the 100-200 priority range for critical deny rules that enforce hard security boundaries.

## Configure rule properties to enforce least privilege

Each NSG rule requires six properties that together determine what traffic to allow or deny.

**Source** and **destination** accept an IP address, CIDR (Classless Inter-Domain Routing) range, **service tag**, or application security group. Service tags like AzureLoadBalancer, Internet, and virtual network let you scope rules without managing IP address lists. For example, using the AzureLoadBalancer tag as the source allows traffic from Azure's infrastructure load balancer (168.63.129.16) without hard-coding that IP address.

**Protocol** specifies TCP, UDP, or Any. Be specific—choosing "Any" creates unnecessary risk. If your application uses TCP port 1433 for SQL Server connections, the rule should specify TCP, not Any.

**Port** accepts a specific port number (such as 1433, 22, 443, or 3389) or a range. Avoid broad ranges like 0-65535 in allow rules because they undermine the principle of least privilege. With **augmented security rules**, you can specify multiple ports, source addresses, or destination addresses in a single rule using comma-separated values, which reduce your total rule count.

**Action** is either Allow or Deny. Use Deny rules to create hard security boundaries and Allow rules to open specific, documented pathways.

**Priority** ranges from 100 to 4096, with lower numbers evaluated first. Leave gaps between priority numbers so future administrators can insert rules without renumbering your entire ruleset.

> [!TIP]
> Use service tags whenever possible instead of hard-coding IP addresses. Tags like virtual network and AzureLoadBalancer automatically adapt when Azure updates its infrastructure IP ranges, reducing long-term maintenance.

## Attach an NSG to the database subnet

Contoso's team creates an NSG to protect the database tier using subnet-level attachment. The following steps show the configuration sequence in the Azure portal.

1. Create a new NSG named `nsg-database-subnet` in the same resource group as the virtual network.
2. Add an inbound allow rule with source set to the app subnet IP range (for example, 10.0.2.0/24), destination set to Any, protocol set to TCP, destination port set to 1433, priority set to 200, and action set to Allow.
3. Add an inbound deny rule with source set to Any, destination set to Any, protocol set to TCP. Then ensure the destination port is set to 1433, priority set to 300, and action set to Deny to block any other source from reaching port 1433.
4. Add a deny-all inbound rule at priority 4000 with source set to Any, destination set to Any, protocol set to Any, port set to Any, and action set to Deny as a redundant safety measure, though the default DenyAllInBound rule at priority 65500 already provides this protection.
5. Attach the NSG to the database subnet rather than to individual NICs because subnet-level enforcement is broader and simpler to manage.

Subnet attachment means every VM in the database tier inherits the same protection automatically. When Contoso adds a new database server to the subnet, the NSG rules apply immediately without extra configuration.

## Translate segmentation goals into NSG rules

Contoso's three segmentation goals map directly to specific NSG rules. The following table shows how each business requirement translates into a technical control.

| Goal | Rule type | Source | Destination port | Action | Priority |
|------|-----------|--------|------------------|--------|----------|
| Block web → database (port 1433) | Inbound on DB subnet | Web subnet CIDR (x.x.x.x/24) | 1433 | Deny | 100 |
| Allow app → database (port 1433) | Inbound on DB subnet | App subnet CIDR (x.x.x.X/24) | 1433 | Allow | 200 |
| Block dev → production (all ports) | Inbound on Production subnet | Dev subnet CIDR (x.x.x.x/24) | * | Deny | 100 |
| Allow load balancer → web (443) | Inbound on Web subnet | AzureLoadBalancer tag | 443 | Allow | 200 |

These rules use CIDR ranges as the source, which works in stable environments where subnet allocations don't change frequently. In the next unit, you replace the CIDR-based sources with application security groups, which makes these rules easier to maintain as the environment scales.

## Avoid common NSG misconfigurations

Several anti-patterns undermine NSG effectiveness and create false confidence in your security posture.

Allow Any → Any rules nullify the security benefit of NSGs entirely. If you have a documented business reason for allowing all traffic, the environment probably doesn't need NSG-level segmentation at all. Stacking too many NIC-level NSGs that conflict with subnet NSGs creates difficult troubleshooting because Azure evaluates both layers and applies the most restrictive rule.

Priority gaps that let future administrators insert allow rules above your deny rules create security drift over time. For example, if your critical deny rule is at priority 200 and your allow rule is at priority 300, someone can insert an allow rule at priority 150 that bypasses your deny rule. Reserve the 100-199 range for deny rules and start allow rules at 200 or higher.

Not logging NSG flow logs means you can't audit what traffic your rules are blocking or allowing. NSG flow logs feed into tools like Microsoft Defender for Cloud and Microsoft Sentinel to detect anomalies.

The least-privilege principle applies to NSG rules: if you don't have a documented business reason for a rule, it shouldn't exist. Review your ruleset quarterly and remove rules that no longer serve active workloads.

IP-based CIDR rules work in stable environments, but as workloads scale and IPs change, maintaining accurate source and destination CIDRs becomes error-prone.
