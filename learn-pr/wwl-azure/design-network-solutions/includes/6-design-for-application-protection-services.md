This section describes networking services in Azure that help protect your network resources - Protect your applications using any or a combination of these networking services in Azure - DDoS protection, Private Link, Firewall, Web Application Firewall, Network Security Groups, and Virtual Network Service Endpoints. 

## Distributed denial of service protection

[Azure DDoS Protection](/azure/ddos-protection/manage-ddos-protection) provides countermeasures against the most sophisticated DDoS threats. The service provides enhanced DDoS mitigation capabilities for your application and resources deployed in your virtual networks. Additionally, customers using Azure DDoS Protection have access to DDoS Rapid Response support to engage DDoS experts during an active attack.

:::image type="content" source="../media/denial-protection.png" alt-text="Diagram of Azure DDoS.":::


Use DDoS protection Standard when you need:
- Always-on traffic monitoring 
- Adaptive tuning
- Multi-layered protection
- Mitigation scale
- Attack analytics and metrics
- Attack alerting
- DDoS rapid response team

## Azure Private Link

[Azure Private Link](/azure/private-link/private-link-overview) enables you to access Azure PaaS Services (for example, Azure Storage and SQL Database) and Azure hosted customer-owned/partner services over a private endpoint in your virtual network. Traffic between your virtual network and the service travels the Microsoft backbone network. Exposing your service to the public internet is no longer necessary. You can create your own private link service in your virtual network and deliver it to your customers. Private link is used to access PaaS services such as Azure Storage, Azure SQL, App Services and more as illustrated below. 

Recommend private link or private endpoints when:

- You need private connectivity to services on Azure

- You need integration with on-premises and peered networks

- You need traffic to remain on Microsoft network, with no public internet access

:::image type="content" source="../media/private-link.png" alt-text="Diagram of Azure Private Link.":::



## Azure Firewall

Azure Firewall is a managed, cloud-based network security service that protects your Azure Virtual Network resources. It's a fully stateful firewall as a service with built-in high availability and unrestricted cloud scalability. Using Azure Firewall, you can centrally create, enforce, and log application and network connectivity policies across subscriptions and virtual networks. Azure Firewall uses a static public IP address for your virtual network resources allowing outside firewalls to identify traffic originating from your virtual network. Azure Firewall provides inbound protection for non-HTTP/S protocols (for example, RDP, SSH, FTP), outbound network-level protection for all ports and protocols, and application-level protection for outbound HTTP/S.

:::image type="content" source="../media/firewall-threat.png" alt-text="Diagram of Azure Firewall.":::

 


## Web Application Firewall

[Azure Web Application Firewall](/azure/web-application-firewall/overview) (WAF) provides protection to your web applications from common web exploits and vulnerabilities such as SQL injection, and cross site scripting. Azure WAF provides out of box protection from OWASP top 10 vulnerabilities via managed rules. Additionally, customers can also configure custom rules, which are customer managed rules to provide additional protection based on source IP range, and request attributes such as headers, cookies, form data fields or query string parameters. Preventing such attacks in application code is challenging. It can require rigorous maintenance, patching, and monitoring at multiple layers of the application topology. A centralized web application firewall helps make security management much simpler. A WAF also gives application administrators better assurance of protection against threats and intrusions.

A WAF solution can react to a security threat faster by centrally patching a known vulnerability, instead of securing each individual web application.

WAF can be deployed with Azure Application Gateway, Azure Front Door, and Azure Content Delivery Network (CDN) service from Microsoft. WAF on Azure CDN is currently under public preview. WAF has features that are customized for each specific service. 


:::image type="content" source="../media/web-application-firewall-overview.png" alt-text="Diagram of Azure WAF.":::


## Network security groups

You can filter network traffic to and from Azure resources in an Azure virtual network with a network security group. You can also use network virtual appliances (NVA) such as Azure Firewall or firewalls from other vendors. You can control how Azure routes traffic from subnets. You can also limit who in your organization can work with resources in virtual networks.

