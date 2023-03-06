Each network security group and its defined security rules are evaluated independently. Azure processes the conditions in each rule defined for each virtual machine in your configuration.

- For inbound traffic, Azure first processes network security group security rules for any associated subnets and then any associated network interfaces.
- For outbound traffic, the process is reversed. Azure first evaluates network security group security rules for any associated network interfaces followed by any associated subnets.
- For both the inbound and outbound evaluation process, Azure also checks how to apply the rules for intra-subnet traffic.

How Azure ends up applying your defined security rules for a virtual machine determines the overall _effectiveness_ of your rules.

### Things to know about effective security rules

Let's explore how network security group rules are defined and processed within a virtual network to yield the effective rules.

Consider the following virtual network configuration that shows network security groups (NSGs) controlling traffic to virtual machines (VMs). The configuration requires security rules to manage network traffic to and from the internet over TCP port 80 via the network interface.

:::image type="content" source="../media/security-groups-7a9d5c84.png" alt-text="Illustration that shows how network security group security rules control traffic to virtual machines." border="false":::

In this virtual network configuration, there are three subnets. Subnet 1 contains two virtual machines: VM 1 and VM 2. Subnet 2 and Subnet 3 each contain one virtual machine: VM 3 and VM 4, respectively. Each VM has a network interface card (NIC).

Azure evaluates each NSG configuration to determine the effective security rules:

| Evaluation | Subnet _NSG_ | NIC _NSG_ | Inbound rules | Outbound rules | 
| --- | --- | --- | --- | --- |
| **VM 1** | Subnet 1 <br> _NSG 1_ | NIC <br> _NSG 2_ | _NSG 1_ subnet rules have precedence over _NSG 2_ NIC rules | _NSG 2_ NIC rules have precedence over _NSG 1_ subnet rules |
| **VM 2** | Subnet 1 <br> _NSG 1_ | NIC <br> _none_ | _NSG 1_ subnet rules apply to both subnet and NIC | Azure default rules apply to NIC <br> and _NSG 1_ subnet rules apply to subnet only |
| **VM 3** | Subnet 2 <br> _none_ | NIC <br> _NSG 2_ | Azure default rules apply to subnet <br> and _NSG 2_ rules apply to NIC | _NSG 2_ NIC rules apply to NIC and subnet |
| **VM 4** | Subnet 3 <br> _none_ | NIC <br> _none_ | Azure default rules apply to both subnet and NIC <br> and all inbound traffic is allowed | Azure default rules apply to both subnet and NIC <br> and all outbound traffic is allowed |

#### Inbound traffic effective rules

Azure processes rules for inbound traffic for all VMs in the configuration. Azure identifies if the VMs are members of an NSG, and if they have an associated subnet or NIC.

- When an NSG is created, Azure creates the default security rule `DenyAllInbound` for the group. The default behavior is to deny all inbound traffic from the internet. If an NSG has a subnet or NIC, the rules for the subnet or NIC can override the default Azure security rules.

- NSG inbound rules for a subnet in a VM take precedence over NSG inbound rules for a NIC in the same VM.

#### Outbound traffic effective rules

Azure processes rules for outbound traffic by first examining NSG associations for NICs in all VMs. 

- When an NSG is created, Azure creates the default security rule `AllowInternetOutbound` for the group. The default behavior is to allow all outbound traffic to the internet. If an NSG has a subnet or NIC, the rules for the subnet or NIC can override the default Azure security rules.

- NSG outbound rules for a NIC in a VM take precedence over NSG outbound rules for a subnet in the same VM.

### Things to consider when creating effective rules

Review the following considerations regarding creating effective security rules for machines in your virtual network.

- **Consider allowing all traffic**. If you place your virtual machine within a subnet or utilize a network interface, you don't have to associate the subnet or NIC with a network security group. This approach allows all network traffic through the subnet or NIC according to the default Azure security rules. If you're not concerned about controlling traffic to your resource at a specific level, then don't associate your resource at that level to a network security group.

- **Consider importance of allow rules**. When you create a network security group, you must define an **allow** rule for both the subnet and network interface in the group to ensure traffic can get through. If you have a subnet or NIC in your network security group, you must define an allow rule at each level. Otherwise, the traffic is denied for any level that doesn't provide an allow rule definition.

- **Consider intra-subnet traffic**. The security rules for a network security group that's associated to a subnet can affect traffic between all virtual machines in the subnet. By default, Azure allows virtual machines in the same subnet to send traffic to each other (referred to as _intra-subnet traffic_). You can prohibit intra-subnet traffic by defining a rule in the network security group to deny all inbound and outbound traffic. This rule prevents all virtual machines in your subnet from communicating with each other.

- **Consider rule priority**. The security rules for a network security group are processed in priority order. To ensure a particular security rule is always processed, assign the lowest possible priority value to the rule. It's a good practice to leave gaps in your priority numbering, such as 100, 200, 300, and so. The gaps in the numbering allow you to add new rules without having to edit existing rules.

### View effective security rules

If you have several network security groups and aren't sure which security rules are being applied, you can use the **Effective security rules** link in the Azure portal. You can use the link to verify which security rules are applied to your machines, subnets, and network interfaces.

:::image type="content" source="../media/effective-security-rules-d93ab464.png" alt-text="Screenshot of the Networking page in the Azure portal showing the Effective security rules link highlighted.":::