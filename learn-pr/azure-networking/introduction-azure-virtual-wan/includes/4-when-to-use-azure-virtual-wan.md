<<<<<<< HEAD
<!-- Estimated unit duration 5 minutes -->

In this unit you’ll discover common use cases for Azure Virtual WAN and explore different enterprise connection models for companies of all sizes.

## Use cases for Azure Virtual WAN

Common use cases for deploying Azure Virtual WAN include:

- Enterprises migrating from existing Multi-protocol Label Switching (MPLS) network connectivity to Azure Virtual WAN that uses Microsoft backbone network. This will provide simplified management for their combined networking functionality. Additionally, it will reduce cost while providing faster network services access.
- Enterprises transitioning from their private WAN to SD-WAN due to a growing cloud footprint. Virtual WAN offers multiple options for interconnecting their current SD-WANs to Azure Virtual WAN. For each of these options, the interconnection process of SD-WAN is similar to Virtual WAN.
- Businesses connecting through the Azure high-speed backbone using their closest Point of presence (POP) location. This provides the business borderless connectivity.

Enterprises can choose from these options:

| Enterprise connection model | Functional features|
|:------------------------------------------- |:-------------------- |
|  Direct Interconnect Model | The SD-WAN branch customer-premises equipment (CPE) is directly connected to virtual hubs via IPsec connections. Azure workloads can be accessed securely and directly using IPsec tunnels connected to virtual hubs. |
| Direct Interconnect Model with NVA-in-VWAN-hub | Supports the interconnection of a third-party Network Virtual Appliance (NVA) directly into the virtual hub, protecting their current investments.|
| Indirect Interconnect model | CPE deployed in their VNet are indirectly connected to virtual hubs using IPsec. The virtual CPE serves as an SD-WAN gateway into Azure. |
|  Managed Hybrid WAN model  | Enterprises acquire a Managed Service Provider (MSP) to provide their SD-WAN design, integrations, and operations |

It should be re-enforced that the benefits of Azure Virtual WAN are not just for Fortune 500 global companies. Small, medium and large business can take advantage of the multiple methods of connectivity outlined above offering tremendous flexibility for users to access a company’s services. For example, the Virtual WAN any-to-any connectivity to support distributed working from home users running Point-to-Site VPN. This allows connection to all your resources on-premises and in Azure by your contractors, employees, and customers.

## Use case summary

Azure Virtual WAN is beneficial for organizations that:

- Need to manage the traffic between the user and the destination.
- Provide automatic connections between company services in other regions.
- Want to take advantage of a global service using Azure global transit network.
- Use automated spoke setup and configuration.
- Take advantage of enhanced WAN performance without sacrificing security.
- Use optimal routing through VNet connections with low latency and high bandwidth.
- Use firewall protection with security policy managed by Azure Firewall manager.

The ease of management, any-to-any connectivity, access speed, and cost saving are features of the Azure Virtual WAN.
=======
<!-- Estimated unit duration 5 minutes -->

<!-- Phil, please add an introduction to the unit. Ideally continuing the Contoso story, and/or explaining what the learner will learn/do. Might be something like, “In this unit you’ll discover common use cases for Azure Virtual WAN and explore different enterprise connection models for companies of all sizes.”  -->

<!--  Phil, in the second bullet below, the last sentence is a little unclear. Would it be accurate to replace the last sentence with, “For each of these options, the interconnection process of SD-WAN is similar to Virtual WAN.”  -->

## Use cases for Azure Virtual WAN

Common use cases for deploying Azure Virtual WAN include:
- Enterprises migrating from existing Multi-protocol Label Switching (MPLS) network connectivity to Azure Virtual WAN that uses Microsoft backbone network. This will provide simplified management for their combined networking functionality. Additionally, it will reduce cost while providing faster network services access.
- Enterprises transitioning from their private WAN to SD-WAN due to a growing cloud footprint. Virtual WAN offers multiple options for interconnecting their current SD-WANs to Azure Virtual WAN. In all these cases, the interconnection of SD-WAN with Virtual WAN is similar from the connectivity process.
- Businesses connecting through the Azure high-speed backbone using their closest Point of presence (POP) location. This provides the business borderless connectivity.

Enterprises can choose from these options:

| Enterprise connection model | Functional features|
|:------------------------------------------- |:-------------------- |
|  Direct Interconnect Model | The SD-WAN branch customer-premises equipment (CPE) is directly connected to virtual hubs via IPsec connections. Azure workloads can be accessed securely and directly using IPsec tunnels connected to virtual hubs. |
| Direct Interconnect Model with NVA-in-VWAN-hub | Supports the interconnection of a third-party Network Virtual Appliance (NVA) directly into the virtual hub, protecting their current investments.|
| Indirect Interconnect model | CPE deployed in their VNet are indirectly connected to virtual hubs using IPsec. The virtual CPE serves as an SD-WAN gateway into Azure. |
|  Managed Hybrid WAN model  | Enterprises acquire a Managed Service Provider (MSP) to provide their SD-WAN design, integrations, and operations |

<!--  Phil, there’s was typo below, I changed it to “distributed”. But, please fix my edit if wrong.  -->

It should be re-enforced that the benefits of Azure Virtual WAN are not just for Fortune 500 global companies. Small, medium and large business can take advantage of the multiple methods of connectivity outlined above offering tremendous flexibility for users to access a company’s services. For example, the Virtual WAN any-to-any connectivity to support distributed working from home users running Point-to-Site VPN. This allows connection to all your resources on-premises and in Azure by your contractors, employees, and customers.

## Use case summary

Azure Virtual WAN is beneficial for organizations that:
- Need to manage the traffic between the user and the destination.
- Provide automatic connections between company services in other regions.
- Want to take advantage of a global service using Azure global transit network.
- Use automated spoke setup and configuration.
- Take advantage of enhanced WAN performance without sacrificing security.
- Use optimal routing through VNet connections with low latency and high bandwidth.
- Use firewall protection with security policy managed by Azure Firewall manager.

The ease of management, any-to-any connectivity, access speed, and cost saving are revolutionary features.


<!--  Phil, the sentence above seems a little like marketing. Might at least change “revolutionary”.  -->
>>>>>>> a15d16ce5802654297b7882da7604b45da0ac6cb
