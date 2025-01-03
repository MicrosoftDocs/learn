
A Network Security Group (NSG) in Azure allows you to filter network traffic to and from Azure resources in an Azure virtual network. A network security group contains security rules that allow or deny inbound network traffic to, or outbound network traffic from, several types of Azure resources. For each rule, you can specify source and destination, port, and protocol.

## NSG security rules

A network security group contains zero, or as many rules as desired, within Azure subscription limits. Each rule has these properties.

- **Name**. Must be a unique name within the network security group.
- **Priority**. Can be any number between 100 and 4096. Rules are processed in priority order, with lower numbers processed before higher numbers, because lower numbers have higher priority. Once traffic matches a rule, processing stops. A
- **Source or destination**. Can be set to Any, or an individual IP address, or classless inter-domain routing (CIDR) block (10.0.0.0/24, for example), service tag, or application security group.
- **Protocol**. Can be TCP, UDP, ICMP, ESP, AH, or Any.
- **Direction**. Can be configured to apply to inbound, or outbound traffic.
- **Port range**. Can be specified either as an individual port or range of ports. For example, you could specify 80 or 10000-10005. Specifying ranges enables you to create fewer security rules.
- **Action**. Can be configured to allow or deny.

The firewall evaluates the rules using the source, source port, destination, destination port, and protocol.

## Default security rules

Azure creates these default rules.

| **Direction** |           **Name**            | **Priority** |    **Source**     | **Source Ports** | **Destination** | **Destination Ports** | **Protocol** | **Access** |
|:-------------:|:-----------------------------:|:------------:|:-----------------:|:----------------:|:---------------:|:---------------------:|:------------:|:----------:|
|    Inbound    |       `AllowVNetInBound`       |    65000     |  `VirtualNetwork`   |     0-65535      | `VirtualNetwork`  |        0-65535        |     Any      |   Allow    |
|    Inbound    | `AllowAzureLoadBalancerInBound` |    65001     | `AzureLoadBalancer` |     0-65535      |    0.0.0.0/0    |        0-65535        |     Any      |   Allow    |
|    Inbound    |        `DenyAllInbound`         |    65500     |     0.0.0.0/0     |     0-65535      |    0.0.0.0/0    |        0-65535        |     Any      |    Deny    |
|   Outbound    |       `AllowVnetOutBound`      |    65000     |  `VirtualNetwork`   |     0-65535      | `VirtualNetwork`  |        0-65535        |     Any      |   Allow    |
|   Outbound    |     `AllowInternetOutBound`     |    65001     |     0.0.0.0/0     |     0-65535      |    `Internet`     |        0-65535        |     Any      |   Allow    |
|   Outbound    |        `DenyAllOutBound`       |    65500     |     0.0.0.0/0     |     0-65535      |    0.0.0.0/0    |        0-65535        |     Any      |    Deny    |

This diagram and bullet points illustrate different scenarios for how network security groups might be deployed.

:::image type="content" source="../media/network-security-group-interaction-92030446.png" alt-text="Diagram of the network security group example.":::

For **inbound traffic** Azure processes the rules in a network security group associated to a subnet first, if there's one, and then the rules in a network security group associated to the network interface, if there's one.

- **VM1:** `Subnet1` is associated with NSG1, so the security rules are processed, and VM1 is in `Subnet1`. Unless you created a rule that allows port 80 inbound, the `DenyAllInbound` default security rule denies the traffic, and never evaluated by NSG2, since NSG2 is associated to the network interface. If NSG1 has a security rule that allows port 80, NSG2 then processes the traffic. To allow port 80 to the virtual machine, both NSG1 and NSG2 must have a rule that allows port 80 from the internet.
- **VM2:** The rules in NSG1 are processed because VM2 is also in `Subnet1`. Since VM2 doesn't have a network security group associated to its network interface, it receives all traffic allowed through NSG1 or is denied all traffic denied by NSG1. Traffic is either allowed or denied to all resources in the same subnet when a network security group is associated to a subnet.
- **VM3:** Since there's no network security group associated to `Subnet2`, traffic is allowed into the subnet and processed by NSG2, because NSG2 is associated to the network interface attached to VM3.
- **VM4:** Traffic is allowed to VM4, because a network security group isn't associated to `Subnet3`, or the network interface in the virtual machine. All network traffic is allowed through a subnet and network interface if they don't have a network security group associated to them.

For **outbound traffic**, Azure processes the rules in a network security group associated to a network interface first, if there's one, and then the rules in a network security group associated to the subnet, if there's one.

- **VM1:** The security rules in NSG2 are processed. Unless you create a security rule that denies port 80 outbound to the internet, the AllowInternetOutbound default security rule allows the traffic in both NSG1 and NSG2. If NSG2 has a security rule that denies port 80, the traffic is denied, and NSG1 never evaluates it. To deny port 80 from the virtual machine, either, or both of the network security groups must have a rule that denies port 80 to the internet.
- **VM2:** All traffic is sent through the network interface to the subnet, since the network interface attached to VM2 doesn't have a network security group associated to it. The rules in NSG1 are processed.
- **VM3:** If NSG2 has a security rule that denies port 80, the traffic is denied. If NSG2 has a security rule that allows port 80, then port 80 is allowed outbound to the internet, since a network security group isn't associated to `Subnet2`.
- **VM4:** All network traffic is allowed from VM4, because a network security group isn't associated to the network interface attached to the virtual machine, or to `Subnet3`.

## Application Security Groups

An Application Security Group (ASG) enables you to configure network security as a natural extension of an application's structure, allowing you to group virtual machines and define network security policies based on those groups. You can reuse your security policy at scale without manual maintenance of explicit IP addresses. The platform handles the complexity of explicit IP addresses and multiple rule sets, allowing you to focus on your business logic.

To minimize the number of security rules you need, create rules using service tags or application security groups. Avoid rules with individual IP addresses, or ranges of IP addresses.

## Filter network traffic with an NSG using the Azure portal

You can use a network security group to filter network traffic inbound and outbound from a virtual network subnet. Network security groups contain security rules that filter network traffic by IP address, port, and protocol. Security rules are applied to resources deployed in a subnet.

The key stages to filter network traffic with an NSG are:

1. Create a resource group.
2. Create a virtual network.
3. Create application security groups.
4. Create a network security group.
5. Associate a network security group with a subnet.
6. Create security rules.
8. Associate NICs to an ASG.
9. Test traffic filters.

To view the detailed steps for all these tasks, see [Tutorial: Filter network traffic with a network security group using the Azure portal](/azure/virtual-network/tutorial-filter-network-traffic).