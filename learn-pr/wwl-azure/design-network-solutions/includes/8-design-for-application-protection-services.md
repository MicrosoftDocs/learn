Azure offers several networking services to help protect your network resources. You can protect your applications by using one service or a combination of services. In this unit, we examine Azure DDoS Protection, Azure Firewall, Private Link, Web Application Firewall, and Virtual Network security groups and service endpoints. 

### Azure DDoS Protection (distributed denial of service protection)

[Azure DDoS Protection](/azure/ddos-protection/manage-ddos-protection) provides countermeasures against the most sophisticated DDoS threats. The service provides enhanced DDoS mitigation capabilities for your application and resources deployed in your virtual networks. Additionally, customers who use Azure DDoS Protection have access to DDoS Rapid Response support to engage DDoS experts during an active attack.

#### Business scenarios

- Implement always-on traffic monitoring, adaptive tuning, and mitigation scale.
- Access multi-layered protection, including attack analytics, metrics, and alerting.
- Receive support from the DDoS rapid response team.

### Azure Private Link

[Azure Private Link](/azure/private-link/private-link-overview) enables you to access Azure PaaS services (such as Azure Storage and SQL Database) and Azure hosted customer-owned/partner services over a private endpoint in your virtual network. Traffic between your virtual network and the service travels the Microsoft backbone network. Exposing your service to the public internet is no longer necessary. You can create your own private link service in your virtual network and deliver it to your customers. Private Link is used to access PaaS services, such as Azure Storage, Azure SQL, App Services, and more. 

#### Business scenarios

- Enable private connectivity to services on Azure.
- Integrate with on-premises and peered networks.
- Restrict traffic to the Microsoft network with no public internet access.

### Azure Firewall

Azure Firewall is a managed, cloud-based network security service that protects your Azure Virtual Network resources. It's a fully stateful firewall as a service with built-in high availability and unrestricted cloud scalability. Azure Firewall uses a static public IP address for your virtual network resources, which allows outside firewalls to identify traffic originating from your virtual network. Azure Firewall provides inbound protection for non-HTTP/S protocols (such as RDP, SSH, and FTP), outbound network-level protection for all ports and protocols, and application-level protection for outbound HTTP/S.

#### Business scenarios

- Implement centralized creation, enforcement, and logging of application and network connectivity policies.
- Apply connectivity policies across subscriptions and virtual networks.
- Combine Azure Firewall rules with just in time (JIT) access to restrict access to your virtual machine management ports.

### Azure Web Application Firewall

[Azure Web Application Firewall](/azure/web-application-firewall/overview) provides protection to your web applications from common web exploits and vulnerabilities such as SQL injection, and cross-site scripting. Web Application Firewall provides out of box protection from OWASP top 10 vulnerabilities via managed rules. Configure customer-managed rules for extra protection based on source IP range and request attributes (headers, cookies, form data fields, query string parameters). Preventing similar attacks in your application code can be challenging. The process can require rigorous maintenance, patching, and monitoring at multiple layers of the application topology. A centralized web application firewall helps to simplify security management. A web application firewall gives application administrators better assurance of protection against threats and intrusions.

#### Business scenarios

- React faster to security threats by centrally patching known vulnerabilities instead of securing individual web apps.
- Deploy Web Application Firewall with Application Gateway, Front Door, and Content Delivery Network.

### Azure virtual network security groups

You can filter network traffic to and from Azure resources in an Azure virtual network with [Azure network security group (NSGs)](/azure/virtual-network/network-security-groups-overview). You can use a network virtual appliance (NVA) such as Azure Firewall or firewalls from other vendors.

An NSG contains a list of access control list (ACL) rules that allow or deny network traffic to subnets, network interface cards (NICs), or both. NSGs can be associated with either subnets or individual NICs connected to a subnet. When an NSG is associated with a subnet, the ACL rules apply to all the virtual machines in that subnet.

NSGs contain two sets of rules: inbound and outbound. The priority for a rule must be unique within each set. Each rule has properties of protocol, source and destination port ranges, address prefixes, direction of traffic, priority, and access type. All NSGs contain a set of default rules. The default rules can't be deleted, but because they're assigned the lowest priority, you can override them with custom rules.

#### Business scenarios

- Control how Azure routes traffic from subnets.
- Limit the users in an organization who can work with resources in virtual networks.
- Restrict traffic to an individual NIC by associating an NSG directly to a NIC.
- Combine NSGs with JIT access to restrict access to your virtual machine management ports.

### Azure Virtual Network - Service endpoints

Azure Virtual Network service endpoints extend your virtual network private address space and the identity of your virtual network to the Azure services over a direct connection. You can use endpoints to secure your critical Azure service resources to have access to only your virtual networks. Traffic from your virtual network to the Azure service always remains on the Microsoft Azure backbone network. Service endpoints are easy to set up and have less management overhead than other strategies.

#### Business scenarios

- Secure your critical Azure service resources to only your virtual networks.
- Increase security for your Azure service resources.
- Implement optimal routing for Azure service traffic from your virtual network.

