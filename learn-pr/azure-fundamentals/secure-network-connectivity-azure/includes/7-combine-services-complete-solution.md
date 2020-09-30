When you're considering an Azure security solution, consider all the elements of defense in depth.

Here are some recommendations on how to combine Azure services to create a complete network security solution.

## Secure the perimeter layer

The perimeter layer is about protecting your organization's resources from network-based attacks. Identifying these attacks, alerting the appropriate security teams, and eliminating their impact are important to keeping your network secure. To do this:

+ Use Azure DDoS Protection to filter large-scale attacks before they can cause a denial of service for users.
+ Use perimeter firewalls with Azure Firewall to identify and alert on malicious attacks against your network.

## Secure the network layer

At this layer, the focus is on limiting network connectivity across all of your resources to allow only what's required. Segment your resources and use network-level controls to restrict communication to only what's needed.

By restricting connectivity, you reduce the risk of lateral movement throughout your network from an attack. Use network security groups to create rules that define allowed inbound and outbound communication at this layer. Here are some recommended practices:

+ Limit communication between resources by segmenting your network and configuring access controls.
+ Deny by default.
+ Restrict inbound internet access and limit outbound where appropriate.
+ Implement secure connectivity to on-premises networks.

## Combine services

You can combine Azure networking and security services to manage your network security and provide increased layered protection. Here are two ways you can combine services:

+ **Network security groups and Azure Firewall**

    Azure Firewall complements the functionality of network security groups. Together, they provide better defense-in-depth network security.

    Network security groups provide distributed network-layer traffic filtering to limit traffic to resources within virtual networks in each subscription.

    Azure Firewall is a fully stateful, centralized network firewall as a service. It provides network-level and application-level protection across different subscriptions and virtual networks.

+ **Azure Application Gateway web application firewall and Azure Firewall**

    Web application firewall (WAF) is a feature of Azure Application Gateway that provides your web applications with centralized, inbound protection against common exploits and vulnerabilities.

    Azure Firewall provides:
    
    - Inbound protection for non-HTTP/S protocols (for example, RDP, SSH, and FTP).
    - Outbound network-level protection for all ports and protocols.
    - Application-level protection for outbound HTTP/S. 
    
    Combining them provides more layers of protection.
