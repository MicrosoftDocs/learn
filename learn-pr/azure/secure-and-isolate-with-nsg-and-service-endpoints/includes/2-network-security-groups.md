As part of the project to move your ERP system to Azure, you need to ensure that servers have proper isolation, so that only allowed systems can make network connections. For example, you have database servers that store data for your ERP application. You want to block prohibited systems from communicating with the servers over the network, while allowing application servers to communicate with the database servers.

## Network security groups

Network security groups filter network traffic to and from Azure resources. Network security groups contain security rules that you configure to allow or deny inbound and outbound traffic. You can use network security groups to filter traffic between VMs or subnets within a virtual network and from the internet.

### Network security group assignment and evaluation

Network security groups are assigned to a network interface or a subnet. When you assign a network security group to a subnet, the rules will apply to all network interfaces in that subnet. You can restrict traffic further by associating a network security group to the network interface of a VM.

When you apply network security groups to both subnet and network interface, each network security group is evaluated independently. Inbound traffic will first be evaluated by the network security group applied to the subnet, then by the network security group applied to the network interface. Conversely, outbound traffic from a VM will first be evaluated by the network security group applied to the network interface, then by the network interface applied to the subnet.

![Visualization of network security groups](../media/2-nsg.svg)

Applying a network security group to a subnet instead of individual network interfaces can reduce administration and management efforts. This approach also ensures that all VMs within the specified subnet are secured with the same set of rules.

Each subnet and network interface can have one network security group applied to it. Network security groups support TCP, UDP, and ICMP, and operate at Layer 4 of the OSI model.

In our manufacturing company scenario, network security groups can help you secure the network.  With network security groups, you can control which computers can connect to your application servers. You configure the network security group so that only a specific range of IP addresses can connect to the servers. You can lock this down more by only allowing access to or from specific ports or from individual IP addresses.  These rules can be applied to devices that are connecting remotely from on-premises networks, or between resources within Azure.

## Security rules

A network security group contains one or more security rules. Security rules are configured to either allow or deny traffic.

Rules have several properties:

|Property  |Explanation  |
|---------|---------|
|Name|A unique name within the network security group|
|Priority | A number between 100 and 4096 |
|Source or destination| Any, or an individual IP address, classless inter-domain routing (CIDR) block (10.0.0.0/24, for example), service tag, or application security group |
|Protocol     | TCP, UDP, or Any |
|Direction| Whether the rule applies to inbound, or outbound traffic|
|Port range     | An individual port or range of ports  |
|Action     | Allow or deny the traffic      |

Network security group security rules are evaluated by priority using the 5-tuple information (source, source port, destination, destination port, and protocol) to allow or deny the traffic. When the conditions for a rule match the device configuration, rule processing stops.

For example, suppose your company has created a security rule to allow inbound traffic on port 3389 (RDP) to your Web servers with a priority of 200. And then suppose that another administrator has created a rule to deny inbound traffic on port 3389 with a priority of 150. The deny rule will take precedence because it will be processed first. The rule with priority 150 is processed before the rule with priority 200.

With network security groups, the connections are stateful. Return traffic is automatically allowed for the same TCP/UDP session. For example, an inbound rule allowing traffic on port 80, also allows the VM to respond to the request (typically on an ephemeral port) without needing a corresponding outbound rule.

Thinking back to the ERP system, the web servers for the ERP application connect to database servers that are in their own subnets. You can apply security rules to state that the only allowed communication from the web servers to the database servers is port 1433 for SQL Server database communications. All other traffic to the database servers will be denied.  

### Default security rules

When you create a network security group, Azure creates several default rules. These default rules cannot be changed, but can be overridden with your own rules. These default rules allow connectivity within a virtual network and from Azure load balancers, allow outbound communication to the internet, and deny inbound traffic from the internet. 
 
The default rules for inbound traffic are:


| Priority | Rule Name  | Description  |
|----------|------------|--------------|
| 65000 | AllowVnetInbound | Allow Inbound coming from any VM to any VM within the subnet |
| 65001 | AllowAzureLoadBalancerInbound | Allow traffic from the default load balancer to any VM within the subnet |
| 65500 | DenyAllInBound | Deny traffic from any external source to any of the VMs |

