:::image type="content" source="../media/private-links-602b4a62.png" alt-text="An Azure Private Link connects a NSG Private endpoint with SQL database. A direct connection is not allowed.":::


Azure Private Link provides private connectivity from a virtual network to Azure platform as a service (PaaS), customer-owned, or Microsoft partner services. It simplifies the network architecture and secures the connection between endpoints in Azure by eliminating data exposure to the public internet.

 -  **Private connectivity to services on Azure**. Traffic remains on the Microsoft network, with no public internet access. Connect privately to services running in other Azure regions. Private Link is global and has no regional restrictions.
 -  **Integration with on-premises and peered networks**. Access private endpoints over private peering or VPN tunnels from on-premises or peered virtual networks. Microsoft hosts the traffic, so you don’t need to set up public peering or use the internet to migrate your workloads to the cloud.
 -  **Protection against data exfiltration for Azure resources**. Use Private Link to map private endpoints to Azure PaaS resources. When there is a security incident within your network, only the mapped resource would be accessible, eliminating the threat of data exfiltration.
 -  **Services delivered directly to your customers’ virtual networks**. Privately consume Azure PaaS, Microsoft partner, and your own services in your virtual networks on Azure. Private Link works across Azure Active Directory (Azure AD) tenants to help unify your experience across services. Send, approve, or reject requests directly, without permissions or role-based access controls.

## How it works

Use Private Link to bring services delivered on Azure into your private virtual network by mapping it to a private endpoint. Or privately deliver your own services in your customers’ virtual networks. All traffic to the service can be routed through the private endpoint, so no gateways, NAT devices, ExpressRoute or VPN connections, or public IP addresses are needed. Private Link keeps traffic on the Microsoft global network.
