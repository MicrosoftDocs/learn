As system administrator at Contoso, you must ensure that any services hosted in Microsoft Azure with IaaS meet the company's stringent security requirements. To properly secure network traffic, you can set up NSGs.

## Network security groups 

An NSG filters inbound and outbound network traffic. Configuring the security rules for a NSG allows you to control network traffic by allowing or denying specific traffic types.

You can assign an NSG to:

- A network interface to filter network traffic on just that interface.
- A subnet to filter traffic on all connected network interfaces in the subnet.

You can also assign NSGs to both network interfaces and subnets. Then, each NSG is evaluated independently.

![A graphic depicts a subnet object that contains two VMs, VM1 and VM2. VM1 is protected through the assignment of an NSG called NSG1. The entire subnet is protected by an NSG called NSG2.](../media/m19-network-security-groups.png)

For inbound traffic, the following process occurs:

1. Inbound traffic is first evaluated by the NSG applied to the subnet.
1. Inbound traffic is then evaluated by the NSG applied to the network interface.

However, for outbound traffic, the following process occurs:

1. Outbound traffic from a VM is first evaluated by the NSG applied to the network interface.
1. Outbound traffic from a VM is then evaluated by the NSG applied to the subnet.

> [!TIP]
> You can reduce administrative effort by applying an NSG to a subnet instead of to individual network interfaces, to secure all VMs within the specified subnet with the same set of rules.

## Security rules

An NSG contains security rules that are used to allow or deny filtered network traffic.

The properties of an NSG security rule are outlined in the following table.

|Property|Meaning|
|-|-|
|**Name**|A unique name within the network security group.|
|**Priority**|A number between 100 and 4096. Lower numbers have a higher priority and are processed first.|
|**Source or destination**|Any, or an individual IP address, classless inter-domain routing (CIDR) block (10.0.0.0/24, for example), service tag, or application security group. Network security groups are processed after Azure translates a public IP address to a private IP address for inbound traffic, and before Azure translates a private IP address to a public IP address for outbound traffic.|
|**Protocol**|Transmission Control Protocol (TCP), User Datagram Protocol (UDP), Internet Control Message Protocol (ICMP), or Any.|
|**Direction**|Whether the rule applies to inbound, or outbound traffic.|
|**Port range**|An individual port or range of ports (for example, 10000-10005). You can also use a wildcard (*).|
|**Action**|Allow or deny the traffic.|
|**Description**| Optional property for describing the purpose of the rule.|

> [!NOTE] 
> You don't define the direction of a rule as a property of the rule. Rather, you start by creating an inbound or outbound rule.

> [!IMPORTANT] 
> When network traffic is matched with a network security rule, that security rule is used for the network traffic. Further security rules are not evaluated (for that network traffic). However, other network traffic is evaluated against further security rules.

### Default security rules

An NSG has three inbound and three outbound security rules that can't be modified. The purpose of these default rules are to:

- Allow connectivity within a virtual network and from Azure load balancers.
- Allow outbound communication to the internet.
- Deny all traffic from the internet.

The three default **inbound** rules are described in the following table.

|Priority|Rule name|Description|
|-|-|-|
|65000|AllowVnetInbound|Allow inbound coming from any VM to any VM within the subnet.|
|65001|AllowAzureLoadBalancerInbound|Allow traffic from the default load balancer to any VM within the subnet.|
|65500|DenyAllInBound|Deny traffic from any external source to any of the VMs.|

The default **outbound** rules are described in the following table.

|Priority|Rule name|Description|
|-|-|-|
|65000|AllowVnetOutbound|Allow outbound traffic going from any VM to any VM within the subnet.|
|65001|AllowInternetOutbound|Allow outbound traffic going to the internet from any VM.|
|65500|DenyAllOutBound|Deny traffic from any internal VM to a system outside the virtual network.|

> [!TIP] 
> You can add additional default rules.

If Contoso IT wants to connect Azure VMs by using Microsoft Remote Desktop, you can add an inbound security rule to the network security group that allows RDP traffic. Note that inbound RDP is one of default rules that can be added automatically when you create an Azure VM by using the Azure portal.

> [!NOTE]
>  You can override the default rules by creating higher priority rules that address your unique needs.

### Augmented security rules

If you have many security rules that you want to simplify, you can use augmented security rules. Augmented rules let you add the following options into a single security rule:

