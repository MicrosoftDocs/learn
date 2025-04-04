
A [site-to-site (S2S) VPN gateway](/azure/vpn-gateway/design#s2smulti) lets you create a secure connection to your virtual network from another virtual network or a physical network. The following diagram illustrates how you would connect an on-premises network to the Azure platform. The internet connection uses an IPsec VPN tunnel.

:::image type="content" source="../media/site-site-vpn-architecture-78aaf8d4.png" alt-text="Diagram of the site-to-site VPN Gateway architecture.":::


## In the diagram:

 -  The on-premises network represents your on-premises Active Directory and any data or resources.
 -  The gateway is responsible for sending encrypted traffic to a virtual IP address when it uses a public connection.
 -  The Azure virtual network holds all your cloud applications and any Azure VPN gateway components.
 -  An Azure VPN gateway provides the encrypted link between the Azure virtual network and your on-premises network. An Azure VPN gateway is made up of these elements:
    
     -  Virtual network gateway
     -  Local network gateway
     -  Connection
     -  Gateway subnet
 -  An internal load balancer, located in the front end, routes cloud traffic to the correct cloud-based application or resource.

Using this architecture offers several benefits, including:

 -  Simplifying configuration and maintenance.
 -  Encrypting data and traffic between the on-premises gateway and the Azure gateway.
 -  Allowing for future network requirements. 

This architecture isn't applicable in all situations because it uses an existing internet connection as the link between the two gateway points. Bandwidth constraints can cause latency issues that result from reuse of the existing infrastructure.

### Implement a site-to-site VPN connection (video)

This video diagrams site-to-site connections. The diagram builds over the video. 

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=cce9cc6b-a7b7-4b5b-9661-b5c666ce1bd7]