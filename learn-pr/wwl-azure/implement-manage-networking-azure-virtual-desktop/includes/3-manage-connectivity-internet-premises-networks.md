You can connect your on-premises computers and networks to a virtual network using any combination of the following options:

 -  **Point-to-site virtual private network (VPN)**: Established between a virtual network and a single computer in your network.
 -  Each computer that wants to establish connectivity with a virtual network must configure its connection.
 -  Ideal for just getting started with Azure, or for developers, because it requires little or no changes to your existing network.
 -  The communication between your computer and a virtual network is sent through an encrypted tunnel over the internet.
 -  **Site-to-site VPN**: Established between your on-premises VPN device and an Azure VPN Gateway that is deployed in a virtual network.
 -  Enables any on-premises resource that you authorize to access a virtual network.
 -  The communication between your on-premises VPN device and an Azure VPN gateway is sent through an encrypted tunnel over the internet.
 -  **Azure ExpressRoute**: Established between your network and Azure, through an ExpressRoute partner.
 -  This connection is private. Traffic does not go over the internet.

## Filter network traffic

You can filter network traffic between subnets using either or both of the following options:

 -  **Network security groups (NSGs)**: Network security groups and application security groups can contain multiple inbound and outbound security rules that enable you to filter traffic to and from resources by source and destination IP address, port, and protocol.
 -  **Network virtual appliance (NVA)**: A network virtual appliance is a VM that performs a network function, such as a firewall, WAN optimization, or other network function.

### Route network traffic

Azure routes traffic between subnets, connected virtual networks, on-premises networks, and the Internet, by default. You can implement either or both of the following options to override the default routes Azure creates:

 -  **Route tables**: You can create custom route tables with routes that control where traffic is routed to for each subnet.
 -  **Border gateway protocol (BGP) routes**: If you connect your virtual network to your on-premises network using an Azure VPN Gateway or ExpressRoute connection, you can propagate your on-premises BGP routes to your virtual networks.

## Virtual network integration for Azure services

Integrating Azure services to an Azure virtual network enables private access to the service from virtual machines or compute resources in the virtual network. You can integrate Azure services in your virtual network with the following options:

 -  Deploying dedicated instances of the service into a virtual network. The services can then be privately accessed within the virtual network and from on-premises networks.
 -  Using Private Link to access privately a specific instance of the service from your virtual network and from on-premises networks.
 -  You can also access the service using public endpoints by extending a virtual network to the service, through service endpoints. Service endpoints allow service resources to be secured to the virtual network.