A network security group (NSG) contains a list of Access Control List (ACL) rules that allow or deny network traffic to subnets, NICs, or both. NSGs can be associated with either subnets or individual NICs connected to a subnet. When an NSG is associated with a subnet, the ACL rules apply to all the VMs in that subnet. In addition, traffic to an individual NIC can be restricted by associating an NSG directly to a NIC.

NSGs contain two sets of rules: inbound and outbound. The priority for a rule must be unique within each set. Each rule has properties of protocol, source and destination port ranges, address prefixes, direction of traffic, priority, and access type. All NSGs contain a set of default rules. The default rules cannot be deleted, but because they are assigned the lowest priority, they can be overridden by the rules that you create.

 

## Service endpoints

Virtual Network (VNet) service endpoints extend your virtual network private address space and the identity of your VNet to the Azure services, over a direct connection. Endpoints allow you to secure your critical Azure service resources to only your virtual networks. Traffic from your VNet to the Azure service always remains on the Microsoft Azure backbone network.

:::image type="content" source="../media/service-endpoints-overview.png" alt-text="Diagram of Service Endpoints.":::


Key Benefits:
- Improved security for your Azure service resources
- Optimal routing for Azure service traffic from your virtual network
- Simple to set up with less management overhead


## Azure Bastion 

The Azure Bastion service is a new fully platform-managed PaaS service that you provision inside your virtual network. It provides secure and seamless RDP/SSH connectivity to your virtual machines directly in the Azure portal over TLS. When you connect via Azure Bastion, your virtual machines do not need a public IP address.

Recommend Azure Bastion when you need to:

- Secure remote connections from the Azure portal to Azure VMs

- Eliminate exposing RDP ports, SSH ports, or public IP addresses for your internal VMs

:::image type="content" source="../media/azure-bastion.png" alt-text="Diagram of Azure bastion deployed within an Azure Virtual Network.":::

 
### Key security features

- Traffic initiated from Azure Bastion to target virtual machines stays within the virtual network or between peered virtual networks.

- There's no need to apply NSGs to the Azure Bastion subnet, because it's hardened internally. For additional security, you can configure NSGs to allow only remote connections to the target virtual machines from the Azure Bastion host.

- Azure Bastion helps protect against port scanning. RDP ports, SSH ports, and public IP addresses aren't publicly exposed for your VMs.

- Azure Bastion helps protect against zero-day exploits. It sits at the perimeter of your virtual network. So you don't need to worry about hardening each of the virtual machines in your virtual network. The Azure platform keeps Azure Bastion up to date.

- The service integrates with native security appliances for an Azure virtual network, like Azure Firewall.

- You can use the service to monitor and manage remote connections.

 

## Just in time (JIT) network access 

With JIT, you can lock down the inbound traffic to your VMs, reducing exposure to attacks while providing easy access to connect to VMs when needed.


 

When you enable just-in-time VM access, you can select the ports on the VM to which inbound traffic will be blocked. This ensures "deny all inbound traffic" rules exist for your selected ports in the [network security group](/azure/virtual-network/network-security-groups-overview) (NSG) and [Azure Firewall rules](/azure/firewall/rule-processing). These rules restrict access to your Azure VMs’ management ports and defend them from attack.

If other rules already exist for the selected ports, then those existing rules take priority over the new "deny all inbound traffic" rules. If there are no existing rules on the selected ports, then the new rules take top priority in the NSG and Azure Firewall.

When a user requests access to a VM, Security Center checks that the user has [Azure role-based access control (Azure RBAC)](/azure/role-based-access-control/role-assignments-portal) permissions for that VM. If the request is approved, NSGs and Azure Firewall allow inbound traffic to the selected ports from the relevant IP address (or range), for the amount of time that was specified. After the time has expired, the NSGs are returned to their previous states. Connections that are already established are not interrupted.