Understanding Azure's routing configuration when integrated with SAP and Azure workloads and features is crucial for network performance and security.

## Modifying Azure Virtual Machine default routing

Azure implements a default routing configuration that facilitates basic connectivity, including ability to reach the internet and communicate with other resources on the same or directly connected virtual networks. You can modify this default configuration in multiple ways:

- **Creating user-defined routes**, which are route tables with one or more rules altering the default routing behavior and associate them with virtual network subnets. These rules apply to any traffic leaving these subnets and targeting IP address ranges that you referenced as prefixes in the route table. 
These rules enable routing control within and between virtual networks, including on-premises and Azure networks in hybrid setups, and internet-bound traffic from network subnets.
- **Configuring Border Gateway Protocol (BGP) routing**, which facilitates dynamic route exchange between on-premises networks and Azure virtual networks in hybrid scenarios. BGP routing allows for the management of routing behavior between local networks and Azure virtual networks in hybrid scenarios. It also controls traffic from virtual network subnets to the internet, like in forced tunneling situations.
- **Using Azure Private Link**, which provides a secure and private connection between your virtual network and Azure services, ensuring that traffic remains within the Microsoft backbone network. Using Azure Private Link enhances security and performance for SAP workloads, including SAP Business Technology Platform (BTP) used with SAP Private Link Service and RISE with SAP when hosted on Azure. For SAP BTP and RISE with SAP hosted on other cloud providers, alternative methods such as ExpressRoute or Site-to-Site VPN are required for secure and private connectivity.
