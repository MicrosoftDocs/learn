When considering your Azure security solution consider all the elements of defense in depth. 
<div style="background:yellow;">
TODO: While I like the scenario based approach, is this needed for the exam? It's a little repetitive. Perhaps could be replaced with a "What would TWT do" scenario.
</div>

## Perimeter layer

The network perimeter layer is about protecting organizations from network-based attacks against your resources. Identifying these attacks, alerting, and eliminating their impact is important to keep your network secure. To do this:

+ Use Azure DDoS Protection to filter large-scale attacks before they can cause a denial of service for end users.
+ Use perimeter firewalls with Azure Firewall to identify and alert on malicious attacks against your network.

## Network layer

At this layer, the focus is on limiting network connectivity across all your resources to only allow what is required. Segment your resources and use network-level controls to restrict communication to only what is needed. By restricting connectivity, you reduce the risk of lateral movement throughout your network from an attack. Use NSGs to create rules about inbound and outbound communication at this layer. As best practices:

+ Limit communication between resources through segmenting your network and configuring access controls.
+ Deny by default.
+ Restrict inbound internet access and limit outbound where appropriate.
+ Implement secure connectivity to on-premises networks.


## Combine services

You can also combine multiple Azure networking and security services to manage your network security and provide increased layered protection.  The following are examples of combined services:

+ **Network security groups and Azure Firewall**. Azure Firewall complements network security group functionality. Together, they provide better defense-in-depth network security. Network security groups provide distributed network layer traffic filtering to limit traffic to resources within virtual networks in each subscription. Azure Firewall is a fully stateful, centralized network firewall-as-a-service, which provides network and application-level protection across different subscriptions and virtual networks.

+ **Application Gateway WAF and Azure Firewall**. WAF is a feature of Application Gateway that provides your web applications with centralized, inbound protection against common exploits and vulnerabilities. *Azure Firewall* provides inbound protection for non-HTTP/S protocols (for example, RDP, SSH, FTP), outbound network-level protection for all ports and protocols, and application-level protection for outbound HTTP/S. Combining both provides additional layers of protection.

