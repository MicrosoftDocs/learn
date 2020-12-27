<!- Estimated unit duration 5 minutes -->

## User Cases for Azure Virtual WAN

When to consider deploying Azure Virtual WAN:

- Enterprises that are migrating from existing Multi-protocol Label Switching (MPLS) network connectivity to Azure Virtual WAN that uses Microsoft backbone network. This will provide simplified management for their combined networking functionality. Additional it will reduce cost while providing faster network services access.
- Enterprises that are transitioning from their private WAN to SD-WAN due to a growing cloud footprint. Virtual WAN offers multiple options for interconnecting their current SD-WANs to Azure Virtual WAN. In all of these cases, the interconnection of SD-WAN with Virtual WAN is similar from the connectivity process.
- In Azure Virtual WAN design documentation it details how a business can connect through the Azure high speed backbone using their closes Point of presence (POP) location. This provides the business borderless connectivity.

Enterprises can choose from these options:

| Enterprise connection model | Functional features|
|:------------------------------------------- |:-------------------- |
|  Direct Interconnect Model | The SD-WAN branch customer-premises equipment (CPE) is directly connected to virtual hubs via IPsec connections. Azure workloads can be accessed securely and directly using IPsec tunnels connected to virtual hubs |
| Direct Interconnect Model with NVA-in-VWAN-hub | Supports the interconnection of a third-party Network Virtual Appliance (NVA) directly into the virtual hub, protecting their current investments|
| Indirect Interconnect model | CPE deployed in their VNet are indirectly connected to virtual hubs using IPsec. The virtual CPE serves as an SD-WAN gateway into Azure |
|  Managed Hybrid WAN model  | Enterprises acquire a Managed Service Provider (MSP) to provide their SD-WAN design, integrations, and operations |
It should be re-enforced that the benefits of Azure Virtual WAN are not just for Fortune 500 global companies. Small, medium and large business can take advantage of the multiple methods of connectivity outlined above offering tremendous flexibility for users to access a companies services. For example, the Virtual WAN any-to-any connectivity to support distrubed working from home users running Point-to-Site VPN. This allows connection to all of your resources on-premises and in Azure by your contractors, employees, and customers.

In summary:

- Azure Virtual WAN manages the traffic between the user and the destination.
- It provides automatic connections between company services in other regions.
- A global service using azure global transit network.
- Automated spoke setup and configuration.
- It allows for enhanced WAN performance without sacrificing security.
- Optimal routing through VNet connections with low latency and high bandwidth.
- Firewall protection with security policy managed by Azure Firewall manager.

The easy of management, any-to-any connectivity, access speed, and cost saving are revolutionary features.