The default rules for outbound traffic are:

| Priority | Rule Name  | Description  |
|----------|------------|--------------|
| 65000 | AllowVnetOutbound |  Allow Outbound going from any VM to any VM within the subnet |
| 65001 | AllowInternetOutbound | Allow Outbound traffic going to the Internet from any VM |
| 65500 | DenyAllOutBound | Deny traffic from any internal VM to system outside the VNet |

### Augmented security rules

You use augmented security rules for network security groups to simplify the management of large numbers of rules. Augmented security rules also help when you need to implement more complex network sets of rules. Augmented rules let you add the following options into a single security rule:

- multiple IP addresses
- multiple ports
- service tags
- application security groups

Suppose your company wants to restrict access to resources in your data center, spread across several network address ranges. With augmented rules, you can add all these ranges into a single rule, reducing the administrative overhead and complexity in your network security groups.

### Service Tags

You use service tags to simplify network security group security even further. Service tags are used to allow or deny traffic to a specified Azure service, either globally or per region.

Service tags simplify security for VMs and Azure VNets by allowing you to restrict access by resources or services. Service tags represent a group of IP addresses, and help simplify the configuration of your security rules. For resources that you can specify using a tag, you don't need to know IP address or port details.

You can restrict access to many services. Microsoft manages the service tags, you can't create your own service tag. Some examples of the services are:

- **VirtualNetwork** - The VirtualNetwork tag represents all virtual network addresses anywhere in Azure, and in your on-premises network if you're using hybrid connectivity.
- **AzureLoadBalancer** - This tag denotes Azure's infrastructure load balancer. The tag translates to the Virtual IP address of the host (168.63.129.16) where Azure's health probes originate.
- **Internet** - The Internet tag represents anything outside the VNet address that is publicly reachable, including resources such as Azure WebApps that have public IP addresses.
- **AzureTrafficManager** - The AzureTrafficManager tag represents the IP address for Azure Traffic Manager.
- **Storage** - The Storage tag represents the IP address space for the Azure Storage service. You can specify whether traffic is allowed or denied. You can also specify if access is allowed only to a specific region, but you can't select individual storage accounts.
- **SQL** - The SQL tag represents the address for Azure SQL Database, Azure Database for MySQL, Azure Database for PostgreSQL, and Azure SQL Data Warehouse services. You can specify whether traffic is allowed or denied and to limit to a specific region.
- **AppService** - The AppService tag represents address prefixes for Azure App Service.

## Application security groups

Application security groups let you configure network security for resources used by specific applications. You can group VMs logically, no matter what their IP address or subnet assignment.

Application security groups are used within a network security group to apply a security rule to a group of resources. Using application security groups makes it easier to deploy and scale up specific application workloads. You just add a new VM deployment to one or more application security groups, and that VM automatically picks up your security rules for that workload.

An application security group allows you to group network interfaces together and you can then use that application security group as a source or destination rule within a network security group. 

For example, your company has a number of front-end servers in a VNet. The Web servers must be accessible over ports 80 and 8080. Database servers must be accessible over port 1433. You assign the network interfaces for the web servers to one application security group, and the network interfaces for the database servers to another application security group. You then create two inbound rules in your network security group. One rule allows HTTP traffic to all servers in the Web server application security group. The other rule allows SQL traffic to all servers in the database server application security group.

![Application security groups](../media/2-asg-nsg.svg)

 Without application security groups, you'd need to create a separate rule for each VM.

The key benefit of application security groups is that it makes administration easier. You can easily add and remove network interfaces to an application security group as you deploy or redeploy application servers. You can also dynamically apply new rules to an application security group, which are then automatically applied to all the VMs in that application security group.

## When to use network security groups

As a best practice, you should always use network security groups to help protect your networked assets against unwanted traffic. Network security groups give you granular control access over the network layer, without the potential complexity of setting security rules for every VM or VNet.
