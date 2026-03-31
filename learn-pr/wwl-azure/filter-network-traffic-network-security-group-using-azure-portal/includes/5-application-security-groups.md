Application security groups (ASGs) enable you to configure network security as a natural extension of your application's structure. Instead of defining security rules based on explicit IP addresses, you can group virtual machines by their application role and define network security policies based on those groups. This approach simplifies security management and makes rules reusable at scale.

## Benefits of application security groups

- **Simplified management**: Group virtual machines (VMs) by application tier (web, logic, database) rather than managing individual IP addresses
- **Scalable security**: Apply consistent security policies across multiple VMs without updating rules
- **Intuitive organization**: Security rules reflect your application architecture
- **Reduced complexity**: The platform handles IP address management automatically

## Example: Multi-tier application security

Consider a three-tier application with web servers, application servers, and database servers:

:::image type="content" source="../media/application-security-groups-fab4e68f.png" alt-text="Diagram showing an example of Azure Network Security Groups and Application Security Groups.":::

In this example:
- **NIC1** and **NIC2** are members of the **AsgWeb** application security group (web tier)
- **NIC3** is a member of the **AsgLogic** application security group (application tier)
- **NIC4** is a member of the **AsgDb** application security group (database tier)

Each network interface can be a member of multiple ASGs (up to Azure subscription limits). No NSGs are associated directly with the network interfaces. Instead, **NSG1** is associated with both subnets and contains the following rules:

### Allow-HTTP-Inbound-Internet

This rule allows HTTP traffic from the internet to reach the web tier. The DenyAllInBound default security rule blocks all other inbound traffic from the internet, so no other rules are needed for the AsgLogic or AsgDb groups.

| **Priority** | **Source** | **Source ports** | **Destination** | **Destination ports** | **Protocol** | **Access** |
| ------------ | ---------- | ---------------- | --------------- | --------------------- | ------------ | ---------- |
| 100          | Internet   | \*               | AsgWeb          | 80                    | TCP          | Allow      |

### Deny-Database-All

This rule blocks all traffic to the database tier by default. It's necessary because the AllowVNetInBound default rule would otherwise allow all resources in the virtual network to communicate with the database.

| **Priority** | **Source** | **Source ports** | **Destination** | **Destination ports** | **Protocol** | **Access** |
| ------------ | ---------- | ---------------- | --------------- | --------------------- | ------------ | ---------- |
| 120          | \*         | \*               | AsgDb           | 1433                  | Any          | Deny       |

### Allow-Database-BusinessLogic

This rule allows traffic from the application logic tier (AsgLogic) to the database tier (AsgDb). The rule has **priority 110**, which is lower than the Deny-Database-All rule (priority 120). Since lower priority numbers are processed first, this rule is evaluated before the deny rule, allowing AsgLogic to access the database while blocking all other traffic.

| **Priority** | **Source** | **Source ports** | **Destination** | **Destination ports** | **Protocol** | **Access** |
| ------------ | ---------- | ---------------- | --------------- | --------------------- | ------------ | ---------- |
| 110          | AsgLogic   | \*               | AsgDb           | 1433                  | TCP          | Allow      |

### How rules apply

Only network interfaces that are members of an ASG are affected by rules that specify that ASG as the source or destination. If a network interface isn't a member of an ASG referenced in a rule, the rule doesn't apply to that network interface, even if the NSG is associated with its subnet.

## Constraints and considerations

When working with application security groups, keep these limitations in mind:

 -  **Subscription limits**: There are limits to the number of ASGs per subscription. Review Azure subscription limits documentation for current values.
 -  **Same virtual network requirement**: All network interfaces in an ASG must exist in the same virtual network. For example, if the first NIC assigned to AsgWeb is in VNet1, all subsequent NICs assigned to AsgWeb must also be in VNet1.
 -  **Cross-ASG rules**: When specifying ASGs as both source and destination in a security rule, all network interfaces in both ASGs must exist in the same virtual network. For example, if AsgLogic has NICs from VNet1 and AsgDb has NICs from VNet2, you can't create a rule with AsgLogic as source and AsgDb as destination.

> [!TIP]
> Plan your ASG structure before implementing security rules. Using ASGs and service tags instead of individual IP addresses or IP ranges minimizes the number of security rules you need to create and maintain. Fewer rules, simplifies management and reduces the likelihood of configuration errors.
