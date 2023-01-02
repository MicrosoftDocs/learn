Each network security group and its defined security rules are evaluated independently. Azure processes the conditions in each rule defined for each virtual machine in your configuration.

For inbound traffic, Azure first processes network security group security rules for any associated subnets and then any associated network interfaces. For outbound traffic, the process is reversed. Azure first evaluates network security group security rules for any associated network interfaces followed by any associated subnets. For both the inbound and outbound evaluation process, Azure also checks how to apply the rules for intra-subnet traffic.

How Azure ends up applying your defined security rules for a virtual machine determines the overall _effectiveness_ of your rules.

### Things to know about effective security rules

Let's explore how network security group rules are defined and processed within a virtual network to yield the effective rules.

Consider the following virtual network configuration that shows network security groups (NSGs) controlling traffic to virtual machines (VMs). The configuration requires security rules to manage network traffic to and from the internet over TCP port 80 via the network interface.

:::image type="content" source="../media/security-groups-7a9d5c84.png" alt-text="Illustration that shows how network security group security rules control traffic to virtual machines." border="false":::

In this virtual network configuration, there are three subnets. Subnet 1 contains two virtual machines: VM 1 and VM 2. Subnet 2 and Subnet 3 each contain one virtual machine: VM 3 and VM 4, respectively. The virtual machines in the subnets have network interface cards (NICs).

#### Inbound traffic effective rules

Azure processes rules for inbound traffic for all virtual machines in the configuration. Azure identifies if your machines are members of a network security group, and if they have associated subnets and network interfaces. The default behavior is to deny all inbound traffic from the internet.

- **VM 1**: Azure discovers that VM 1 is contained in Subnet 1, which is associated with NSG 1. Azure processes the subnet security rules in NSG 1 for VM 1.

   Azure discovers that VM 1 has a NIC, which is associated with NSG 2. To allow inbound traffic on port 80 to VM 1, both NSG 1 on the subnet and NSG 2 on the NIC must define a rule to allow inbound traffic on port 80 from the internet.
   
   By default, Azure creates the `DenyAllInbound` security rule. This default rule in Azure and any rules defined in NSG 1 take precedence over rules for inbound traffic defined in NSG 2. If NSG 1 defines the allow port 80 rule, then port 80 inbound traffic is processed by the rules in NSG 2.
   
   If NSG 1 doesn't define the allow port 80 rule, the inbound traffic is automatically denied by the default security rule in Azure. The inbound traffic never gets evaluated by the rules in NSG 2 because NSG 2 is associated to the NIC, which is lower in rule precedence than the subnet for inbound traffic.

- **VM 2**: Azure discovers that VM 2 is also contained in Subnet 1. Azure processes the same subnet security rules in NSG 1 for VM 2 as it did for VM 1.

   Azure discovers that VM 2 has a NIC, but this NIC doesn't have an associated network security group. As a result, the NIC in VM 2 receives all traffic allowed by the rules defined in NSG 1. The NIC is also denied all traffic that's denied by the rules set in NSG 1.

- **VM 3**: Azure discovers that VM 3 is contained in Subnet 2, which doesn't have an associated network security group. Because Subnet 2 has no associated NSG, inbound traffic into the Subnet 2 is allowed based on the default Azure security rules.

   Azure discovers that VM 3 has a NIC, which is associated with NSG 2. Azure processes the security rules in NSG 2 to control inbound traffic to the NIC for VM 3.

- **VM 4**: Azure discovers that VM 4 is contained in Subnet 3. Like Subnet 2, Subnet 3 also doesn't have an associated network security group. Azure allows inbound traffic to VM 4 based on the default Azure security rules.

   Azure discovers that VM 4 has a NIC, which also doesn't have an associated network security group. The NIC in VM 4 receives all traffic allowed by the default Azure security rules. The NIC is also denied all traffic that's denied by the default Azure security rules.

#### Outbound traffic effective rules

Azure processes rules for outbound traffic by examining network security group associations for NICs in your virtual machines. The default behavior is to allow all outbound traffic to the internet.

- **VM 1**: Azure discovers that VM 1 has a NIC and it's associated with NSG 2. Azure processes the NIC security rules in NSG 2 for VM 1.
   
   To deny traffic to port 80 from the virtual machine, then either or both NSG 1 and NSG 2 must have a rule to deny port 80 traffic to the internet. By default, Azure creates the `AllowInternetOutbound` security rule. This default rule in Azure and any rules defined in NSG 2 take precedence over rules for outbound traffic defined in NSG 1.
   
   To deny outbound traffic on port 80 from VM 1, both NSG 2 on the NIC and NSG 1 on the subnet must define a rule to deny outbound traffic on port 80 to the internet. If NSG 2 doesn't define the deny port 80 rule, the outbound traffic is automatically allowed by the default security rule in Azure.

   If NSG 2 defines the deny port 80 rule, the outbound traffic never gets evaluated by rules in NSG 1. NSG 1 is associated to the subnet, which is lower in rule precedence than the NIC for outbound traffic.

- **VM 2**: Azure discovers that VM 2 has a NIC, but this NIC doesn't have an associated network security group. As a result, Azure processes the NSG 1 security rules for the NIC and the subnet in VM 2 to control outbound traffic.

- **VM 3**: Azure discovers that VM 3 has a NIC and it's associated with NSG 2 similar to the NIC in VM 1.

   Azure processes the security rules in NSG 2 to process outbound traffic to the NIC for VM 3.
   
   If NSG 2 defines a rule to deny outbound traffic on port 80, this rule overrides the default Azure security rules, and any outbound rules defined in NSG 1 for Subnet 3. No outbound traffic is processed by the subnet.

- **VM 4**: Azure discovers that VM 4 has a NIC, and it's not associated with a network security group. There's also no network security group associated with Subnet 3. As a result, all network outbound traffic is allowed from VM 4 according to the default Azure security rules.

### Things to consider about creating effective rules

Review the following considerations regarding creating effective security rules for machines in your virtual network.

- **Consider allowing all traffic**. If you place your virtual machine within a subnet or utilize a network interface, you don't have to associate the subnet or NIC with a network security group. This approach allows all network traffic through the subnet or NIC according to the default Azure security rules. If you're not concerned about controlling traffic to your resource at a specific level, then don't associate your resource at that level to a network security group.

- **Consider importance of allow rules**. When you create a network security group, you must define an **allow** rule for both the subnet and network interface in the group to ensure traffic can get through. If you have a subnet or NIC in your network security group, you must define an allow rule at each level. Otherwise, the traffic is denied for any level that doesn't provide an allow rule definition.

- **Consider intra-subnet traffic**. The security rules for a network security group that's associated to a subnet can affect traffic between all virtual machines in the subnet. By default, Azure allows virtual machines in the same subnet to send traffic to each other (referred to as _intra-subnet traffic_). You can prohibit intra-subnet traffic by defining a rule in the network security group to deny all inbound and outbound traffic. This rule prevents all virtual machines in your subnet from communicating with each other.

### View effective security rules

If you have several network security groups and aren't sure which security rules are being applied, you can use the **Effective security rules** link in the Azure portal. You can use the link to verify which security rules are applied to your machines, subnets, and network interfaces.

:::image type="content" source="../media/effective-security-rules-d93ab464.png" alt-text="Screenshot of the Networking page in the Azure portal showing the Effective security rules link highlighted.":::