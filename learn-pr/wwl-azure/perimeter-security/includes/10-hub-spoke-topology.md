This reference architecture shows how to implement a hub-spoke topology in Azure. The hub is a virtual network in Azure that acts as a central point of connectivity to your on-premises network. The spokes are virtual networks that peer with the hub and can be used to isolate workloads. Traffic flows between the on-premises datacenter and the hub through an ExpressRoute or VPN gateway connection.

:::image type="content" source="../media/hub-spoke-9a71ff8d.png" alt-text="A sample network topology of a Hub and Spoke running on Azure.":::


Typical uses for this architecture include:

 -  Workloads deployed in different environments, such as development, testing, and production, that require shared services such as DNS, IDS, NTP, or AD DS. Shared services are placed in the hub virtual network, while each environment is deployed to a spoke to maintain isolation.
 -  Workloads that do not require connectivity to each other, but require access to shared services.
 -  Enterprises that require central control over security aspects, such as a firewall in the hub as a DMZ, and segregated management for the workloads in each spoke.<br>

The architecture consists of the following components.

 -  **On-premises network** \- A private local-area network running within an organization.
 -  **VPN device** \- A device or service that provides external connectivity to the on-premises network. The VPN device may be a hardware device or a software solution such as the Routing and Remote Access Service (RRAS) in Windows Server 2012. For a list of supported VPN appliances and information on configuring selected VPN appliances for connecting to Azure, see About VPN devices for Site-to-Site VPN Gateway connections.
 -  **VPN virtual network gateway or ExpressRoute gateway** \- The virtual network gateway enables the virtual network to connect to the VPN device, or ExpressRoute circuit, used for connectivity with your on-premises network. For more information, see Connect an on-premises network to a Microsoft Azure virtual network.
 -  **Hub virtual network** \- The virtual network is used as the hub in the hub-spoke topology. The hub is the central point of connectivity to your on-premises network, and a place to host services that can be consumed by the different workloads hosted in the spoke virtual networks.
 -  **Gateway subnet** \- The virtual network gateways are held in the same subnet.
 -  **Spoke virtual networks** \- One or more virtual networks that are used as spokes in the hub-spoke topology. Spokes can be used to isolate workloads in their own virtual networks, managed separately from other spokes. Each workload might include multiple tiers, with multiple subnets connected through Azure load balancers. For more information about the application infrastructure, see Running Windows VM workloads and Running Linux VM workloads.
 -  **Virtual network peering** \- Two virtual networks can be connected using a peering connection. Peering connections are non-transitive, low latency connections between virtual networks. Once peered, the virtual networks exchange traffic by using the Azure backbone, without the need for a router. In hub-spoke network topology, you use virtual network peering to connect the hub to each spoke. You can peer virtual networks in the same region or different regions. For more information, see Requirements and constraints.
