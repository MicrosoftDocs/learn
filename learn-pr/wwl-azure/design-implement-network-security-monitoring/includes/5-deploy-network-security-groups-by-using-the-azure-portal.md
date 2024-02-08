A Network Security Group (NSG) in Azure allows you to filter network traffic to and from Azure resources in an Azure virtual network. A network security group contains security rules that allow or deny inbound network traffic to, or outbound network traffic from, several types of Azure resources. For each rule, you can specify source and destination, port, and protocol.

## NSG security rules

A network security group contains zero, or as many rules as desired, within Azure subscription limits. Each rule specifies the following properties:

- **Name** \- Must be a unique name within the network security group.
- **Priority** \- Can be any number between 100 and 4096. Rules are processed in priority order, with lower numbers processed before higher numbers, because lower numbers have higher priority. Once traffic matches a rule, processing stops. As a result, any rules that exist with lower priorities (higher numbers) that have the same attributes as rules with higher priorities aren't processed.
- **Source or destination** \- Can be set to Any, or an individual IP address, or classless inter-domain routing (CIDR) block (10.0.0.0/24, for example), service tag, or application security group.
- **Protocol** \- Can be TCP, UDP, ICMP, ESP, AH, or Any.
- **Direction** \- Can be configured to apply to inbound, or outbound traffic.
- **Port range** \- Can be specified either as an individual port or range of ports. For example, you could specify 80 or 10000-10005. Specifying ranges enables you to create fewer security rules.
- **Action** \- Can be set to Allow or deny.

The firewall evaluates network security group security rules by priority, using the 5-tuple information (source, source port, destination, destination port, and protocol) to either allow or deny the traffic.

## Default security rules

Azure creates the following default rules in each network security group that you create:

| **Direction** |           **Name**            | **Priority** |    **Source**     | **Source Ports** | **Destination** | **Destination Ports** | **Protocol** | **Access** |
|:-------------:|:-----------------------------:|:------------:|:-----------------:|:----------------:|:---------------:|:---------------------:|:------------:|:----------:|
|    Inbound    |       `AllowVNetInBound`       |    65000     |  `VirtualNetwork`   |     0-65535      | `VirtualNetwork`  |        0-65535        |     Any      |   Allow    |
|    Inbound    | `AllowAzureLoadBalancerInBound` |    65001     | `AzureLoadBalancer` |     0-65535      |    0.0.0.0/0    |        0-65535        |     Any      |   Allow    |
|    Inbound    |        `DenyAllInbound`         |    65500     |     0.0.0.0/0     |     0-65535      |    0.0.0.0/0    |        0-65535        |     Any      |    Deny    |
|   Outbound    |       `AllowVnetOutBound`      |    65000     |  `VirtualNetwork`   |     0-65535      | `VirtualNetwork`  |        0-65535        |     Any      |   Allow    |
|   Outbound    |     `AllowInternetOutBound`     |    65001     |     0.0.0.0/0     |     0-65535      |    `Internet`     |        0-65535        |     Any      |   Allow    |
|   Outbound    |        `DenyAllOutBound`       |    65500     |     0.0.0.0/0     |     0-65535      |    0.0.0.0/0    |        0-65535        |     Any      |    Deny    |

The following diagram and bullet points illustrate different scenarios for how network security groups might be deployed to allow network traffic to and from the internet over TCP port 80:

:::image type="content" source="../media/network-security-group-interaction-92030446.png" alt-text="Diagram of the Network security group example setup.":::

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

To minimize the number of security rules you need, and the need to change the rules, plan out the application security groups you need and create rules using service tags or application security groups, rather than individual IP addresses, or ranges of IP addresses, whenever possible.

## Filter network traffic with an NSG using the Azure portal

You can use a network security group to filter network traffic inbound and outbound from a virtual network subnet. Network security groups contain security rules that filter network traffic by IP address, port, and protocol. Security rules are applied to resources deployed in a subnet.

The key stages to filter network traffic with an NSG using the Azure portal are:

1. **Create a resource group** - this can either be done beforehand or as you create the virtual network in the next stage. All other resources that you create must be in the same region specified here.
2. **Create a virtual network** - this must be deployed in the same resource group you created previously.
3. **Create application security groups** - the application security groups you create here enables you to group together servers with similar functions, such as web servers or management servers. You would create two application security groups here; one for web servers and one for management servers (for example, MyAsgWebServers and MyAsgMgmtServers)
4. **Create a network security group** \- the network security group secures network traffic in your virtual network. This NSG will be associated with a subnet in the next stage.
5. **Associate a network security group with a subnet** - this is where you associate the network security group you create previously, with the subnet of the virtual network you created in stage 2 above.
6. **Create security rules** - this is where you create your inbound security rules. Here you would create a security rule to allow ports 80 and 443 to the application security group for your web servers (for example, MyAsgWebServers). Then you would create another security rule to allow RDP traffic on port 3389 to the application security group for your management servers (for example, MyAsgMgmtServers). These rules control from where you can access your VM remotely and your IIS Webserver.
7. **Create virtual machines** - this is where you create the web server (for example, MyVMWeb) and management server (for example, MyVMMgmt) virtual machines that will be associated with their respective application security group in the next stage.
8. **Associate NICs to an ASG** - this is where you associate the network interface card (NIC) attached to each virtual machine with the relevant application security group that you created in stage 3 above.
9. **Test traffic filters** - the final stage is where you test that your traffic filtering is working as expected.
     - To test this, you would attempt to connect to the management server virtual machine (for example, MyVMMgmt) by using an RDP connection, thereby verifying that you can connect because port 3389 is allowing inbound connections from the Internet to the management servers application security group (for example, MyAsgMgmtServers).
     - While connected to the RDP session on the management server (for example, MyVMMgmt), you would then test an RDP connection from the management server virtual machine (for example, MyVMMgmt) to the web server virtual machine (for example, MyVMWeb), which again should succeed because virtual machines in the same network can communicate with each over any port by default.
     - However, you'll not be able to create an RDP connection to the web server virtual machine (for example, MyVMWeb) from the internet, because the security rule for the web servers application security group (for example, MyAsgWebServers) prevents connections to port 3389 inbound from the Internet. Inbound traffic from the Internet is denied to all resources by default.
     - While connected to the RDP session on the web server (for example, MyVMWeb), you could then install IIS on the web server, then disconnect from the web server virtual machine RDP session, and disconnect from the management server virtual machine RDP session. In the Azure portal, you would then determine the Public IP address of the web server virtual machine (for example, MyVMWeb), and confirm you can access the web server virtual machine from the Internet by opening a web browser on your computer and navigating to http:// (for example, http://23.96.39.113) **.** You should see the standard IIS welcome screen, because port 80 is allowed inbound access from the Internet to the web servers application security group (for example, MyAsgWebServers). The network interface attached to the web server virtual machine (for example, MyVMWeb) is associated with the web servers application security group (for example, MyAsgWebServers) and therefore allows the connection.

To view the detailed steps for all these tasks, see [Tutorial: Filter network traffic with a network security group using the Azure portal](/azure/virtual-network/tutorial-filter-network-traffic).