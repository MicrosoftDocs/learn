Azure offers several networking services to help protect your network resources. You can protect your applications by using one service or a combination of services. In this unit, we examine Azure DDoS Protection, Azure Firewall, Private Link, Web Application Firewall, and Virtual Network security groups and service endpoints. 

### Azure DDoS Protection (distributed denial of service protection)

[Azure DDoS Protection](/azure/ddos-protection/manage-ddos-protection) provides countermeasures against the most sophisticated DDoS threats. The service provides enhanced DDoS mitigation capabilities for your application and resources deployed in your virtual networks. Additionally, customers who use Azure DDoS Protection have access to DDoS Rapid Response support to engage DDoS experts during an active attack.

#### Business scenarios

- Implement always-on traffic monitoring, adaptive tuning, and mitigation scale
- Access multi-layered protection, including attack analytics, metrics, and alerting
- Receive support from the DDoS rapid response team

### Azure Private Link

[Azure Private Link](/azure/private-link/private-link-overview) enables you to access Azure PaaS services (such as Azure Storage and SQL Database) and Azure hosted customer-owned/partner services over a private endpoint in your virtual network. Traffic between your virtual network and the service travels the Microsoft backbone network. Exposing your service to the public internet is no longer necessary. You can create your own private link service in your virtual network and deliver it to your customers. Private Link is used to access PaaS services, such as Azure Storage, Azure SQL, App Services, and more. 

#### Business scenarios

- Enable private connectivity to services on Azure
- Integrate with on-premises and peered networks
- Restrict traffic to the Microsoft network with no public internet access

### Azure Firewall

Azure Firewall is a managed, cloud-based network security service that protects your Azure Virtual Network resources. It's a fully stateful firewall as a service with built-in high availability and unrestricted cloud scalability. Azure Firewall uses a static public IP address for your virtual network resources, which allows outside firewalls to identify traffic originating from your virtual network. Azure Firewall provides inbound protection for non-HTTP/S protocols (such as RDP, SSH, and FTP), outbound network-level protection for all ports and protocols, and application-level protection for outbound HTTP/S.

#### Business scenarios

- Implement centralized creation, enforcement, and logging of application and network connectivity policies
- Apply connectivity policies across subscriptions and virtual networks 
- Combine Azure Firewall rules with just in time (JIT) access to restrict access to your virtual machine management ports

### Azure Web Application Firewall

[Azure Web Application Firewall](/azure/web-application-firewall/overview) provides protection to your web applications from common web exploits and vulnerabilities such as SQL injection, and cross-site scripting. Web Application Firewall provides out of box protection from OWASP top 10 vulnerabilities via managed rules. Configure customer-managed rules for extra protection based on source IP range and request attributes (headers, cookies, form data fields, query string parameters). Preventing similar attacks in your application code can be challenging. The process can require rigorous maintenance, patching, and monitoring at multiple layers of the application topology. A centralized web application firewall helps to simplify security management. A web application firewall gives application administrators better assurance of protection against threats and intrusions.

#### Business scenarios

- React faster to security threats by centrally patching known vulnerabilities instead of securing individual web apps
- Deploy Web Application Firewall with Application Gateway, Front Door, and Content Delivery Network

### Azure Virtual Network - Security groups

You can filter network traffic to and from Azure resources in an Azure virtual network with [Azure network security group (NSGs)](/azure/virtual-network/network-security-groups-overview). You can use a network virtual appliance (NVA) such as Azure Firewall or firewalls from other vendors.

An NSG contains a list of access control list (ACL) rules that allow or deny network traffic to subnets, network interface cards (NICs), or both. NSGs can be associated with either subnets or individual NICs connected to a subnet. When an NSG is associated with a subnet, the ACL rules apply to all the virtual machines in that subnet.

NSGs contain two sets of rules: inbound and outbound. The priority for a rule must be unique within each set. Each rule has properties of protocol, source and destination port ranges, address prefixes, direction of traffic, priority, and access type. All NSGs contain a set of default rules. The default rules can't be deleted, but because they're assigned the lowest priority, you can override them with custom rules.

#### Business scenarios

- Control how Azure routes traffic from subnets
- Limit the users in an organization who can work with resources in virtual networks
- Restrict traffic to an individual NIC by associating an NSG directly to a NIC
- Combine NSGs with JIT access to restrict access to your virtual machine management ports

### Azure Virtual Network - Service endpoints

Azure Virtual Network service endpoints extend your virtual network private address space and the identity of your virtual network to the Azure services over a direct connection. You can use endpoints to secure your critical Azure service resources to have access to only your virtual networks. Traffic from your virtual network to the Azure service always remains on the Microsoft Azure backbone network. Service endpoints are easy to set up and have less management overhead than other strategies.

#### Business scenarios

- Secure your critical Azure service resources to only your virtual networks
- Increase security for your Azure service resources
- Implement optimal routing for Azure service traffic from your virtual network

### Azure Bastion 

Azure Bastion is a fully platform-managed PaaS service that you implement inside your virtual network. Azure Bastion provides secure and seamless RDP/SSH connectivity to your virtual machines directly in the Azure portal over TLS. Azure Bastion helps protect against port scanning. RDP ports, SSH ports, and public IP addresses aren't publicly exposed for your virtual machines. 

When you connect via Azure Bastion, your virtual machines don't need a public IP address. Traffic initiated from Azure Bastion to target virtual machines stays within the virtual network or between peered virtual networks.

Azure Bastion sits at the perimeter of your virtual network and helps protect against zero-day exploits. You don't need to worry about hardening each of the virtual machines in your virtual network. The Azure platform keeps Azure Bastion up to date.

There's no need to apply NSGs to the Azure Bastion subnet because it's hardened internally. For more security, you can configure NSGs to allow only remote connections to the target virtual machines from the Azure Bastion host.

#### Business scenarios

- Secure remote connections from the Azure portal to Azure virtual machines
- Eliminate exposing RDP ports, SSH ports, or public IP addresses for your internal virtual machines
- Integrate with native security appliances for an Azure virtual network, like Azure Firewall
- Monitor and manage remote connections.

### Things to know about JIT network access 

JIT network access lets you lock down inbound traffic to your virtual machines. You can implement JIT to reduce exposure to attacks while providing easy access to connect to your virtual machines when needed.

- When you enable JIT virtual machine access, you select the ports on the virtual machines to which inbound traffic is blocked. This configuration ensures "deny all inbound traffic" rules exist for your selected ports in the NSG and [Azure Firewall rules](/azure/firewall/rule-processing). These rules restrict access to your Azure virtual machine's management ports and defend them from attack.

- If other rules already exist for the selected ports, the existing rules take priority over the new "deny all inbound traffic" rules. If there are no existing rules on the selected ports, the new rules take top priority in the NSG and Azure Firewall.

- When a user requests access to a virtual machine, Security Center checks if the user has [Azure role-based access control (Azure RBAC)](/azure/role-based-access-control/role-assignments-portal) permissions for that virtual machine. If the request is approved, NSGs and Azure Firewall allow inbound traffic to the selected ports from the relevant IP address (or range) for the amount of time specified. After the time has expired, the NSGs are returned to their previous states. Connections that are already established aren't interrupted.