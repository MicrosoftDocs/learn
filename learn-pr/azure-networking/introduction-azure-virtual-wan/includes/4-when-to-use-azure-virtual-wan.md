In this unit, you’ll discover common cases for deploying Azure Virtual WAN.

## Common cases for deploying Azure Virtual WAN

Consider deploying Azure Virtual WAN in the following situations:

- Enterprises migrating from existing Multi-protocol Label Switching (MPLS) network connectivity to Azure Virtual WAN that uses Microsoft backbone network. The Microsoft backbone will provide simplified management for their combined networking functionality. Additionally, it will reduce cost while providing faster network services access.
- Enterprises transitioning from their private WAN to SD-WAN because of their growing cloud footprint. Virtual WAN offers multiple options for interconnecting their current SD-WANs to Azure Virtual WAN. For each of these options, the interconnection process of SD-WAN is similar to Virtual WAN.
- Businesses connecting through the Azure high-speed backbone using their closest Point of presence (POP) location. These connections provide the business borderless connectivity.

Enterprises can choose from these options:

| Enterprise connection model | Functional features|
|:------------------------------------------- |:-------------------- |
|  Direct Interconnect Model | The SD-WAN branch customer-premises equipment (CPE) is directly connected to virtual hubs with IPsec connections. Azure workloads can be accessed securely and directly using IPsec tunnels connected to virtual hubs. |
| Direct Interconnect Model with NVA-in-VWAN-hub | Supports the interconnection of a third-party Network Virtual Appliance (NVA) directly into the virtual hub, protecting their current investments.|
| Indirect Interconnect model | When CPE is used in their virtual network, they're indirectly connected to virtual hubs using IPsec. The virtual CPE serves as an SD-WAN gateway into Azure. |
|  Managed Hybrid WAN model  | Enterprises acquire a Managed Service Provider (MSP) to provide their SD-WAN design, integrations, and operations |

The benefits of Azure Virtual WAN aren't just for Fortune 500 global companies.

Small, medium, and large business can take advantage of the multiple methods of connectivity previously outlined. The options for connectivity offer users flexibility to access a company’s services.

For example, the Virtual WAN any-to-any connectivity supports distributed working from home, your contractors, employees, and customers. They all can connect using Point-to-Site VPN. This service allows connection to all your resources on-premises and in Azure.

Azure Virtual WAN is beneficial for organizations that:

- Need to manage the traffic between the user and the destination.
- Provide automatic connections between company services in other regions.
- Want to take advantage of a global service using Azure global transit network.
- Use automated spoke setup and configuration.
- Take advantage of enhanced WAN performance without sacrificing security.
- Use optimal routing through virtual network connections with low latency and high bandwidth.
- Use firewall protection with security policy managed by Azure Firewall Manager.

The ease of management, any-to-any connectivity, access speed, and cost saving are features of the Azure Virtual WAN.