- Multiple IP addresses
- Multiple ports
- Service tags
- Application security groups

For example, Contoso IT wants to restrict access to specific resources in the datacenter, but the resources are spread across several network address ranges. With augmented rules, you can add all of these ranges into a single rule, reducing the administrative overhead.

> [!NOTE] 
> You can also use augmented rules in the source or destination and port range fields of a rule.

### Service tags

A service tag represents a group of IP address prefixes from a given Azure service. When you create security rules, you can use service tags in place of specific IP addresses. By specifying the service tag name (for example, AzureBackup) in the appropriate source or destination field of a rule, you can deny or allow the traffic for that service.

> [!NOTE] 
> You cannot create your own service tags. Microsoft manages the address prefixes encompassed by the service tag and automatically updates the service tag as addresses change, minimizing the complexity of frequent updates to network security rules.

You can use service tags to:

- Achieve network isolation and protect your Azure resources from the general internet while accessing Azure services that have public endpoints.
- Create inbound/outbound network security group rules to deny traffic to/from the internet and allow traffic to/from Azure Cloud Services.

> [!NOTE] 
> You can use service tags to define network access controls on network security groups and also in Azure Firewall.

The following table lists some examples of the available service tags.

|Tag|Explanation|
||--|
|VirtualNetwork|This tag represents all virtual network addresses anywhere in Azure, and in your on-premises network if you're using hybrid connectivity.|
|AzureLoadBalancer|This tag denotes Azure's infrastructure load balancer. The tag translates to the virtual IP address of the host (168.63.129.16) where Azure health probes originate.|
|Internet|This tag represents anything outside the virtual network address that is publicly reachable, including resources that have public IP addresses. One such resource is the Web Apps feature of Azure App Service.|
|AzureTrafficManager|This tag represents the IP address for Azure Traffic Manager|

> [!NOTE] 
> You can review a complete list of service tags at [Available service tags](https://aka.ms/available-service-tags?azure-portal=true).

## Application security groups

An application security group (ASG) enables you to group network interfaces together. You can then use that ASG as a source or destination rule within an NSG.

> [!TIP] 
> ASGs make administration easier because you can add or remove network interfaces to the ASG as you deploy or redeploy application servers.

You can use ASGs to:

- Configure network security for resources that specific applications use. This enables you to group VMs logically, irrespective of their subnet assignment.
- Apply a security rule to a group of resources. It's easier to deploy and scale up specific application workloads. You just add a new VM deployment to one or more ASGs, and that VM automatically picks up your security rules for that workload.

> [!NOTE] 
> If an NSG applies to VMs, then security rules for the ASG also automatically apply to VMs and allow full network connectivity between VMs in the sample ASG.

Without ASGs, you'd need to create a separate rule for each VM. For example, Contoso has a number of front-end servers in a VNet. IT staff decide to implement NSGs and ASGs to secure the network resources, as depicted in the following graphic.


![The graphic depicts a collection of web servers is protected by an NSG called **ERP - SERVERS-NSG**, as is a collection of SQL servers. This NSG has two rules: one which filters web traffic to port 80 and 8080, and a second that filters SQL traffic on port 1433. The web servers are protected by an ASG called **WEB-SVR-ASG** assigned to their NICs. The SQL servers are protected by an ASG called **SQL-SVR-ASG** which is assigned to their NICs. All resources are connected to the same VNet.](../media/m19-application-security-group.png) 

Using ASGs enables Contoso to meet the following objectives:

- Web servers must be accessible over ports 80 and 8080.
- Database servers must be accessible from web servers over port 1433.

To configure this solution in your role as system administrator, you will need to perform the following high-level procedure:

1. Assign the network interfaces for the web servers to one ASG.
1. Assign the network interfaces for the database servers to another ASG.
1. Create two inbound rules in your network security group:
    - One rule opens HTTP and TCP port 8080 traffic to all servers in the web server ASG.
    - The other rule allows SQL traffic to all servers in the database server ASG.

> [!IMPORTANT] 
> You should always use NSGs to help protect your networked resources from unwanted traffic. With NSGs, you have granular control access over the network layer. At the same time, you can avoid the complexity of configuring and enabling security rules for every VM or virtual network.

> [!NOTE] 
> If you have a trial Azure tenant, you might want to perform the following exercise: [Create and manage network security groups](https://aka.ms/3-exercise-network-security-groups?azure-portal=true)